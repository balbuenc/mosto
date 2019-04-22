<%@ Page Title="Contacto" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Contacto.aspx.cs" Inherits="Almacenes.Contacto" %>

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
        <asp:ListView ID="ContactoListView"
            runat="server"
            DataSourceID="ContactoDS"
            DataKeyNames="IdContacto"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>Proveedor</th>
                            <th>Tipo</th>
                            <th>Descripción</th>
                            <th>Informacíon</th>
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
                        <asp:Label ID="lblIdContacto" runat="server" Text='<%# Eval("IdContacto") %>' Visible="false" />
                        <asp:Label ID="lblIdProveedor" runat="server" Text='<%# Eval("IdProveedor") %>' Visible="false" />
                        <asp:Label ID="lblProveedor" runat="server" Text='<%# Eval("Proveedor") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdTipoContacto" runat="server" Text='<%# Eval("IdTipoContacto") %>' Visible="false" />
                        <asp:Label ID="lblTipoContacto" runat="server" Text='<%# Eval("TipoContacto") %>' />

                    </td>
                    <td>
                        <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("Descripcion") %>' /></td>
                    <td>
                        <asp:Label ID="lblDatoContacto" runat="server" Text='<%# Eval("DatoContacto") %>' /></td>
                    <td>
                        <asp:Label ID="lblActivo" runat="server" Text='<%# Eval("Activo") %>' /></td>

                    <td>
                        <asp:LinkButton  runat="server" ID="EditContactoBtn" CommandName="Editar" CommandArgument='<%# Eval("IdContacto")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton  runat="server" ID="DeleteContactoBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdContacto")%>' ToolTip="Eliminar">
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
                                                <div class="col-3"><b>Tipo</b></div>
                                                <div class="col-9">

                                                    <asp:DropDownList ID="IdTipoContactoDDL"
                                                        runat="server"
                                                        DataSourceID="TipoContactoDS"
                                                        DataTextField="TipoContacto"
                                                        DataValueField="IdTipoContacto"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdTipoContacto") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Descripción</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Bind("Descripcion") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Información</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDatoContacto" runat="server" Text='<%# Bind("DatoContacto") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Activo</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="ActivoDDL"
                                                        runat="server"
                                                        CssClass="form-control mitad"
                                                        SelectedValue='<%# Bind("Activo") %>'>
                                                        <asp:ListItem>S</asp:ListItem>
                                                        <asp:ListItem>N</asp:ListItem>
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
                                                <div class="col-3"><b>ID</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdContacto" runat="server" Text='<%# Bind("IdContacto") %>' CssClass="form-control mitad" Enabled="false" />
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
                                                <div class="col-3"><b>Tipo</b></div>
                                                <div class="col-9">
                                                     <asp:DropDownList ID="IdTipoContactoDDL"
                                                        runat="server"
                                                        DataSourceID="TipoContactoDS"
                                                        DataTextField="TipoContacto"
                                                        DataValueField="IdTipoContacto"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdTipoContacto") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Descripción</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Bind("Descripcion") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Información</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDatoContacto" runat="server" Text='<%# Bind("DatoContacto") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Activo</b></div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="ActivoDDL"
                                                        runat="server"
                                                        CssClass="form-control mitad"
                                                        SelectedValue='<%# Bind("Activo") %>'>
                                                        <asp:ListItem>S</asp:ListItem>
                                                        <asp:ListItem>N</asp:ListItem>
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
        <asp:SqlDataSource ID="ContactoDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            InsertCommand="management.sp_Contacto_insert" InsertCommandType="StoredProcedure"
            SelectCommand="management.sp_Contacto_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="IdProveedor" Type="Int32" />
                <asp:Parameter Name="IdTipoContacto" Type="Int32" />
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter Name="DatoContacto" Type="String" />
                <asp:Parameter Name="Activo" Type="String" />

            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="ProveedorDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdProveedor, RazonSocial from management.Proveedor  order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="TipoContactoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdTipoContacto, TipoContacto from management.TipoContacto order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <!-- #endregion -->




    </div>
</asp:Content>
