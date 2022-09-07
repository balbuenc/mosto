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
                    //ProcesosMenu.Visible = ((int[])Session["vProcesosMenu"])[1] == 1 ? true : false;
                    //ContabilidadMenu.Visible = ((int[])Session["vContabilidadMenu"])[1] == 1 ? true : false;
                    ReportesMenu.Visible = ((int[])Session["vReportesMenu"])[1] == 1 ? true : false;

                    //Menu secundarions ADMINISTRACION
                    TipodeLicitacionesMenu.Visible = ((int[])Session["vTipodeLicitaciones"])[1] == 1 ? true : false;
                    TipodeContactoMenu.Visible = ((int[])Session["vTipodeContacto"])[1] == 1 ? true : false;
                    ImpuestosMenu.Visible = ((int[])Session["vImpuestos"])[1] == 1 ? true : false;
                    UnidaddeMedidaMenu.Visible = ((int[])Session["vUnidaddeMedida"])[1] == 1 ? true : false;
                    //DependenciasMenu.Visible = ((int[])Session["vDependencias"])[1] == 1 ? true : false;
                    //DepositosMenu.Visible = ((int[])Session["vDepositos"])[1] == 1 ? true : false;
                    UsuariosMenu.Visible = ((int[])Session["vUsuarios"])[1] == 1 ? true : false;
                    RolesMenu.Visible = ((int[])Session["vRoles"])[1] == 1 ? true : false;
                    SeguridadMenu.Visible = ((int[])Session["vSeguridad"])[1] == 1 ? true : false;

                    //Menu Secundario COMPRAS
                    LicitacionesMenu.Visible = ((int[])Session["vLicitaciones"])[1] == 1 ? true : false;
                    ProveedoresMenu.Visible = ((int[])Session["vProveedores"])[1] == 1 ? true : false;
                    //ContactosMenu.Visible = ((int[])Session["vContactos"])[1] == 1 ? true : false;
                    ArticulosMenu.Visible = ((int[])Session["vArticulos"])[1] == 1 ? true : false;
                    CodigosdeBarraMenu.Visible = ((int[])Session["vCodigosdeBarra"])[1] == 1 ? true : false;
                    ContratosMenu.Visible = ((int[])Session["vContratos"])[1] == 1 ? true : false;

                    // Menu secundario PROCESOS
                    //OperacionesdeEntradasMenu.Visible = ((int[])Session["vOperacionesdeEntradas"])[1] == 1 ? true : false;
                    //OperacionesdeSalidasMenu.Visible = ((int[])Session["vOperacionesdeSalidas"])[1] == 1 ? true : false;
                    //MovimientoporDependenciasMenu.Visible = ((int[])Session["vMovimientoporDependencias"])[1] == 1 ? true : false;
                    //MovimientoporDepositosMenu.Visible = ((int[])Session["vMovimientoporDepositos"])[1] == 1 ? true : false;
                    //InventarioMenu.Visible = ((int[])Session["vInventario"])[1] == 1 ? true : false;

                    //Menu secundario CONTABILIDAD
                    //PlandeCuentasMenu.Visible = ((int[])Session["vPlandeCuentas"])[1] == 1 ? true : false;
                    //TipodeCuentasMenu.Visible = ((int[])Session["vTipodeCuentas"])[1] == 1 ? true : false;
                    //AsiganciondecuentasMenu.Visible = ((int[])Session["vAsiganciondecuentas"])[1] == 1 ? true : false;
                    //LibrodiarioMenu.Visible = ((int[])Session["vLibrodiario"])[1] == 1 ? true : false;

                    //Menu secundario REPORTES
                    ExistenciapordespositosMenu.Visible = ((int[])Session["vExistenciapordespositos"])[1] == 1 ? true : false;
                    //ExistenciapordependenciaMenu.Visible = ((int[])Session["vExistenciapordependencia"])[1] == 1 ? true : false;
                    //ExistenciaglobalMenu.Visible = ((int[])Session["vExistenciaglobal"])[1] == 1 ? true : false;
                    //EntradasMenu.Visible = ((int[])Session["vEntradas"])[1] == 1 ? true : false;
                    //SalidasMenu.Visible = ((int[])Session["vSalidas"])[1] == 1 ? true : false;
                    //MovimientodependenciasMenu.Visible = ((int[])Session["vMovimientodependencias"])[1] == 1 ? true : false;
                    //LibroMenu.Visible = ((int[])Session["vLibro"])[1] == 1 ? true : false;
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