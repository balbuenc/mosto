
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
            ((Label)this.Master.FindControl("lblActualPage")).Text = "MOVIMIENTO DEPENDENCIAS";
            if (!IsPostBack)
            {
                if (Request.QueryString["mode"] == "insert")
                {
                    DependenciaDDL.Enabled = true;
                    txtDefincion.Enabled = true;
                    txtSolicitante.Enabled = true;
                    CrearMovimientoBtn.Visible = true;
                }
                else if (Request.QueryString["mode"] == "edit" && Request.QueryString["IdTransaccion"] != null)
                {
                    DependenciaDDL.Enabled = false;
                    txtDefincion.Enabled = false;
                    txtSolicitante.Enabled = false;
                    CrearMovimientoBtn.Visible = false;
                    DestinoPanel.Visible = true;
                    ArticuloPanel.Visible = true;

                    DependenciaDDL.DataBind();

                    ObtenerTransaccion(Convert.ToInt32(Request.QueryString["IdTransaccion"].ToString()));
                    Session["IdTransaccion"] = Request.QueryString["IdTransaccion"].ToString();

                    DependenciaMovimientosListView.DataBind();
                    IdArticuloDDL.DataBind();
                }
                else if (Request.QueryString["mode"] == "view" && Request.QueryString["IdTransaccion"] != null)
                {
                    DependenciaDDL.Enabled = false;
                    DependenciaDDL.DataBind();
                    IdArticuloDDL.DataBind();

                    txtDefincion.Enabled = false;
                    txtSolicitante.Enabled = false;

                    CrearMovimientoBtn.Visible = false;
                    CerrarMovimientoBtn.Visible = false;

                    DestinoPanel.Visible = false;
                    ArticuloPanel.Visible = true;

                    ArticuloPanel.Enabled = false;
                    DestinoPanel.Enabled = false;

                    

                    ObtenerTransaccion(Convert.ToInt32(Request.QueryString["IdTransaccion"].ToString()));
                    Session["IdTransaccion"] = Request.QueryString["IdTransaccion"].ToString();

                    DependenciaMovimientosDS.SelectCommand = "[warehouse].[sp_DependenciaMovimiento_get_all]";
                    DependenciaMovimientosDS.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;

                    DependenciaMovimientosDS.SelectParameters.Clear();
                    DependenciaMovimientosDS.SelectParameters.Add("NroTransaccion", txtNroTransaccion.Text);

                    DependenciaMovimientosListView.DataBind();

                    ReportTransaccionBtn.Visible = true;


                }
                else
                {
                    DependenciaDDL.Enabled = false;
                    txtDefincion.Enabled = false;
                    txtSolicitante.Enabled = false;
                    CrearMovimientoBtn.Visible = false;
                }
            }
        }

        protected void IdArticuloDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            ObtenerDatosArticuloLote(Convert.ToInt32(((DropDownList)sender).SelectedValue));
        }

        //Función que obtiene los datos de la última transacción relacionada al contrato por su ID
        private void ObtenerTransaccion(int IdTransaccion)
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                SqlConnection conn = new SqlConnection(DependenciaMovimientosDS.ConnectionString);
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

                        DependenciaDDL.SelectedValue = dr["IdDependenciaAnterior"].ToString();

                        //DependenciaDDL.SelectedIndex = -1;

                        //DependenciaDDL.Items.FindByValue(IdDependenciaActual).Selected = true;


                    }
                }

                conn.Close();


            }
            catch (Exception ex)
            {
                ErrorLabel.Text = "ObtenerTransaccion: " + ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
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

                        txtExistente.Text = string.Format("{0:N0}", dr["CantidadStaging"]);

                    }
                }

                txtExistente.Text = txtExistente.Text.Replace(".", "");

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
            //ReportTransaccionBtn.Visible = true;
            DestinoPanel.Visible = true;
            ArticuloPanel.Visible = true;
        }

        protected void DisableControls()
        {
            ReportTransaccionBtn.Visible = false;
            DestinoPanel.Visible = false;
            ArticuloPanel.Visible = false;

        }



        //Procedimiento que Agrega un Articulo al lote de la transacción Actual
        private void InsertarArticuloMovimiento()
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                if (txtNroTransaccion.Text == "")
                {
                    ShowPopUpMsg("No se ha seleccionado una transacción.");
                    return;
                }

                if (Convert.ToInt32(txtExistente.Text) < Convert.ToInt32(txtArticuloCantidad.Text))
                {
                    ShowPopUpMsg("La cantidad solicitada supera la existencia del artículo.");
                    return;
                }

                if (Convert.ToInt32(txtArticuloCantidad.Text) <= 0)
                {
                    ShowPopUpMsg("La cantidad solicitada debe ser mayor a cero.");
                    return;
                }

                if (txtArticuloCantidad.Text == "")
                {
                    ShowPopUpMsg("La cantidad solicitada no es válida.");
                    return;
                }


                SqlConnection conn = new SqlConnection(ArticuloLoteDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "warehouse.sp_DependenciasMovimientos";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdTransaccion", Session["idTransaccion"]);
                cmd.Parameters.AddWithValue("@Login", Context.User.Identity.Name);
                cmd.Parameters.AddWithValue("@IdDependenciaAnterior", DependenciaDDL.SelectedValue);
                cmd.Parameters.AddWithValue("@IdDependenciaActual", DependenciaDestinoDDL.SelectedValue);
                cmd.Parameters.AddWithValue("@Cantidad", txtArticuloCantidad.Text);
                cmd.Parameters.AddWithValue("@IdLoteOrigen", IdArticuloDDL.SelectedValue);
                cmd.Parameters.AddWithValue("@Descripcion", txtDefincion.Text);
                cmd.Parameters.AddWithValue("@Solicitante", txtSolicitante.Text);


                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();
                DependenciaMovimientosListView.DataBind();

                txtArticuloCantidad.Text = "";

            }
            catch (Exception ex)
            {
                ShowPopUpMsg("Error al Registrar movimiento : " + ex.Message);
                return;
            }
        }

        protected void AgregarArticuloBtn_Click(object sender, EventArgs e)
        {
            InsertarArticuloMovimiento();
            IdArticuloDDL.DataBind();
        }

        protected void CrearMovimientoBtn_Click(object sender, EventArgs e)
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

                DependenciaDDL.Enabled = false;
                txtDefincion.Enabled = false;
                txtSolicitante.Enabled = false;
                CrearMovimientoBtn.Visible = false;
            }
        }

        protected void CerrarMovimientoBtn_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand();
            try
            {

                SqlConnection conn = new SqlConnection(ArticuloLoteDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "staging.sp_Transaccion_Close";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdTransaccion", Session["idTransaccion"]);
                cmd.Parameters.AddWithValue("@Login", Context.User.Identity.Name);


                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                Response.Redirect("TransaccionMovimiento.aspx?Tipo=Dependencia");
            }
            catch (Exception ex)
            {
                ShowPopUpMsg("Error al Cerrar transacción: " + ex.Message);
                return;
            }
        }

        protected void DependenciaMovimientosListView_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            IdArticuloDDL.DataBind();
        }

        protected void ReportTransaccionBtn_ServerClick(object sender, EventArgs e)
        {
            string url;

            url = "rptMovimientoDependencias.aspx?NroTransaccion=" + txtNroTransaccion.Text;

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "popup", "window.open('" + url + "','_blank')", true);
        }
    }
}