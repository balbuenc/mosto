using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class Articulo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("Articulo.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Articulo.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(ArticuloDS.ConnectionString);

            cmd = new SqlCommand("warehouse.[sp_Articulo_get_Articulo]", con);
            cmd.Parameters.Add(new SqlParameter("@IdArticulo", ID));
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
            SqlConnection con = new SqlConnection(ArticuloDS.ConnectionString);

            cmd = new SqlCommand("warehouse.[sp_Articulo_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdArticulo", ID));



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
                ArticuloListView.DataBind();

                ErrorLabel.Text = "El Registro se eliminó correctamente.";
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 3000);
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

        private double ConvertToDouble(string s)
        {
            char systemSeparator = Thread.CurrentThread.CurrentCulture.NumberFormat.CurrencyDecimalSeparator[0];
            double result = 0;
            try
            {
                s = s.Replace(".", "");
                if (s != null)
                    if (!s.Contains(","))
                        result = double.Parse(s, CultureInfo.InvariantCulture);
                    else
                        result = Convert.ToDouble(s.Replace(".", systemSeparator.ToString()).Replace(",", systemSeparator.ToString()));
            }
            catch (Exception e)
            {
                try
                {
                    result = Convert.ToDouble(s);
                }
                catch
                {
                    try
                    {
                        result = Convert.ToDouble(s.Replace(",", ";").Replace(".", ",").Replace(";", "."));
                    }
                    catch
                    {
                        throw new Exception("Wrong string-to-double format");
                    }
                }
            }
            return result;
        }

        protected void EditFormView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            SqlCommand cmd = new SqlCommand();
            DataKey key = EditFormView.DataKey;

            string format = "dd/MM/yyyy";
            double cant = 0;

            try
            {
                //Obtengo los valores de los campos a editar
                TextBox txtIdArticulo = (TextBox)EditFormView.FindControl("txtIdArticulo");
                TextBox txtDescripcion = (TextBox)EditFormView.FindControl("txtDescripcion");
                DropDownList IdProveedorDDL = (DropDownList)EditFormView.FindControl("IdProveedorDDL");
                TextBox txtCodigoDeBarra = (TextBox)EditFormView.FindControl("txtCodigoDeBarra");
                DropDownList IdUnidadMedidaDDL = (DropDownList)EditFormView.FindControl("IdUnidadMedidaDDL");
                TextBox txtCantidadTotal = (TextBox)EditFormView.FindControl("txtCantidadTotal");
                TextBox txtCantidadPendiente = (TextBox)EditFormView.FindControl("txtCantidadPendiente");
                TextBox txtCantidadExistente = (TextBox)EditFormView.FindControl("txtCantidadExistente");
                DropDownList IdContratoDDL = (DropDownList)EditFormView.FindControl("IdContratoDDL");

                System.Web.UI.HtmlControls.HtmlInputText calendarFechaEntregaArticulo = (System.Web.UI.HtmlControls.HtmlInputText)EditFormView.FindControl("calendarFechaEntregaArticulo");
                System.Web.UI.HtmlControls.HtmlInputText calendarFechaVencimientoArticulo = (System.Web.UI.HtmlControls.HtmlInputText)EditFormView.FindControl("calendarFechaVencimientoArticulo");

                //Convertir cantidad total a decimal para el ingreso a la BD
                cant = ConvertToDouble(txtCantidadTotal.Text.ToString());

                //DateTime isoDateTime = DateTime.ParseExact(txtCalendar.Value, format, CultureInfo.InvariantCulture);
                DateTime isoDateTimeEntrega = DateTime.ParseExact(calendarFechaEntregaArticulo.Value, format, CultureInfo.InvariantCulture);
                DateTime isoDateTimeVencimiento = DateTime.ParseExact(calendarFechaVencimientoArticulo.Value, format, CultureInfo.InvariantCulture);

                SqlConnection conn = new SqlConnection(ArticuloDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "warehouse.sp_Articulo_update";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdArticulo", txtIdArticulo.Text);
                cmd.Parameters.AddWithValue("@Descripcion", txtDescripcion.Text);
                cmd.Parameters.AddWithValue("@IdProveedor", IdProveedorDDL.SelectedValue);
                cmd.Parameters.AddWithValue("@FechaEntrega", isoDateTimeEntrega);
                cmd.Parameters.AddWithValue("@FechaVencimiento", isoDateTimeVencimiento);
                cmd.Parameters.AddWithValue("@CodigoDeBarra", txtCodigoDeBarra.Text);
                cmd.Parameters.AddWithValue("@IdUnidadMedida", IdUnidadMedidaDDL.SelectedValue);
                cmd.Parameters.AddWithValue("@CantidadTotal", cant);
                cmd.Parameters.AddWithValue("@IdContrato", IdContratoDDL.SelectedValue);

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#editModal').modal('hide');", true);

                Response.Redirect("Articulo.aspx");


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
            ArticuloListView.DataBind();

        }
    }
}