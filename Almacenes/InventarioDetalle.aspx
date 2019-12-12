﻿<%@ Page Title="Detalles de inventario" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="InventarioDetalleDetalle.aspx.cs" Inherits="Almacenes.InventarioDetalleDetalle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="css/jquery-ui.css" rel="stylesheet" />
    <link href="css/Enigma.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.js"></script>



    <script type="text/javascript">
        $(function () {
            $("[id$=txtSearchArticulo]").autocomplete(
                {
                    source: "SearchArticuloDeposito.ashx?IdInventario='<%=Request.QueryString["IdInventario"] %>'" ,
                    // note minlength, triggers the Handler call only once 3 characters entered
                    //source: 

                    minLength: 3,
                    focus: function (event, ui) {
                        $("[id$=txtSearchArticulo]").val(ui.item.label);
                        return false;
                    },
                    select: function (event, ui) {
                        if (ui.item) {
                            $("[id$=txtSearchArticulo]").val(ui.item.Client);
                            console.log($("[id$=btnSearch]"));
                            $("[id$=btnSearch]").click();
                            return false;
                        }

                    }
                })
                .autocomplete("instance")._renderItem = function (ul, item) {
                    //console.log(item.Client);
                    return $("<li>")
                        .append("<div class='style=background:black'>" + item.Client + "</div>")
                        .appendTo(ul);
                };
        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="fondo">
        <div class="page-header encabezado">
            <div class="container-fluid">

                <asp:Panel runat="server" DefaultButton="AddRegistroBtn">
                    <div class="row">
                        <div class="col-5 font-weight-bold">
                            Artículo
                        </div>
                       
                        <div class="col-2 font-weight-bold">
                            Existencia
                        </div>
                        <div class="col-4 font-weight-bold">
                            Detalle
                        </div>
                        <div class="col-1"></div>

                    </div>

                    <div class="row">
                        <div class="col-5">
                            <%--<asp:DropDownList ID="ArticuloDDL" runat="server" CssClass="form-control" DataSourceID="ArticuloDS" DataValueField="IdArticuloMaestro" DataTextField="Articulo">
                            </asp:DropDownList>--%>
                            <div class="input-group mb-4">
                            <input id="txtSearchArticulo" runat="server" placeholder="Articulo" class="form-control form-control-sm">
                            <div class="input-group-append">

                                <button class="btn btn-outline-secondary btn-sm" type="button" runat="server" id="btnClearArticulo" onserverclick="btnClearArticulo_ServerClick" title="Limpiar artículo">
                                    <i class="fas fa-broom fa-sm"></i>
                                </button>
                            </div>
                        </div>
                        </div>

                        <div class="col-2">
                            <asp:TextBox ID="txtExistencia" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-4">
                            <asp:TextBox ID="txtDetalle" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>


                        <div class="col-1">
                            <div class="btn-group btn-shadow">

                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="AddRegistroBtn" ToolTip="Agregar inventario" OnClick="AddRegistroBtn_OnClick">
                                <div class="form-row">
                                <asp:Label  Text="Agregar" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label> 
                                <i class="fas fa-plus fa-sm"  style="padding:5px"></i>
                                </div>
                                </asp:LinkButton>

                            </div>
                        </div>

                    </div>
                </asp:Panel>
            </div>
            <div class="row">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
            </div>
        </div>

        <div class="container-fluid">
            <div class="row pie" style="padding-left: 15px">
                <asp:DataPager ID="InventarioDetalleDataPager" runat="server" PagedControlID="InventarioDetalleListView" PageSize="100">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                        <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm font-weight-bold  border" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary  btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                    </Fields>
                </asp:DataPager>
            </div>

            <asp:ListView ID="InventarioDetalleListView"
                runat="server"
                DataSourceID="InventarioDetalleDS"
                DataKeyNames="IdInventarioDetalle"
                OnItemCommand="InventarioDetalleListView_ItemCommand">
                <LayoutTemplate>
                    <div class="table table-responsive">
                        <table class="table table-striped table-condensed">
                            <thead>
                                <th>ID</th>
                                <th>Artículo</th>
                                <th>Depósito</th>

                                <th>Existencia</th>
                                <th>Comentario</th>


                                <th>...</th>
                            </thead>
                            <tbody>
                                <tr runat="server" id="itemPlaceholder" />
                            </tbody>
                        </table>
                    </div>
                </LayoutTemplate>
                <ItemTemplate>

                    <tr>
                        <td>
                            <asp:Label ID="lblIdInventarioDetalle" runat="server" Text='<%# Eval("IdInventarioDetalle") %>' /></td>
                        <td>
                            <asp:Label ID="lblArticulo" runat="server" Text='<%# Eval("Articulo") %>' /></td>



                        <td>
                            <asp:Label ID="lblExistencia" runat="server" Text='<%# Eval("Existencia") %>' /></td>
                        <td>
                            <asp:Label ID="lblComentario" runat="server" Text='<%# Eval("Comentario") %>' /></td>



                        <td>

                            <asp:LinkButton runat="server" ID="DeleteInventarioDetalleBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdInventarioDetalle")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');">
                            <i class="fas fa-trash-alt"></i>
                            </asp:LinkButton>

                        </td>

                    </tr>

                </ItemTemplate>
                <EditItemTemplate>
                </EditItemTemplate>
                <InsertItemTemplate>
                </InsertItemTemplate>
            </asp:ListView>



            <!-- #region DataSources -->
            <asp:SqlDataSource ID="InventarioDetalleDS"
                runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="inventory.sp_InventarioDetalle_get_all" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                </DeleteParameters>

                <UpdateParameters>
                </UpdateParameters>

                <SelectParameters>
                    <asp:QueryStringParameter Name="IdInventario" QueryStringField="IdInventario" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>


            <asp:SqlDataSource ID="ArticuloDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="select IdArticuloMaestro, Articulo from warehouse.ArticuloMaestro order by ltrim(rtrim(Articulo))" SelectCommandType="Text"></asp:SqlDataSource>




            <!-- #endregion -->




        </div>
    </div>
</asp:Content>