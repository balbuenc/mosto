using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class Seguridad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)this.Master.FindControl("lblActualPage")).Text = "ASIGNACIÓN DE PERMISOS";
        }

        protected void AsignacionesListView_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            IdPrivilegeDDL.DataBind();
        }

        private void ShowPopUpMsg(string msg)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("alert('");
            sb.Append(msg.Replace("\n", "\\n").Replace("\r", "").Replace("'", "\\'"));
            sb.Append("');");
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showalert", sb.ToString(), true);
        }
        protected void AddPrivilegeBtn_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(AsignacionesDS.ConnectionString);

            if (IdPrivilegeDDL.SelectedValue == "")
            {
                ShowPopUpMsg("El Rol ya posee todos los privilegios.");
                return;
            }

            try
            {
                cmd = new SqlCommand("secure.sp_Add_Role_Privilege", con);
                cmd.Parameters.Add(new SqlParameter("@IdRole", IdRoleDDL.SelectedValue));
                cmd.Parameters.Add(new SqlParameter("@IdModule", IdModuleDDL.SelectedValue));
                cmd.Parameters.Add(new SqlParameter("@IdPrivilege", IdPrivilegeDDL.SelectedValue));


                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();
                cmd.ExecuteNonQuery();

                AsignacionesListView.DataBind();
                IdPrivilegeDDL.DataBind();

            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
               
            }

        }
    }
}