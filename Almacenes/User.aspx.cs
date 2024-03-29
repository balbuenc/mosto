﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class User : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)this.Master.FindControl("lblActualPage")).Text = "USUARIOS";
            if (Request.QueryString["PageSize"] != null)
            {
                UserDataPager.PageSize = Convert.ToInt16(Request.QueryString["PageSize"]);
            }

            //Authorize User Role
            if (Session["SecureMatrix"] == null)
            {
                string OriginalUrl = HttpContext.Current.Request.RawUrl;
                string LoginPageUrl = "/Login.aspx";
                HttpContext.Current.Response.Redirect(String.Format("{0}?ReturnUrl={1}", LoginPageUrl, OriginalUrl));
            }

            Utils.Authorization("vUsuarios");
            AddRegistroBtn.Visible = Utils.WRITE;
        }

        protected void SearchBtn_ServerClick(object sender, EventArgs e)
        {
            UserListView.DataBind();
        }

        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("User.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("User.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(UserDS.ConnectionString);

            cmd = new SqlCommand("secure.[sp_User_get_User]", con);
            cmd.Parameters.Add(new SqlParameter("@IdUser", ID));
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter adp = new SqlDataAdapter();

            con.Open();

            adp.SelectCommand = cmd;
            DataSet ds = new DataSet();
            adp.Fill(ds);

            EditFormView.DataSource = ds;
            EditFormView.DataBind();

            con.Close();
        }

        protected void GetUserToUpdatePassword(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(UserDS.ConnectionString);

            cmd = new SqlCommand("secure.[sp_User_get_User]", con);
            cmd.Parameters.Add(new SqlParameter("@IdUser", ID));
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter adp = new SqlDataAdapter();

            con.Open();

            adp.SelectCommand = cmd;
            DataSet ds = new DataSet();
            adp.Fill(ds);

            setPasswordFormView.DataSource = ds;
            setPasswordFormView.DataBind();

            con.Close();
        }


        protected void GetUserToUpdateRole(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(UserDS.ConnectionString);

            cmd = new SqlCommand("secure.[sp_User_get_User]", con);
            cmd.Parameters.Add(new SqlParameter("@IdUser", ID));
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter adp = new SqlDataAdapter();

            con.Open();

            adp.SelectCommand = cmd;
            DataSet ds = new DataSet();
            adp.Fill(ds);

            setUserRoleFormView.DataSource = ds;
            setUserRoleFormView.DataBind();

            con.Close();
        }


        protected void DeleteRecord(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(UserDS.ConnectionString);

            cmd = new SqlCommand("secure.[sp_User_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdUser", ID));



            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();
            cmd.ExecuteNonQuery();



            con.Close();
        }


        protected void ListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                GetRecordToUpdate(e.CommandArgument.ToString());

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
               "$('#editModal').modal('show');", true);



            }
            else if (e.CommandName == "Eliminar")
            {
                DeleteRecord(e.CommandArgument.ToString());
                UserListView.DataBind();

                ErrorLabel.Text = "El Registro se eliminó correctamente.";
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 3000);
            }
            else if (e.CommandName == "SetPassword")
            {
                GetUserToUpdatePassword(e.CommandArgument.ToString());

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
               "$('#setUserPasswordModal').modal('show');", true);
            }
            else if (e.CommandName == "SetRole")
            {
                GetUserToUpdateRole(e.CommandArgument.ToString());
                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
               "$('#setUserRoleModal').modal('show');", true);
            }
        }


        protected void FadeOut(string ClientID, int Time)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "script", "window.setTimeout(function() { document.getElementById('" + ClientID + "').style.display = 'none' }," + Time.ToString() + ");", true);
        }



        protected void EditFormView_ModeChanging(object sender, FormViewModeEventArgs e)
        {
            EditFormView.ChangeMode(e.NewMode);
        }




        protected void EditFormView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            SqlCommand cmd = new SqlCommand();
            DataKey key = EditFormView.DataKey;


            try
            {
                //Obtengo los valores de los campos a editar
                TextBox txtIdUser = (TextBox)EditFormView.FindControl("txtIdUser");
                TextBox txtUserName = (TextBox)EditFormView.FindControl("txtUserName");


                TextBox txtFirstName = (TextBox)EditFormView.FindControl("txtFirstName");
                TextBox txtLastName = (TextBox)EditFormView.FindControl("txtLastName");
                TextBox txtEmail = (TextBox)EditFormView.FindControl("txtEmail");
                TextBox txtPhone = (TextBox)EditFormView.FindControl("txtPhone");
                TextBox txtDiscriminator = (TextBox)EditFormView.FindControl("txtDiscriminator");
                TextBox txtDocumentNumber = (TextBox)EditFormView.FindControl("txtDocumentNumber");

                SqlConnection conn = new SqlConnection(UserDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "secure.sp_User_update";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdUser", txtIdUser.Text);
                cmd.Parameters.AddWithValue("@UserName", txtUserName.Text);


                cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
                cmd.Parameters.AddWithValue("@LastName", txtLastName.Text);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text);
                cmd.Parameters.AddWithValue("@Discriminator", txtDiscriminator.Text);
                cmd.Parameters.AddWithValue("@DocumentNumber", txtDocumentNumber.Text);

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#editModal').modal('hide');", true);

                Response.Redirect("User.aspx");


            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }


        protected void EditFormView_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            EditFormView.ChangeMode(FormViewMode.ReadOnly);
            ErrorLabel.Text = "El Registro de actualizó correctamente";
            ErrorLabel.Visible = true;
            FadeOut(ErrorLabel.ClientID, 5000);
            UserListView.DataBind();

        }

        protected void setPasswordFormView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            SqlCommand cmd = new SqlCommand();
            DataKey key = EditFormView.DataKey;


            try
            {
                //Obtengo los valores de los campos a editar
                TextBox txtIdUser = (TextBox)setPasswordFormView.FindControl("txtIdUser");
                TextBox txtPasswordHash = (TextBox)setPasswordFormView.FindControl("txtPasswordHash");

                SqlConnection conn = new SqlConnection(UserDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "secure.sp_User_SetPassword";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdUser", txtIdUser.Text);
                cmd.Parameters.AddWithValue("@PasswordHash", txtPasswordHash.Text);

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#setUserPasswordModal').modal('hide');", true);

                Response.Redirect("User.aspx");


            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }

        protected void setUserRoleFormView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            SqlCommand cmd = new SqlCommand();
            DataKey key = EditFormView.DataKey;


            try
            {
                //Obtengo los valores de los campos a editar
                TextBox txtIdUser = (TextBox)setUserRoleFormView.FindControl("txtIdUser");
                DropDownList ddlIdUserRole = (DropDownList)setUserRoleFormView.FindControl("ddlIdUserRole");

                SqlConnection conn = new SqlConnection(UserDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "secure.sp_User_SetRole";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdUser", txtIdUser.Text);
                cmd.Parameters.AddWithValue("@IdRole", ddlIdUserRole.SelectedValue);

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#setUserRoleModal').modal('hide');", true);

                Response.Redirect("User.aspx");


            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }

        protected void UserListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {

            LinkButton EditUserBtn = (LinkButton)e.Item.FindControl("EditUserBtn");
            LinkButton DeleteUserBtn = (LinkButton)e.Item.FindControl("DeleteUserBtn");

            EditUserBtn.Enabled = Utils.UPDATE;
            DeleteUserBtn.Enabled = Utils.DELETE;
        }
    }
}