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
    public partial class Contrato : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)this.Master.FindControl("lblActualPage")).Text = "FACTURAS";
            if (Request.QueryString["PageSize"] != null)
            {
                ContratoDataPager.PageSize = Convert.ToInt16(Request.QueryString["PageSize"]);
            }

            //Authorize User Role
            if (Session["SecureMatrix"] == null)
            {
                string OriginalUrl = HttpContext.Current.Request.RawUrl;
                string LoginPageUrl = "/Login.aspx";
                HttpContext.Current.Response.Redirect(String.Format("{0}?ReturnUrl={1}", LoginPageUrl, OriginalUrl));
            }

            Utils.Authorization("vContratos");
            AddRegistroBtn.Visible = Utils.WRITE;

        }

        protected void SearchBtn_ServerClick(object sender, EventArgs e)
        {
            ContratoListView.DataBind();
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
                Response.Redirect("ContratoDetalle.aspx?IdContrato=" + e.CommandArgument.ToString());
            }
            else if (e.CommandName == "Eliminar")
            {
                DeleteRecord(e.CommandArgument.ToString());
                ContratoListView.DataBind();

                ErrorLabel.Text = "El registro se eliminó correctamente.";
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 3000);
            }
        }


        protected void FadeOut(string ClientID, int Time)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "script", "window.setTimeout(function() { document.getElementById('" + ClientID + "').style.display = 'none' }," + Time.ToString() + ");", true);
        }





        protected void AddLicitacionBtn_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("ContratoDetalle.aspx");
        }

        protected void ContratoListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            Label lblEstado = (Label)e.Item.FindControl("lblEstado");
            LinkButton DeleteContratoBtn = (LinkButton)e.Item.FindControl("DeleteContratoBtn");
            LinkButton EditContratoBtn = (LinkButton)e.Item.FindControl("EditContratoBtn");

           

            try
            {
                EditContratoBtn.Enabled = Utils.UPDATE;
                DeleteContratoBtn.Enabled = Utils.DELETE;

                if (lblEstado.Text == "Finalizado")
                {
                    DeleteContratoBtn.Visible = false;
                    EditContratoBtn.Visible = false;
                    lblEstado.Attributes["class"] = "badge badge-danger";
                }
                else
                {
                    DeleteContratoBtn.Visible = true;
                    EditContratoBtn.Visible = true;
                    lblEstado.Attributes["class"] = "badge badge-success";
                }
            }
            catch (Exception ex)
            {
                return;
            }
        }
    }
}