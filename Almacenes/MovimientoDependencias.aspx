<%@ Page Title="" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="MovimientoDependencias.aspx.cs" Inherits="Almacenes.MovimientoDependencias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
    <link href="css/Enigma.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="container-fluid" style="background-color: white">
            <div class="row">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
            </div>
        </div>
    </div>
    <div class="container-fluid" style="background-color: white">
        <asp:UpdatePanel ID="MovimientoDependenciaUP" runat="server">
            <ContentTemplate>
                <div class="form-row">
                    <div class="col-10">
                        <div class="col-form-label" style="border-bottom: 1px solid; font-weight: bold"><b>Movimiento entre Dependencias</b></div>
                    </div>
                    <div class="col-2" style="text-align: right">
                        <button runat="server" id="ReportTransaccionBtn" class="btn btn-primary btn-group-lg" title="Ver reporte" visible="false">
                            <span>Imprimir Movimiento
                    <i class="fas fa-book-reader"></i>
                            </span>
                        </button>
                    </div>
                </div>
                <div class="form-row" style="padding-top: 10px">
                    <div class="col-3" style="vertical-align: middle">
                        <div class="col-form-label font-weight-bold">Dependencia Origen</div>
                    </div>
                    <div class="col-3">
                        <asp:DropDownList ID="DependenciaDDL"
                            runat="server"
                            DataSourceID="DependenciaDS"
                            DataTextField="Dependencia"
                            DataValueField="IdDependencia"
                            CssClass="form-control form-control-sm"
                            AutoPostBack="true">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-3">
                        <div class="col-form-label">Desripción del movimiento.</div>
                    </div>
                    <div class="col-3">
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
                    <div class="col-3">
                        <asp:TextBox CssClass="form-control form-control-sm" ID="txtDefincion" runat="server" />
                    </div>
                    <div class="col-3">
                        <asp:TextBox CssClass="form-control form-control-sm" ID="txtSolicitante" runat="server" />
                    </div>

                    <div class="col-1">
                        <asp:TextBox CssClass="form-control form-control-sm" ID="txtNroTransaccion" runat="server" Enabled="false" />
                    </div>

                    <div class="col-1">
                        <asp:TextBox CssClass="form-control form-control-sm" ID="txtFecha" runat="server" Enabled="false" />
                    </div>
                    <div class="col-2"></div>
                    <div class="col-2" style="text-align: right">
                        <button runat="server" id="btnCrearMovimientoDependenci" class="btn btn-danger" title="Ver reporte" onserverclick="btnCrearMovimientoDependenci_ServerClick">
                            <span>Grabar Movmiento                    
                                    <i class="fas fa-suitcase-rolling"></i>
                            </span>
                        </button>
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
                            <div class="col-form-label">Dependencia destino</div>
                        </div>
                        <div class="col-2">
                            <div class="col-form-label">Cantidad</div>
                        </div>

                        <div class="col-2"></div>
                        <div class="col-2"></div>
                    </div>
                    <div class="form-row">
                        <div class="col-3">
                            <asp:DropDownList ID="DependenciaDestinoDDL"
                                runat="server"
                                DataSourceID="DependenciaDS"
                                DataTextField="Dependencia"
                                DataValueField="IdDependencia"
                                CssClass="form-control form-control-sm"
                                AutoPostBack="false">
                            </asp:DropDownList>
                        </div>
                        <div class="col-2">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtArticuloCantidad" runat="server" TextMode="Number" />
                        </div>

                        <div class="col-2">
                            <asp:Button runat="server" ID="AgregarArticuloBtn" UseSubmitBehavior="false" Text="Mover Artículo" CausesValidation="false" CssClass="form-control" />
                        </div>

                    </div>
                </asp:Panel>

                <asp:Panel ID="ArticuloPanel" runat="server" Visible="false">
                    <div class="form-row">
                        <div class="col-12">
                            <div class="col-form-label" style="border-bottom: 1px solid; font-weight: bold">Artículos</div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-12">
                            <div class="col-10">
                                <asp:DataPager ID="SalidaLoteDataPager" runat="server" PagedControlID="SalidaLoteListView" PageSize="10">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                                        <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                                    </Fields>
                                </asp:DataPager>
                            </div>
                            <asp:ListView ID="SalidaLoteListView"
                                runat="server"
                                DataSourceID="LoteContratoDS"
                                DataKeyNames="IdSalidaLote">
                                <LayoutTemplate>
                                    <div class="table responsive">
                                        <table class="table table-striped table-condensed">
                                            <thead>
                                                <th>ID</th>
                                                <th>Artículo</th>
                                                <th>Cantidad</th>
                                                <th>Precio Unitario</th>
                                                <th>Monto Impuesto</th>
                                                <th>Total</th>

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
                                            <asp:Label ID="lblIdLote" runat="server" Text='<%# Eval("IdSalidaLote") %>' />
                                        </td>
                                        <td>
                                            <asp:Label ID="lbArticulo" runat="server" Text='<%# Eval("Articulo") %>' />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCantidad" runat="server" Text='<%#:string.Format("{0:N0}", Eval("Cantidad")) %>' />
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
                                        <td hidden="hidden">
                                            <asp:Label ID="lblDependencia" runat="server" Text='<%# Eval("Dependencia") %>' Visible="false" />
                                        </td>
                                        <td hidden="hidden">
                                            <asp:Label ID="lblIdDependencia" runat="server" Text='<%# Eval("IdDependencia") %>' Visible="false" />
                                        </td>


                                        <td>
                                            <asp:LinkButton runat="server" ID="DeleteArticuloBtn" CommandName="Delete" CommandArgument='<%# Eval("IdSalidaLote")%>' ToolTip="Eliminar">
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
        SelectCommand="[warehouse].[sp_GetLoteArticuloExistenteByIdDependencia_DDL]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DependenciaDDL" PropertyName="SelectedValue" Name="IdDependencia" DbType="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="LoteContratoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
        SelectCommand="[warehouse].[sp_SalidaLote_get_SalidaLote_By_NroTransaccion]" SelectCommandType="StoredProcedure"
        DeleteCommand="warehouse.sp_SalidaLote_delete" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtNroTransaccion" Name="NroTransaccion" PropertyName="Text" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="IdSalidaLote" DbType="Int32" />
        </DeleteParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="DependenciaDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
        SelectCommand="select IdDependencia, Dependencia from warehouse.Dependencia where Activo = 'S' order by 1" SelectCommandType="Text"></asp:SqlDataSource>

    <!-- #endregion -->
</asp:Content>
