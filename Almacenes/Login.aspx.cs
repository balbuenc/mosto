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
            Utils u = new Utils();

            //Cargo la matriz de seguridad desde la DB [W][R][D][U]
            //Menu Principales
            Session["vAdministracionMenu"] = u.GetSecurityPrivilege("Administracion.Menu");
            Session["vComprasMenu"] = u.GetSecurityPrivilege("Compras.Menu");
            Session["vProcesosMenu"] = u.GetSecurityPrivilege("Procesos.Menu");
            Session["vContabilidadMenu"] = u.GetSecurityPrivilege("Contabilidad.Menu");
            Session["vReportesMenu"] = u.GetSecurityPrivilege("Reportes.Menu");

            //Menu secundario ADMINISTRACION
            Session["vTipodeLicitaciones"] = u.GetSecurityPrivilege("Administracion.TipodeLicitaciones");
            Session["vTipodeContacto"] = u.GetSecurityPrivilege("Administracion.TipodeContacto");
            Session["vImpuestos"] = u.GetSecurityPrivilege("Administracion.Impuestos");
            Session["vUnidaddeMedida"] = u.GetSecurityPrivilege("Administracion.UnidaddeMedida");
            Session["vDependencias"] = u.GetSecurityPrivilege("Administracion.Dependencias");
            Session["vDepositos"] = u.GetSecurityPrivilege("Administracion.Depositos");
            Session["vUsuarios"] = u.GetSecurityPrivilege("Administracion.Usuarios");
            Session["vRoles"] = u.GetSecurityPrivilege("Administracion.Roles");


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