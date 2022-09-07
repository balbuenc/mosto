<%@ Page Title="Clientes" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Proveedor.aspx.cs" Inherits="Almacenes.Management.Proveedores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="fondo">
        <div class="page-header encabezado">
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
                                <asp:ListItem Text="CLIENTE" Value="Proveedor"></asp:ListItem>
                                <asp:ListItem Text="RUC" Value="RUC"></asp:ListItem>
                                <asp:ListItem Text="Nro. Documento" Value="DOCUMENTO"></asp:ListItem>
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

                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="AddRegistroBtn" data-toggle="modal" data-target="#addModal" ToolTip="Agregar cliente">
                                <div class="form-row">
                                <asp:Label  Text="Agregar cliente" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label> 
                                <i class="fas fa-plus fa-sm"  style="padding:5px"></i>
                                </div>
                                </asp:LinkButton>
                                <div class="btn-group" role="group">
                                    <button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle btn-border" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        #
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                        <a class="dropdown-item" href="/Proveedor.aspx?PageSize=10" runat="server">10</a>
                                        <a class="dropdown-item" href="/Proveedor.aspx?PageSize=20" runat="server">20</a>
                                        <a class="dropdown-item" href="/Proveedor.aspx?PageSize=30" runat="server">30</a>
                                        <a class="dropdown-item" href="/Proveedor.aspx?PageSize=50" runat="server">50</a>
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
                <asp:DataPager ID="ProveedorDataPager" runat="server" PagedControlID="ProveedorListView" PageSize="10">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                        <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm font-weight-bold  border" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary  btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                    </Fields>
                </asp:DataPager>
            </div>

            <asp:ListView ID="ProveedorListView"
                runat="server"
                DataSourceID="ProveedorDS"
                DataKeyNames="IdProveedor"
                OnItemDataBound="ProveedorListView_ItemDataBound"
                OnItemCommand="ListView_ItemCommand">
                <LayoutTemplate>
                    <div class="table table-responsive">
                        <table class="table table-striped table-condensed">
                            <thead>
                                <th>ID</th>
                                <th>Nombres</th>
                                <th>Apellidos</th>
                                <th>Razón Social</th>
                                <th>RUC</th>
                                <th>Fecha Registro</th>
                                <th>Nro. Documento</th>
                                <th>Nro. CC</th>
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
                            <asp:Label ID="lblIdProveedor" runat="server" Text='<%# Eval("IdProveedor") %>' /></td>
                        <td>
                            <asp:Label ID="lblNombres" runat="server" Text='<%# Eval("Nombres") %>' /></td>
                        <td>
                            <asp:Label ID="lblApellidos" runat="server" Text='<%# Eval("Apellidos") %>' /></td>
                        <td>
                            <asp:Label ID="lblRazonSocial" runat="server" Text='<%# Eval("RazonSocial") %>' /></td>
                        <td>
                            <asp:Label ID="lblRUC" runat="server" Text='<%# Eval("RUC") %>' /></td>
                        <td>
                            <asp:Label ID="lblFechaRegistro" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval( "FechaRegistro") ) %>' /></td>
                        <td>
                            <asp:Label ID="lblNroDocumento" runat="server" Text='<%# Eval("NroDocumento") %>' /></td>
                        <td>
                            <asp:Label ID="lblNroCuenta" runat="server" Text='<%# Eval("NroCuenta") %>' /></td>

                        <td>
                            <asp:LinkButton runat="server" ID="EditProveedorBtn" CommandName="Editar" CommandArgument='<%# Eval("IdProveedor")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                            </asp:LinkButton>
                        </td>

                        <td>

                            <asp:LinkButton runat="server" ID="DeleteProveedorBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdProveedor")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');">
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
                                    <b id="addModalLabel">Agregar nuevo Cliente.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                    <asp:FormView ID="InsertFormView" runat="server" DataSourceID="ProveedorDS" Width="100%"
                                        CellPadding="4" DataKeyNames="IdProveedor" ForeColor="#333333"
                                        DefaultMode="Insert"
                                        OnItemInserted="FormView1_ItemInserted">
                                        <EditItemTemplate>
                                        </EditItemTemplate>
                                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                        <InsertItemTemplate>
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-3"><b>ID</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtIdProveedor" runat="server" Text="" CssClass="form-control mitad" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Nombres</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtNombres" runat="server" Text='<%# Bind("Nombres") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Apellidos</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtApellidos" runat="server" Text='<%# Bind("Apellidos") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Razón Social</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtRazonSocial" runat="server" Text='<%# Bind("RazonSocial") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>RUC</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtRUC" runat="server" Text='<%# Bind("RUC") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Fecha Registro</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtFechaRegistro" runat="server" Text='<%# Eval("FechaRegistro") %>' CssClass="form-control" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Nro. Documento</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtNroDocumento" runat="server" Text='<%# Bind("NroDocumento") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Nro. Cuenta contable</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtNroCuenta" runat="server" Text='<%# Bind("NroCuenta") %>' CssClass="form-control" />
                                                    </div>
                                                </div>

                                            </div>

                                            <hr />

                                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Aceptar" CssClass="btn btn-success" />
                                            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancelar" Text="Cancelar" CssClass="btn btn-danger" OnClick="CancelButton_Click" />
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


            <div id="editModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">


                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="modal-content">
                                <div class="modal-header">
                                    <b id="editModalLabel">Modificar Cliente.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                    <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                        CellPadding="4" DataKeyNames="IdProveedor" ForeColor="#333333"
                                        DefaultMode="Edit"
                                        OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                        <EditItemTemplate>
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-3"><b>ID</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtIdProveedor" runat="server" Text='<%# Bind("IdProveedor") %>' CssClass="form-control mitad" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Nombres</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtNombres" runat="server" Text='<%# Bind("Nombres") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Apellidos</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtApellidos" runat="server" Text='<%# Bind("Apellidos") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3">Razón Social</div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtRazonSocial" runat="server" Text='<%# Bind("RazonSocial") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>RUC</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtRUC" runat="server" Text='<%# Bind("RUC") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Fecha Registro</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtFechaRegistro" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval( "FechaRegistro") ) %>' CssClass="form-control" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Nro. Documento</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtNroDocumento" runat="server" Text='<%# Bind("NroDocumento") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Nro. Cuenta contable</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtNroCuenta" runat="server" Text='<%# Bind("NroCuenta") %>' CssClass="form-control" />
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
            <asp:SqlDataSource ID="ProveedorDS"
                runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                InsertCommand="management.sp_Proveedor_insert" InsertCommandType="StoredProcedure"
                SelectCommand="management.sp_Proveedor_get_all" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Nombres" Type="String" />
                    <asp:Parameter Name="Apellidos" Type="String" />
                    <asp:Parameter Name="RazonSocial" Type="String" />
                    <asp:Parameter Name="RUC" Type="String" />

                    <asp:Parameter Name="NroDocumento" Type="String" />
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
