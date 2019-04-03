<%@ Page Title="Asignación Lote-Dependencia" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="AsignacionLoteDependencia.aspx.cs" Inherits="Almacenes.AsignacionLoteDependencia" %>
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
        <asp:ListView ID="AsignacionLoteDependenciaListView"
            runat="server"
            DataSourceID="AsignacionLoteDependenciaDS"
            DataKeyNames="IdAsignacionLoteDependencia"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Lote</th>
                            <th>Dependencia</th>
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
                        <asp:Label ID="lblIdAsignacionLoteDependencia" runat="server" Text='<%# Eval("IdAsignacionLoteDependencia") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdLote" runat="server" Text='<%# Eval("IdLote") %>' Visible="false" />
                        <asp:Label ID="lblLote" runat="server" Text='<%# Eval("Lote") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdDependencia" runat="server" Text='<%# Eval("IdDependencia") %>' Visible="false" />
                        <asp:Label ID="lblDependencia" runat="server" Text='<%# Eval("Dependencia") %>' />
                    </td>

                    <td>
                        <asp:Label ID="lblFechaAsignacion" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval("FechaAsignacion")) %>' /></td>

                    <td>
                        <asp:LinkButton CssClass="btn btn-info" runat="server" ID="EditAsignacionLoteDependenciaBtn" CommandName="Editar" CommandArgument='<%# Eval("IdAsignacionLoteDependencia")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton CssClass="btn btn-danger" runat="server" ID="DeleteAsignacionLoteDependenciaBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdAsignacionLoteDependencia")%>' ToolTip="Eliminar">
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
                                <b id="addModalLabel">Nuevo Lote-Dependencia.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="AsignacionLoteDependenciaDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdAsignacionLoteDependencia" ForeColor="#333333"
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
                                                    <asp:TextBox ID="txtIdAsignacionLoteDependencia" runat="server" Text="" CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Lote</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdLoteDDL"
                                                        runat="server"
                                                        DataSourceID="LoteDS"
                                                        DataTextField="Lote"
                                                        DataValueField="IdLote"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdLote") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Dependencia</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdDependenciaDDL"
                                                        runat="server"
                                                        DataSourceID="DependenciaDS"
                                                        DataTextField="Dependencia"
                                                        DataValueField="IdDependencia"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdDependencia") %>'>
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
                                <b id="editModalLabel">Modificar Lote-Dependencia</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdAsignacionLoteDependencia" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">

                                            <div class="row">
                                                <div class="col-3"><b>ID</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdAsignacionLoteDependencia" runat="server" Text='<%# Bind("IdAsignacionLoteDependencia") %>' CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Lote</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdLoteDDL"
                                                        runat="server"
                                                        DataSourceID="LoteDS"
                                                        DataTextField="Lote"
                                                        DataValueField="IdLote"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdLote") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Dependencia</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdDependenciaDDL"
                                                        runat="server"
                                                        DataSourceID="DependenciaDS"
                                                        DataTextField="Dependencia"
                                                        DataValueField="IdDependencia"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdDependencia") %>'>
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
        <asp:SqlDataSource ID="AsignacionLoteDependenciaDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            InsertCommand="warehouse.sp_AsignacionLoteDependencia_insert" InsertCommandType="StoredProcedure"
            SelectCommand="warehouse.sp_AsignacionLoteDependencia_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>

                <asp:Parameter Name="IdLote" Type="Int32" />
                <asp:Parameter Name="IdDependencia" Type="Int32" />

            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="LoteDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdLote,'#'+cast(NroLote as varchar(10))+' ('+a.Descripcion+')' as Lote  from warehouse.Lote l 
            left outer join warehouse.Articulo a on l.IdArticulo = a.IdArticulo
            order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="DependenciaDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdDependencia,Dependencia from warehouse.Dependencia d 
order by 2"
            SelectCommandType="Text"></asp:SqlDataSource>

        <!-- #endregion -->




    </div>
</asp:Content>
