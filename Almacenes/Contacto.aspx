<%@ Page Title="Contacto" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Contacto.aspx.cs" Inherits="Almacenes.Contacto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="alert alert-primary" role="alert">
            <div class="row">
                <div class="col-10">
                    <b><%: Page.Title %> </b>

                </div>
                <div class="col-2">
                    <button class="btn btn-primary" type="button" runat="server" id="AddLicitacionBtn" data-toggle="modal" data-target="#addModal">
                        <i class="fas fa-plus"></i>
                    </button>
                </div>
            </div>
            <div class="row alert-info">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <asp:ListView ID="ContactoListView"
            runat="server"
            DataSourceID="ContactoDS"
            DataKeyNames="IdContacto"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped" style="font-size: x-small; font-family: 'Segoe UI'">
                        <thead>
                            <th>IdProveedor</th>
                            <th>IdTipoContacto</th>
                            <th>Descripcion</th>
                            <th>DatoContacto</th>
                            <th>Activo</th>
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
                        <asp:Label ID="lblIdTipoContacto" runat="server" Text='<%# Eval("IdTipoContacto") %>' /></td>
                    <td>
                        <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("Descripcion") %>' /></td>
                    <td>
                        <asp:Label ID="lblDatoContacto" runat="server" Text='<%# Eval("DatoContacto") %>' /></td>
                    <td>
                        <asp:Label ID="lblActivo" runat="server" Text='<%# Eval("Activo") %>' /></td>

                    <th>
                        <asp:LinkButton CssClass="btn btn-info" runat="server" ID="EditContactoBtn" CommandName="Editar" CommandArgument='<%# Eval("IdContacto")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </th>

                    <th>

                        <asp:LinkButton CssClass="btn btn-danger" runat="server" ID="DeleteContactoBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdContacto")%>' ToolTip="Eliminar">
                            <i class="fa  fa-eraser fa-sm"></i>
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
                                <b id="addModalLabel">Agregar nuevo Contacto.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="ContactoDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdContacto" ForeColor="#333333"
                                    DefaultMode="Insert"
                                    OnItemInserted="FormView1_ItemInserted">
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <InsertItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">IdProveedor</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdProveedor" runat="server" Text="" CssClass="form-control" Font-Size="X-Small" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">IdTipoContacto</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdTipoContacto" runat="server" Text='<%# Bind("IdTipoContacto") %>' CssClass="form-control" Font-Size="X-Small" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Descripcion</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Bind("Descripcion") %>' CssClass="form-control" Font-Size="X-Small" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">DatoContacto</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDatoContacto" runat="server" Text='<%# Bind("DatoContacto") %>' CssClass="form-control" Font-Size="X-Small" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Activo</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtActivo" runat="server" Text='<%# Bind("Activo") %>' CssClass="form-control" Font-Size="X-Small" />
                                                </div>
                                            </div>

                                        </div>


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
                                <b id="editModalLabel">Modificar Contacto.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdContacto" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">IdProveedor</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdProveedor" runat="server" Text='<%# Bind("IdProveedor") %>' CssClass="form-control" Font-Size="X-Small" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">IdTipoContacto</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdTipoContacto" runat="server" Text='<%# Bind("IdTipoContacto") %>' CssClass="form-control" Font-Size="X-Small" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Descripcion</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Bind("Descripcion") %>' CssClass="form-control" Font-Size="X-Small" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">DatoContacto</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDatoContacto" runat="server" Text='<%# Bind("DatoContacto") %>' CssClass="form-control" Font-Size="X-Small" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Activo</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtActivo" runat="server" Text='<%# Bind("Activo") %>' CssClass="form-control" Font-Size="X-Small" />
                                                </div>
                                            </div>


                                        </div>



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
        <asp:SqlDataSource ID="ContactoDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            InsertCommand="management.sp_Contacto_insert" InsertCommandType="StoredProcedure"
            SelectCommand="management.sp_Contacto_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>

             
                <asp:Parameter Name="IdTipoContacto" Type="Int32" />
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter Name="DatoContacto" Type="String" />
                <asp:Parameter Name="Activo" Type="String" />
            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>


        <!-- #endregion -->




    </div>
</asp:Content>
