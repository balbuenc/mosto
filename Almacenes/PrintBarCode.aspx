<%@ Page Title="Impresión código de barras" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="PrintBarCode.aspx.cs" Inherits="Almacenes.PrintBarCode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

           

            function imprimir(printpage)
            {
              var headstr = "<html><body>";
              var footstr = "</body>";
             
              var newstr = document.all.item(printpage).innerHTML;
              var oldstr = document.body.innerHTML;
              document.body.innerHTML = headstr+newstr+footstr;
              window.print();
              document.body.innerHTML = oldstr;
              return false;
            }

            function CallPrint(strid) {
                    var prtContent = document.getElementById(strid);
                    var WinPrint = window.open('', '', 'letf=0,top=0,width=800,height=500,toolbar=0,scrollbars=0,status=0,dir=ltr');
                    WinPrint.document.write(prtContent.innerHTML);
                    WinPrint.document.close();
                    WinPrint.focus();
                    WinPrint.print();
                    WinPrint.close();
                    prtContent.innerHTML = strOldOne;
                }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="barcode" >
        <img id="Code" runat="server" width="300" src=""/>
    </div>
    <div>
        <asp:Button ID="Button2" runat="server" Text="Imprimir"  OnClientClick="javascript:imprimir('barcode');"/>
        
        
    </div>
</asp:Content>
