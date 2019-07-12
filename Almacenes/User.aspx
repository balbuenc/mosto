<%@ Page Title="Usuarios" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="Almacenes.User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="container-fluid" style="background-color:white">
            <div class="row">
                <div class="col-2">
                    <div class="col-form-label-lg azul"><%: Page.Title %> </div>
                </div>
                <div class="col-4">
                    <asp:TextBox ID="txtSearchKey" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-2">
                    <asp:DropDownList ID="searchParameterDDL" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Usuario" Value="USUARIO"></asp:ListItem>
                        <asp:ListItem Text="Nombres" Value="NOMBRE"></asp:ListItem>
                        <asp:ListItem Text="Apellidos" Value="APELLIDO"></asp:ListItem>
                        <asp:ListItem Text="Email" Value="CORREO"></asp:ListItem>
                        <asp:ListItem Text="Nro. Documento" Value="DOCUMENTO"></asp:ListItem>
                        <asp:ListItem Text="Rol" Value="ROL"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-1">
                    <button class="btn btn-primary" type="button" runat="server" id="SearchBtn" onserverclick="SearchBtn_ServerClick">
                        <i class="fas fa-search fa-sm"></i>
                    </button>
                </div>
                <div class="col-1">
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

    <div class="container-fluid" style="background-color:white"> 
        <asp:ListView ID="UserListView"
            runat="server"
            DataSourceID="UserDS"
            DataKeyNames="IdUser"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>UserName</th>

                            <th>Nombres</th>
                            <th>Apellidos</th>
                            <th>Email</th>
                            <th>Teléfono</th>
                            <th>Nro. Doc.</th>
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
                        <asp:Label ID="lblIdUser" runat="server" Text='<%# Eval("IdUser") %>' /></td>
                    <td>
                        <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>' /></td>

                    <td>
                        <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("FirstName") %>' /></td>
                    <td>
                        <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("LastName") %>' /></td>
                    <td>
                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' /></td>
                    <td>
                        <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("Phone") %>' /></td>

                    <td>
                        <asp:Label ID="lblDocumentNumber" runat="server" Text='<%# Eval("DocumentNumber") %>' /></td>

                    <td>
                        <asp:LinkButton runat="server" ID="EditUserBtn" CommandName="Editar" CommandArgument='<%# Eval("IdUser")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton runat="server" ID="DeleteUserBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdUser")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');">
                            <i class="fas fa-trash-alt"></i>
                        </asp:LinkButton>

                    </td>

                </tr>
                <tr>

                    <td>
                        <asp:LinkButton runat="server" ID="ResetUserPasswordBtn" CommandName="SetPassword" CommandArgument='<%# Eval("IdUser")%>' ToolTip="Resetear Contraseña">
                            <i class="fa fa-key fa-sm" aria-hidden="true"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton runat="server" ID="SetUserRolBtn" CommandName="SetRole" CommandArgument='<%# Eval("IdUser")%>' ToolTip="Asignar Rol">
                            <i class="fa fa-user-plus fa-sm" aria-hidden="true"></i>
                        </asp:LinkButton>


                    </td>
                    <td>
                        <asp:Label ID="lblUserRole" runat="server" Text='<%#Eval("UserRole") %>' ForeColor="#0066cc" Font-Italic="true" Font-Names="Verdana"></asp:Label>
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
                                <b id="addModalLabel">Agregar nuevo User.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="UserDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdUser" ForeColor="#333333"
                                    DefaultMode="Insert"
                                    OnItemInserted="FormView1_ItemInserted">
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <InsertItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">ID</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdUser" runat="server" Text="" CssClass="form-control mitad" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">UserName</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtUserName" runat="server" Text='<%# Bind("UserName") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Password</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtPasswordHash" runat="server" Text='<%# Bind("PasswordHash") %>' CssClass="form-control" TextMode="Password" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Nombres</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Bind("FirstName") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Apellidos</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtLastName" runat="server" Text='<%# Bind("LastName") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Correo</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' CssClass="form-control" TextMode="Email" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Teléfono</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtPhone" runat="server" Text='<%# Bind("Phone") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Descripción</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDiscriminator" runat="server" Text='<%# Bind("Discriminator") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Nro. Documento</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDocumentNumber" runat="server" Text='<%# Bind("DocumentNumber") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Rol</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="ddlIdUserRole"
                                                        runat="server"
                                                        DataSourceID="RoleDS"
                                                        DataTextField="Role"
                                                        DataValueField="IdRole"
                                                        CssClass="form-control spacing"
                                                        SelectedValue='<%# Bind("IdRole") %>'
                                                        >
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
                                <b id="editModalLabel">Modificar User.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdUser" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">ID</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdUser" runat="server" Text='<%# Bind("IdUser") %>' CssClass="form-control mitad" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">UserName</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtUserName" runat="server" Text='<%# Bind("UserName") %>' CssClass="form-control" />
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-3">Nombres</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Bind("FirstName") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Apellidos</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtLastName" runat="server" Text='<%# Bind("LastName") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Email</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' CssClass="form-control" TextMode="Email" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Teléfono</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtPhone" runat="server" Text='<%# Bind("Phone") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Descripción</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDiscriminator" runat="server" Text='<%# Bind("Discriminator") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Nro. Documento</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDocumentNumber" runat="server" Text='<%# Bind("DocumentNumber") %>' CssClass="form-control" />
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



        <div id="setUserPasswordModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="setUserPasswordModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div class="modal-content">
                            <div class="modal-header">
                                <b id="setUserPasswordModalLabel">Resetear contraseña de usuario.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="setPasswordFormView"
                                    runat="server"
                                    Width="100%"
                                    CellPadding="4"
                                    DataKeyNames="IdUser"
                                    ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnItemUpdating="setPasswordFormView_ItemUpdating">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">ID</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdUser" runat="server" Text='<%# Bind("IdUser") %>' CssClass="form-control mitad" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">UserName</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtuserName" runat="server" Text='<%# Bind("Username") %>' CssClass="form-control mitad" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Password</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtPasswordHash" runat="server" Text='<%# Bind("PasswordHash") %>' CssClass="form-control" TextMode="Password" />
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


        <div id="setUserRoleModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="setUserRolesModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <ContentTemplate>
                        <div class="modal-content">
                            <div class="modal-header">
                                <b id="setUserRoleModalLabel">Asignar Rol de usuario.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="setUserRoleFormView"
                                    runat="server"
                                    Width="100%"
                                    CellPadding="4"
                                    DataKeyNames="IdUser"
                                    ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnItemUpdating="setUserRoleFormView_ItemUpdating">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">ID</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdUser" runat="server" Text='<%# Bind("IdUser") %>' CssClass="form-control mitad" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">UserName</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtuserName" runat="server" Text='<%# Bind("Username") %>' CssClass="form-control mitad" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Rol actual</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtUserRole" runat="server" Text='<%# Bind("UserRole") %>' CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Nuevo Rol</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="ddlIdUserRole"
                                                        runat="server"
                                                        DataSourceID="RoleDS"
                                                        DataTextField="Role"
                                                        DataValueField="IdRole"
                                                        CssClass="form-control spacing">
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
        <asp:SqlDataSource ID="UserDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            InsertCommand="secure.sp_User_insert" InsertCommandType="StoredProcedure"
            SelectCommand="secure.sp_User_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>

                <asp:Parameter Name="UserName" Type="String" />
                <asp:Parameter Name="PasswordHash" Type="String" />
                <asp:Parameter Name="FirstName" Type="String" DefaultValue="ND" />
                <asp:Parameter Name="LastName" Type="String" DefaultValue="ND" />
                <asp:Parameter Name="Email" Type="String" DefaultValue="ND" />
                <asp:Parameter Name="Phone" Type="String" DefaultValue="ND" />
                <asp:Parameter Name="Discriminator" Type="String" DefaultValue="ND" />
                <asp:Parameter Name="DocumentNumber" Type="String" DefaultValue="ND" />
                <asp:Parameter Name="IdRole" Type="Int16"/>

            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtSearchKey" PropertyName="Text" Name="key" DefaultValue="*" />
                <asp:ControlParameter ControlID="searchParameterDDL" PropertyName="SelectedValue" Name="parameter" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="RoleDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdRole , Role from secure.Role order by Role" SelectCommandType="Text">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>



        <!-- #endregion -->


    </div>
</asp:Content>
