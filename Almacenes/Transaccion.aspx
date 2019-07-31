<%@ Page Title="Ingresos" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Transaccion.aspx.cs" Inherits="Almacenes.Transaccion" %>

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
                                <asp:ListItem Text="Definición" Value="DEFINICION"></asp:ListItem>
                                <asp:ListItem Text="Nro. factura" Value="NROFACTURA"></asp:ListItem>
                                <asp:ListItem Text="Nro. contrato" Value="NROCONTRATO"></asp:ListItem>
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

                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="AddTransaccionBtn" data-toggle="modal" data-target="#addModal" ToolTip="Agregar entrada">
                                <div class="form-row">
                                <asp:Label  Text="Nueva Entrada" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label> 
                                <i class="fas fa-sign-in-alt"  style="padding:5px"></i>
                                </div>
                                </asp:LinkButton>

                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="AddtransaccionSalidaBtn" data-toggle="modal" data-target="#addModalSalida" ToolTip="Agregar salida">
                                <div class="form-row">
                                <asp:Label  Text="Nueva Salida" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label> 
                                <i class="fas fa-sign-out-alt"  style="padding:5px"></i>
                                </div>
                                </asp:LinkButton>

                                <div class="btn-group" role="group">
                                    <button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle btn-border" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        #
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                        <a class="dropdown-item" id="Entrada10" href="/Transaccion.aspx?PageSize=10&Tipo=Entrada" runat="server" visible="false">10</a>
                                        <a class="dropdown-item" id="Entrada20" href="/Transaccion.aspx?PageSize=20&Tipo=Entrada" runat="server" visible="false">20</a>
                                        <a class="dropdown-item" id="Entrada30" href="/Transaccion.aspx?PageSize=30&Tipo=Entrada" runat="server" visible="false">30</a>
                                        <a class="dropdown-item" id="Entrada50" href="/Transaccion.aspx?PageSize=50&Tipo=Entrada" runat="server" visible="false">50</a>

                                        <a class="dropdown-item" id="Salida10" href="/Transaccion.aspx?PageSize=10&Tipo=Salida" runat="server" visible="false">10</a>
                                        <a class="dropdown-item" id="Salida20" href="/Transaccion.aspx?PageSize=20&Tipo=Salida" runat="server" visible="false">20</a>
                                        <a class="dropdown-item" id="Salida30" href="/Transaccion.aspx?PageSize=30&Tipo=Salida" runat="server" visible="false">30</a>
                                        <a class="dropdown-item" id="Salida50" href="/Transaccion.aspx?PageSize=50&Tipo=Salida" runat="server" visible="false">50</a>
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
                OnItemCommand="ListView_ItemCommand"
                OnItemDataBound="TransaccionListView_ItemDataBound"
                OnDataBound="TransaccionListView_DataBound">
                <LayoutTemplate>
                    <div class="table table-responsive">
                        <table class="table table-striped table-condensed">
                            <thead>
                                <th>ID</th>
                                <th>Fecha</th>
                                <th>Nro. Transacción</th>
                                <th>Definición</th>

                                <th>Usuario</th>
                                <th>NroContrato</th>
                                <th id="thSolicitante" runat="server">Solicitante</th>
                                <th id="thNotaRemision" runat="server">Remisión</th>
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
                            <asp:Label ID="lblNroContrato" runat="server" Text='<%# Eval("NroContrato") %>' /></td>
                        <td id="tdSolicitante" runat="server">
                            <asp:Label ID="lblSolicitante" runat="server" Text='<%# Eval("Solicitante") %>' /></td>
                        <td id="tdNotaRemision" runat="server">
                            <asp:Label ID="lblNotaRemision" runat="server" Text='<%# Eval("NotaRemision") %>' /></td>
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

                            <asp:LinkButton runat="server" ID="DeleteTransaccionBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdTransaccion")%>' ToolTip="Eliminar Transaccion" OnClientClick="return confirm('Desea eliminar el registro?');">
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

            <div id="addModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="modal-content">
                                <div class="modal-header">
                                    <b id="addModalLabel">Agregar entrada.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">

                                    <div class="container-fluid">

                                        <div class="row">
                                            <div class="col-3">Descripción</div>
                                            <div class="col-9">
                                                <asp:TextBox ID="txtDefinicion" runat="server" Text='<%# Bind("Definicion") %>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-3">Nro. Factura</div>
                                            <div class="col-9">
                                                <asp:TextBox ID="txtNroFactura" runat="server" Text='<%# Bind("NroFactura") %>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-3">Remisión</div>
                                            <div class="col-9">
                                                <asp:TextBox ID="txtNotaRemision" runat="server" Text='<%# Bind("NotaRemision") %>' CssClass="form-control" />
                                            </div>
                                        </div>


                                        <div class="row">
                                            <div class="col-3">Contrato</div>
                                            <div class="col-9">
                                                <asp:DropDownList ID="IdContratoDDL"
                                                    runat="server"
                                                    DataSourceID="ContratoDS"
                                                    DataTextField="NroContrato"
                                                    DataValueField="IdContrato"
                                                    CssClass="form-control form-control-sm">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>

                                    <hr />

                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Aceptar" CssClass="btn btn-success" OnClick="InsertButton_Click" />
                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancelar" Text="Cancelar" CssClass="btn btn-danger" OnClick="CancelButton_Click" />

                                </div>
                                <div class="modal-footer">
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>


            </div>


            <div id="addModalSalida" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addModalSalidaLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="modal-content">
                                <div class="modal-header">
                                    <b id="addModalSalidaLabel">Agregar Salida.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">

                                    <div class="container-fluid">

                                        <div class="row">
                                            <div class="col-3">Descripción</div>
                                            <div class="col-9">
                                                <asp:TextBox ID="txtDefinicionSalida" runat="server" Text='<%# Bind("Definicion") %>' CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-3">Dependencia</div>
                                            <div class="col-9">
                                                <asp:DropDownList ID="DependenciaDDL"
                                                    runat="server"
                                                    DataSourceID="DependenciaDS"
                                                    DataTextField="Dependencia"
                                                    DataValueField="IdDependencia"
                                                    CssClass="form-control form-control-sm">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-3">Solicitante</div>
                                            <div class="col-9">
                                                <asp:TextBox ID="txtSolicitanteSalida" runat="server" Text="" CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row" style="visibility: hidden">
                                            <div class="col-3">Contrato</div>
                                            <div class="col-9">
                                                <asp:DropDownList ID="ContratoExistenciaDDL"
                                                    runat="server"
                                                    DataSourceID="ContratoExistenciaDS"
                                                    DataTextField="Contrato"
                                                    DataValueField="IdContrato"
                                                    CssClass="form-control form-control-sm">
                                                </asp:DropDownList>
                                            </div>
                                        </div>


                                    </div>

                                    <hr />
                                    <asp:LinkButton ID="InsertSalidaBtn" runat="server" CausesValidation="True" CommandName="Insert" Text="Aceptar" CssClass="btn btn-success" OnClick="InsertSalidaBtn_Click" />
                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancelar" Text="Cancelar" CssClass="btn btn-danger" OnClick="CancelButton_Click" />

                                </div>
                                <div class="modal-footer">
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

            <!-- #region DataSources -->
            <asp:SqlDataSource ID="TransaccionDS"
                runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="[warehouse].[sp_Transaccion_get_all]" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                </DeleteParameters>
                <InsertParameters>
                </InsertParameters>
                <UpdateParameters>
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSearchKey" PropertyName="Text" Name="key" DefaultValue="*" />
                    <asp:ControlParameter ControlID="searchParameterDDL" PropertyName="SelectedValue" Name="parameter" />
                    <asp:QueryStringParameter Name="tipo_transaccion" Type="String" DefaultValue="Entrada" QueryStringField="Tipo" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="ContratoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="select IdContrato, NroContrato + ' [' + p.RazonSocial + ']'  as NroContrato
                            from management.Contrato c
                            left outer join management.Licitacion l on c.IdLicitacion = l.IdLicitacion
                            left outer join management.Proveedor p on c.IdProveedor = p.IdProveedor 
                            where c.Estado = 'Activo'
                            order by 2"
                SelectCommandType="Text"></asp:SqlDataSource>

            <asp:SqlDataSource ID="ContratoExistenciaDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="management.sp_get_Contrato_ExistenciaDDL"
                SelectCommandType="StoredProcedure"></asp:SqlDataSource>

            <asp:SqlDataSource ID="DependenciaDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="select IdDependencia, Dependencia + ' [' + Descripcion + ']' as Dependencia from warehouse.Dependencia where Activo = 'S' order by 2 asc"
                SelectCommandType="Text"></asp:SqlDataSource>
            <!-- #endregion -->




        </div>
    </div>
</asp:Content>
