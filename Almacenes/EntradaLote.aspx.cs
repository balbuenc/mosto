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
    public partial class EntradaLote : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)this.Master.FindControl("lblActualPage")).Text = "ENTRADA";
            if (!IsPostBack)
            {
                if (Request.QueryString["mode"] == "insert")
                {
                    ObtenerDatosContrato(Convert.ToInt32(this.Session["IdContratoTransaccion"].ToString()));
                    txtDefincion.Text = this.Session["DefinicionTransaccion"].ToString();
                    txtNroFactura.Text = this.Session["NroFactura"].ToString();
                    txtNotaRemision.Text = this.Session["NotaRemision"].ToString();
                    NuevaTransaccion();
                }
                else if (Request.QueryString["mode"] == "edit")
                {
                    ObtenerTransaccion(Convert.ToInt32(Request.QueryString["IdTransaccion"].ToString()));
                    Session["IdTransaccion"] = Request.QueryString["IdTransaccion"].ToString();
                }
            }
        }

        protected void FadeOut(string ClientID, int Time)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "script", "window.setTimeout(function() { document.getElementById('" + ClientID + "').style.display = 'none' }," + Time.ToString() + ");", true);
        }




        //Procedimiento que obtienen los datos del contrato según su ID desde la DB
        private void ObtenerDatosContrato(int IdContrato)
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                //Asigno a la variable de sesión el ID el contrato actual a ser consultado
                this.Session["IdContrato"] = IdContrato;

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
                        txtTipoContrato.Text = dr["Tipo"].ToString();
                        txtEstadoContrato.Text = dr["Estado"].ToString();
                    }
                }

                conn.Close();

               
            }
            catch (Exception ex)
            {
                ErrorLabel.Text = "ObtenerDatosContrato:" + ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }


        //Función que obtiene los datos de la última transacción relacionada al contrato por su ID
        private void ObtenerTransaccion(int IdTransaccion)
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                SqlConnection conn = new SqlConnection(ArticuloContratoDS.ConnectionString);
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
                        txtNroFactura.Text = dr["NroFactura"].ToString();
                        txtNotaRemision.Text = dr["NotaRemision"].ToString();

                        ObtenerDatosContrato((int)dr["IdContrato"]);
                    }
                }

                conn.Close();

                DisableTransactionControls();
            }
            catch (Exception ex)
            {
                ErrorLabel.Text = "ObtenerTransaccion: " + ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
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


        //Procedimiento que Agrega un Articulo al lote de la transacción Actual
        private void InsertarArticuloLote()
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                if (txtNroTransaccion.Text == "")
                {
                    ShowPopUpMsg("No se ha seleccionado una transacción.");
                    return;
                }

                //Control si la cantidad de entrada exede la cantidad del contrato menos la cantidad existente
                if (txtTipoContrato.Text == "N")
                {
                    if (Convert.ToInt32(txtArticuloCantidad.Text) > Convert.ToInt32(txtDiferenciaContrato.Text))
                    {
                        ShowPopUpMsg("La cantidad ingresada supera el limite del contrato.");
                        return;
                    }

                    if (Convert.ToInt32(txtArticuloCantidad.Text) <= 0)
                    {
                        ShowPopUpMsg("La cantidad ingresada debe de ser mayor a cero.");
                        return;
                    }
                }

                SqlConnection conn = new SqlConnection(ArticuloContratoDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "[warehouse].[sp_Lote_insert]";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdArticulo", IdArticuloDDL.SelectedValue);
                cmd.Parameters.AddWithValue("@Cantidad", txtArticuloCantidad.Text);
                cmd.Parameters.AddWithValue("@IdDependencia", IdDependendciaDDL.Text);
                cmd.Parameters.AddWithValue("@IdDeposito", IdDepositoDDL.Text);
                cmd.Parameters.AddWithValue("@Nrotransaccion", txtNroTransaccion.Text);


                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();
                LoteContratoListView.DataBind();

                txtArticuloCantidad.Text = "";
                txtArticuloCantidad.Focus();

            }
            catch (Exception ex)
            {
                ErrorLabel.Text = "InsertarArticuloLote: " + ex.Message;
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
                SqlConnection conn = new SqlConnection(ArticuloContratoDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "[warehouse].[sp_GenerateTransaction]";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@Definicion", txtDefincion.Text);
                cmd.Parameters.AddWithValue("@NroFactura", txtNroFactura.Text);
                cmd.Parameters.AddWithValue("@Login", Context.User.Identity.Name);
                cmd.Parameters.AddWithValue("@TipoTransaccion", "Entrada");
                cmd.Parameters.AddWithValue("@IdContrato", (int)Session["IdContrato"]);
                cmd.Parameters.AddWithValue("@Solicitante", DBNull.Value);
                cmd.Parameters.AddWithValue("@NotaRemision", txtNotaRemision.Text);

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
            txtNotaRemision.Enabled = false;
        }

        private void EnableTransactionControls()
        {
            txtNroTransaccion.Enabled = true;
            txtDefincion.Enabled = true;
            txtFecha.Enabled = true;
            txtNroFactura.Enabled = true;
            txtNotaRemision.Enabled = true;
        }



        //Procedimiento que obtienen los datos del Articulo Contrato |  precio, impuesto, Cantidad total
        private void ObtenerDatosArticuloContrato(Int32 IdArticulo)
        {
            Int32 cantDiferenciaContrato = 0;

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

                try
                {
                    //ShowPopUpMsg("Total :" + txtCantidadTotal.Text  + " Existente: " + txtExistente.Text);


                    cantDiferenciaContrato = Convert.ToInt32(txtCantidadTotal.Text.Replace(".", "")) - Convert.ToInt32(txtExistente.Text.Replace(".", ""));
                    //ShowPopUpMsg("Calculo de Dif.: " + cantDiferenciaContrato.ToString());

                    txtDiferenciaContrato.Text = cantDiferenciaContrato.ToString();
                }
                catch (Exception exp)
                {
                    ErrorLabel.Text = "ObtenerDatosArticuloContrato: Calculo de Diferencia - " + exp.Message + " : " + exp.InnerException;
                    ErrorLabel.Visible = true;
                    FadeOut(ErrorLabel.ClientID, 5000);

                }


            }
            catch (Exception ex)
            {
                ErrorLabel.Text = "ObtenerDatosArticuloContrato: " + ex.Message + " : " + ex.InnerException;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
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
            ObtenerDatosArticuloContrato(Convert.ToInt32(IdArticuloDDL.SelectedValue));
        }



        protected void LoteContratoListView_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            if (IdArticuloDDL.SelectedValue != "")
                ObtenerDatosArticuloContrato(Convert.ToInt32(IdArticuloDDL.SelectedValue));
        }

        protected void ReportTransaccionBtn_ServerClick(object sender, EventArgs e)
        {
            string url;

            url = "rptEntrada.aspx?IdTransaccion=" + Session["IdTransaccion"];

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "popup", "window.open('" + url + "','_blank')", true);
        }

        protected void EditCabeceraBtn_Click(object sender, EventArgs e)
        {
            txtDefincion.BorderColor = System.Drawing.Color.Red;
            txtNroFactura.BorderColor = System.Drawing.Color.Red;
            txtNotaRemision.BorderColor = System.Drawing.Color.Red;

            txtDefincion.Enabled = true;
            txtNroFactura.Enabled = true;
            txtNotaRemision.Enabled = true;

            AcceptCabeceraBtn.Visible = true;
            EditCabeceraBtn.Visible = false;
        }

        protected void AcceptCabeceraBtn_Click(object sender, EventArgs e)
        {
            txtDefincion.BorderColor = System.Drawing.Color.LightGray;
            txtNroFactura.BorderColor = System.Drawing.Color.LightGray;
            txtNotaRemision.BorderColor = System.Drawing.Color.LightGray;

            txtDefincion.Enabled = false;
            txtNroFactura.Enabled = false;
            txtNotaRemision.Enabled = false;

            AcceptCabeceraBtn.Visible = false;
            EditCabeceraBtn.Visible = true;

            ModificarCabeceraTransaccion();
        }

        protected void ModificarCabeceraTransaccion()
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                SqlConnection conn = new SqlConnection(ArticuloContratoDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "warehouse.sp_Transaccion_update";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@NroTransaccion", txtNroTransaccion.Text);
                cmd.Parameters.AddWithValue("@Definicion", txtDefincion.Text);
                cmd.Parameters.AddWithValue("@NroFactura", txtNroFactura.Text);
                cmd.Parameters.AddWithValue("@NotaRemision", txtNotaRemision.Text);
                cmd.Parameters.AddWithValue("@Solicitante",  DBNull.Value);


                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();
              

            }
            catch (Exception ex)
            {
                ErrorLabel.Text = "ModificarCabeceraTransaccion: " + ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }
    }
}