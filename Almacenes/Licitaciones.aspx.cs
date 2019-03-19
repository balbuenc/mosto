using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes.Management
{
    public partial class Licitaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void AddLicitacionBtn_ServerClick(object sender, EventArgs e)
        {
          

            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "js_sendSMS", "$('#addModal').modal('toggle')", true);
           
        }
    }
}