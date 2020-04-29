using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
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

                ValidateRole();
            }
        }

        private void ValidateRole()
        {
            if (Session["UserRole"].ToString() == "Administrador")
            {
                AdministracionMenu.Visible = true;
                ComprasMenu.Visible = true;
                ProcesosMenu.Visible = true;
            }
            else
            {
                AdministracionMenu.Visible = false;
                ComprasMenu.Visible = false;
                ProcesosMenu.Visible = false;
            }
        }

        protected void Unnamed_ServerClick(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            Response.Cookies.Clear();
            FormsAuthentication.SignOut();


            Response.Redirect("Default.aspx");
        }
    }
}