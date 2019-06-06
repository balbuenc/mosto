<%@ Page Title="Salida de Lotes" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="SalidaLote.aspx.cs" Inherits="Almacenes.SalidaLote" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
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
    <div class="page-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="col-form-label-lg azul"><%: Page.Title %> </div>
                </div>
            </div>
            <div class="row">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <asp:UpdatePanel ID="ArticuloContratoUP" runat="server">
            <ContentTemplate>
                <div class="form-row">
                    <div class="col-12">
                        <div class="col-form-label" style="border-bottom: 1px solid; font-weight: bold"><b>Operación de Salida</b></div>
                    </div>
                </div>
                <div class="form-row">

                    <div class="col-3">
                        <div class="col-form-label">Definición</div>
                    </div>
                    <div class="col-3">
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

                </div>
                <div class="form-row">

                    <div class="col-3">
                        <asp:TextBox CssClass="form-control form-control-sm" ID="txtDefincion" runat="server" Enabled="false" />
                    </div>
                    <div class="col-3">
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
                        <asp:TextBox CssClass="form-control form-control-sm" ID="txtExistente" runat="server" Enabled="false" />
                    </div>

                </div>



                <asp:Panel ID="ArticuloPanel" runat="server" DefaultButton="AgregarArticuloBtn">
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
                       
                        <div class="col-2">
                            <asp:Button runat="server" ID="AgregarArticuloBtn" UseSubmitBehavior="false" Text="Agregar al Lote" CausesValidation="false" CssClass="form-control"  OnClick="AgregarArticuloBtn_Click" />
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
                            DataKeyNames="IdLote">
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
                                    <td>
                                        <asp:Label ID="lblDependencia" runat="server" Text='<%# Eval("Dependencia") %>' />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblDeposito" runat="server" Text='<%# Eval("Deposito") %>' />
                                    </td>

                                    <td>
                                        <asp:LinkButton runat="server" ID="DeleteArticuloBtn" CommandName="Delete" CommandArgument='<%# Eval("IdArticulo")%>' ToolTip="Eliminar">
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
        SelectCommand="[warehouse].[sp_GetLoteArticuloExistente_DDL]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter SessionField="IdDependencia" Name="IdDependencia" DbType="Int32" />
        </SelectParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="LoteContratoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
        SelectCommand="[warehouse].[sp_Lote_get_Lote_By_NroTransaccion]" SelectCommandType="StoredProcedure"
        DeleteCommand="[warehouse].[sp_Lote_delete]" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="NroTransaccion" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="IdLote" DbType="Int32" />
        </DeleteParameters>

    </asp:SqlDataSource>

    <!-- #endregion -->
</asp:Content>
