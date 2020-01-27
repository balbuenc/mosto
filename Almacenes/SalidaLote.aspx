<%@ Page Title="Salida de Lotes" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="SalidaLote.aspx.cs" Inherits="Almacenes.SalidaLote" %>

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
            <asp:UpdatePanel ID="ArticuloContratoUP" runat="server">
                <ContentTemplate>

                    <div class="form-row">
                        <div class="col-3">
                            <div class="col-form-label" style="border-bottom: 1px solid; font-weight: bold"><b>Operación de Salida</b></div>
                        </div>
                        <div class="col-5">
                        </div>
                        <div class="col-4" style="text-align: right">
                            <div class="btn-group btn-shadow">
                                <asp:LinkButton runat="server" ID="CrearTransaccionBtn" CssClass="btn btn-danger btn-border" Text="Grabar transacción" OnClick="CrearTransaccionBtn_Click" Visible="false" ToolTip="Grabar Salida">
                                    <span>Grabar Transacción
                                        <i class="fas fa-suitcase-rolling"></i>
                                    </span>
                                </asp:LinkButton>

                                <button runat="server" id="ReportTransaccionBtn" class="btn btn-primary btn-border" title="Ver reporte" onserverclick="ReportTransaccionBtn_ServerClick">
                                    <span>Imprimir Salida
                                    <i class="fas fa-book-reader"></i>
                                    </span>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-3">
                            <div class="col-form-label">Descripción</div>
                        </div>
                        <div class="col-2">
                            <div class="col-form-label">Dependencia</div>
                        </div>

                        <div class="col-1">
                            <div class="col-form-label">#Transacción</div>
                        </div>

                        <div class="col-1">
                            <div class="col-form-label">Fecha</div>
                        </div>
                        <div class="col-2">
                            <div class="col-form-label">Solicitante</div>
                        </div>
                        <div class="col-2">
                            <div class="col-form-label">Contrato</div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-3">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtDefincion" runat="server" Enabled="false" />
                        </div>
                        <div class="col-2">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtDependencia" runat="server" Enabled="false" />
                        </div>
                        <div class="col-1">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtNroTransaccion" runat="server" Enabled="false" />
                        </div>

                        <div class="col-1">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtFecha" runat="server" Enabled="false" />
                        </div>
                        <div class="col-2">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtSolicitante" runat="server" Enabled="false" />
                        </div>
                        <div class="col-2">
                            <asp:TextBox CssClass="form-control form-control-sm" ID="txtContrato" runat="server" Enabled="false" />
                        </div>
                        <div class="col-1">
                            <asp:LinkButton runat="server" ID="EditCabeceraBtn" ToolTip="Editar salida" OnClick="EditCabeceraBtn_Click" CssClass="btn btn-danger" Visible="true">
                                    <i class="fas fa-edit"></i>
                            </asp:LinkButton>
                            <asp:LinkButton runat="server" ID="AcceptCabeceraBtn" ToolTip="Guardar cambios" OnClick="AcceptCabeceraBtn_Click" CssClass="btn btn-success" Visible="false">
                                    <i class="fas fa-check"></i>
                            </asp:LinkButton>
                        </div>
                    </div>

                    <asp:Panel ID="ArticuloPanel" runat="server" DefaultButton="AgregarArticuloBtn"  Visible="false">
                        <div class="form-row">
                            <div class="col-5">
                                <div class="col-form-label">Artículo</div>
                            </div>
                            <div class="col-1">
                                <div class="col-form-label">Precio</div>
                            </div>
                            <div class="col-1">
                                <div class="col-form-label">Impuesto</div>
                            </div>

                            <div class="col-1">
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
                                    OnDataBound="IdArticuloDDL_DataBound"
                                    OnSelectedIndexChanged="IdArticuloDDL_SelectedIndexChanged"
                                    AutoPostBack="true">
                                </asp:DropDownList>
                            </div>
                            <div class="col-1">
                                <asp:TextBox CssClass="form-control form-control-sm" ID="txtPrecio" runat="server" Enabled="false" />
                            </div>
                            <div class="col-1">
                                <asp:TextBox CssClass="form-control form-control-sm" ID="txtImpuesto" runat="server" Enabled="false" />
                            </div>

                            <div class="col-1">
                                <asp:TextBox CssClass="form-control form-control-sm" ID="txtExistente" runat="server" Enabled="false" />
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="col-2">
                                <div class="col-form-label">Cantidad</div>
                            </div>
                            <div class="col-2"></div>
                        </div>
                        <div class="form-row">
                            <div class="col-2">
                                <asp:TextBox CssClass="form-control form-control-sm" ID="txtArticuloCantidad" runat="server" TextMode="Number" />
                            </div>
                            <div class="col-3">
                                <asp:Button runat="server" ID="AgregarArticuloBtn" UseSubmitBehavior="false" Text="Agregar salida de Artículo" CausesValidation="false" CssClass="btn btn-info" OnClick="AgregarArticuloBtn_Click" />
                            </div>

                            <div class="col-3">
                            </div>
                            <div class="col-2">
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
                            <div class="col-form-label" style="border-bottom: 1px solid; font-weight: bold">Artículos de Salida</div>
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
                                DataKeyNames="IdSalidaLote"
                                OnItemDataBound="SalidaLoteListView_ItemDataBound"
                                OnItemDeleted="SalidaLoteListView_ItemDeleted">
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
                                            <asp:LinkButton runat="server" ID="DeleteSalidaLoteBtn" CommandName="Delete" CommandArgument='<%# Eval("IdSalidaLote")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');">
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
        <asp:SqlDataSource ID="ArticuloLoteDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="[staging].[sp_GetLoteArticuloExistenteByIdDependencia_DDL]" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter SessionField="IdDependencia" Name="IdDependencia" DbType="Int32" />
            </SelectParameters>

        </asp:SqlDataSource>

        <asp:SqlDataSource ID="LoteContratoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="[staging].[sp_SalidaLote_get_SalidaLote_By_NroTransaccion]" SelectCommandType="StoredProcedure"
            DeleteCommand="staging.sp_SalidaLote_delete" DeleteCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtNroTransaccion" Name="NroTransaccion" PropertyName="Text" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="IdSalidaLote" DbType="Int32" />
            </DeleteParameters>

        </asp:SqlDataSource>
        <!-- #endregion -->
    </div>
</asp:Content>
