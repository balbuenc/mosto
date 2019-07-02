
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class MovimientoDependencias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void IdArticuloDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            ObtenerDatosArticuloLote(Convert.ToInt32(((DropDownList)sender).SelectedValue));
        }

        //Procedimiento que obtienen los datos del Articulo Contrato |  precio, impuesto, Cantidad total
        private void ObtenerDatosArticuloLote(Int32 IdLote)
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                SqlConnection conn = new SqlConnection(ArticuloLoteDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "warehouse.sp_ArticuloLote_get_ArticuloLote";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdLote", IdLote);


                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        txtPrecio.Text = string.Format("{0:N0}", dr["Precio"]);
                        txtImpuesto.Text = string.Format("{0:N0}", dr["PrecioImpuesto"]);

                        txtExistente.Text = string.Format("{0:N0}", dr["Cantidad"]);
                    }
                }

                conn.Close();

            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }

        protected void IdArticuloDDL_DataBound(object sender, EventArgs e)
        {
            if (((DropDownList)sender).SelectedValue != "")
                ObtenerDatosArticuloLote(Convert.ToInt32(((DropDownList)sender).SelectedValue));
        }

        protected void FadeOut(string ClientID, int Time)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "script", "window.setTimeout(function() { document.getElementById('" + ClientID + "').style.display = 'none' }," + Time.ToString() + ");", true);
        }

        //Procedimiento que genera una nueva transacción para el Contrato actual
        private bool NuevaTransaccion()
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                SqlConnection conn = new SqlConnection(ArticuloLoteDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "[warehouse].[sp_GenerateTransaction]";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@Definicion", txtDefincion.Text);
                cmd.Parameters.AddWithValue("@NroFactura", DBNull.Value);
                cmd.Parameters.AddWithValue("@Login", Context.User.Identity.Name);
                cmd.Parameters.AddWithValue("@TipoTransaccion", "Dependencia");
                cmd.Parameters.AddWithValue("@IdContrato", DBNull.Value);
                cmd.Parameters.AddWithValue("@Solicitante", txtSolicitante.Text);
                cmd.Parameters.AddWithValue("@NotaRemision", DBNull.Value);


                // Set Output Paramater
                SqlParameter OutputParam = new SqlParameter("@NroTransaccion", SqlDbType.VarChar);
                OutputParam.Direction = ParameterDirection.Output;
                OutputParam.Size = 20;
                cmd.Parameters.Add(OutputParam);

                SqlParameter FechaParam = new SqlParameter("@Fecha", SqlDbType.VarChar);
                FechaParam.Direction = ParameterDirection.Output;
                FechaParam.Size = 10;
                cmd.Parameters.Add(FechaParam);

                SqlParameter IdTransaccionParam = new SqlParameter("@IdTransaccion", SqlDbType.Int);
                IdTransaccionParam.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(IdTransaccionParam);

                conn.Open();
                cmd.ExecuteNonQuery();

                txtNroTransaccion.Text = OutputParam.Value.ToString();
                txtFecha.Text = FechaParam.Value.ToString();

                Session["IdTransaccion"] = IdTransaccionParam.Value.ToString();

                conn.Close();

                return true;
            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
                return false;
                     
            }
        }

        private void ShowPopUpMsg(string msg)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("alert('");
            sb.Append(msg.Replace("\n", "\\n").Replace("\r", "").Replace("'", "\\'"));
            sb.Append("');");
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showalert", sb.ToString(), true);
        }


        protected void EnableControls()
        {
            ReportTransaccionBtn.Visible = true;
            DestinoPanel.Visible = true;
            ArticuloPanel.Visible = true;
        }

        protected void DisableControls()
        {
            ReportTransaccionBtn.Visible = false;
            DestinoPanel.Visible = false;
            ArticuloPanel.Visible = false;

        }

        protected void btnCrearMovimientoDependenci_ServerClick(object sender, EventArgs e)
        {

            if (txtDefincion.Text == "")
            {
                ShowPopUpMsg("El movimiento debe tener una descripción");
                return;
            }

            if (txtSolicitante.Text == "")
            {
                ShowPopUpMsg("El movimiento debe tener un solicitante");
                return;
            }

            if (!NuevaTransaccion())
            {
                DisableControls();
                ShowPopUpMsg("Error al crear cabecera de movimiento entre Dependencias");
            }
            else
            {
                EnableControls();
            }
        }
    }
}