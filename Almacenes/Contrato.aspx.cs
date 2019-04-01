using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class Contrato : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("Contrato.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Contrato.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(ContratoDS.ConnectionString);

            cmd = new SqlCommand("management.[sp_Contrato_get_Contrato]", con);
            cmd.Parameters.Add(new SqlParameter("@IdContrato", ID));
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
            SqlConnection con = new SqlConnection(ContratoDS.ConnectionString);

            cmd = new SqlCommand("management.[sp_Contrato_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdContrato", ID));



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
                ContratoListView.DataBind();

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

            string format = "dd/MM/yyyy";

            try
            {
                //Obtengo los valores de los campos a editar
                DropDownList txtIdProveedor = (DropDownList)EditFormView.FindControl("IdProveedorDDL");
                DropDownList txtIdLicitacion= (DropDownList)EditFormView.FindControl("IdLicitacionDDL");
                TextBox txtIdContrato = (TextBox)EditFormView.FindControl("txtIdContrato");
                
                
                System.Web.UI.HtmlControls.HtmlInputText calendarFechaInicioContrato = (System.Web.UI.HtmlControls.HtmlInputText)EditFormView.FindControl("calendarFechaInicioContrato");
                System.Web.UI.HtmlControls.HtmlInputText calendarFechaFinConrtrato = (System.Web.UI.HtmlControls.HtmlInputText)EditFormView.FindControl("calendarFechaFinContrato");

                
                TextBox txtNroContrato = (TextBox)EditFormView.FindControl("txtNroContrato");
                


                DateTime isoDateTimeInicio = DateTime.ParseExact(calendarFechaInicioContrato.Value, format, CultureInfo.InvariantCulture);
                DateTime isoDateTimeFin = DateTime.ParseExact(calendarFechaFinConrtrato.Value, format, CultureInfo.InvariantCulture);

                SqlConnection conn = new SqlConnection(ContratoDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "management.sp_Contrato_update";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdContrato", txtIdContrato.Text);
                cmd.Parameters.AddWithValue("@IdProveedor", txtIdProveedor.SelectedValue);
                cmd.Parameters.AddWithValue("@FechaInicioContrato", isoDateTimeInicio);
                cmd.Parameters.AddWithValue("@FechaFinContrato", isoDateTimeFin);
                cmd.Parameters.AddWithValue("@NroContrato", txtNroContrato.Text);
                cmd.Parameters.AddWithValue("@IdLicitacion", txtIdLicitacion.SelectedValue);

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#editModal').modal('hide');", true);

                Response.Redirect("Contrato.aspx");


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
            ContratoListView.DataBind();

        }
    }
}