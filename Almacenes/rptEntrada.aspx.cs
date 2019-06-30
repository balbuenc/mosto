using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Almacenes
{
    public partial class rptEntrada : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                ReportParameter[] parameters = new ReportParameter[1];
                parameters[0] = new ReportParameter("IdTransaccion", Request.QueryString["IdTransaccion"]);



                ReportViewer1.ProcessingMode = ProcessingMode.Remote;
                ReportViewer1.ShowParameterPrompts = false;
                IReportServerCredentials irsc = new CustomReportCredentials(System.Configuration.ConfigurationManager.AppSettings["rptUSer"], System.Configuration.ConfigurationManager.AppSettings["rptUserKey"], System.Configuration.ConfigurationManager.AppSettings["rptUserDomain"]);
                ReportViewer1.ServerReport.ReportServerCredentials = irsc;
                ReportViewer1.ServerReport.ReportServerUrl = new Uri(System.Configuration.ConfigurationManager.AppSettings["ReportServer"]);
                ReportViewer1.ServerReport.ReportPath = "/AlmacenesSSRS/LotesEntrada";
                ReportViewer1.ServerReport.SetParameters(parameters);
                ReportViewer1.ServerReport.Refresh();
            }
        }
    }
}