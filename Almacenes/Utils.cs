using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Almacenes
{
    public class Utils
    {

        public int[] GetSecurityVector(string module, JObject token)
        {
            int[] vector = { 0, 0, 0, 0 };

            try
            {
                JArray a = (JArray)token["Modules"];
                foreach (var item in a.Children().Children().Children())
                {
                    var itemProperties = item.Children<JProperty>();
                    //you could do a foreach or a linq here depending on what you need to do exactly with the value

                    var myElement = itemProperties.FirstOrDefault(x => x.Name == "Name");
                    var myPrivilege = itemProperties.FirstOrDefault(x => x.Name == "Privilege");

                    var myElementValue = myElement.Value; ////This is a JValue type
                    var myPrivilegeValue = myPrivilege.Value;

                    if (myElement.Value.ToString() == module)
                    {
                        if(myPrivilegeValue.ToString() == "ESCRITURA")
                        {
                            vector[0] = 1;
                        }
                        else if (myPrivilegeValue.ToString() == "LECTURA")
                        {
                            vector[1] = 1;
                        }
                        else if (myPrivilegeValue.ToString() == "BORRADO")
                        {
                            vector[2] = 1;
                        }
                        else if (myPrivilegeValue.ToString() == "MODIFICACION")
                        {
                            vector[3] = 1;
                        }
                    }
                }

                return vector;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public int[] GetSecurityPrivilege(string module)
        {
            JObject json;
          

            try
            {
                json = (JObject)HttpContext.Current.Session["SecureMatrix"];

                return GetSecurityVector(module, json);
            }
            catch (Exception ex)
            {
                return null;
            }

        }
    }
}