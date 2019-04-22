<%@ Page Title="Lotes" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Lote.aspx.cs" Inherits="Almacenes.Lote" %>

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
        <asp:ListView ID="LoteListView"
            runat="server"
            DataSourceID="LoteDS"
            DataKeyNames="IdLote"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Artículo</th>
                            <th>Nro. Lote</th>
                            <th>Fecha</th>
                            <th>Cantidad</th>
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
                        <asp:Label ID="lblIdLote" runat="server" Text='<%# Eval("IdLote") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdArticulo" runat="server" Text='<%# Eval("IdArticulo") %>' Visible="false" />
                        <asp:Label ID="lblArticulo" runat="server" Text='<%# Eval("Articulo") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblNroLote" runat="server" Text='<%# Eval("NroLote") %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaLote" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval("FechaLote") )%>' /></td>
                    <td>
                        <asp:Label ID="lblCantidad" runat="server" Text='<%# Eval("Cantidad") %>' /></td>

                    <td>
                        <asp:LinkButton  runat="server" ID="EditLoteBtn" CommandName="Editar" CommandArgument='<%# Eval("IdLote")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton  runat="server" ID="DeleteLoteBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdLote")%>' ToolTip="Eliminar">
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
                                <b id="addModalLabel">Agregar nuevo Lote.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="LoteDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdLote" ForeColor="#333333"
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
                                                    <asp:TextBox ID="txtIdLote" runat="server" Text="" CssClass="form-control mitad" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Artículo</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdArticuloDDL"
                                                        runat="server"
                                                        DataSourceID="ArticuloDS"
                                                        DataTextField="Descripcion"
                                                        DataValueField="IdArticulo"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdArticulo") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Nro. Lote</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtNroLote" runat="server" Text='<%# Bind("NroLote") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Entrega</b></div>
                                                <div class="col-9">
                                                    <asp:Calendar ID="txtFechaLote" runat="server" SelectedDate='<%# Bind("FechaLote") %>' />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Cantidad</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCantidad" runat="server" Text='<%# Bind("Cantidad") %>' CssClass="form-control" />
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
                                <b id="editModalLabel">Modificar Lote.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdLote" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3"><b>ID</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdLote" runat="server" Text='<%# Bind("IdLote") %>' CssClass="form-control mitad" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Artículo</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdArticuloDDL"
                                                        runat="server"
                                                        DataSourceID="ArticuloDS"
                                                        DataTextField="Descripcion"
                                                        DataValueField="IdArticulo"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdArticulo") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Nro. Lote</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtNroLote" runat="server" Text='<%# Bind("NroLote") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Entrega</b></div>

                                                <div class="col-9">
                                                    <div class="input-group date" data-provide="datepicker" data-date-format="dd/mm/yyyy">
                                                        <input type="text" class="form-control" value='<%#  String.Format("{0:dd/MM/yyyy}",Eval( "FechaLote") ) %>' runat="server" id="calendarFechaLote">
                                                        <div class="input-group-addon">
                                                            <span class="glyphicon glyphicon-th"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Cantidad</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCantidad" runat="server" Text='<%# Bind("Cantidad") %>' CssClass="form-control" />
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
        <asp:SqlDataSource ID="LoteDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            InsertCommand="warehouse.sp_Lote_insert" InsertCommandType="StoredProcedure"
            SelectCommand="warehouse.sp_Lote_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="IdLote" Type="Int32" />
                <asp:Parameter Name="IdArticulo" Type="Int32" />
                <asp:Parameter Name="NroLote" Type="Int32" />
                <asp:Parameter Name="FechaLote" Type="DateTime" />
                <asp:Parameter Name="Cantidad" Type="Decimal" />

            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="ArticuloDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdArticulo, Descripcion from warehouse.Articulo  order by 2" SelectCommandType="Text"></asp:SqlDataSource>

           <!-- #endregion -->


    </div>
</asp:Content>
