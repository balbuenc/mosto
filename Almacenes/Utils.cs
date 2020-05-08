using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Almacenes
{
    public static class Utils
    {
        static bool _WRITE;
        static bool _READ;
        static bool _UPDATE;
        static bool _DELETE;


        public static bool WRITE
        {
            get
            {
                return _WRITE;
            }
            set
            {
                _WRITE = value;
            }
        }

        public static bool READ
        {
            get
            {
                return _READ;
            }
            set
            {
                _READ = value;
            }
        }

        public static bool UPDATE
        {
            get
            {
                return _UPDATE;
            }
            set
            {
                _UPDATE = value;
            }
        }

        public static bool DELETE
        {
            get
            {
                return _DELETE;
            }
            set
            {
                _DELETE = value;
            }
        }

        public static void Authorization(string module)
        {
            //Get User role privileges
            WRITE = ((int[])HttpContext.Current.Session[module])[0] == 1 ? true: false;
            READ = ((int[])HttpContext.Current.Session[module])[1] == 1 ? true : false;
            DELETE = ((int[])HttpContext.Current.Session[module])[2] == 1 ? true : false;
            UPDATE = ((int[])HttpContext.Current.Session[module])[3] == 1 ? true : false;
        }



    public static int[] GetSecurityVector(string module, JObject token)
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
                    if (myPrivilegeValue.ToString() == "ESCRITURA")
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

    public static int[] GetSecurityPrivilege(string module)
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