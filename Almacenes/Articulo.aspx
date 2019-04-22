<%@ Page Title="Artículos" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Articulo.aspx.cs" Inherits="Almacenes.Articulo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/Enigma.css" rel="stylesheet" />
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
        <asp:ListView ID="ArticuloListView"
            runat="server"
            DataSourceID="ArticuloDS"
            DataKeyNames="IdArticulo"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Descripción</th>
                            <th>Proveedor</th>
                            <th>Entrega</th>
                            <th>Vencimiento</th>
                            <th>Cód. Barra</th>
                            <th>U. Medida</th>
                            <th>Cant. Total</th>
                            <th>Cant. Pendiente</th>
                            <th>Cant. Existente</th>
                            <th>Contrato</th>
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
                        <asp:Label ID="lblIdArticulo" runat="server" Text='<%# Eval("IdArticulo") %>' /></td>
                    <td>
                        <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("Descripcion") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdProveedor" runat="server" Text='<%# Eval("IdProveedor") %>' Visible="false"/>
                        <asp:Label ID="lblProveedor" runat="server" Text='<%# Eval("Proveedor") %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaEntrega" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}", Eval("FechaEntrega") ) %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaVencimiento" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}", Eval("FechaVencimiento") ) %>' /></td>
                    <td>
                        <asp:Label ID="lblCodigoDeBarra" runat="server" Text='<%# Eval("CodigoDeBarra") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdUnidadMedida" runat="server" Text='<%# Eval("IdUnidadMedida")%>'  Visible="false" />
                        <asp:Label ID="lblUnidadMedida" runat="server" Text='<%# Eval("UnidadMedida") %>' /></td>
                    <td>
                        <asp:Label ID="lblCantidadTotal" runat="server" Text='<%# Eval("CantidadTotal") %>' /></td>
                    <td>
                        <asp:Label ID="lblCantidadPendiente" runat="server" Text='<%# Eval("CantidadPendiente") %>' /></td>
                    <td>
                        <asp:Label ID="lblCantidadExistente" runat="server" Text='<%# Eval("CantidadExistente") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdContrato" runat="server" Text='<%# Eval("IdContrato") %>' Visible="false"/>
                        <asp:Label ID="lblContrato" runat="server" Text='<%# Eval("Contrato") %>' /></td>
                    <td>
                        <asp:LinkButton  runat="server" ID="EditArticuloBtn" CommandName="Editar" CommandArgument='<%# Eval("IdArticulo")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton  runat="server" ID="DeleteArticuloBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdArticulo")%>' ToolTip="Eliminar">
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
                                <b id="addModalLabel">Agregar nuevo Articulo.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="ArticuloDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdArticulo" ForeColor="#333333"
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
                                                    <asp:TextBox ID="txtIdArticulo" runat="server" Text="" CssClass="form-control mitad" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Descripción</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Bind("Descripcion") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Proveedor</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdProveedorDDL"
                                                        runat="server"
                                                        DataSourceID="ProveedorDS"
                                                        DataTextField="Razonsocial"
                                                        DataValueField="IdProveedor"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdProveedor") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Entrega</b></div>
                                                <div class="col-9">
                                                    <asp:Calendar ID="txtFechaEntrega" runat="server" SelectedDate='<%# Bind("FechaEntrega") %>' />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Vencimiento</b></div>
                                                <div class="col-9">
                                                    <asp:Calendar ID="txtFechaVencimiento" runat="server" SelectedDate='<%# Bind("FechaVencimiento") %>' />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Cód. barra</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCodigoDeBarra" runat="server" Text='<%# Bind("CodigoDeBarra") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>U. Medida</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdUnidadMedidaDDL"
                                                        runat="server"
                                                        DataSourceID="UnidadMedidaDS"
                                                        DataTextField="UnidadMedida"
                                                        DataValueField="IdUnidadMedida"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdUnidadMedida") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Cant. Total</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCantidadTotal" runat="server" Text='<%# Bind("CantidadTotal") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Cant. Pendiente</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCantidadPendiente" runat="server" Text="" CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Cant. Existente</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCantidadExistente" runat="server" Text="" CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Contrato</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdContratoDDL"
                                                        runat="server"
                                                        DataSourceID="ContratoDS"
                                                        DataTextField="NroContrato"
                                                        DataValueField="IdContrato"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdContrato") %>'>
                                                    </asp:DropDownList>
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
                                <b id="editModalLabel">Modificar Articulo.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdArticulo" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3"><b>ID</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdArticulo" runat="server" Text='<%# Bind("IdArticulo") %>' CssClass="form-control mitad" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Descripción</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Bind("Descripcion") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Proveedor</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdProveedorDDL"
                                                        runat="server"
                                                        DataSourceID="ProveedorDS"
                                                        DataTextField="Razonsocial"
                                                        DataValueField="IdProveedor"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdProveedor") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Entrega</b></div>

                                                <div class="col-9">
                                                    <div class="input-group date" data-provide="datepicker" data-date-format="dd/mm/yyyy">
                                                        <input type="text" class="form-control" value='<%#  String.Format("{0:dd/MM/yyyy}",Eval( "FechaEntrega") ) %>' runat="server" id="calendarFechaEntregaArticulo">
                                                        <div class="input-group-addon">
                                                            <span class="glyphicon glyphicon-th"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Vencimiento</b></div>

                                                <div class="col-9">
                                                    <div class="input-group date" data-provide="datepicker" data-date-format="dd/mm/yyyy">
                                                        <input type="text" class="form-control" value='<%#  String.Format("{0:dd/MM/yyyy}",Eval( "FechaVencimiento") ) %>' runat="server" id="calendarFechaVencimientoArticulo">
                                                        <div class="input-group-addon">
                                                            <span class="glyphicon glyphicon-th"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Cód. barra</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCodigoDeBarra" runat="server" Text='<%# Bind("CodigoDeBarra") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>U. Medida</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdUnidadMedidaDDL"
                                                        runat="server"
                                                        DataSourceID="UnidadMedidaDS"
                                                        DataTextField="UnidadMedida"
                                                        DataValueField="IdUnidadMedida"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdUnidadMedida") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Cant. Total</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCantidadTotal" runat="server" Text='<%# Bind("CantidadTotal") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Cant. Pendiente</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCantidadPendiente" runat="server" Text='<%# Bind("CantidadPendiente") %>' CssClass="form-control" Enabled="false"/>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Cant. Existente</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCantidadExistente" runat="server" Text='<%# Bind("CantidadExistente") %>' CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Contrato</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdContratoDDL"
                                                        runat="server"
                                                        DataSourceID="ContratoDS"
                                                        DataTextField="NroContrato"
                                                        DataValueField="IdContrato"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdContrato") %>'>
                                                    </asp:DropDownList>
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
        <asp:SqlDataSource ID="ArticuloDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            InsertCommand="warehouse.sp_Articulo_insert" InsertCommandType="StoredProcedure"
            SelectCommand="warehouse.sp_Articulo_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
                
                <asp:Parameter Name="IdProveedor" Type="Int32" />
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter Name="FechaEntrega" Type="DateTime" />
                <asp:Parameter Name="FechaVencimiento" Type="DateTime" />
                <asp:Parameter Name="CodigoDeBarra" Type="String" />
                <asp:Parameter Name="IdUnidadMedida" Type="Int32" />
                <asp:Parameter Name="CantidadTotal" Type="Decimal" />
                <asp:Parameter Name="IdContrato" Type="Int32" />

            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="ProveedorDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdProveedor, upper(RazonSocial) as RazonSocial from management.Proveedor  order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="UnidadMedidaDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdUnidadMedida, UnidadMedida from warehouse.UnidadMedida  order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="ContratoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdContrato, NroContrato from management.Contrato  order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <!-- #endregion -->




    </div>
</asp:Content>
