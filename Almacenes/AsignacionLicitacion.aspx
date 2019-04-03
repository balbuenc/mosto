<%@ Page Title="Asignacion Licitacion" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="AsignacionLicitacion.aspx.cs" Inherits="Almacenes.AsignacionLicitacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
        <asp:ListView ID="AsignacionLicitacionListView"
            runat="server"
            DataSourceID="AsignacionLicitacionDS"
            DataKeyNames="IdAsignacionLicitacion"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Proveedor</th>
                            <th>Licitacion</th>
                            <th>Fecha</th>
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
                        <asp:Label ID="lblIdAsignacionLicitacion" runat="server" Text='<%# Eval("IdAsignacionLicitacion") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdProveedor" runat="server" Text='<%# Eval("IdProveedor") %>' Visible="false" />
                        <asp:Label ID="lblProveedor" runat="server" Text='<%# Eval("Proveedor") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdLicitacion" runat="server" Text='<%# Eval("IdLicitacion") %>' Visible="false" />
                        <asp:Label ID="lblLicitacion" runat="server" Text='<%# Eval("Licitacion") %>' />
                    </td>

                    <td>
                        <asp:Label ID="lblFechaAsignacion" runat="server" Text='<%# Eval("FechaAsignacion") %>' /></td>

                    <td>
                        <asp:LinkButton CssClass="btn btn-info" runat="server" ID="EditAsignacionLicitacionBtn" CommandName="Editar" CommandArgument='<%# Eval("IdAsignacionLicitacion")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton CssClass="btn btn-danger" runat="server" ID="DeleteAsignacionLicitacionBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdAsignacionLicitacion")%>' ToolTip="Eliminar">
                            <i class="fa  fa-eraser fa-sm"></i>
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
                                <b id="addModalLabel">Agregar nueva Asignacion Licitacion.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="AsignacionLicitacionDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdAsignacionLicitacion" ForeColor="#333333"
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
                                                    <asp:TextBox ID="txtIdAsignacionLicitacion" runat="server" Text="" CssClass="form-control" Enabled="false" />
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
                                                <div class="col-3"><b>Licitación</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdLicitacionDDL"
                                                        runat="server"
                                                        DataSourceID="LicitacionDS"
                                                        DataTextField="NroLicitacion"
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
                                <b id="editModalLabel">Modificar Asignacion Licitacion.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdAsignacionLicitacion" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">

                                            <div class="row">
                                                <div class="col-3"><b>ID</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdAsignacionLicitacion" runat="server" Text='<%# Bind("IdAsignacionLicitacion") %>' CssClass="form-control" Enabled="false" />
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
                                                <div class="col-3"><b>Licitación</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdLicitacionDDL"
                                                        runat="server"
                                                        DataSourceID="LicitacionDS"
                                                        DataTextField="NroLicitacion"
                                                        DataValueField="IdLicitacion"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdLicitacion") %>'>
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
        <asp:SqlDataSource ID="AsignacionLicitacionDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            InsertCommand="management.sp_AsignacionLicitacion_insert" InsertCommandType="StoredProcedure"
            SelectCommand="management.sp_AsignacionLicitacion_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>

                <asp:Parameter Name="IdProveedor" Type="Int32" />
                <asp:Parameter Name="IdLicitacion" Type="Int32" />

            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="ProveedorDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdProveedor, upper(RazonSocial) as RazonSocial from management.Proveedor  order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="LicitacionDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdLicitacion, cast(l.NroLicitacion as varchar(10))+' ('+tl.TipoLicitacion+')' as NroLicitacion 
            from management.Licitacion l 
            left outer join management.TipoLicitacion tl on l.IdTipoLicitacion= tl.IdTipoLicitacion
            order by 2"
            SelectCommandType="Text"></asp:SqlDataSource>

        <!-- #endregion -->




    </div>
</asp:Content>
