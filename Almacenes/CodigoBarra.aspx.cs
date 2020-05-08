using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Zen.Barcode;

namespace Almacenes
{
    public partial class CodigoBarra : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)this.Master.FindControl("lblActualPage")).Text = "CÓDIGO DE BARRAS";
            if (Request.QueryString["PageSize"] != null)
            {
                CodigoBarraListViewDataPager.PageSize = Convert.ToInt16(Request.QueryString["PageSize"]);
            }

            //Authorize User Role
            if (Session["SecureMatrix"] == null)
            {
                string OriginalUrl = HttpContext.Current.Request.RawUrl;
                string LoginPageUrl = "/Login.aspx";
                HttpContext.Current.Response.Redirect(String.Format("{0}?ReturnUrl={1}", LoginPageUrl, OriginalUrl));
            }

            Utils.Authorization("vCodigosdeBarra");
            AddRegistroBtn.Visible = Utils.WRITE;

        }

        protected void SearchBtn_ServerClick(object sender, EventArgs e)
        {
            CodigoBarraListView.DataBind();
        }


        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("CodigoBarra.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("CodigoBarra.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(CodigoBarraDS.ConnectionString);

            cmd = new SqlCommand("warehouse.[sp_CodigoBarra_get_CodigoBarra]", con);
            cmd.Parameters.Add(new SqlParameter("@IdCodigoBarra", ID));
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
            SqlConnection con = new SqlConnection(CodigoBarraDS.ConnectionString);

            cmd = new SqlCommand("warehouse.[sp_CodigoBarra_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdCodigoBarra", ID));



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
                CodigoBarraListView.DataBind();

                ErrorLabel.Text = "El Registro se eliminó correctamente.";
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 3000);
            }
            if (e.CommandName == "Barcode")
            {
                string url;

                url = "rptCodigoBarra.aspx?IdCodigoBarra=" + e.CommandArgument.ToString();

                Response.Redirect(url);

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
                TextBox txtIdCodigoBarra = (TextBox)EditFormView.FindControl("txtIdCodigoBarra");
                TextBox txtIdArticuloMaestro = (TextBox)EditFormView.FindControl("txtIdArticuloMaestro");
                TextBox txtDato = (TextBox)EditFormView.FindControl("txtDato");
                


                //DateTime isoDateTime = DateTime.ParseExact(txtCalendar.Value, format, CultureInfo.InvariantCulture);

                SqlConnection conn = new SqlConnection(CodigoBarraDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "warehouse.sp_CodigoBarra_update";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdCodigoBarra", txtIdCodigoBarra.Text);
                cmd.Parameters.AddWithValue("@IdArticuloMaestro", txtIdArticuloMaestro.Text);
                cmd.Parameters.AddWithValue("@Dato", txtDato.Text);
                cmd.Parameters.AddWithValue("@Image",getBarcode(txtDato.Text));

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#editModal').modal('hide');", true);

                Response.Redirect("CodigoBarra.aspx");


            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }

        private byte[] getBarcode(string Data)
        {
            BarcodeSymbology s = BarcodeSymbology.Code128;
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

        protected void EditFormView_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            EditFormView.ChangeMode(FormViewMode.ReadOnly);
            ErrorLabel.Text = "El Registro de actualizò correctamente";
            ErrorLabel.Visible = true;
            FadeOut(ErrorLabel.ClientID, 5000);
            CodigoBarraListView.DataBind();

        }

        private void ShowPopUpMsg(string msg)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("alert('");
            sb.Append(msg.Replace("\n", "\\n").Replace("\r", "").Replace("'", "\\'"));
            sb.Append("');");
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showalert", sb.ToString(), true);
        }


        protected void AddLicitacionBtn_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtSearchArticulo.Value.ToString() == "")
                {
                    ShowPopUpMsg("El campo artículo debe tener un valor.");
                }

                string[] tokens = txtSearchArticulo.Value.ToString().Split('#');
                txtIdArticuloMaestro.Text = tokens[1];
                txtArticuloMaestro.Text = txtSearchArticulo.Value.ToString();


                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                  "$('#addModal').modal('show');", true);
            }
            catch (Exception ex)
            {
                ShowPopUpMsg("Error al agregar código: " +ex.Message);
            }
        }

        protected void InsertButton_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand();
            DataKey key = EditFormView.DataKey;



            try
            {
                SqlConnection conn = new SqlConnection(CodigoBarraDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "[warehouse].[sp_CodigoBarra_insert]";
                cmd.CommandType = CommandType.StoredProcedure;

                 

                             
                cmd.Parameters.AddWithValue("@IdArticuloMaestro", txtIdArticuloMaestro.Text);
                cmd.Parameters.AddWithValue("@Dato", txtDato.Text);
                cmd.Parameters.AddWithValue("@Image", getBarcode(txtDato.Text));
                

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#addModal').modal('hide');", true);

                Response.Redirect("CodigoBarra.aspx");


            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }

        protected void CodigoBarraListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            LinkButton EditCodigoBarraBtn = (LinkButton)e.Item.FindControl("EditCodigoBarraBtn");
            LinkButton DeleteCodigoBarraBtn = (LinkButton)e.Item.FindControl("DeleteCodigoBarraBtn");

            EditCodigoBarraBtn.Enabled = Utils.UPDATE;
            DeleteCodigoBarraBtn.Enabled = Utils.DELETE;
        }
    }
}