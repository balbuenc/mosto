<%@ Page Title="" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="TransaccionMovimiento.aspx.cs" Inherits="Almacenes.TransaccionMovimiento" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="fondo">
        <div class="page-header  encabezado">
            <div class="container-fluid">
                <asp:Panel runat="server" DefaultButton="SearchBtn">
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
                                <asp:ListItem Text="Nro. transacción" Value="NROTRANSACCION"></asp:ListItem>
                                <asp:ListItem Text="Descripción" Value="DESCRIPCION"></asp:ListItem>
                                <asp:ListItem Text="Usuario" Value="USUARIO"></asp:ListItem>
                                <asp:ListItem Text="Solicitante" Value="SOLICITANTE"></asp:ListItem>
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

                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="AddTransaccionDependenciaBtn" ToolTip="Nuevo movimiento entre dependencias" OnClick="AddTransaccionBtn_ServerClick">
                                <div class="form-row">
                                <asp:Label  Text="Movimiento Dependencia" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label> 
                                <i class="fas fa-plus"  style="padding:5px"></i>
                                </div>
                                </asp:LinkButton>

                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="AddtransaccionDepositoBtn" ToolTip="Nuevo movimiento entre depósitos" OnClick="AddTransaccionBtn_ServerClick">
                                <div class="form-row">
                                <asp:Label  Text="Movimiento Depósito" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label> 
                                <i class="fas fa-sign-out-alt"  style="padding:5px"></i>
                                </div>
                                </asp:LinkButton>

                                <div class="btn-group" role="group">
                                    <button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle btn-border" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        #
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                        <a class="dropdown-item" id="Dependencia10" href="/TransaccionMovimiento.aspx?PageSize=10&Tipo=Dependencia" runat="server" visible="false">10</a>
                                        <a class="dropdown-item" id="Dependencia20" href="/TransaccionMovimiento.aspx?PageSize=20&Tipo=Dependencia" runat="server" visible="false">20</a>
                                        <a class="dropdown-item" id="Dependencia30" href="/TransaccionMovimiento.aspx?PageSize=30&Tipo=Dependencia" runat="server" visible="false">30</a>
                                        <a class="dropdown-item" id="Dependencia50" href="/TransaccionMovimiento.aspx?PageSize=50&Tipo=Dependencia" runat="server" visible="false">50</a>

                                        <a class="dropdown-item" id="Deposito10" href="/TransaccionMovimiento.aspx?PageSize=10&Tipo=Deposito" runat="server" visible="false">10</a>
                                        <a class="dropdown-item" id="Deposito20" href="/TransaccionMovimiento.aspx?PageSize=20&Tipo=Deposito" runat="server" visible="false">20</a>
                                        <a class="dropdown-item" id="Deposito30" href="/TransaccionMovimiento.aspx?PageSize=30&Tipo=Deposito" runat="server" visible="false">30</a>
                                        <a class="dropdown-item" id="Deposito50" href="/TransaccionMovimiento.aspx?PageSize=50&Tipo=Deposito" runat="server" visible="false">50</a>
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
                <asp:DataPager ID="TransaccionDataPager" runat="server" PagedControlID="TransaccionListView" PageSize="20">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                        <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm font-weight-bold  border" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary  btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                    </Fields>
                </asp:DataPager>
            </div>
            <asp:ListView ID="TransaccionListView"
                runat="server"
                DataSourceID="TransaccionDS"
                DataKeyNames="IdTransaccion"
                OnItemDataBound="TransaccionListView_ItemDataBound"
                OnItemCommand="TransaccionListView_ItemCommand">
                <LayoutTemplate>
                    <div class="table table-responsive">
                        <table class="table table-striped table-condensed">
                            <thead>
                                <th>ID</th>
                                <th>Fecha</th>
                                <th>Nro. Transacción</th>
                                <th>Descripción</th>
                                <th>Usuario</th>
                                <th>Solicitante</th>
                                <th>Estado</th>
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
                            <asp:Label ID="lblIdtransaccion" runat="server" Text='<%# Eval("Idtransaccion") %>' /></td>
                        <td>
                            <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("Fecha") %>' /></td>
                        <td>
                            <asp:Label ID="lblNroTransaccion" runat="server" Text='<%# Eval("NroTransaccion") %>' /></td>
                        <td>
                            <asp:Label ID="lblDefinicion" runat="server" Text='<%# Eval("Definicion") %>' /></td>
                        <td>
                            <asp:Label ID="lblUser" runat="server" Text='<%# Eval("UserName") %>' /></td>
                        <td>
                            <asp:Label ID="lblSolicitante" runat="server" Text='<%# Eval("Solicitante") %>' /></td>
                        <td>
                            <asp:Label ID="lblEstado" runat="server" Text='<%# Eval("Estado") %>' /></td>

                        <td>
                            <asp:LinkButton runat="server" ID="ReportTransaccionBtn" CommandName="ViewReport" CommandArgument='<%# Eval("IdTransaccion")%>' ToolTip="Ver reporte">
                            <i class="fas fa-book-reader"></i>
                            </asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton runat="server" ID="DetailsTransaccionBtn" CommandName="Editar" CommandArgument='<%# Eval("IdTransaccion")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                            </asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton runat="server" ID="DeleteTransaccionMovimientoBtn" CommandName="delete" CommandArgument='<%# Eval("IdTransaccion")%>' ToolTip="Eliminar Transaccion" OnClientClick="return confirm('Desea eliminar el registro?');">
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
            <asp:SqlDataSource ID="TransaccionDS"
                runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="[warehouse].[sp_TransaccionMovimiento_get_all]" SelectCommandType="StoredProcedure"
                DeleteCommand="warehouse.[sp_Transaccion_delete]" DeleteCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="IdTransaccion" DbType="Int32" />
                </DeleteParameters>
                <InsertParameters>
                </InsertParameters>
                <UpdateParameters>
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSearchKey" PropertyName="Text" Name="key" DefaultValue="*" />
                    <asp:ControlParameter ControlID="searchParameterDDL" PropertyName="SelectedValue" Name="parameter" />
                    <asp:QueryStringParameter Name="tipo_transaccion" Type="String" DefaultValue="Dependencia" QueryStringField="Tipo" />
                </SelectParameters>
            </asp:SqlDataSource>


            <asp:SqlDataSource ID="DependenciaDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="select IdDependencia, Dependencia + ' [' + Descripcion + ']' as Dependencia from warehouse.Dependencia where Activo = 'S' order by 2 asc"
                SelectCommandType="Text"></asp:SqlDataSource>
            <!-- #endregion -->




        </div>
    </div>
</asp:Content>
