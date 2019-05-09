<%@ Page Title="Entrada de Items" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Entrada.aspx.cs" Inherits="Almacenes.Entrada" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Scripts/jquery-3.0.0.js"></script>

    <script type="text/javascript">
        $(function () {
            $("[id$=txtSearchClaim]").autocomplete(
                {
                    source: "SearchArticulo.ashx",
                    // note minlength, triggers the Handler call only once 3 characters entered
                    minLength: 3,
                    focus: function (event, ui) {
                        $("[id$=txtSearchClaim]").val(ui.item.label);
                        return false;
                    },
                    select: function (event, ui) {
                        if (ui.item) {
                            $("[id$=txtSearchClaim]").val(ui.item.Client);
                            console.log($("[id$=btnSearch]"));
                            $("[id$=btnSearch]").click();
                            return false;
                        }

                    }
                })
                .autocomplete("instance")._renderItem = function (ul, item) {
                    //console.log(item.Client);
                    return $("<li>")
                        .append("<div>" + item.Client + "</div>")
                        .appendTo(ul);
                };
        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container-fluid">
        <div class="card">
            <div class="card-header">
                Operación de Entrada.
            </div>
            <div class="card-body">
                <div class="card-text">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" id="txtSearchClaim" runat="server" placeholder="Proveedor" aria-label="Proveedor" aria-describedby="btnSearch">
                        <div class="input-group-append">
                            <button class="btn btn-toolbar" type="button" id="btnSearch">Buscar</button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


</asp:Content>
