
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Zen.Barcode;


namespace Almacenes
{
    public partial class PrintBarCode : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try {
                ((Label)this.Master.FindControl("lblActualPage")).Text = "IMPRESIÓN DE CÓDIGO DE BARRAS";

                string img = "data:image/png;base64," + getBarcode(Request.QueryString["Data"].ToString());
                Code.Src = img;
            }
            catch (Exception Ex)
            {
                Response.Write(Ex.Message);
            }


        }

        private string getBarcode(string Data)
        {
            BarcodeSymbology s = BarcodeSymbology.Code39C;
            BarcodeDraw drawObject = BarcodeDrawFactory.GetSymbology(s);
            var metrics = drawObject.GetDefaultMetrics(60);
            metrics.Scale = 2;
            var barcodeImage = drawObject.Draw(Data, metrics);

            using (MemoryStream ms = new MemoryStream())
            {
                barcodeImage.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                byte[] imageBytes = ms.ToArray();

                return Convert.ToBase64String(imageBytes);
            }
        }
    }
}