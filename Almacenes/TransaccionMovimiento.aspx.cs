using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class TransaccionMovimiento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddTransaccionBtn_ServerClick(object sender, EventArgs e)
        {
            if (Request.QueryString["tipo"] == "Dependencia")
            {
                Response.Redirect("/MovimientoDependencias.aspx?mode=insert");
            }
            else
            {
                return;
            }
            
        }

        protected void SearchBtn_ServerClick(object sender, EventArgs e)
        {
            TransaccionListView.DataBind();
        }
    }
}