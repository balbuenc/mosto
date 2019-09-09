<%@ Page Title="Código de barras" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="CodigoBarra.aspx.cs" Inherits="Almacenes.CodigoBarra" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%--<link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />--%>
    <link href="css/jquery-ui.css" rel="stylesheet" />
    
    <link href="css/Enigma.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.js"></script>

    <script type="text/javascript">
        $(function () {
            $("[id$=txtSearchArticulo]").autocomplete(
                {
                    source: "SearchArticuloBarcode.ashx",
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
                    console.log(item.Client);
                    return $("<li>")
                        .append("<div>" + item.Client + "</div>")
                        .appendTo(ul);
                };
        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="fondo">
        <div class="page-header encabezado">
            <div class="container-fluid">
                <asp:Panel runat="server" DefaultButton="SearchBtn">
                    <div class="row">
                        <div class="col-2 font-weight-bold">
                           Generar código
                        </div>
                        <div class="col-7">
                            <input id="txtSearchArticulo" runat="server" placeholder="Articulo" class="form-control form-control-sm">
                        </div>
                        <div class="col-2">
                            <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="AddLicitacionBtn" ToolTip="Agregar código" OnClick="AddLicitacionBtn_Click">
                                <div class="form-row">
                                <asp:Label  Text="Agregar código" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label> 
                                <i class="fas fa-plus fa-sm"  style="padding:5px"></i>
                                </div>
                            </asp:LinkButton>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-4 font-weight-bold">
                            Palabra clave
                        </div>
                        <div class="col-2 font-weight-bold">
                            Criterio
                        </div>
                        <div class="col-6">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-4">

                            <asp:TextBox ID="txtSearchKey" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-2">
                            <asp:DropDownList ID="searchParameterDDL" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Artículo" Value="ARTICULO"></asp:ListItem>
                                <asp:ListItem Text="Dato" Value="DATO"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-6">
                            <div class="btn-group btn-shadow">
                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="SearchBtn" onserverclick="SearchBtn_ServerClick" ToolTip="Buscar">
                                <div class="form-row">
                                <asp:Label Text="Buscar" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label>
                                <i class="fas fa-search fa-sm" style="padding:5px"></i>
                              </div>
                                </asp:LinkButton>


                                <div class="btn-group" role="group">
                                    <button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle btn-border" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        #
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                        <a class="dropdown-item" href="/CodigoBarra.aspx?PageSize=10" runat="server">10</a>
                                        <a class="dropdown-item" href="/CodigoBarra.aspx?PageSize=20" runat="server">20</a>
                                        <a class="dropdown-item" href="/CodigoBarra.aspx?PageSize=30" runat="server">30</a>
                                        <a class="dropdown-item" href="/CodigoBarra.aspx?PageSize=50" runat="server">50</a>
                                    </div>
                                </div>
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
                <asp:DataPager ID="CodigoBarraListViewDataPager" runat="server" PagedControlID="CodigoBarraListView" PageSize="10">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                        <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm font-weight-bold  border" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary  btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                    </Fields>
                </asp:DataPager>
            </div>
            <asp:ListView ID="CodigoBarraListView"
                runat="server"
                DataSourceID="CodigoBarraDS"
                DataKeyNames="IdCodigoBarra"
                OnItemCommand="ListView_ItemCommand">
                <LayoutTemplate>
                    <div class="table table-responsive">
                        <table class="table table-striped table-condensed">
                            <thead>
                                <th>ID</th>
                                <th>Artículo</th>
                                <th>Dato</th>
                                <th>...</th>
                                <th>...</th>
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
                            <asp:Label ID="lblIdCodigoBarra" runat="server" Text='<%# Eval("IdCodigoBarra") %>' /></td>
                        <td>
                            <asp:Label ID="lblIdArticuloMaestro" runat="server" Text='<%# Eval("Articulo") %>' /></td>
                        <td>
                            <asp:Label ID="lblDato" runat="server" Text='<%# Eval("Dato") %>' /></td>


                        <td>
                            <asp:LinkButton runat="server" ID="EditCodigoBarraBtn" CommandName="Editar" CommandArgument='<%# Eval("IdCodigoBarra")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                            </asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton runat="server" ID="CodigoBarraBtn" CommandName="Barcode" CommandArgument='<%# Eval("IdCodigoBarra")%>' ToolTip="Ver código de barras">
                                <i class="fas fa-barcode fa-sm"></i>
                            </asp:LinkButton>
                        </td>

                        <td>

                            <asp:LinkButton runat="server" ID="DeleteCodigoBarraBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdCodigoBarra")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');">
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

            <!-- #region Modals -->
            <div id="addModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="modal-content">
                                <div class="modal-header">
                                    <b id="addModalLabel">Agregar nuevo Código Barra.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">

                                    <div class="container-fluid">
                                        <div class="row">
                                            <div class="col-3">ID</div>
                                            <div class="col-9">
                                                <asp:TextBox ID="txtIdArticuloMaestro" runat="server" Text="" CssClass="form-control mitad" Enabled="false" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-3">Articulo</div>
                                            <div class="col-9">
                                                <asp:TextBox ID="txtArticuloMaestro" runat="server" Text='<%# Bind("Articulo") %>' CssClass="form-control" Enabled="false" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-3">Dato</div>
                                            <div class="col-9">
                                                <asp:TextBox ID="txtDato" runat="server" Text='<%# Bind("Dato") %>' CssClass="form-control" />
                                            </div>
                                        </div>



                                    </div>

                                    <hr />
                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" Text="Aceptar" CssClass="btn btn-success" OnClick="InsertButton_Click" />
                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" Text="Cancelar" CssClass="btn btn-danger" OnClick="CancelButton_Click" />

                                </div>
                                <div class="modal-footer">
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>


            </div>


            <div id="editModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">


                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="modal-content">
                                <div class="modal-header">
                                    <b id="editModalLabel">Modificar CodigoBarra.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                    <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                        CellPadding="4" DataKeyNames="IdCodigoBarra" ForeColor="#333333"
                                        DefaultMode="Edit"
                                        OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                        <EditItemTemplate>
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-3">ID</div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtIdCodigoBarra" runat="server" Text='<%# Bind("IdCodigoBarra") %>' CssClass="form-control mitad" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3">Articulo</div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtIdArticuloMaestro" runat="server" Text='<%# Bind("IdArticuloMaestro") %>' CssClass="form-control"  Visible="false"/>
                                                        <asp:TextBox ID="txtArticuloMaestro" runat="server" Text='<%# Bind("Articulo") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3">Dato</div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtDato" runat="server" Text='<%# Bind("Dato") %>' CssClass="form-control" />
                                                    </div>
                                                </div>



                                            </div>

                                            <hr />

                                            <asp:LinkButton ID="AcceptButton" runat="server" CausesValidation="False" CommandName="Update" Text="Aceptar" CssClass="btn btn-success" />
                                            <asp:LinkButton ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancelar" Text="Cancelar" CssClass="btn btn-danger" OnClick="CancelButton_Click" />
                                        </EditItemTemplate>
                                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                        <InsertItemTemplate>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                        </ItemTemplate>



                                    </asp:FormView>
                                </div>
                                <div class="modal-footer">
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>


            </div>

            <!-- #endregion -->




            <!-- #region DataSources -->
            <asp:SqlDataSource ID="CodigoBarraDS"
                runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                InsertCommand="warehouse.sp_CodigoBarra_insert" InsertCommandType="StoredProcedure"
                SelectCommand="warehouse.sp_CodigoBarra_get_all" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="IdCodigoBarra" Type="Int32" />
                    <asp:Parameter Name="IdArticuloMaestro" Type="Int32" />
                    <asp:Parameter Name="Dato" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSearchKey" PropertyName="Text" Name="key" DefaultValue="*" />
                    <asp:ControlParameter ControlID="searchParameterDDL" PropertyName="SelectedValue" Name="parameter" />
                </SelectParameters>
            </asp:SqlDataSource>



            <!-- #endregion -->




        </div>
    </div>
</asp:Content>
