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
    public partial class SalidaLote : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)this.Master.FindControl("lblActualPage")).Text = "SALIDA DE ARTÍCULOS";
            if (!IsPostBack)
            {
                if (Request.QueryString["mode"] == "insert")
                {
                    txtDefincion.Text = this.Session["DefinicionTransaccion"].ToString();
                    txtSolicitante.Text = this.Session["Solicitante"].ToString();
                    txtDependencia.Text = this.Session["Dependencia"].ToString();
                    txtContrato.Text = this.Session["ContratoExistencia"].ToString();

                    IdArticuloDDL.DataBind();

                    ArticuloPanel.Visible = false;

                    ReportTransaccionBtn.Visible = false;
                    CrearTransaccionBtn.Visible = true;
                    CerrarTransaccionBtn.Visible = false;
                }
                else if (Request.QueryString["mode"] == "edit")
                {
                    ObtenerTransaccion(Convert.ToInt32(Request.QueryString["IdTransaccion"].ToString()));
                    Session["IdTransaccion"] = Request.QueryString["IdTransaccion"].ToString();
                    ArticuloLoteDS.DataBind();
                    LoteContratoDS.DataBind();
                    SalidaLoteListView.DataBind();

                    ArticuloPanel.Visible = true;

                    ReportTransaccionBtn.Visible = true;
                    CrearTransaccionBtn.Visible = false;
                    if (ExisteItemSalida())
                    {
                        CerrarTransaccionBtn.Visible = true;
                    }
                }
            }
        }

        protected void CrearTransaccionBtn_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["mode"] == "insert")
            {
                if (NuevaTransaccion())
                {
                    SalidaLoteListView.DataBind();
                    ArticuloPanel.Visible = true;
                    CrearTransaccionBtn.Visible = false;
                    ReportTransaccionBtn.Visible = true;

                    if (ExisteItemSalida())
                    {
                        CerrarTransaccionBtn.Visible = true;
                    }
                }

            }
        }

        protected bool ExisteItemSalida()
        {
            if (SalidaLoteListView.Items.Count > 0)
                return true;
            else
                return false;
        }

        protected void CerrarTransaccionBtn_Click(object sender, EventArgs e)
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

                Response.Redirect("Transaccion.aspx?Tipo=Salida");
            }
            catch (Exception ex)
            {
                ShowPopUpMsg("Error al Cerrar transacción: " + ex.Message);
                return;
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
                        txtContrato.Text = dr["Contrato"].ToString();
                        this.Session["IdContratoExistencia"] = dr["IdContrato"].ToString();
                        this.Session["IdDependencia"] = dr["IdDependencia"].ToString();
                        txtDependencia.Text = dr["Dependencia"].ToString();
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


        //Función que genera una nueva transacción para el Contrato actual y devuelve el resultado (TRUE/FALSE)
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
                cmd.Parameters.AddWithValue("@TipoTransaccion", "Salida");
                cmd.Parameters.AddWithValue("@IdContrato", this.Session["IdContratoExistencia"].ToString());
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


        //Procedimiento que Agrega un Articulo al lote de la transacción Actual
        private void InsertarArticuloSalidaLote()
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                if (txtNroTransaccion.Text == "")
                {
                    ShowPopUpMsg("No se ha seleccionado una transacción.");
                    return;
                }

                if (Convert.ToInt32(txtExistente.Text.Replace(".","")) < Convert.ToInt32(txtArticuloCantidad.Text))
                {
                    ShowPopUpMsg("La cantidad solicitada supera la existencia del artículo.");
                    return;
                }

                if (Convert.ToInt32(txtArticuloCantidad.Text) <= 0)
                {
                    ShowPopUpMsg("La cantidad ingresada debe de ser mayor a cero.");
                    return;
                }

                if (txtArticuloCantidad.Text == "")
                {
                    ShowPopUpMsg("La cantidad solicitada no es válida.");
                    return;
                }


                SqlConnection conn = new SqlConnection(ArticuloLoteDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "[warehouse].[sp_SalidaLote_insert]";
                cmd.CommandType = CommandType.StoredProcedure;



                cmd.Parameters.AddWithValue("@IdLote", IdArticuloDDL.SelectedValue);
                cmd.Parameters.AddWithValue("@CantidadSalida", txtArticuloCantidad.Text);
                cmd.Parameters.AddWithValue("@IdDependencia", this.Session["IdDependencia"].ToString());

                cmd.Parameters.AddWithValue("@Nrotransaccion", txtNroTransaccion.Text);


                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                SalidaLoteListView.DataBind();


                txtArticuloCantidad.Text = "";
                txtArticuloCantidad.Focus();


            }
            catch (Exception ex)
            {
                ShowPopUpMsg("La cantidad solicitada no es válida.");
                return;
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

                cmd.CommandText = "warehouse.sp_ArticuloLote_get_ArticuloLote_Salida";
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

                conn.Close();

            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }


        protected void IdArticuloDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            ObtenerDatosArticuloLote(Convert.ToInt32(((DropDownList)sender).SelectedValue));
        }


        protected void IdArticuloDDL_DataBound(object sender, EventArgs e)
        {
            if (((DropDownList)sender).SelectedValue != "")
                ObtenerDatosArticuloLote(Convert.ToInt32(((DropDownList)sender).SelectedValue));
        }

        protected void AgregarArticuloBtn_Click(object sender, EventArgs e)
        {
            InsertarArticuloSalidaLote();
            IdArticuloDDL.DataBind();

            if (ExisteItemSalida())
            {
                CerrarTransaccionBtn.Visible = true;
            }
        }


        protected void SalidaLoteListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {

                Label lblDependencia = (Label)e.Item.FindControl("lblDependencia");
                this.Session["idDependencia"] = ((Label)e.Item.FindControl("lblIdDependencia")).Text;

                txtDependencia.Text = lblDependencia.Text;

            }
           
        }

        protected void SalidaLoteListView_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            IdArticuloDDL.DataBind();
            SalidaLoteListView.DataBind();
           
        }

        protected void ReportTransaccionBtn_ServerClick(object sender, EventArgs e)
        {
            string url;

            url = "rptSalida.aspx?IdTransaccion=" + Session["IdTransaccion"];

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "popup", "window.open('" + url + "','_blank')", true);
        }



        protected void EditCabeceraBtn_Click(object sender, EventArgs e)
        {
            txtDefincion.BorderColor = System.Drawing.Color.Red;
            txtSolicitante.BorderColor = System.Drawing.Color.Red;


            txtDefincion.Enabled = true;
            txtSolicitante.Enabled = true;


            AcceptCabeceraBtn.Visible = true;
            EditCabeceraBtn.Visible = false;
        }

        protected void AcceptCabeceraBtn_Click(object sender, EventArgs e)
        {
            txtDefincion.BorderColor = System.Drawing.Color.LightGray;
            txtSolicitante.BorderColor = System.Drawing.Color.LightGray;


            txtDefincion.Enabled = false;
            txtSolicitante.Enabled = false;


            AcceptCabeceraBtn.Visible = false;
            EditCabeceraBtn.Visible = true;

            ModificarCabeceraTransaccion();
        }

        protected void ModificarCabeceraTransaccion()
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                SqlConnection conn = new SqlConnection(LoteContratoDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "warehouse.sp_Transaccion_update";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@NroTransaccion", txtNroTransaccion.Text);
                cmd.Parameters.AddWithValue("@Definicion", txtDefincion.Text);
                cmd.Parameters.AddWithValue("@NroFactura", DBNull.Value);
                cmd.Parameters.AddWithValue("@NotaRemision", DBNull.Value);
                cmd.Parameters.AddWithValue("@Solicitante", txtSolicitante.Text);


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