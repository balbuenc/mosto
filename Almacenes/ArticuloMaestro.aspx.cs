
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Zen.Barcode;

namespace Almacenes
{
    public partial class ArticuloMaestro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)this.Master.FindControl("lblActualPage")).Text = "ARTICULOS";
            if (Request.QueryString["PageSize"] != null)
            {
                ArticuloMaestroListViewDataPager.PageSize = Convert.ToInt16(Request.QueryString["PageSize"]);
            }
        }
        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("ArticuloMaestro.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("ArticuloMaestro.aspx");
        }

        protected void SearchBtn_ServerClick(object sender, EventArgs e)
        {
            ArticuloMaestroListView.DataBind();
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(ArticuloMaestroDS.ConnectionString);

            cmd = new SqlCommand("warehouse.[sp_ArticuloMaestro_get_ArticuloMaestro]", con);
            cmd.Parameters.Add(new SqlParameter("@IdArticuloMaestro", ID));
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter adp = new SqlDataAdapter();

            con.Open();

            adp.SelectCommand = cmd;
            DataSet ds = new DataSet();
            adp.Fill(ds);

            EditFormView.DataSource = ds;
            EditFormView.DataBind();

            con.Close();
        }


        protected void DeleteRecord(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(ArticuloMaestroDS.ConnectionString);

            cmd = new SqlCommand("warehouse.[sp_ArticuloMaestro_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdArticuloMaestro", ID));



            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();
            cmd.ExecuteNonQuery();



            con.Close();
        }


        protected void ListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                GetRecordToUpdate(e.CommandArgument.ToString());

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
               "$('#editModal').modal('show');", true);
            }
            else if (e.CommandName == "Eliminar")
            {
                DeleteRecord(e.CommandArgument.ToString());
                ArticuloMaestroListView.DataBind();

                ErrorLabel.Text = "El Registro se eliminó correctamente.";
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 3000);
            }
            if (e.CommandName == "CodigoBarra")
            {
                IdArticuloMaestroHF.Value = e.CommandArgument.ToString();

                Label idlbl = (Label)e.Item.FindControl("lblArticulo");
                

                CodigoBarraModalLabel.InnerText = "Código de barras: " + idlbl.Text;
                CodigoBarraListView.DataBind();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
               "$('#CodigoBarraModal').modal('show');", true);
            }
        }


        protected void FadeOut(string ClientID, int Time)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "script", "window.setTimeout(function() { document.getElementById('" + ClientID + "').style.display = 'none' }," + Time.ToString() + ");", true);
        }



        protected void EditFormView_ModeChanging(object sender, FormViewModeEventArgs e)
        {
            EditFormView.ChangeMode(e.NewMode);
        }


        protected void EditFormView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            SqlCommand cmd = new SqlCommand();
            DataKey key = EditFormView.DataKey;


            try
            {
                //Obtengo los valores de los campos a editar
                TextBox txtIdArticuloMaestro = (TextBox)EditFormView.FindControl("txtIdArticuloMaestro");
                TextBox txtArticulo = (TextBox)EditFormView.FindControl("txtArticulo");
                TextBox txtDescripcion = (TextBox)EditFormView.FindControl("txtDescripcion");

                TextBox txtCodigo = (TextBox)EditFormView.FindControl("txtCodigo");
                DropDownList IdUnidadMedidaDDL = (DropDownList)EditFormView.FindControl("IdUnidadMedidaDDL");


                SqlConnection conn = new SqlConnection(ArticuloMaestroDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "warehouse.sp_ArticuloMaestro_update";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdArticuloMaestro", txtIdArticuloMaestro.Text);
                cmd.Parameters.AddWithValue("@Codigo", txtCodigo.Text);
                cmd.Parameters.AddWithValue("@Articulo", txtArticulo.Text);
                cmd.Parameters.AddWithValue("@Descripcion", txtDescripcion.Text);
                cmd.Parameters.AddWithValue("@IdUnidadMedida", IdUnidadMedidaDDL.SelectedValue);

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#editModal').modal('hide');", true);

                Response.Redirect("ArticuloMaestro.aspx");


            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }


        protected void EditFormView_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            EditFormView.ChangeMode(FormViewMode.ReadOnly);
            ErrorLabel.Text = "El Registro de actualizó correctamente";
            ErrorLabel.Visible = true;
            FadeOut(ErrorLabel.ClientID, 5000);
            ArticuloMaestroListView.DataBind();

        }

       

        protected void CodigoBarraListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Barcode")
            {
                string url;

                url = "rptCodigoBarra.aspx?IdCodigoBarra=" + e.CommandArgument.ToString() ;

                

                Response.Redirect(url);

            }
        }

        private byte[] getBarcode(string Data)
        {
            BarcodeSymbology s = BarcodeSymbology.Code39C;
            BarcodeDraw drawObject = BarcodeDrawFactory.GetSymbology(s);
            var metrics = drawObject.GetDefaultMetrics(60);
            metrics.Scale = 2;
            var barcodeImage = drawObject.Draw(Data, metrics);

            using (MemoryStream ms = new MemoryStream())
            {
                barcodeImage.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                byte[] imageBytes = ms.ToArray();

                //return Convert.ToBase64String(imageBytes);
                return imageBytes;
            }
        }

        protected void CodigoBarraDS_Inserting(object sender, SqlDataSourceCommandEventArgs e)
        {
            
            e.Command.Parameters["@Image"].Value = getBarcode(e.Command.Parameters["@Dato"].Value.ToString());

        }
    }
}