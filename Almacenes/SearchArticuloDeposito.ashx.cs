using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Almacenes
{
    /// <summary>
    /// Summary description for SearchArticuloDeposito
    /// </summary>
        
    [WebService(Namespace = "Almacenes/http-handlers/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class SearchArticuloDeposito : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            string json = string.Empty;
            List<string> customers = new List<string>();
            string error = "";

            // note the httpcontext.Request contains the search term
            if (!string.IsNullOrEmpty(context.Request["term"]))
            {
                string searchTerm = context.Request["term"];
                string IdInventario = context.Request["IdInventario"];

                IdInventario = IdInventario.Replace("'", "");

                using (SqlConnection conn = new SqlConnection())
                {
                    conn.ConnectionString = ConfigurationManager.ConnectionStrings["AlmacenesConnectionString"].ConnectionString;

                    try
                    {
                        using (SqlCommand cmd = new SqlCommand())
                        {
                            cmd.CommandType = System.Data.CommandType.StoredProcedure;
                            cmd.CommandText = "[warehouse].[sp_search_articulo_deposito]";
                            cmd.Parameters.AddWithValue("@find", searchTerm);
                            cmd.Parameters.AddWithValue("@IdInventario", IdInventario);
                            cmd.Connection = conn;
                            conn.Open();
                            using (SqlDataReader sdr = cmd.ExecuteReader())
                            {
                                while (sdr.Read())
                                {
                                    customers.Add(sdr["client"].ToString());
                                }
                            }
                            conn.Close();
                        }
                    }
                    catch (Exception ex)
                    {
                        error = ex.Message;
                        return;
                    }
                }

                if (customers.Count != 0)
                {
                    var transformList = new List<ResponseData>();

                    for (int index = 0; index < customers.Count; index++)
                    {
                        transformList.Add(new ResponseData
                        {
                            Client = customers[index].ToString()
                        });
                    }

                    // call Newtonsoft.Json function to serialize list into JSON
                    json = JsonConvert.SerializeObject(transformList);
                }

            }

            // write the JSON (or nothing) to the response
            context.Response.Write(json);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}