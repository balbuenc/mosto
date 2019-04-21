<%@ Page Title="Contratos" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Contrato.aspx.cs" Inherits="Almacenes.Contrato" %>

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
        <asp:ListView ID="ContratoListView"
            runat="server"
            DataSourceID="ContratoDS"
            DataKeyNames="IdContrato"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Proveedor</th>
                            <th>Inicio</th>
                            <th>Fin</th>
                            <th>Nro. de Contrato</th>
                            <th>Licitación</th>
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
                        <asp:Label ID="lblIdContrato" runat="server" Text='<%# Eval("IdContrato") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdProveedor" runat="server" Text='<%# Eval("IdProveedor") %>' Visible="false" />
                        <asp:Label ID="lblProveedor" runat="server" Text='<%# Eval("Proveedor") %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaInicioContrato" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval( "FechaInicioContrato") ) %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaFinContrato" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval( "FechaFinContrato") ) %>' /></td>
                    <td>
                        <asp:Label ID="lblNroContrato" runat="server" Text='<%# Eval("NroContrato") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdLicitacion" runat="server" Text='<%# Eval("IdLicitacion") %>' Visible="false" />
                        <asp:Label ID="lblLicitacion" runat="server" Text='<%# Eval("Licitacion") %>' />
                    </td>


                    <td>
                        <asp:LinkButton CssClass="btn btn-info" runat="server" ID="EditContratoBtn" CommandName="Editar" CommandArgument='<%# Eval("IdContrato")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>
                    <td>
                        <asp:LinkButton CssClass="btn btn-danger" runat="server" ID="DeleteContratoBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdContrato")%>' ToolTip="Eliminar">
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
                                <b id="addModalLabel">Agregar nuevo Contrato.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="ContratoDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdContrato" ForeColor="#333333"
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
                                                    <asp:TextBox ID="txtIdContrato" runat="server" Text="" CssClass="form-control mitad" Enabled="false" />
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
                                                <div class="col-3"><b>Inicio</b></div>
                                                <div class="col-9">
                                                    <asp:Calendar ID="txtFechaInicioContrato" runat="server" SelectedDate='<%# Bind("FechaInicioContrato") %>' />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Fin</b></div>
                                                <div class="col-9">
                                                    <asp:Calendar ID="txtFechaFinContrato" runat="server" SelectedDate='<%# Bind("FechaFinContrato") %>' />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Nro. de Contrato</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtNroContrato" runat="server" Text='<%# Bind("NroContrato") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Licitación</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdLicitacionDDL"
                                                        runat="server"
                                                        DataSourceID="LicitacionDS"
                                                        DataTextField="Licitacion"
                                                        DataValueField="IdLicitacion"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdLicitacion") %>'>
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
                                <b id="editModalLabel">Modificar Contrato.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdContrato" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3"><b>ID</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdContrato" runat="server" Text='<%# Bind("IdContrato") %>' CssClass="form-control mitad" Enabled="false" />
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
                                                <div class="col-3"><b>Inicio</b></div>

                                                <div class="col-9">
                                                    <div class="input-group date" data-provide="datepicker" data-date-format="dd/mm/yyyy">
                                                        <input type="text" class="form-control" value='<%#  String.Format("{0:dd/MM/yyyy}",Eval( "FechaInicioContrato") ) %>' runat="server" id="calendarFechaInicioContrato">
                                                        <div class="input-group-addon">
                                                            <span class="glyphicon glyphicon-th"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Fin</b></div>
                                                
                                                 <div class="col-9">
                                                    <div class="input-group date" data-provide="datepicker" data-date-format="dd/mm/yyyy">
                                                        <input type="text" class="form-control" value='<%#  String.Format("{0:dd/MM/yyyy}",Eval( "FechaFinContrato") ) %>' runat="server" id="calendarFechaFinContrato">
                                                        <div class="input-group-addon">
                                                            <span class="glyphicon glyphicon-th"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Nro. de Contrato</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtNroContrato" runat="server" Text='<%# Bind("NroContrato") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Licitación</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdLicitacionDDL"
                                                        runat="server"
                                                        DataSourceID="LicitacionDS"
                                                        DataTextField="Licitacion"
                                                        DataValueField="IdLicitacion"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdLicitacion") %>'>
                                                    </asp:DropDownList>
                                                </div>
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
        <asp:SqlDataSource ID="ContratoDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            InsertCommand="management.sp_Contrato_insert" InsertCommandType="StoredProcedure"
            SelectCommand="management.sp_Contrato_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>

                <asp:Parameter Name="IdProveedor" Type="Int32" />
                <asp:Parameter Name="FechaInicioContrato" Type="DateTime" />
                <asp:Parameter Name="FechaFinContrato" Type="DateTime" />
                <asp:Parameter Name="NroContrato" Type="String" />
                <asp:Parameter Name="IdLicitacion" Type="Int32" />

            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="ProveedorDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdProveedor, RazonSocial from management.Proveedor  order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="LicitacionDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select l.IdLicitacion,  cast(l.NroLicitacion as varchar(20)) + ' ('+ tl.TipoLicitacion + ')' as Licitacion
                            from management.licitacion l
                            left outer join management.TipoLicitacion tl on l.IdTipoLicitacion = tl.IdTipoLicitacion"
            SelectCommandType="Text"></asp:SqlDataSource>

        <!-- #endregion -->




    </div>
</asp:Content>
