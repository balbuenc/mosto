<%@ Page Title="Tipo de Licitaciones" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="TipoLicitaciones.aspx.cs" Inherits="Almacenes.TipoLicitaciones" %>

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
        <asp:ListView ID="TipoLicitacionListView"
            runat="server"
            DataSourceID="TipoLicitacionDS"
            DataKeyNames="IdTipoLicitacion"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed" >
                        <thead>
                            <th>ID</th>
                            <th>Tipo Licitación</th>
                            <th>Descripcion</th>
                            <th>Activo</th>
                            <th>Código</th>
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
                        <asp:Label ID="lblIdTipoLicitacion" runat="server" Text='<%# Eval("IdTipoLicitacion") %>' /></td>
                    <td>
                        <asp:Label ID="lblTipoLicitacion" runat="server" Text='<%# Eval("TipoLicitacion") %>' /></td>
                    <td>
                        <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("Descripcion") %>' /></td>
                    <td>
                        <asp:Label ID="lblActivo" runat="server" Text='<%# Eval("Activo") %>' /></td>
                    <td>
                        <asp:Label ID="lblCodigo" runat="server" Text='<%# Eval("Codigo") %>' /></td>


                    <th>
                        <asp:LinkButton  runat="server" ID="EditTipoLicitacionBtn" CommandName="Editar" CommandArgument='<%# Eval("IdTipoLicitacion")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </th>

                    <th>

                        <asp:LinkButton  runat="server" ID="DeleteTipoLicitacionBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdTipoLicitacion")%>' ToolTip="Eliminar">
                            <i class="fas fa-trash-alt"></i>
                        </asp:LinkButton>

                    </th>

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
                                <b id="addModalLabel">Agregar Tipo de Licitación.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="TipoLicitacionDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdTipoLicitacion" ForeColor="#333333"
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
                                                    <asp:TextBox ID="txtIdTipoLicitacion" runat="server" Text="" CssClass="form-control mitad" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Tipo Licitación</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtTipoLicitacion" runat="server" Text='<%# Bind("TipoLicitacion") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Descripción</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Bind("Descripcion") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Activo</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="ActivoDDL"
                                                        runat="server"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("Activo") %>'>
                                                        <asp:ListItem>S</asp:ListItem>
                                                        <asp:ListItem>N</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Código</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCodigo" runat="server" Text='<%# Bind("Codigo") %>' CssClass="form-control" />
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
                                <b id="editModalLabel">Modificar Tipo de Licitación.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdTipoLicitacion" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3"><b>ID</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdTipoLicitacion" runat="server" Text='<%# Bind("IdTipoLicitacion") %>' CssClass="form-control mitad" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Tipo Licitación</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtTipoLicitacion" runat="server" Text='<%# Bind("TipoLicitacion") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Descripción</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Bind("Descripcion") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Activo</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="ActivoDDL"
                                                        runat="server"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("Activo") %>'>
                                                        <asp:ListItem>S</asp:ListItem>
                                                        <asp:ListItem>N</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Código</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCodigo" runat="server" Text='<%# Bind("Codigo") %>' CssClass="form-control" />
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
        <asp:SqlDataSource ID="TipoLicitacionDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            InsertCommand="management.sp_TipoLicitacion_insert" InsertCommandType="StoredProcedure"
            SelectCommand="management.sp_TipoLicitacion_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>

                <asp:Parameter Name="TipoLicitacion" Type="String" />
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter Name="Activo" Type="String" />
                <asp:Parameter Name="Codigo" Type="String" />
            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>


        <!-- #endregion -->




    </div>
</asp:Content>
