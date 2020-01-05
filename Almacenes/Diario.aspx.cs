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
    public partial class Diario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)this.Master.FindControl("lblActualPage")).Text = "LIBRO DIARIO";
            if (Request.QueryString["PageSize"] != null)
            {
                DiarioDataPager.PageSize = Convert.ToInt16(Request.QueryString["PageSize"]);
            }
        }

        protected void SearchBtn_ServerClick(object sender, EventArgs e)
        {
            DiarioListView.DataBind();
        }

        protected void ListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                Response.Redirect("DiarioDetalle.aspx?IdDiario=" + e.CommandArgument.ToString());
            }
           
        }


        protected void FadeOut(string ClientID, int Time)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "script", "window.setTimeout(function() { document.getElementById('" + ClientID + "').style.display = 'none' }," + Time.ToString() + ");", true);
        }

        
    }
}