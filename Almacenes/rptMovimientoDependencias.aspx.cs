using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class rptMovimientoDependencias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ReportParameter[] parameters = new ReportParameter[1];
                parameters[0] = new ReportParameter("NroTransaccion", Request.QueryString["NroTransaccion"]);

                ReportViewer1.ProcessingMode = ProcessingMode.Remote;
                IReportServerCredentials irsc = new CustomReportCredentials(System.Configuration.ConfigurationManager.AppSettings["rptUSer"], System.Configuration.ConfigurationManager.AppSettings["rptUserKey"], System.Configuration.ConfigurationManager.AppSettings["rptUserDomain"]);
                ReportViewer1.ServerReport.ReportServerCredentials = irsc;
                ReportViewer1.ServerReport.ReportServerUrl = new Uri(System.Configuration.ConfigurationManager.AppSettings["ReportServer"]);
                ReportViewer1.ServerReport.ReportPath = "/AlmacenesSSRS/MovimientoDependencia";

                ReportViewer1.ServerReport.SetParameters(parameters);
                ReportViewer1.ServerReport.Refresh();

            }
        }
    }
}