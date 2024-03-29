﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
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
            ((Label)this.Master.FindControl("lblActualPage")).Text = "PUNTOS DE EMISIÓN";
            if (Request.QueryString["PageSize"] != null)
            {
                LicitacionDataPager.PageSize = Convert.ToInt16(Request.QueryString["PageSize"]);
            }
            //Authorize User Role
            if (Session["SecureMatrix"] == null)
            {
                string OriginalUrl = HttpContext.Current.Request.RawUrl;
                string LoginPageUrl = "/Login.aspx";
                HttpContext.Current.Response.Redirect(String.Format("{0}?ReturnUrl={1}", LoginPageUrl, OriginalUrl));
            }

            Utils.Authorization("vLicitaciones");
            AddRegistroBtn.Visible = Utils.WRITE;

        }

        protected void SearchBtn_ServerClick(object sender, EventArgs e)
        {
            LicitacionListView.DataBind();
        }


        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("Licitaciones.aspx");
        }

        protected void InsertCancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Licitaciones.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(LicitacionDS.ConnectionString);

            cmd = new SqlCommand("[management].[sp_licitacion_get_licitacion]", con);
            cmd.Parameters.Add(new SqlParameter("@IdLicitacion", ID));
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


        protected void DeleteRecord(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(LicitacionDS.ConnectionString);

            cmd = new SqlCommand("[management].[sp_licitacion_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdLicitacion", ID));

            // Set Output Paramater
            SqlParameter OutputParam = new SqlParameter("@Output", SqlDbType.VarChar);
            OutputParam.Direction = ParameterDirection.Output;
            OutputParam.Size = 512;
            cmd.Parameters.Add(OutputParam);

            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();
            cmd.ExecuteNonQuery();

            ErrorLabel.Text = OutputParam.Value.ToString();

            con.Close();
        }


        protected void LicitacionListView_ItemCommand(object sender, ListViewCommandEventArgs e)
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
                LicitacionListView.DataBind();


                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
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
                TextBox txtIdLicitacion = (TextBox)EditFormView.FindControl("txtIdLicitacion");
                DropDownList IdLicitacionDDL = (DropDownList)EditFormView.FindControl("IdLicitacionDDL");
                TextBox txtNroLicitacion = (TextBox)EditFormView.FindControl("txtNroLicitacion");
                TextBox txtFechaLicitacion = (TextBox)EditFormView.FindControl("txtFechaLicitacion");
                
                DropDownList ActivoDDL = (DropDownList)EditFormView.FindControl("ActivoDDL");
                TextBox txtLlamado = (TextBox)EditFormView.FindControl("txtLlamado");


                SqlConnection conn = new SqlConnection(LicitacionDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "management.sp_licitacion_update";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdLicitacion", txtIdLicitacion.Text);
                cmd.Parameters.AddWithValue("@IdTipoLicitacion", IdLicitacionDDL.SelectedValue.ToString());
                cmd.Parameters.AddWithValue("@NroLicitacion", txtNroLicitacion.Text);
                cmd.Parameters.AddWithValue("@FechaLicitacion", txtFechaLicitacion.Text);
                cmd.Parameters.AddWithValue("@UOCReferancia", "");
                cmd.Parameters.AddWithValue("@UOCIdLicitacion", "");
                cmd.Parameters.AddWithValue("@Activo", ActivoDDL.SelectedValue.ToString());
                cmd.Parameters.AddWithValue("@Llamado", txtLlamado.Text);

                // Set Output Paramater
                SqlParameter OutputParam = new SqlParameter("@Output", SqlDbType.VarChar);
                OutputParam.Direction = ParameterDirection.Output;
                OutputParam.Size = 512;
                cmd.Parameters.Add(OutputParam);


                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                Response.Redirect("Licitaciones.aspx");
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
        }

        protected void LicitacionListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {

            LinkButton EditLicitacionBtn = (LinkButton)e.Item.FindControl("EditLicitacionBtn");
            LinkButton DeleteLicitacionBtn = (LinkButton)e.Item.FindControl("DeleteLicitacionBtn");

            EditLicitacionBtn.Enabled = Utils.UPDATE;
            DeleteLicitacionBtn.Enabled = Utils.DELETE;
           
        }
    }
}