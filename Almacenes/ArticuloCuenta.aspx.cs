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
    public partial class ArticuloCuenta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)this.Master.FindControl("lblActualPage")).Text = "ASIGNACIÓN DE CUENTAS CONTABLES";
            if (Request.QueryString["PageSize"] != null)
            {
                ArticuloCuentaListViewDataPager.PageSize = Convert.ToInt16(Request.QueryString["PageSize"]);
            }

            //Authorize User Role
            if (Session["SecureMatrix"] == null)
            {
                string OriginalUrl = HttpContext.Current.Request.RawUrl;
                string LoginPageUrl = "/Login.aspx";
                HttpContext.Current.Response.Redirect(String.Format("{0}?ReturnUrl={1}", LoginPageUrl, OriginalUrl));
            }

            Utils.Authorization("vAsiganciondecuentas");
            AddRegistroBtn.Visible = Utils.WRITE;
        }

        protected void SearchBtn_ServerClick(object sender, EventArgs e)
        {
            ArticuloCuentaListView.DataBind();
        }


        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("ArticuloCuenta.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("ArticuloCuenta.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(ArticuloCuentaDS.ConnectionString);

            cmd = new SqlCommand("accounting.[sp_ArticuloCuenta_get_ArticuloCuenta]", con);
            cmd.Parameters.Add(new SqlParameter("@IdArticuloCuenta", ID));
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
            SqlConnection con = new SqlConnection(ArticuloCuentaDS.ConnectionString);

            cmd = new SqlCommand("accounting.[sp_ArticuloCuenta_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdArticuloCuenta", ID));



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
                ArticuloCuentaListView.DataBind();

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
                DropDownList IdArticuloMaestro = (DropDownList)EditFormView.FindControl("IdArticuloMaestro");
               
                DropDownList IdCuenta = (DropDownList)EditFormView.FindControl("IdCuenta");
                TextBox txtIdArticuloCuenta = (TextBox)EditFormView.FindControl("txtIdArticuloCuenta");
                DropDownList IdConcpetoContable = (DropDownList)EditFormView.FindControl("ConceptoContableDDL");

                //DateTime isoDateTime = DateTime.ParseExact(txtCalendar.Value, format, CultureInfo.InvariantCulture);

                SqlConnection conn = new SqlConnection(ArticuloCuentaDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "accounting.sp_ArticuloCuenta_update";
                cmd.CommandType = CommandType.StoredProcedure;

               
                cmd.Parameters.AddWithValue("@IdCuenta", IdCuenta.SelectedValue);
               
                cmd.Parameters.AddWithValue("@IdArticuloMaestro", IdArticuloMaestro.Text);
                
                cmd.Parameters.AddWithValue("@IdArticuloCuenta", txtIdArticuloCuenta.Text);

                cmd.Parameters.AddWithValue("@IdConceptoContable", IdConcpetoContable.SelectedValue);

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#editModal').modal('hide');", true);

                Response.Redirect("ArticuloCuenta.aspx");


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
            ArticuloCuentaListView.DataBind();

        }

        protected void ArticuloCuentaListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {

            LinkButton EditArticuloCuentaBtn = (LinkButton)e.Item.FindControl("EditArticuloCuentaBtn");
            LinkButton DeleteArticuloCuentaBtn = (LinkButton)e.Item.FindControl("DeleteArticuloCuentaBtn");

            EditArticuloCuentaBtn.Enabled = Utils.UPDATE;
            DeleteArticuloCuentaBtn.Enabled = Utils.DELETE;
        }
    }
}