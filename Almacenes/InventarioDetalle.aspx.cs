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
    public partial class InventarioDetalleDetalle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            ((Label)this.Master.FindControl("lblActualPage")).Text = "DETALLE DE INVENTARIO";

        }



        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("InventarioDetalle.aspx");
        }

        protected void InsertCancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("InventarioDetalle.aspx");
        }




        protected void DeleteRecord(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(InventarioDetalleDS.ConnectionString);

            cmd = new SqlCommand("[inventory].[sp_InventarioDetalle_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdInventarioDetalle", ID));

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


        protected void InventarioDetalleListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                DeleteRecord(e.CommandArgument.ToString());
                InventarioDetalleListView.DataBind();


                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }


        protected void FadeOut(string ClientID, int Time)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "script", "window.setTimeout(function() { document.getElementById('" + ClientID + "').style.display = 'none' }," + Time.ToString() + ");", true);
        }

        protected void AddRegistroBtn_OnClick(Object sender, EventArgs e)
        {
            AgregarInventario();
            InventarioDetalleListView.DataBind();

            txtExistencia.Text = "";
            txtDetalle.Text = "";
        }

        protected void AgregarInventario()
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(InventarioDetalleDS.ConnectionString);

            try
            {
                cmd = new SqlCommand("inventory.sp_InventarioDetalle_insert", con);
                cmd.Parameters.Add(new SqlParameter("@IdInventario", Request.QueryString["IdInventario"]));
               
               
                cmd.Parameters.Add(new SqlParameter("@Existencia", txtExistencia.Text));
                cmd.Parameters.Add(new SqlParameter("@Comentario", txtDetalle.Text));
                cmd.Parameters.Add(new SqlParameter("@IdArticuloMaestro", txtSearchArticulo.Value.ToString()));

                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();
                cmd.ExecuteNonQuery();



                con.Close();
            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
            }
        }

        protected void btnClearArticulo_ServerClick(object sender, EventArgs e)
        {
            txtSearchArticulo.Value = "";
         
        }


    }
}