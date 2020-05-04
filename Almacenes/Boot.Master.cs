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
                if (!Context.User.Identity.IsAuthenticated || Session["SecureMatrix"] == null)
                {
                    string OriginalUrl = HttpContext.Current.Request.RawUrl;
                    string LoginPageUrl = "/Login.aspx";
                    HttpContext.Current.Response.Redirect(String.Format("{0}?ReturnUrl={1}", LoginPageUrl, OriginalUrl));
                }
                else
                {
                    UserLabel.Text = Context.User.Identity.Name;


                    //Habilito los Accesos al menu principal (Si estan con privilegio de lectura [1] == 1)
                    AdministracionMenu.Visible = ((int[])Session["vAdministracionMenu"])[1] == 1 ? true : false;
                    ComprasMenu.Visible = ((int[])Session["vComprasMenu"])[1] == 1 ? true : false;
                    ProcesosMenu.Visible = ((int[])Session["vProcesosMenu"])[1] == 1 ? true : false;
                    ContabilidadMenu.Visible = ((int[])Session["vContabilidadMenu"])[1] == 1 ? true : false;
                    ReportesMenu.Visible = ((int[])Session["vReportesMenu"])[1] == 1 ? true : false;

                    //Menu secundarions ADMINISTRACION
                    TipodeLicitacionesMenu.Visible = ((int[])Session["vTipodeLicitaciones"])[1] == 1 ? true : false;
                    TipodeContactoMenu.Visible = ((int[])Session["vTipodeContacto"])[1] == 1 ? true : false;
                    ImpuestosMenu.Visible = ((int[])Session["vImpuestos"])[1] == 1 ? true : false;
                    UnidaddeMedidaMenu.Visible = ((int[])Session["vUnidaddeMedida"])[1] == 1 ? true : false;
                    DependenciasMenu.Visible = ((int[])Session["vDependencias"])[1] == 1 ? true : false;
                    DepositosMenu.Visible = ((int[])Session["vDepositos"])[1] == 1 ? true : false;
                    UsuariosMenu.Visible = ((int[])Session["vUsuarios"])[1] == 1 ? true : false;
                    RolesMenu.Visible = ((int[])Session["vRoles"])[1] == 1 ? true : false;
                    SeguridadMenu.Visible = ((int[])Session["vSeguridad"])[1] == 1 ? true : false;
                }

                
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