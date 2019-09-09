<%@ Page Title="Entrada de Lotes" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="EntradaLote.aspx.cs" Inherits="Almacenes.EntradaLote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />--%>
    <link href="css/jquery-ui.css" rel="stylesheet" />
    <link href="css/Enigma.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.js"></script>



    <script type="text/javascript">
        $(function () {
            $("[id$=txtSearchContrato]").autocomplete(
                {
                    source: "SearchContrato.ashx",
                    minLength: 3,
                    focus: function (event, ui) {
                        $("[id$=txtSearchContrato]").val(ui.item.label);
                        return false;
                    },
                    select: function (event, ui) {
                        if (ui.item) {
                            $("[id$=txtSearchContrato]").val(ui.item.Client);
                            console.log($("[id$=SearchContratoBtn]"));
                            $("[id$=SearchContratoBtn]").click();
                            return false;
                        }

                    }
                })
                .autocomplete("instance")._renderItem = function (ul, item) {
                 
                    return $("<li>")
                        .append("<div class='style=background:black'>" + item.Client + "</div>")
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
                <div class="col-3">
                    <div class="col-form-label" style="border-bottom: 1px solid; font-weight: bold"><b>Datos del Contrato</b></div>
                </div>
                <div class="col-5"></div>
                <div class="col-4" style="text-align: right">
                    <div class="btn-group btn-shadow">
                        <asp:LinkButton runat="server" ID="CrearTransaccionBtn" CssClass="btn btn-danger btn-border" Text="Grabar transacción" OnClick="CrearTransaccionBtn_Click" Visible="false" ToolTip="Grabar Salida">
                                    <span>Grabar Transacción
                                        <i class="fas fa-suitcase-rolling"></i>
                                    </span>
                        </asp:LinkButton>
                        <button runat="server" id="ReportTransaccionBtn" class="btn btn-primary btn-border" title="Ver reporte" onserverclick="ReportTransaccionBtn_ServerClick">
                            <span>Imprimir Entrada
                    <i class="fas fa-book-reader"></i>
                            </span>
                        </button>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-1">
                    <div class="col-form-label">#Contrato</div>
                </div>
                <div class="col-3">
                    <div class="col-form-label">Proveedor</div>
                </div>
                <div class="col-3">
                    <div class="col-form-label">Licitación</div>
                </div>
                <div class="col-1">
                    <div class="col-form-label">Tipo</div>
                </div>
                <div class="col-1">
                    <div class="col-form-label">Estado</div>
                </div>
            </div>
            <div class="form-row">
                <div class="col-1">
                    <asp:TextBox ID="txtNroContrato" CssClass="form-control form-control-sm" runat="server" Text="" Enabled="false" />
                </div>
                <div class="col-3">
                    <asp:TextBox ID="txtProveedor" runat="server" Text="" CssClass="form-control form-control-sm" Enabled="false" />
                </div>
                <div class="col-3">
                    <asp:TextBox ID="txtLicitacion" runat="server" Text="" CssClass="form-control form-control-sm" Enabled="false" />
                </div>
                <div class="col-1">
                    <asp:TextBox ID="txtTipoContrato" runat="server" Text="" CssClass="form-control form-control-sm" Enabled="false" />
                </div>
                <div class="col-1">
                    <asp:TextBox ID="txtEstadoContrato" runat="server" Text="" CssClass="form-control form-control-sm" Enabled="false" />
                </div>

            </div>

            <asp:UpdatePanel ID="ArticuloContratoUP" runat="server">
                <ContentTemplate>
                    <div class="form-row">
                        <div class="col-12">
                            <div class="col-form-label" style="border-bottom: 1px solid; font-weight: bold"><b>Operación de Entrada</b></div>
                        </div>
                    </div>
                    <div class="form-row">

                        <div class="col-3">
                            <div class="col-form-label">Descripción</div>
                        </div>
                        <div class="col-2">
                            <div class="col-form-label">#Factura</div>
                        </div>
                        <div class="col-2">
                            <div class="col-form-label">#Remisión</div>
                        </div>
                        <div class="col-1">
                            <div class="col-form-label">#Transacción</div>

                        </div>


                        <div class="col-1">
                            <div class="col-form-label">Fecha</div>
                        </div>



                    </div>
                    <div class="form-row">


                        <div class="col-3">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtDefincion" runat="server" />
                        </div>
                        <div class="col-2">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtNroFactura" runat="server" />
                        </div>
                        <div class="col-2">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtNotaRemision" runat="server" />
                        </div>

                        <div class="col-1">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtNroTransaccion" runat="server" Enabled="false" />
                        </div>
                        <div class="col-1">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtFecha" runat="server" Enabled="false" />
                        </div>
                        <div class="col-1">
                            <asp:LinkButton runat="server" ID="EditCabeceraBtn" ToolTip="Editar entrada" OnClick="EditCabeceraBtn_Click" CssClass="btn btn-danger" Visible="true">
                                <i class="fas fa-edit"></i>
                            </asp:LinkButton>
                            <asp:LinkButton runat="server" ID="AcceptCabeceraBtn" ToolTip="Guardar cambios" OnClick="AcceptCabeceraBtn_Click" CssClass="btn btn-success" Visible="false">
                                <i class="fas fa-check"></i>
                            </asp:LinkButton>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-5">
                            <div class="col-form-label">Artículo</div>
                        </div>
                        <div class="col">
                            <div class="col-form-label">Precio</div>
                        </div>
                        <div class="col">
                            <div class="col-form-label">Impuesto</div>
                        </div>
                        <div class="col">
                            <div class="col-form-label">Cant. Contrato</div>
                        </div>
                        <div class="col">
                            <div class="col-form-label">Dif. Contrato</div>
                        </div>
                    </div>


                    <div class="form-row">

                        <div class="col-5">
                            <asp:DropDownList ID="IdArticuloDDL"
                                runat="server"
                                DataSourceID="ArticuloContratoDS"
                                DataTextField="Articulo"
                                DataValueField="IdArticulo"
                                CssClass="form-control form-control-sm"
                                OnSelectedIndexChanged="IdArticuloDDL_SelectedIndexChanged"
                                OnDataBound="IdArticuloDDL_DataBound"
                                AutoPostBack="true">
                            </asp:DropDownList>
                        </div>
                        <div class="col">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtPrecio" runat="server" Enabled="false" />
                        </div>
                        <div class="col">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtImpuesto" runat="server" Enabled="false" />
                        </div>
                        <div class="col">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtCantidadTotal" runat="server" Enabled="false" />
                        </div>
                        <div class="col">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtExistente" runat="server" Enabled="false" Visible="false" />
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtDiferenciaContrato" runat="server" Enabled="false" />
                        </div>

                    </div>



                    <asp:Panel ID="ArticuloPanel" runat="server" DefaultButton="AgregarArticuloBtn">
                        <div class="form-row">
                            <div class="col-2">
                                <div class="col-form-label">Cantidad</div>
                            </div>
                            <div class="col-4">
                                <div class="col-form-label">Dependencia</div>
                            </div>
                            <div class="col-4">
                                <div class="col-form-label">Depósito</div>
                            </div>
                            <div class="col-2"></div>
                        </div>
                        <div class="form-row">
                            <div class="col-2">
                                <asp:TextBox CssClass="form-control form-control-sm" ID="txtArticuloCantidad" runat="server" TextMode="Number" />
                            </div>
                            <div class="col-4">
                                <asp:DropDownList ID="IdDependendciaDDL"
                                    runat="server"
                                    DataSourceID="DependenciaDS"
                                    DataTextField="Dependencia"
                                    DataValueField="IdDependencia"
                                    CssClass="form-control form-control-sm">
                                </asp:DropDownList>
                            </div>
                            <div class="col-4">
                                <asp:DropDownList ID="IdDepositoDDL"
                                    runat="server"
                                    DataSourceID="DepositoDS"
                                    DataTextField="Deposito"
                                    DataValueField="IdDeposito"
                                    CssClass="form-control form-control-sm">
                                </asp:DropDownList>
                            </div>
                            <div class="col-2">
                                <asp:Button runat="server" ID="AgregarArticuloBtn" UseSubmitBehavior="false" Text="Agregar artículo" CausesValidation="false" CssClass="btn btn-info" OnClick="AgregarArticuloBtn_Click" />
                            </div>
                            <div class="col-2" style="text-align: right">
                                <asp:LinkButton runat="server" ID="CerrarTransaccionBtn" CssClass="btn btn-success btn-shadow" Text="Cerrar movimiento" OnClick="CerrarTransaccionBtn_Click" Visible="false">
                                    <span>Cerrar Transacción
                                        <i class="fas fa-vote-yea"></i>
                                    </span>
                                </asp:LinkButton>
                            </div>

                        </div>
                    </asp:Panel>

                    <div class="form-row">
                        <div class="col-12">
                            <div class="col-form-label" style="border-bottom: 1px solid; font-weight: bold">Artículos del Lote</div>
                        </div>
                    </div>


                    <div class="form-row">
                        <div class="col-12">
                            <div class="col-10">
                                <asp:DataPager ID="LoteContratoDataPager" runat="server" PagedControlID="LoteContratoListView" PageSize="10">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                                        <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                                    </Fields>
                                </asp:DataPager>
                            </div>
                            <asp:ListView ID="LoteContratoListView"
                                runat="server"
                                DataSourceID="LoteContratoDS"
                                DataKeyNames="IdLote"
                                OnItemDeleted="LoteContratoListView_ItemDeleted">
                                <LayoutTemplate>
                                    <div class="table table-responsive">
                                        <table class="table table-striped table-condensed">
                                            <thead>
                                                <th>ID</th>
                                                <th>Artículo</th>
                                                <th>Cantidad</th>
                                                <th>Precio Unitario</th>
                                                <th>Monto Impuesto</th>
                                                <th>Total</th>
                                                <th>Dependencia</th>
                                                <th>Depósito</th>
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
                                            <asp:Label ID="lblIdLote" runat="server" Text='<%# Eval("IdLote") %>' />
                                        </td>
                                        <td>
                                            <asp:Label ID="lbArticulo" runat="server" Text='<%# Eval("Articulo") %>' />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCantidad" runat="server" Text='<%#:string.Format("{0:N0}", Eval("CantidadEntrada")) %>' />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPrecio" runat="server" Text='<%#:string.Format("{0:N0}",Eval("Precio")) %>' />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPrecioImpuesto" runat="server" Text='<%#:string.Format("{0:N0}", Eval("PrecioImpuesto")) %>' />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotal" runat="server" Text='<%#:string.Format("{0:N0}", Eval("PrecioLote")) %>' />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDependencia" runat="server" Text='<%# Eval("Dependencia") %>' />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDeposito" runat="server" Text='<%# Eval("Deposito") %>' />
                                        </td>

                                        <td>
                                            <asp:LinkButton runat="server" ID="DeleteArticuloBtn" CommandName="Delete" CommandArgument='<%# Eval("IdArticulo")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');">
                                           <i class="fas fa-trash-alt"></i>
                                            </asp:LinkButton>
                                        </td>

                                    </tr>
                                </ItemTemplate>
                                <EditItemTemplate>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                </InsertItemTemplate>
                                <EmptyDataTemplate>
                                    <div class="container">
                                        <div class="alert-info" style="text-align: center">No se registran Artículos en la transacción actual.</div>
                                    </div>
                                </EmptyDataTemplate>

                            </asp:ListView>



                        </div>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <!-- #region DataSources -->




        <asp:SqlDataSource ID="DependenciaDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdDependencia, Dependencia + ' (' + Descripcion + ')' as Dependencia from warehouse.Dependencia where Activo = 'S' order by 1" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="DepositoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdDeposito, Deposito + ' ('+isnull(Ubicacion,'Sin ùbicación')+')' as Deposito from warehouse.Deposito where Activo = 'S' order by Deposito" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="ArticuloContratoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="warehouse.sp_GetArticuloContrato_By_NroContrato_DDL" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtNroContrato" Name="NroContrato" PropertyName="Text" />
            </SelectParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="LoteContratoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="[warehouse].[sp_Lote_get_Lote_By_NroTransaccion]" SelectCommandType="StoredProcedure"
            DeleteCommand="[warehouse].[sp_Lote_delete]" DeleteCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtNroTransaccion" Name="NroTransaccion" PropertyName="Text" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="IdLote" DbType="Int32" />
            </DeleteParameters>

        </asp:SqlDataSource>

        <!-- #endregion -->
    </div>

</asp:Content>
