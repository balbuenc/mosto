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
    public partial class InventarioDetalleDetalle : System.Web.UI.Page
    {
        protected String txtEstado = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)this.Master.FindControl("lblActualPage")).Text = "DETALLE DE INVENTARIO";
            ObtenerDatosInventario(Request.QueryString["IdInventario"]);
            if (txtEstado == "Abierto")
            {
                CommandsBtn.Visible = true;
            }
            else
            {
                CommandsBtn.Visible = false;
            }

            ErrorLabel.Text = "";
            ErrorLabel.Visible = false;

            //Authorize User Role
            if (Session["SecureMatrix"] == null)
            {
                string OriginalUrl = HttpContext.Current.Request.RawUrl;
                string LoginPageUrl = "/Login.aspx";
                HttpContext.Current.Response.Redirect(String.Format("{0}?ReturnUrl={1}", LoginPageUrl, OriginalUrl));
            }

            Utils.Authorization("vInventario");
            AddRegistroBtn.Visible = Utils.WRITE;
        }

        private void ObtenerDatosInventario(string IdInventario)
        {
            SqlCommand cmd = new SqlCommand();

            try
            {
                SqlConnection conn = new SqlConnection(InventarioDetalleDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "[inventory].[sp_Inventario_get_Inventario]";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@IdInventario", IdInventario);


                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        txtIdInventario.Text = dr["IdInventario"].ToString();
                        txtDeposito.Text = dr["Deposito"].ToString();
                        txtFechaInventario.Text = dr["FechaInventario"].ToString();
                        txtDescripcion.Text = dr["Descripcion"].ToString();
                        txtEstado = dr["Estado"].ToString();

                    }
                }

                conn.Close();
            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
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

        protected void CloseInventarioBtn_OnClick(Object sender, EventArgs e)
        {
            if (CerrarInventario())
                Response.Redirect("Inventario.aspx");
        }

        private bool CerrarInventario()
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(InventarioDetalleDS.ConnectionString);


            try
            {
                cmd = new SqlCommand("inventory.sp_Inventario_close", con);
                cmd.Parameters.Add(new SqlParameter("@IdInventario", Request.QueryString["IdInventario"]));


                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();
                cmd.ExecuteNonQuery();



                con.Close();
                return true;

            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;

                FadeOut(ErrorLabel.ClientID, 5000);

                return false;
            }
        }

        private void ShowPopUpMsg(string msg)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("alert('");
            sb.Append(msg.Replace("\n", "\\n").Replace("\r", "").Replace("'", "\\'"));
            sb.Append("');");
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showalert", sb.ToString(), true);
        }

        protected void AgregarInventario()
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(InventarioDetalleDS.ConnectionString);
            Int32 cant;

            try
            {
                cant = Convert.ToInt32(txtExistencia.Text.ToString());
            }
            catch
            {
                ShowPopUpMsg("La cantidad existente debe ser un número válido");
                return;
            }

            try
            {
                cmd = new SqlCommand("inventory.sp_InventarioDetalle_insert", con);
                cmd.Parameters.Add(new SqlParameter("@IdInventario", Request.QueryString["IdInventario"]));


                cmd.Parameters.Add(new SqlParameter("@Existencia", txtExistencia.Text));
                cmd.Parameters.Add(new SqlParameter("@Comentario", txtDetalle.Text));
                cmd.Parameters.Add(new SqlParameter("@Articulo", txtSearchArticulo.Value.ToString()));

                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();
                cmd.ExecuteNonQuery();



                con.Close();

                txtSearchArticulo.Value = "";
                txtExistencia.Text = "";
                txtDetalle.Text = "";
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

        protected void InventarioDetalleListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {

            LinkButton DeleteInventarioDetalleBtn = (LinkButton)e.Item.FindControl("DeleteInventarioDetalleBtn");

            DeleteInventarioDetalleBtn.Enabled = Utils.DELETE;

            if (txtEstado == "Abierto")
            {
                DeleteInventarioDetalleBtn.Visible = true;
            }
            else
            {
                DeleteInventarioDetalleBtn.Visible = false;
            }
        }


    }
}