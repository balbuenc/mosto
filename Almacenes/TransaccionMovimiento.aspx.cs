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
            if (Request.QueryString["Tipo"] == "Dependencia")
            {
                AddTransaccionDependenciaBtn.Visible = true;
                AddtransaccionDepositoBtn.Visible = false;

                Dependencia10.Visible = true;
                Dependencia20.Visible = true;
                Dependencia30.Visible = true;
                Dependencia50.Visible = true;

                Deposito10.Visible = false;
                Deposito20.Visible = false;
                Deposito30.Visible = false;
                Deposito50.Visible = false;

            }
            else if (Request.QueryString["Tipo"] == "Deposito")
            {
                AddtransaccionDepositoBtn.Visible = true;
                AddTransaccionDependenciaBtn.Visible = false;

                Dependencia10.Visible = false;
                Dependencia20.Visible = false;
                Dependencia30.Visible = false;
                Dependencia50.Visible = false;

                Deposito10.Visible = true;
                Deposito20.Visible = true;
                Deposito30.Visible = true;
                Deposito50.Visible = true;
            }

            if (Request.QueryString["PageSize"] != null)
            {
                TransaccionDataPager.PageSize = Convert.ToInt16(Request.QueryString["PageSize"]);
            }

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