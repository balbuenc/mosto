<%@ Page Title="" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="rptSalida.aspx.cs" Inherits="Almacenes.Reports" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    <div style="background-color:white">
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" ProcessingMode="Remote" ShowCredentialPrompts="false"  Width="100%" Height="800px">
        
        
    </rsweb:ReportViewer>
    </div>
</asp:Content>
