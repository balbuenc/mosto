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
            EnableControls();
        }

        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("Contrato.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Contrato.aspx");
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
                txtNroContrato.Text = e.CommandArgument.ToString();

                DisableControls();

                ArticuloContratoGridView.DataBind();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
               "$('#addModal').modal('show');", true);



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

        void DisableControls()
        {
            txtNroContrato.Enabled = false;
            txtSearchProveedor.Disabled = true;
            txtFechaInicioContrato.Enabled = false;
            txtFechaFinContrato.Enabled = false;
            IdLicitacionDDL.Enabled = false;
        }

        void EnableControls()
        {
            txtNroContrato.Enabled = true;
            txtSearchProveedor.Disabled = false;
            txtFechaInicioContrato.Enabled = true;
            txtFechaFinContrato.Enabled = true;
            IdLicitacionDDL.Enabled = true;
        }

        void LimpiarArticulo()
        {
            txtSearchArticulo.Value = "";
            txtArticuloCantidad.Value = "";
            txtArticuloPrecio.Value = "";
        }


        protected void AgregarAriculoBtn_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                SqlConnection conn = new SqlConnection(ContratoDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "management.sp_AddArticuloContrato";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@Proveedor", txtSearchProveedor.Value);
                cmd.Parameters.AddWithValue("@FechaInicioContrato", txtFechaInicioContrato.Text);
                cmd.Parameters.AddWithValue("@FechaFinContrato", txtFechaFinContrato.Text);
                cmd.Parameters.AddWithValue("@NroContrato", txtNroContrato.Text);
                cmd.Parameters.AddWithValue("@IdLicitacion", IdLicitacionDDL.SelectedValue);
                cmd.Parameters.AddWithValue("@ArticuloMaestro", txtSearchArticulo.Value);
                cmd.Parameters.AddWithValue("@CantidadArticulo", txtArticuloCantidad.Value);
                cmd.Parameters.AddWithValue("@Precio", txtArticuloPrecio.Value);
                cmd.Parameters.AddWithValue("@IdImpuesto", IdImpuestoDDL.SelectedValue);


                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                DisableControls();

                ArticuloContratoGridView.DataBind();

                LimpiarArticulo();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
              "$('#addModal').modal('show');", true);


            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }
    }
}