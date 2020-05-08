using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void ValidateRole()
        {
            

            //Cargo la matriz de seguridad desde la DB [W][R][D][U]
            //Menu Principales
            Session["vAdministracionMenu"] = Utils.GetSecurityPrivilege("Administracion.Menu");
            Session["vComprasMenu"] = Utils.GetSecurityPrivilege("Compras.Menu");
            Session["vProcesosMenu"] = Utils.GetSecurityPrivilege("Procesos.Menu");
            Session["vContabilidadMenu"] = Utils.GetSecurityPrivilege("Contabilidad.Menu");
            Session["vReportesMenu"] = Utils.GetSecurityPrivilege("Reportes.Menu");

            //Menu secundario ADMINISTRACION
            Session["vTipodeLicitaciones"] = Utils.GetSecurityPrivilege("Administracion.TipodeLicitaciones");
            Session["vTipodeContacto"] = Utils.GetSecurityPrivilege("Administracion.TipodeContacto");
            Session["vImpuestos"] = Utils.GetSecurityPrivilege("Administracion.Impuestos");
            Session["vUnidaddeMedida"] = Utils.GetSecurityPrivilege("Administracion.UnidaddeMedida");
            Session["vDependencias"] = Utils.GetSecurityPrivilege("Administracion.Dependencias");
            Session["vDepositos"] = Utils.GetSecurityPrivilege("Administracion.Depositos");
            Session["vUsuarios"] = Utils.GetSecurityPrivilege("Administracion.Usuarios");
            Session["vRoles"] = Utils.GetSecurityPrivilege("Administracion.Roles");
            Session["vSeguridad"] = Utils.GetSecurityPrivilege("Administracion.Seguridad");

            //Menu secundario COMPRAS           
            Session["vLicitaciones"] = Utils.GetSecurityPrivilege("Compras.Licitaciones");
            Session["vProveedores"] = Utils.GetSecurityPrivilege("Compras.Proveedores");
            Session["vContratos"] = Utils.GetSecurityPrivilege("Compras.Contratos");
            Session["vContactos"] = Utils.GetSecurityPrivilege("Compras.Contactos");
            Session["vArticulos"] = Utils.GetSecurityPrivilege("Compras.Articulos");
            Session["vCodigosdeBarra"] = Utils.GetSecurityPrivilege("Compras.CodigosdeBarra");

            //Menu secundario PROCESOS
            Session["vOperacionesdeEntradas"] = Utils.GetSecurityPrivilege("Procesos.OperacionesdeEntradas");
            Session["vOperacionesdeSalidas"] = Utils.GetSecurityPrivilege("Procesos.OperacionesdeSalidas");
            Session["vMovimientoporDependencias"] = Utils.GetSecurityPrivilege("Procesos.MovimientoporDependencias");
            Session["vMovimientoporDepositos"] = Utils.GetSecurityPrivilege("Procesos.MovimientoporDepositos");
            Session["vInventario"] = Utils.GetSecurityPrivilege("Procesos.Inventario");

            //Menu secundario CONTABILIDAD
            Session["vPlandeCuentas"] = Utils.GetSecurityPrivilege("Contabilidad.PlandeCuentas");
            Session["vTipodeCuentas"] = Utils.GetSecurityPrivilege("Contabilidad.TipodeCuentas");
            Session["vAsiganciondecuentas"] = Utils.GetSecurityPrivilege("Contabilidad.Asiganciondecuentas");
            Session["vLibrodiario"] = Utils.GetSecurityPrivilege("Contabilidad.Librodiario");

            //Menu nsecundario REPORTES
            Session["vExistenciapordespositos"] = Utils.GetSecurityPrivilege("Reportes.Existenciapordespositos");
            Session["vExistenciapordependencia"] = Utils.GetSecurityPrivilege("Reportes.Existenciapordependencia");
            Session["vExistenciaglobal"] = Utils.GetSecurityPrivilege("Reportes.Existenciaglobal");
            Session["vEntradas"] = Utils.GetSecurityPrivilege("Reportes.Entradas");
            Session["vSalidas"] = Utils.GetSecurityPrivilege("Reportes.Salidas");
            Session["vMovimientodependencias"] = Utils.GetSecurityPrivilege("Reportes.Movimientodependencias");
            Session["vLibro"] = Utils.GetSecurityPrivilege("Reportes.Libro");

        }

        bool ValidateUser(string UserName, String Password)
        {
            SqlCommand cmd = new SqlCommand();

            try
            {
                string cs = ConfigurationManager.ConnectionStrings["AlmacenesConnectionString"].ConnectionString;
                SqlConnection conn = new SqlConnection(cs);

                cmd.Connection = conn;

                cmd.CommandText = "[secure].[sp_User_Validate]";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@UserName", UserName);
                cmd.Parameters.AddWithValue("@Password", Password);

                SqlParameter RetParam = new SqlParameter("@Authentincated", SqlDbType.Int);
                RetParam.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(RetParam);

                conn.Open();
                cmd.ExecuteNonQuery();

                int IntReturn = Convert.ToInt32(cmd.Parameters["@Authentincated"].Value);

                conn.Close();

                Session["UserRole"] = GetUserRole(UserName);
                Session["SecureMatrix"] = SetSecureMatrix(Session["UserRole"].ToString());

                ValidateRole();

                if (IntReturn == 1)
                {
                    return true;
                }
                else
                {
                    return false;
                }


            }
            catch (Exception ex)
            {
                Msg.Text = ex.Message;
                return false;


            }


        }

        private JObject SetSecureMatrix(string RoleName)
        {
            SqlCommand cmd = new SqlCommand();
            JObject arrayList;
            string jsonResult;
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["AlmacenesConnectionString"].ConnectionString;
                SqlConnection conn = new SqlConnection(cs);

                cmd.Connection = conn;

                cmd.CommandText = "[secure].[sp_get_RolePrivileges]";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@RoleName", RoleName);

                // Set Output Paramater
                SqlParameter OutputParam = new SqlParameter("@json", SqlDbType.NVarChar);
                OutputParam.Direction = ParameterDirection.Output;
                OutputParam.Size = 8000;
                cmd.Parameters.Add(OutputParam);

                conn.Open();

                cmd.ExecuteNonQuery();



                conn.Close();


                jsonResult = OutputParam.Value.ToString();


                arrayList = JObject.Parse(jsonResult);

                return arrayList;

            }
            catch (Exception ex)
            {
                Msg.Text = ex.Message;
                return null;
            }
        }


        public string GetUserRole(string UserName)
        {
            SqlCommand cmd = new SqlCommand();
            string UserRole = "";

            try
            {
                string cs = ConfigurationManager.ConnectionStrings["AlmacenesConnectionString"].ConnectionString;
                SqlConnection conn = new SqlConnection(cs);

                cmd.Connection = conn;

                cmd.CommandText = "[secure].[sp_get_UserRole]";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@UserName", UserName);



                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        UserRole = dr["Role"].ToString();
                    }
                }

                conn.Close();


                return UserRole;

            }
            catch (Exception ex)
            {
                Msg.Text = ex.Message;
                return null;
            }
        }

        public void Login_OnClick(object sender, EventArgs args)
        {
            if (ValidateUser(UsernameTextbox.Text, PasswordTextbox.Text))
                FormsAuthentication.RedirectFromLoginPage(UsernameTextbox.Text, true);
            else
                Msg.Text = "Error en inicio de sesión. Favor verifique sus credenciales e intente de nuevo.";
        }

    }
}