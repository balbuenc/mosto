using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class DiarioDetalle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)this.Master.FindControl("lblActualPage")).Text = "DETALLE ASIENTO";
        }

        protected void FadeOut(string ClientID, int Time)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "script", "window.setTimeout(function() { document.getElementById('" + ClientID + "').style.display = 'none' }," + Time.ToString() + ");", true);
        }

        protected void DiarioListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {

                Label lblIdDiario = (Label)e.Item.FindControl("lblIdDiario");
                Label lblDescripcion = (Label)e.Item.FindControl("lblDescripcion");
                Label lblFecha = (Label)e.Item.FindControl("lblFecha");

                if (lblIdDiario != null)
                    txtIdDiario.Text = "#" + lblIdDiario.Text;
                if (lblDescripcion != null)
                    txtDescripcion.Text = lblDescripcion.Text;
                if (lblFecha != null)
                    txtFecha.Text = lblFecha.Text;
            }
        }

        protected void PlanCuentaListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            TextBox txtNroCuenta = (TextBox)DiarioListView.EditItem.FindControl("txtNroCuenta");
            txtNroCuenta.Text = e.CommandArgument.ToString();
        }
    }
}