using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class Inventory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UserNameHF.Value = User.Identity.Name;

            ((Label)this.Master.FindControl("lblActualPage")).Text = "INVENTARIO";
            if (Request.QueryString["PageSize"] != null)
            {
                InventarioDataPager.PageSize = Convert.ToInt16(Request.QueryString["PageSize"]);
            }
        }

        protected void SearchBtn_ServerClick(object sender, EventArgs e)
        {
            InventarioListView.DataBind();
        }


        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("Inventario.aspx");
        }

        protected void InsertCancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Inventario.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(InventarioDS.ConnectionString);

            cmd = new SqlCommand("[inventory].[sp_Inventario_get_Inventario]", con);
            cmd.Parameters.Add(new SqlParameter("@IdInventario", ID));
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
            SqlConnection con = new SqlConnection(InventarioDS.ConnectionString);

            cmd = new SqlCommand("[inventory].[sp_Inventario_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdInventario", ID));

            // Set Output Paramater
            //SqlParameter OutputParam = new SqlParameter("@Output", SqlDbType.VarChar);
            //OutputParam.Direction = ParameterDirection.Output;
            //OutputParam.Size = 512;
            //cmd.Parameters.Add(OutputParam);

            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();
            cmd.ExecuteNonQuery();

            ErrorLabel.Text = "El registro se eliminó con exito.";

            con.Close();
        }


        protected void InventarioListView_ItemCommand(object sender, ListViewCommandEventArgs e)
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
                InventarioListView.DataBind();


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
                TextBox txtIdInventario = (TextBox)EditFormView.FindControl("txtIdInventario");
                TextBox txtFechaInventario = (TextBox)EditFormView.FindControl("txtFechaInventario");
                
                TextBox txtDescripcion = (TextBox)EditFormView.FindControl("txtDescripcion");


                SqlConnection conn = new SqlConnection(InventarioDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "inventory.sp_Inventario_update";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdInventario", txtIdInventario.Text);
                cmd.Parameters.AddWithValue("@FechaInventario", txtFechaInventario.Text);
                
                cmd.Parameters.AddWithValue("@Descripcion", txtDescripcion.Text);

                // Set Output Paramater
                //SqlParameter OutputParam = new SqlParameter("@Output", SqlDbType.VarChar);
                //OutputParam.Direction = ParameterDirection.Output;
                //OutputParam.Size = 512;
                //cmd.Parameters.Add(OutputParam);


                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                Response.Redirect("Inventario.aspx");
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
    }
}