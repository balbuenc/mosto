using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class TipoLicitaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)this.Master.FindControl("lblActualPage")).Text = "TIPO DE";
            if (Request.QueryString["PageSize"] != null)
            {
                TipoLicitacionDataPager.PageSize = Convert.ToInt16(Request.QueryString["PageSize"]);
            }

            //Authorize User Role
            if (Session["SecureMatrix"] == null)
            {
                string OriginalUrl = HttpContext.Current.Request.RawUrl;
                string LoginPageUrl = "/Login.aspx";
                HttpContext.Current.Response.Redirect(String.Format("{0}?ReturnUrl={1}", LoginPageUrl, OriginalUrl));
            }
            
            Utils.Authorization("vTipodeLicitaciones");
            AddRegistroBtn.Visible = Utils.WRITE;
        }

        protected void SearchBtn_ServerClick(object sender, EventArgs e)
        {
            TipoLicitacionListView.DataBind();
        }

        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("TipoLicitaciones.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("TipoLicitaciones.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(TipoLicitacionDS.ConnectionString);

            cmd = new SqlCommand("management.[sp_TipoLicitacion_get_TipoLicitacion]", con);
            cmd.Parameters.Add(new SqlParameter("@IdTipoLicitacion", ID));
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
            SqlConnection con = new SqlConnection(TipoLicitacionDS.ConnectionString);

            cmd = new SqlCommand("management.[sp_TipoLicitacion_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdTipoLicitacion", ID));



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
                TipoLicitacionListView.DataBind();

                ErrorLabel.Text = "El Registro se eliminó correctamente.";
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 3000);
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
                TextBox txtIdTipoLicitacion = (TextBox)EditFormView.FindControl("txtIdTipoLicitacion");
                TextBox txtTipoLicitacion = (TextBox)EditFormView.FindControl("txtTipoLicitacion");
                TextBox txtDescripcion = (TextBox)EditFormView.FindControl("txtDescripcion");
                
                DropDownList ActivoDDL = (DropDownList)EditFormView.FindControl("ActivoDDL");
                TextBox txtCodigo = (TextBox)EditFormView.FindControl("txtCodigo");


                //DateTime isoDateTime = DateTime.ParseExact(txtCalendar.Value, format, CultureInfo.InvariantCulture);

                SqlConnection conn = new SqlConnection(TipoLicitacionDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "management.sp_TipoLicitacion_update";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdTipoLicitacion", txtIdTipoLicitacion.Text);
                cmd.Parameters.AddWithValue("@TipoLicitacion", txtTipoLicitacion.Text);
                cmd.Parameters.AddWithValue("@Descripcion", txtDescripcion.Text);
                
                cmd.Parameters.AddWithValue("@Activo", ActivoDDL.SelectedValue.ToString());
                cmd.Parameters.AddWithValue("@Codigo", txtCodigo.Text);

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#editModal').modal('hide');", true);

                Response.Redirect("TipoLicitaciones.aspx");


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
            ErrorLabel.Text = "El Registro de actualizò correctamente";
            ErrorLabel.Visible = true;
            FadeOut(ErrorLabel.ClientID, 5000);
            TipoLicitacionListView.DataBind();

        }

        protected void TipoLicitacionListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            
            LinkButton EditTipoLicitacionBtn = (LinkButton)e.Item.FindControl("EditTipoLicitacionBtn");
            LinkButton DeleteTipoLicitacionBtn = (LinkButton)e.Item.FindControl("DeleteTipoLicitacionBtn");

            EditTipoLicitacionBtn.Enabled = Utils.UPDATE;
            DeleteTipoLicitacionBtn.Enabled = Utils.DELETE;
        }
    }
}