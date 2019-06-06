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
    public partial class SalidaLote : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["mode"] == "insert")
                {
                    txtDefincion.Text = this.Session["DefinicionTransaccion"].ToString();
                    txtSolicitante.Text = this.Session["Solicitante"].ToString();
                    txtDependencia.Text = this.Session["Dependencia"].ToString();
                    NuevaTransaccion();
                }
                else if (Request.QueryString["mode"] == "edit")
                {
                    ObtenerTransaccion(Convert.ToInt32(Request.QueryString["IdTransaccion"].ToString()));
                }
            }
        }

        protected void FadeOut(string ClientID, int Time)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "script", "window.setTimeout(function() { document.getElementById('" + ClientID + "').style.display = 'none' }," + Time.ToString() + ");", true);
        }


        //Función que obtiene los datos de la última transacción relacionada al contrato por su ID
        private void ObtenerTransaccion(int IdTransaccion)
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                SqlConnection conn = new SqlConnection(ArticuloLoteDS.ConnectionString);
                cmd.Connection = conn;

                cmd.CommandText = "[warehouse].[sp_getTransactionByID]";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdTransaccion", IdTransaccion);

                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        txtNroTransaccion.Text = dr["NroTransaccion"].ToString();
                        txtFecha.Text = dr["Fecha"].ToString();
                        txtDefincion.Text = dr["Definicion"].ToString();
                        txtSolicitante.Text = dr["Solicitante"].ToString();
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

        //Procedimiento que genera una nueva transacción para el Contrato actual
        private void NuevaTransaccion()
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
                cmd.Parameters.AddWithValue("@TipoTransaccion", "Salida");
                cmd.Parameters.AddWithValue("@IdContrato", DBNull.Value);
                cmd.Parameters.AddWithValue("@Solicitante", txtSolicitante.Text);


                // Set Output Paramater
                SqlParameter OutputParam = new SqlParameter("@NroTransaccion", SqlDbType.VarChar);
                OutputParam.Direction = ParameterDirection.Output;
                OutputParam.Size = 20;
                cmd.Parameters.Add(OutputParam);

                SqlParameter FechaParam = new SqlParameter("@Fecha", SqlDbType.VarChar);
                FechaParam.Direction = ParameterDirection.Output;
                FechaParam.Size = 10;
                cmd.Parameters.Add(FechaParam);

                conn.Open();
                cmd.ExecuteNonQuery();

                txtNroTransaccion.Text = OutputParam.Value.ToString();
                txtFecha.Text = FechaParam.Value.ToString();

                conn.Close();
            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }

        protected void AgregarArticuloBtn_Click(object sender, EventArgs e)
        {

        }
    }
}