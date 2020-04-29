<%@ Page Title="Contrato Detalle" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="ContratoDetalle.aspx.cs" Inherits="Almacenes.ContratoDetalle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />--%>
    <link href="css/jquery-ui.css" rel="stylesheet" />
    <link href="css/Enigma.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.js"></script>



    <script type="text/javascript">
        $(function () {
            $("[id$=txtSearchArticulo]").autocomplete(
                {
                    source: "SearchArticulo.ashx?IdContrato='<%=Request.QueryString["IdContrato"] %>'",
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

    <script type="text/javascript">
        $(function () {
            $("[id$=txtSearchProveedor]").autocomplete(
                {
                    source: "SearchProveedor.ashx",
                    minLength: 3,
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
        <div class="page-header">
            <div class="container-fluid">

                <div class="row">
                    <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
                </div>
            </div>
        </div>

        <div class="container-fluid">


            <div class="form-row">
                <div class="col-12">
                    <div class="col-form-label" style="border-bottom: 1px solid; font-weight: bold"><b>Datos del Contrato</b></div>
                </div>

            </div>
            <br />
            <div class="form-row">
                <div class="col-2">
                    <div class="col-form-label"><b>Nro. Contrato</b></div>
                </div>
                <div class="col-2">
                    <asp:TextBox ID="txtNroContrato" runat="server" Text="" CssClass="form-control form-control-sm" />
                </div>
                <div class="col-1">
                    <div class="col-form-label"><b>Tipo</b></div>
                </div>
                <div class="col-2">
                    <asp:DropDownList ID="TipoDDL"
                        runat="server"
                        CssClass="form-control form-control-sm">
                        <asp:ListItem Value="N" Text="Normal"></asp:ListItem>
                        <asp:ListItem Value="R" Text="Requerimiento"></asp:ListItem>

                    </asp:DropDownList>
                </div>
            </div>
            <div class="form-row">
                <div class="col-4">
                    <div class="col-form-label"><b>Proveedor</b></div>
                </div>
                <div class="col">
                    <div class="col-form-label"><b>Inicio</b></div>
                </div>
                <div class="col">
                    <div class="col-form-label"><b>Fin</b></div>
                </div>
                <div class="col-4">
                    <div class="col-form-label"><b>Licitación</b></div>
                </div>
            </div>
            <div class="form-row">
                <div class="col-4">
                    <input id="txtSearchProveedor" class="form-control form-control-sm" runat="server" placeholder="Proveedor" />
                </div>
                <div class="col-2">
                    <asp:TextBox ID="txtFechaInicioContrato" runat="server" Text="" CssClass="form-control form-control-sm" />
                </div>
                <div class="col-2">
                    <asp:TextBox ID="txtFechaFinContrato" runat="server" Text="" CssClass="form-control form-control-sm" />
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

            <div class="form-row">
                <div class="col-12">
                    <div class="col-form-label" style="border-bottom: 1px solid; font-weight: bold"><b>Datos del Artículo</b></div>
                </div>

            </div>
            <br />
            <asp:Panel ID="ArticuloPanel" runat="server" DefaultButton="AgregarArticuloBtn">
                <div class="form-row">

                    <div class="col-7">
                        <div class="input-group mb-7">
                            <input id="txtSearchArticulo" runat="server" placeholder="Articulo" class="form-control form-control-sm">
                            <div class="input-group-append">

                                <button class="btn btn-outline-secondary btn-sm" type="button" runat="server" id="btnClearArticulo" onserverclick="btnClearArticulo_ServerClick" title="Limpiar artículo">
                                    <i class="fas fa-broom fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <input type="text" class="form-control form-control-sm" id="txtArticuloCantidad" runat="server" placeholder="Cantidad del Artículo">
                    </div>
                    <div class="col">
                        <input type="text" class="form-control form-control-sm" id="txtArticuloPrecio" runat="server" placeholder="Precio">
                    </div>
                    <div class="col">
                        <asp:DropDownList ID="IdImpuestoDDL"
                            runat="server"
                            DataSourceID="ImpuestoDS"
                            DataTextField="Impuesto"
                            DataValueField="IdImpuesto"
                            CssClass="form-control form-control-sm">
                        </asp:DropDownList>

                    </div>
                    <div class="col-1 pull-right">
                        <asp:Button runat="server" ID="AgregarArticuloBtn" UseSubmitBehavior="false" OnClick="AgregarArticuloBtn_Click" Text="Agregar" CausesValidation="false" CssClass="btn btn-success" />
                    </div>

                </div>
            </asp:Panel>

            <div class="form-row">
                <div class="col-12">
                    <div class="col-form-label" style="border-bottom: 1px solid; font-weight: bold">Artículos del contrato</div>
                </div>

            </div>
            <div class="row pie" style="padding-left: 15px">
                <div class="col-10">
                    <asp:DataPager ID="ArticuloContratoDataPager" runat="server" PagedControlID="ArticuloContratoListView" PageSize="10">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                            <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm font-weight-bold  border" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                            <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                        </Fields>
                    </asp:DataPager>
                </div>
                <div class="col-2">
                    <asp:Button runat="server" ID="CerrarDetalleBtn" CssClass="btn btn-danger btn-sm" Text="Finalizar contrato" OnClick="CerrarDetalleBtn_Click" />
                </div>
            </div>
            <div class="form-row">
                <div class="col-12">

                    <asp:ListView ID="ArticuloContratoListView"
                        runat="server"
                        DataSourceID="ArticuloContratoDS"
                        DataKeyNames="IdArticulo"
                        OnItemDataBound="ArticuloContratoListView_ItemDataBound"
                         OnDataBound="ArticuloContratoListView_DataBound">
                        <LayoutTemplate>
                            <div class="table table-responsive">
                                <table class="table table-striped table-condensed">
                                    <thead>
                                        <th>ID</th>
                                        <th>Artículo</th>
                                        <th>Cantidad</th>
                                        <th>Precio Unitario</th>
                                        <th>Impuesto</th>
                                        <th>Monto Impuesto</th>
                                        <th>Total</th>
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
                            <tr style="min-height: 5px; height: 5px; font-size: x-small">
                                <td>
                                    <asp:Label ID="lblIdArticulo" runat="server" Text='<%# Eval("IdArticulo") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="lbArticulo" runat="server" Text='<%# Eval("Articulo") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text='<%#:string.Format("{0:N0}", Eval("CantidadTotal")) %>' />
                                </td>
                                <td>
                                    <asp:Label ID="lblPrecio" runat="server" Text='<%#:string.Format("{0:N0}",Eval("Precio")) %>' />

                                </td>
                                <td>
                                    <asp:Label ID="lblImpuesto" runat="server" Text='<%# Eval("Impuesto") %>' />
                                </td>
                                <td>
                                    <asp:Label ID="lblPrecioImpuesto" runat="server" Text='<%#:string.Format("{0:N0}", Eval("PrecioImpuesto")) %>' />
                                </td>
                                <td>
                                    <asp:Label ID="lblTotal" runat="server" Text='<%#:string.Format("{0:N0}", Eval("PrecioTotal")) %>' />
                                </td>
                                <td>
                                    <asp:LinkButton runat="server" ID="DeleteArticuloBtn" CommandName="Delete" CommandArgument='<%# Eval("IdArticulo")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');">
                            <i class="fas fa-trash-alt"></i>
                                    </asp:LinkButton>

                                </td>
                                <td>
                                    <asp:LinkButton runat="server" ID="EditArticuloBtn" CommandName="Edit" CommandArgument='<%# Eval("IdArticulo")%>' ToolTip="Editar">
                            <i class="fas fa-edit"></i>
                                    </asp:LinkButton>

                                </td>
                            </tr>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <td>
                                <asp:Label ID="lblIdArticulo" runat="server" Text='<%# Bind("IdArticulo"  ) %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbArticulo" runat="server" Text='<%# Eval("Articulo") %>' />
                            </td>
                            <td>
                                <asp:TextBox ID="txtCantidadTotal" runat="server" Text='<%# Bind("CantidadTotal","{0:0}") %>' TextMode="Number" />
                            </td>
                            <td>
                                <asp:TextBox ID="lblPrecio" runat="server" Text='<%# Bind("Precio","{0:0}") %>' TextMode="Number" />
                            </td>
                            <td>
                                <asp:DropDownList ID="IdImpuestoDDL"
                                    runat="server"
                                    DataSourceID="ImpuestoDS"
                                    DataTextField="Impuesto"
                                    DataValueField="IdImpuesto"
                                    CssClass="form-control form-control-sm"
                                    SelectedValue='<%# Bind("IdImpuesto") %>'>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Label ID="lblPrecioImpuesto" runat="server" Text="" />
                            </td>
                            <td>
                                <asp:Label ID="lblTotal" runat="server" Text="" />
                            </td>
                            <td>

                                <asp:LinkButton runat="server" ID="btnEdit" CommandName="Update" ToolTip="Aceptar">
                            <i class="fas fa-check"></i>
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton runat="server" ID="btnCancel" CommandName="Cancel" ToolTip="Cancelar">
                            <i class="fas fa-times"></i>
                                </asp:LinkButton>
                            </td>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                        </InsertItemTemplate>

                    </asp:ListView>



                </div>
            </div>
        </div>



        <!-- #region DataSources -->
        <asp:SqlDataSource ID="ProveedorDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdProveedor, RazonSocial from management.Proveedor  order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="LicitacionDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select l.IdLicitacion, upper(l.llamado) + ' | Nro. [' + cast(l.NroLicitacion as varchar(50)) + ']'  as Licitacion
                            from management.licitacion l
                            where Activo = 'S';"
            SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="ImpuestoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdImpuesto, Impuesto from management.Impuesto  order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="ArticuloContratoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="warehouse.sp_GetArticuloContrato_By_NroContrato" SelectCommandType="StoredProcedure"
            DeleteCommand="warehouse.sp_ArticuloContrato_delete" DeleteCommandType="StoredProcedure"
            UpdateCommand="warehouse.sp_ArticuloContrato_update" UpdateCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtNroContrato" Name="NroContrato" PropertyName="Text" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="IdArticulo" DbType="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="IdArticulo" DbType="Int32" />
                <asp:Parameter Name="CantidadTotal" DbType="Int32" />
                <asp:Parameter Name="Precio" DbType="Int32" />
                <asp:Parameter Name="IdImpuesto" DbType="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <!-- #endregion -->



    </div>

</asp:Content>

