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
    public partial class EntradaLote : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void FadeOut(string ClientID, int Time)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "script", "window.setTimeout(function() { document.getElementById('" + ClientID + "').style.display = 'none' }," + Time.ToString() + ");", true);
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
                        txtProveedor.Text = dr["Proveedor"].ToString();
                        txtLicitacion.Text = dr["Licitacion"].ToString();
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

        private void InsertarArticuloLote()
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                SqlConnection conn = new SqlConnection(ArticuloContratoDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "[warehouse].[sp_Lote_insert]";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdArticulo", IdArticuloDDL.SelectedValue);
                cmd.Parameters.AddWithValue("@Cantidad", txtArticuloCantidad.Text);
                cmd.Parameters.AddWithValue("@IdDependencia", IdDependendciaDDL.Text);
                cmd.Parameters.AddWithValue("@IdDeposito", IdDepositoDDL.Text);


                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();
                LoteContratoListView.DataBind();

                txtArticuloCantidad.Text = "";

            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }

        private void NuevaTransaccion()
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                SqlConnection conn = new SqlConnection(ArticuloContratoDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "[warehouse].[sp_GenerateTransaction]";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@Definicion", txtDefincion.Text);
                cmd.Parameters.AddWithValue("@NroFactura", txtNroFactura.Text);
                cmd.Parameters.AddWithValue("@Login", Context.User.Identity.Name);
                cmd.Parameters.AddWithValue("@TipoTransaccion", "Entrada");

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

                DisableTransactionControls();


            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }

        private void DisableTransactionControls()
        {
            txtNroTransaccion.Enabled = false;
            txtDefincion.Enabled = false;
            txtFecha.Enabled = false;
            txtNroFactura.Enabled = false;
        }

        private void EnableTransactionControls()
        {
            txtNroTransaccion.Enabled = true;
            txtDefincion.Enabled = true;
            txtFecha.Enabled = true;
            txtNroFactura.Enabled = true;
        }

        private void ObtenerDatosArticuloContrato(Int32 IdArticulo)
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                SqlConnection conn = new SqlConnection(ArticuloContratoDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "warehouse.[sp_ArticuloContrato_get_ArticuloContrato]";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdArticulo", IdArticulo);


                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        txtPrecio.Text = string.Format("{0:N0}", dr["Precio"]);
                        txtImpuesto.Text = string.Format("{0:N0}", dr["PrecioImpuesto"]);
                        txtCantidadTotal.Text = string.Format("{0:N0}", dr["CantidadTotal"]);
                        txtExistente.Text = string.Format("{0:N0}", dr["Existente"]);
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

        protected void SearchContratoBtn_Click(object sender, EventArgs e)
        {
            string[] broker = txtSearchContrato.Value.ToString().Split('|');
            string[] id = broker[2].Split('#');
            txtNroContrato.Text = broker[0].TrimEnd(' ');
            ObtenerDatosContrato(Convert.ToInt32(id[1]));
            IdArticuloDDL.DataBind();
        }

        protected void IdArticuloDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            ObtenerDatosArticuloContrato(Convert.ToInt32(((DropDownList)sender).SelectedValue));
        }

        protected void IdArticuloDDL_DataBound(object sender, EventArgs e)
        {
            if (((DropDownList)sender).SelectedValue != "")
                ObtenerDatosArticuloContrato(Convert.ToInt32(((DropDownList)sender).SelectedValue));
        }

        protected void AgregarArticuloBtn_Click(object sender, EventArgs e)
        {
            InsertarArticuloLote();
        }

        protected void ReporteBtn_Click(object sender, EventArgs e)
        {
            string url = "http://app.enigmatech.biz/ReportServer/Pages/ReportViewer.aspx?%2fAlmacenesSSRS%2fLotesEntrada&rs:Command=Render&NroContrato=" + txtNroContrato.Text;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "popup", "window.open('" + url + "','_blank')", true);
        }

        protected void NewTransactionBtn_Click(object sender, EventArgs e)
        {
            NuevaTransaccion();
        }
    }
}