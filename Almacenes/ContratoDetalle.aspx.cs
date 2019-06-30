using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class ContratoDetalle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.QueryString["IdContrato"] != null)
            {
                if (!IsPostBack)
                {
                    DisableControls();
                    ObtenerDatosContrato(Convert.ToInt32(Request.QueryString["IdContrato"]));

                    //Desabilito el calendario
                    txtFechaInicioContrato.TextMode = TextBoxMode.SingleLine;
                    txtFechaFinContrato.TextMode = TextBoxMode.SingleLine;
                }
            }
            else if (!IsPostBack)
            {
                EnableControls();

                //Habilito el calendario
                txtFechaInicioContrato.TextMode = TextBoxMode.Date;
                txtFechaFinContrato.TextMode = TextBoxMode.Date;
            }

        }

        private void ObtenerDatosContrato(int IdContrato)
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                SqlConnection conn = new SqlConnection(ArticuloContratoDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "management.[sp_Contrato_get_Contrato]";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdContrato", IdContrato);


                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        txtNroContrato.Text = dr["NroContrato"].ToString();
                        txtFechaInicioContrato.Text = dr["FechaInicioContrato"].ToString().Remove(11);
                        txtFechaFinContrato.Text = dr["FechaFinContrato"].ToString().Remove(11);
                        txtSearchProveedor.Value = dr["Proveedor"].ToString();
                        IdLicitacionDDL.SelectedValue = dr["IdLicitacion"].ToString();
                        TipoDDL.SelectedValue = dr["Tipo"].ToString();
                    }
                }

                conn.Close();

                DisableControls();

                ArticuloContratoListView.DataBind();

                LimpiarArticulo();


            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }

        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("ContratoDetalle.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("ContratoDetalle.aspx");
        }



        protected void DeleteRecord(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(ArticuloContratoDS.ConnectionString);

            cmd = new SqlCommand("management.[sp_Contrato_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdContrato", ID));



            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();
            cmd.ExecuteNonQuery();



            con.Close();
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
            TipoDDL.Enabled = false;
        }

        void EnableControls()
        {
            txtNroContrato.Enabled = true;
            txtSearchProveedor.Disabled = false;
            txtFechaInicioContrato.Enabled = true;
            txtFechaFinContrato.Enabled = true;
            IdLicitacionDDL.Enabled = true;
            TipoDDL.Enabled = true;
        }

        void LimpiarArticulo()
        {
            txtSearchArticulo.Value = "";
            txtArticuloCantidad.Value = "";
            txtArticuloPrecio.Value = "";
        }

        private void ShowPopUpMsg(string msg)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("alert('");
            sb.Append(msg.Replace("\n", "\\n").Replace("\r", "").Replace("'", "\\'"));
            sb.Append("');");
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showalert", sb.ToString(), true);
        }

        protected void AgregarArticuloBtn_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand();
            Int32 cant;

            if (txtNroContrato.Text == "")
            {
                ShowPopUpMsg("Favor ingresar un número de contrato");
                return;
            }

            try {
                cant = Convert.ToInt32(txtArticuloCantidad.Value.ToString());
            }
            catch
            {
                ShowPopUpMsg("La cantidad solicitada debe ser un número válido");
                return;
            }

            try
            {
                cant = Convert.ToInt32(txtArticuloPrecio.Value.ToString());
            }
            catch
            {
                ShowPopUpMsg("El precio debe ser un número válido");
                return;
            }


            try
            {
                SqlConnection conn = new SqlConnection(ArticuloContratoDS.ConnectionString);

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
                cmd.Parameters.AddWithValue("@Tipo", TipoDDL.SelectedValue);


                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                DisableControls();

                ArticuloContratoListView.DataBind();

                LimpiarArticulo();

                txtSearchArticulo.Focus();


            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }

        protected void btnClearArticulo_ServerClick(object sender, EventArgs e)
        {
            txtSearchArticulo.Value = "";
            txtArticuloCantidad.Value = "";
            txtArticuloPrecio.Value = "";
        }
    }

}