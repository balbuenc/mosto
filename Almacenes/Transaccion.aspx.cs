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
            divTitle.InnerText = Request.QueryString["Tipo"];
            if (Request.QueryString["Tipo"] == "Entrada")
            {
                AddTransaccionBtn.Visible = true;
                AddtransaccionSalidaBtn.Visible = false;
            }
            else
            {
                AddtransaccionSalidaBtn.Visible = true;
                AddTransaccionBtn.Visible = false;
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
            this.Session["DefinicionTransaccion"] = txtDefinicionSalida.Text;
            this.Session["IdDependencia"] = DependenciaDDL.SelectedValue;
            this.Session["Dependencia"] = DependenciaDDL.SelectedItem.Text;
            this.Session["Solicitante"] = txtSolicitanteSalida.Text;
            this.Session["idContratoExistencia"] = ContratoExistenciaDDL.SelectedValue;
            this.Session["ContratoExistencia"] = ContratoExistenciaDDL.SelectedItem.Text;
        }

        protected void InsertSalidaBtn_Click(object sender, EventArgs e)
        {
            SetSessionVariables();
            Response.Redirect("SalidaLote.aspx?mode=insert");
        }
    }
}