using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class Boot : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.Url.LocalPath.ToString() != "/Login")
            {
                if (!Context.User.Identity.IsAuthenticated)
                {
                    string OriginalUrl = HttpContext.Current.Request.RawUrl;
                    string LoginPageUrl = "/Login.aspx";
                    HttpContext.Current.Response.Redirect(String.Format("{0}?ReturnUrl={1}", LoginPageUrl, OriginalUrl));
                }
                else
                {
                    UserLabel.Text = Context.User.Identity.Name;
                }
            }
        }
    }
}