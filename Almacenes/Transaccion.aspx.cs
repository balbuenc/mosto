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
    public partial class Transaccion : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["Tipo"] == "Entrada")
            {
                AddTransaccionBtn.Visible = true;
                AddtransaccionSalidaBtn.Visible = false;

                Entrada10.Visible = true;
                Entrada20.Visible = true;
                Entrada30.Visible = true;
                Entrada50.Visible = true;

                Salida10.Visible = false;
                Salida20.Visible = false;
                Salida30.Visible = false;
                Salida50.Visible = false;

                ((Label)this.Master.FindControl("lblActualPage")).Text = "ENTRADAS";


            }
            else if (Request.QueryString["Tipo"] == "Salida")
            {
                AddtransaccionSalidaBtn.Visible = true;
                AddTransaccionBtn.Visible = false;

                Entrada10.Visible = false;
                Entrada20.Visible = false;
                Entrada30.Visible = false;
                Entrada50.Visible = false;

                Salida10.Visible = true;
                Salida20.Visible = true;
                Salida30.Visible = true;
                Salida50.Visible = true;

                ((Label)this.Master.FindControl("lblActualPage")).Text = "SALIDAS";


            }


            if (Request.QueryString["PageSize"] != null)
            {
                TransaccionDataPager.PageSize = Convert.ToInt16(Request.QueryString["PageSize"]);
            }

        }

        protected void SearchBtn_ServerClick(object sender, EventArgs e)
        {
            TransaccionListView.DataBind();
        }


        protected void DeleteRecord(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(TransaccionDS.ConnectionString);

            cmd = new SqlCommand("warehouse.[sp_Transaccion_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdTransaccion", ID));



            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();
            cmd.ExecuteNonQuery();



            con.Close();
        }


        protected void ListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                if (Request.QueryString["Tipo"] == "Entrada")
                {
                    Response.Redirect("EntradaLote.aspx?mode=edit&IdTransaccion=" + e.CommandArgument.ToString());
                }
                else
                {
                    Response.Redirect("SalidaLote.aspx?mode=edit&IdTransaccion=" + e.CommandArgument.ToString());
                }
            }
            else if (e.CommandName == "Eliminar")
            {
                DeleteRecord(e.CommandArgument.ToString());
                TransaccionListView.DataBind();

                ErrorLabel.Text = "El registro se eliminó correctamente.";
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 3000);
            }
            else if (e.CommandName == "ViewReport")
            {
                string url;

                if (Request.QueryString["Tipo"] == "Entrada")
                {
                    url = "rptEntrada.aspx?IdTransaccion=" + e.CommandArgument.ToString();
                }
                else
                {
                    url = "rptSalida.aspx?IdTransaccion=" + e.CommandArgument.ToString();
                }


                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "popup", "window.open('" + url + "','_blank')", true);
            }
        }


        protected void FadeOut(string ClientID, int Time)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "script", "window.setTimeout(function() { document.getElementById('" + ClientID + "').style.display = 'none' }," + Time.ToString() + ");", true);
        }


        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("transaccion.aspx?Tipo=" + Request.QueryString["Tipo"]);
        }


        protected void AddLicitacionBtn_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("TransaccionDetalle.aspx?Tipo=" + Request.QueryString["Tipo"]);
        }

        protected void InsertButton_Click(object sender, EventArgs e)
        {

            this.Session["DefinicionTransaccion"] = txtDefinicion.Text;
            this.Session["IdContratoTransaccion"] = IdContratoDDL.SelectedValue;
            this.Session["NroFactura"] = txtNroFactura.Text;
            this.Session["NotaRemision"] = txtNotaRemision.Text;

            Response.Redirect("EntradaLote.aspx?mode=insert");
        }

        void SetSessionVariables()
        {
            String idDependendencia;
            string[] tokens = txtSearchDependencia.Value.ToString().Split('#');
            idDependendencia = tokens[1];

            this.Session["DefinicionTransaccion"] = txtDefinicionSalida.Text;
            this.Session["IdDependencia"] = idDependendencia;
            this.Session["Dependencia"] = txtSearchDependencia.Value.ToString();
            this.Session["Solicitante"] = txtSolicitanteSalida.Text;
            this.Session["idContratoExistencia"] = ContratoExistenciaDDL.SelectedValue;
            this.Session["ContratoExistencia"] = ContratoExistenciaDDL.SelectedItem.Text;
        }

        protected void InsertSalidaBtn_Click(object sender, EventArgs e)
        {
            SetSessionVariables();
            Response.Redirect("SalidaLote.aspx?mode=insert");
        }

        protected void TransaccionListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            Label lblEstado = (Label)e.Item.FindControl("lblEstado");
            LinkButton DeleteTransaccionMovimientoBtn = (LinkButton)e.Item.FindControl("DeleteTransaccionBtn");
            LinkButton DetailsTransaccionBtn = (LinkButton)e.Item.FindControl("DetailsTransaccionBtn");

            if (lblEstado.Text == "Abierto")
            {
                DeleteTransaccionMovimientoBtn.Visible = true;
                DetailsTransaccionBtn.Visible = true;
                lblEstado.Attributes["class"] = "badge badge-success";
            }
            else
            {
                DeleteTransaccionMovimientoBtn.Visible = false;
                DetailsTransaccionBtn.Visible = false;
                lblEstado.Attributes["class"] = "badge badge-danger";
            }

            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                if (Request.QueryString["Tipo"] == "Entrada")
                {
                    e.Item.FindControl("tdSolicitante").Visible = false;
                }
                else if (Request.QueryString["Tipo"] == "Salida")
                {
                    e.Item.FindControl("tdNotaRemision").Visible = false;
                }
            }
        }

        protected void TransaccionListView_DataBound(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["Tipo"] == "Entrada")
                {
                    TransaccionListView.FindControl("thSolicitante").Visible = false;

                }
                else if (Request.QueryString["Tipo"] == "Salida")
                {
                    TransaccionListView.FindControl("thNotaRemision").Visible = false;

                }
            }
            catch (Exception Ex)
            {
                
            }
        }
    }
}