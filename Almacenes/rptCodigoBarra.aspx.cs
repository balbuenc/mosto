using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class rptCodigoBarra : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((Label)this.Master.FindControl("lblActualPage")).Text = "IMPRESIÓN DE CODIGO DE BARRAS";
            if (!IsPostBack)
            {

                ReportParameter[] parameters = new ReportParameter[1];
                parameters[0] = new ReportParameter("IdCodigoBarra", Request.QueryString["IdCodigoBarra"]);



                ReportViewer1.ProcessingMode = ProcessingMode.Remote;
                ReportViewer1.ShowParameterPrompts = true;
                IReportServerCredentials irsc = new CustomReportCredentials(System.Configuration.ConfigurationManager.AppSettings["rptUSer"], System.Configuration.ConfigurationManager.AppSettings["rptUserKey"], System.Configuration.ConfigurationManager.AppSettings["rptUserDomain"]);
                ReportViewer1.ServerReport.ReportServerCredentials = irsc;
                ReportViewer1.ServerReport.ReportServerUrl = new Uri(System.Configuration.ConfigurationManager.AppSettings["ReportServer"]);
                ReportViewer1.ServerReport.ReportPath = "/AlmacenesSSRS/BarcodeMatrix";
                ReportViewer1.ServerReport.SetParameters(parameters);
                ReportViewer1.ServerReport.Refresh();
            }
        }
    }
}