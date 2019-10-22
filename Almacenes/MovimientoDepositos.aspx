<%@ Page Title="Movimiento entre depósitos" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="MovimientoDepositos.aspx.cs" Inherits="Almacenes.MovimientoDepositos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />--%>
    <link href="css/jquery-ui.css" rel="stylesheet" />
    <link href="css/Enigma.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.js"></script>
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
            <asp:UpdatePanel ID="MovimientoDepositoUP" runat="server">
                <ContentTemplate>
                    <div class="form-row">
                        <div class="col-3">
                            <div class="col-form-label" style="border-bottom: 1px solid; font-weight: bold"><b>Movimiento entre Depósitos</b></div>
                        </div>

                        <div class="col-9" style="text-align: right">

                            <div class="btn-group btn-shadow">
                                <asp:LinkButton runat="server" ID="CrearMovimientoBtn" CssClass="btn btn-danger" Text="Grabar movimiento" OnClick="CrearMovimientoBtn_Click">
                            <span>Grabar Movimiento                    
                                    <i class="fas fa-suitcase-rolling"></i>
                            </span>
                                </asp:LinkButton>


                                <button runat="server" id="ReportTransaccionBtn" class="btn btn-primary btn-group-lg" title="Ver reporte" visible="false" onserverclick="ReportTransaccionBtn_ServerClick">
                                    <span>Imprimir Movimiento
                                       <i class="fas fa-book-reader"></i>
                                    </span>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="form-row" style="padding-top: 10px">
                        <div class="col-3" style="vertical-align: middle">
                            <div class="col-form-label font-weight-bold">Deposito Origen</div>
                        </div>
                        <div class="col-3">
                            <asp:DropDownList ID="DepositoDDL"
                                runat="server"
                                DataSourceID="DepositoDS"
                                DataTextField="Deposito"
                                DataValueField="IdDeposito"
                                CssClass="form-control form-control-sm"
                                AutoPostBack="true">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-3">
                            <div class="col-form-label">Descripción del movimiento.</div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-12">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtDefincion" runat="server" />
                        </div>
                    </div>
                    <div class="form-row">

                        <div class="col-4">
                            <div class="col-form-label">Solicitante</div>
                        </div>
                        <div class="col-1">
                            <div class="col-form-label">#Transacción</div>
                        </div>

                        <div class="col-1">
                            <div class="col-form-label">Fecha</div>
                        </div>

                    </div>

                    <div class="form-row">

                        <div class="col-4">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtSolicitante" runat="server" />
                        </div>

                        <div class="col-1">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtNroTransaccion" runat="server" Enabled="false" />
                        </div>

                        <div class="col-1">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtFecha" runat="server" Enabled="false" />
                        </div>



                    </div>
                    <hr />
                    <asp:Panel ID="DestinoPanel" runat="server" DefaultButton="AgregarArticuloBtn" Visible="false">
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
                                <div class="col-form-label">Existente</div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-5">
                                <asp:DropDownList ID="IdArticuloDDL"
                                    runat="server"
                                    DataSourceID="ArticuloLoteDS"
                                    DataTextField="Articulo"
                                    DataValueField="IdLote"
                                    CssClass="form-control form-control-sm"
                                    AutoPostBack="true"
                                    OnDataBound="IdArticuloDDL_DataBound"
                                    OnSelectedIndexChanged="IdArticuloDDL_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                            <div class="col">
                                <asp:TextBox CssClass="form-control form-control-sm" ID="txtPrecio" runat="server" Enabled="false" />
                            </div>
                            <div class="col">
                                <asp:TextBox CssClass="form-control form-control-sm" ID="txtImpuesto" runat="server" Enabled="false" />
                            </div>

                            <div class="col">
                                <asp:TextBox CssClass="form-control form-control-sm" ID="txtExistente" runat="server" Enabled="false" />
                            </div>

                        </div>
                        <div class="form-row">
                            <div class="col-3">
                                <div class="col-form-label">Depósito destino</div>
                            </div>
                            <div class="col-2">
                                
                            </div>

                            <div class="col-2"></div>
                            <div class="col-2"></div>
                        </div>
                        <div class="form-row">
                            <div class="col-3">
                                <asp:DropDownList ID="DependenciaDestinoDDL"
                                    runat="server"
                                    DataSourceID="DepositoDestinoDS"
                                    DataTextField="Deposito"
                                    DataValueField="IdDeposito"
                                    CssClass="form-control form-control-sm"
                                    AutoPostBack="false">
                                </asp:DropDownList>
                            </div>
                            <div class="col-2">
                               
                            </div>

                            <div class="col-2">
                                <asp:Button runat="server" ID="AgregarArticuloBtn" UseSubmitBehavior="false" Text="Mover Lote" CausesValidation="false" CssClass="btn btn-info" OnClick="AgregarArticuloBtn_Click" />
                            </div>

                        </div>
                    </asp:Panel>

                    <asp:Panel ID="ArticuloPanel" runat="server" Visible="false">
                        <div class="form-row">
                            <div class="col-10">
                                <div class="col-form-label" style="border-bottom: 1px solid; font-weight: bold">Artículos</div>
                            </div>
                            <div class="col-2" style="text-align: right">
                                <asp:LinkButton runat="server" ID="CerrarMovimientoBtn" CssClass="btn btn-success" Text="Cerrar movimiento" OnClick="CerrarMovimientoBtn_Click">
                            <span>Cerrar Movimiento 
                                <i class="fas fa-vote-yea"></i>
                            </span>
                                </asp:LinkButton>

                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-12">
                                <div class="col-10">
                                    <asp:DataPager ID="SalidaLoteDataPager" runat="server" PagedControlID="DepositoMovimientosListView" PageSize="10">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                                            <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                                            <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                                        </Fields>
                                    </asp:DataPager>
                                </div>
                                <asp:ListView ID="DepositoMovimientosListView"
                                    runat="server"
                                    DataSourceID="DepositoMovimientosDS"
                                    DataKeyNames="IdDepositoMovimiento"
                                    OnItemDeleted="DependenciaMovimientosListView_ItemDeleted">
                                    <LayoutTemplate>
                                        <div class="table table-responsive">
                                            <table class="table table-striped table-condensed">
                                                <thead>
                                                    <th>#</th>

                                                    <th>Artículo</th>
                                                    <th>Origen</th>
                                                    <th>Destino</th>
                                                    <th>Fecha</th>
                                                    <th>Cantidad</th>


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
                                                <asp:Label ID="lblIdDependenciaMovimiento" runat="server" Text='<%# Eval("IdDepositoMovimiento") %>' /></td>

                                            <td>
                                                <asp:Label ID="lblArticulo" runat="server" Text='<%# Eval("Articulo") %>' /></td>
                                            <td>
                                                <asp:Label ID="lblIdDependenciaAnterior" runat="server" Text='<%# Eval("Origen") %>' /></td>
                                            <td>
                                                <asp:Label ID="lblIdDependenciaActual" runat="server" Text='<%# Eval("Destino") %>' /></td>
                                            <td>
                                                <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("Fecha", "{0:dd/MM/yyyy}") %>' /></td>
                                            <td>
                                                <asp:Label ID="lblCantidad" runat="server" Text='<%# Eval("Cantidad") %>' /></td>




                                            <td>
                                                <asp:LinkButton runat="server" ID="DeleteMovimientoBtn" CommandName="Delete" CommandArgument='<%# Eval("IdDepositoMovimiento")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');">
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
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <!-- #region DataSources -->

        <asp:SqlDataSource ID="ArticuloLoteDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="[staging].[sp_GetLoteArticuloExistenteByIdDeposito_DDL]" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="DepositoDDL" PropertyName="SelectedValue" Name="IdDeposito" DbType="Int32" />
            </SelectParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="DepositoMovimientosDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="staging.sp_DepositoMovimiento_get_all" SelectCommandType="StoredProcedure"
            DeleteCommand="staging.sp_DepositoMovimiento_delete" DeleteCommandType="StoredProcedure"
            >
            <SelectParameters>
                <asp:ControlParameter ControlID="txtNroTransaccion" Name="NroTransaccion" PropertyName="Text" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="IdDepositoMovimiento" DbType="Int32" />
            </DeleteParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="DepositoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdDeposito, Deposito + isnull(' (' + Descripcion + ')','') as Deposito from warehouse.Deposito where Activo = 'S' order by 1" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="DepositoDestinoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdDeposito, Deposito + isnull(' (' + Descripcion + ')','') as Deposito from warehouse.Deposito where Activo = 'S' and IdDeposito <> @IdDepositoOrigen order by 1" SelectCommandType="Text">
            <SelectParameters>
                <asp:ControlParameter ControlID="DepositoDDL" Name="IdDepositoOrigen" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>

        <!-- #endregion -->

    </div>
</asp:Content>