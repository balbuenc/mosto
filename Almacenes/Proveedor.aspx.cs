using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes.Management
{
    public partial class Proveedores : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SearchBtn_ServerClick(object sender, EventArgs e)
        {
            ProveedorListView.DataBind();
        }

        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("Proveedor.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Proveedor.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(ProveedorDS.ConnectionString);

            cmd = new SqlCommand("management.[sp_Proveedor_get_Proveedor]", con);
            cmd.Parameters.Add(new SqlParameter("@IdProveedor", ID));
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
            SqlConnection con = new SqlConnection(ProveedorDS.ConnectionString);

            cmd = new SqlCommand("management.[sp_Proveedor_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdProveedor", ID));



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
                ProveedorListView.DataBind();

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
                TextBox txtIdProveedor = (TextBox)EditFormView.FindControl("txtIdProveedor");
                TextBox txtNombres = (TextBox)EditFormView.FindControl("txtNombres");
                TextBox txtApellidos = (TextBox)EditFormView.FindControl("txtApellidos");
                TextBox txtRazonSocial = (TextBox)EditFormView.FindControl("txtRazonSocial");
                TextBox txtRUC = (TextBox)EditFormView.FindControl("txtRUC");
                TextBox txtFechaRegistro = (TextBox)EditFormView.FindControl("txtFechaRegistro");
                TextBox txtNroDocumento = (TextBox)EditFormView.FindControl("txtNroDocumento");


                //DateTime isoDateTime = DateTime.ParseExact(txtCalendar.Value, format, CultureInfo.InvariantCulture);

                SqlConnection conn = new SqlConnection(ProveedorDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "management.sp_Proveedor_update";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdProveedor", txtIdProveedor.Text);
                cmd.Parameters.AddWithValue("@Nombres", txtNombres.Text);
                cmd.Parameters.AddWithValue("@Apellidos", txtApellidos.Text);
                cmd.Parameters.AddWithValue("@RazonSocial", txtRazonSocial.Text);
                cmd.Parameters.AddWithValue("@RUC", txtRUC.Text);
                cmd.Parameters.AddWithValue("@FechaRegistro", txtFechaRegistro.Text);
                cmd.Parameters.AddWithValue("@NroDocumento", txtNroDocumento.Text);

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#editModal').modal('hide');", true);

                Response.Redirect("Proveedor.aspx");


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
            ProveedorListView.DataBind();

        }
    }
}