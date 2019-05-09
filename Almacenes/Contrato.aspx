<%@ Page Title="Contratos" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Contrato.aspx.cs" Inherits="Almacenes.Contrato" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/Enigma.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.js"></script>



    <script type="text/javascript">
        $(function () {
            $("[id$=txtSearchArticulo]").autocomplete(
                {
                    source: "SearchArticulo.ashx",
                    // note minlength, triggers the Handler call only once 3 characters entered
                    appendTo: "#addModal",
                    minLength: 1,
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

    <script type="text/javascript">
        $(function () {
            $("[id$=txtSearchProveedor]").autocomplete(
                {
                    source: "SearchProveedor.ashx",
                    appendTo: "#addModal",
                    // note minlength, triggers the Handler call only once 3 characters entered
                    minLength: 1,
                    focus: function (event, ui) {
                        $("[id$=txtSearchProveedor]").val(ui.item.label);
                        return false;
                    },
                    select: function (event, ui) {
                        if (ui.item) {
                            $("[id$=txtSearchProveedor]").val(ui.item.Client);
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
    <div class="page-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-10">
                    <div class="col-form-label-lg azul"><%: Page.Title %> </div>

                </div>
                <div class="col-2">
                    <button class="btn btn-primary" type="button" runat="server" id="AddLicitacionBtn" data-toggle="modal" data-target="#addModal">
                        <i class="fas fa-plus"></i>
                    </button>
                </div>
            </div>
            <div class="row">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
            </div>
        </div>
    </div>

    <div class="container-fluid">

        <asp:ListView ID="ContratoListView"
            runat="server"
            DataSourceID="ContratoDS"
            DataKeyNames="IdContrato"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Proveedor</th>
                            <th>Inicio</th>
                            <th>Fin</th>
                            <th>Nro. de Contrato</th>
                            <th>Licitación</th>
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
                        <asp:Label ID="lblIdContrato" runat="server" Text='<%# Eval("IdContrato") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdProveedor" runat="server" Text='<%# Eval("IdProveedor") %>' Visible="false" />
                        <asp:Label ID="lblProveedor" runat="server" Text='<%# Eval("Proveedor") %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaInicioContrato" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval( "FechaInicioContrato") ) %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaFinContrato" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval( "FechaFinContrato") ) %>' /></td>
                    <td>
                        <asp:Label ID="lblNroContrato" runat="server" Text='<%# Eval("NroContrato") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdLicitacion" runat="server" Text='<%# Eval("IdLicitacion") %>' Visible="false" />
                        <asp:Label ID="lblLicitacion" runat="server" Text='<%# Eval("Licitacion") %>' />
                    </td>


                    <td>
                        <asp:LinkButton runat="server" ID="EditContratoBtn" CommandName="Editar" CommandArgument='<%# Eval("NroContrato")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>
                    <td>
                        <asp:LinkButton runat="server" ID="DeleteContratoBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdContrato")%>' ToolTip="Eliminar">
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
            <div class="modal-dialog" style="max-width: 1148px; width: 95%" role="document">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="modal-content">
                            <div class="modal-header">
                                <b id="addModalLabel">Detalle de Contrato.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <div class="form-row">
                                    <div class="col-2">
                                        <div class="col-form-label"><b>Nro. Contrato</b></div>
                                    </div>
                                    <div class="col-3">
                                        <asp:TextBox ID="txtNroContrato" runat="server" Text="" CssClass="form-control form-control-sm" TextMode="Number" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-4">
                                        <div class="col-form-label">Proveedor</div>
                                    </div>
                                    <div class="col">
                                        <div class="col-form-label">Inicio</div>
                                    </div>
                                    <div class="col">
                                        <div class="col-form-label">Fin</div>
                                    </div>
                                    <div class="col-4">
                                        <div class="col-form-label">Licitación</div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-4">
                                        <input id="txtSearchProveedor" class="form-control form-control-sm" runat="server" placeholder="Proveedor" />
                                    </div>
                                    <div class="col">
                                        <asp:TextBox ID="txtFechaInicioContrato" runat="server" Text="" CssClass="form-control form-control-sm" TextMode="Date" />
                                    </div>
                                    <div class="col">
                                        <asp:TextBox ID="txtFechaFinContrato" runat="server" Text="" CssClass="form-control form-control-sm" TextMode="Date" />
                                    </div>

                                    <div class="col-4">
                                        <asp:DropDownList ID="IdLicitacionDDL"
                                            runat="server"
                                            DataSourceID="LicitacionDS"
                                            DataTextField="Licitacion"
                                            DataValueField="IdLicitacion"
                                            CssClass="form-control form-control-sm">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <br />
                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="col-form-label">Datos del Artículo</div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col-4">
                                        <input id="txtSearchArticulo" runat="server" placeholder="Articulo" class="form-control form-control-sm">
                                    </div>
                                    <div class="col">
                                        <input type="text" class="form-control form-control-sm" id="txtArticuloCantidad" runat="server" placeholder="Cantidad del Artículo">
                                    </div>
                                    <div class="col">
                                        <input type="text" class="form-control form-control-sm" id="txtArticuloPrecio" runat="server" placeholder="Precio">
                                    </div>
                                    <div class="col-">
                                        <asp:DropDownList ID="IdImpuestoDDL"
                                            runat="server"
                                            DataSourceID="ImpuestoDS"
                                            DataTextField="Impuesto"
                                            DataValueField="IdImpuesto"
                                            CssClass="form-control form-control-sm">
                                        </asp:DropDownList>

                                    </div>
                                    <div class="col-1 text-center">
                                        <asp:LinkButton runat="server" ID="AgregarAriculoBtn" ToolTip="Agregar Artículo" OnClick="AgregarAriculoBtn_Click">
                                            <i class="fas fa-plus-circle"></i>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                                <br />
                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="col-form-label"><b>Artículos del contrato</b></div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <asp:GridView ID="ArticuloContratoGridView" runat="server" Width="100%" DataSourceID="ArticuloContratoDS" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="IdArticulo" Font-Names="Segoe UI" Font-Size="Smaller" ForeColor="#333333" GridLines="None">
                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                        <Columns>
                                            <asp:BoundField DataField="Articulo" HeaderText="Artículo" SortExpression="Articulo" />
                                            <asp:BoundField DataField="CantidadTotal" HeaderText="Cantidad" SortExpression="CantidadTotal" />
                                            <asp:BoundField DataField="Precio" HeaderText="Precio" SortExpression="Precio" />
                                            
                                        </Columns>
                                        <EditRowStyle BackColor="#999999" />
                                        <EmptyDataTemplate>
                                            <div class="alert-danger align-content-center" style="text-align: center">El contrato no tiene asignado Artículos.</div>
                                        </EmptyDataTemplate>
                                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                    </asp:GridView>
                                </div>

                                <div class="modal-footer">
                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Aceptar" CssClass="btn btn-success btn-sm" />
                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancelar" Text="Cancelar" CssClass="btn btn-danger btn-sm" OnClick="CancelButton_Click" />
                                </div>

                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>


        </div>



        <!-- #endregion -->




        <!-- #region DataSources -->
        <asp:SqlDataSource ID="ContratoDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            InsertCommand="management.sp_Contrato_insert" InsertCommandType="StoredProcedure"
            SelectCommand="management.sp_Contrato_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>

                <asp:Parameter Name="IdProveedor" Type="Int32" />
                <asp:Parameter Name="FechaInicioContrato" Type="DateTime" />
                <asp:Parameter Name="FechaFinContrato" Type="DateTime" />
                <asp:Parameter Name="NroContrato" Type="String" />
                <asp:Parameter Name="IdLicitacion" Type="Int32" />

            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="ProveedorDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdProveedor, RazonSocial from management.Proveedor  order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="LicitacionDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select l.IdLicitacion, upper(l.llamado) + ' | Nro. [' + cast(l.NroLicitacion as varchar(50)) + ']'  as Licitacion
                            from management.licitacion l;"
            SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="ImpuestoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdImpuesto, Impuesto from management.Impuesto  order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="ArticuloContratoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="warehouse.sp_GetArticuloContrato_By_NroContrato" SelectCommandType="StoredProcedure">
            <SelectParameters>

                <asp:ControlParameter ControlID="txtNroContrato" Name="NroContrato" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>

        <!-- #endregion -->




    </div>
</asp:Content>
