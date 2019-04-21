<%@ Page Title="Usuarios" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="Almacenes.User" %>

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
                            <th>Password</th>
                            <th>FirstName</th>
                            <th>LastName</th>
                            <th>Email</th>
                            <th>Phone</th>
                           
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
                        <asp:Label ID="lblPasswordHash" runat="server" Text="*****"  /></td>
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
                        <asp:LinkButton CssClass="btn btn-info" runat="server" ID="EditUserBtn" CommandName="Editar" CommandArgument='<%# Eval("IdUser")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton CssClass="btn btn-danger" runat="server" ID="DeleteUserBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdUser")%>' ToolTip="Eliminar">
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
                                                    <asp:TextBox ID="txtIdUser" runat="server" Text="" CssClass="form-control mitad"  Enabled="false"/></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">UserName</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtUserName" runat="server" Text='<%# Bind("UserName") %>' CssClass="form-control" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Password</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtPasswordHash" runat="server" Text='<%# Bind("PasswordHash") %>' CssClass="form-control" TextMode="Password" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Nombres</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Bind("FirstName") %>' CssClass="form-control" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Apellidos</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtLastName" runat="server" Text='<%# Bind("LastName") %>' CssClass="form-control" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Correo</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' CssClass="form-control" TextMode="Email" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Teléfono</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtPhone" runat="server" Text='<%# Bind("Phone") %>' CssClass="form-control" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Descripción</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDiscriminator" runat="server" Text='<%# Bind("Discriminator") %>' CssClass="form-control" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Nro. Documento</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDocumentNumber" runat="server" Text='<%# Bind("DocumentNumber") %>' CssClass="form-control" /></div>
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
                                                    <asp:TextBox ID="txtIdUser" runat="server" Text='<%# Bind("IdUser") %>' CssClass="form-control mitad" Enabled="false" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">UserName</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtUserName" runat="server" Text='<%# Bind("UserName") %>' CssClass="form-control" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Password</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtPasswordHash" runat="server" Text='<%# Bind("PasswordHash") %>' CssClass="form-control" TextMode="Password" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Nombres</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtFirstName" runat="server" Text='<%# Bind("FirstName") %>' CssClass="form-control" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Apellidos</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtLastName" runat="server" Text='<%# Bind("LastName") %>' CssClass="form-control" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Email</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' CssClass="form-control" TextMode="Email" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Teléfono</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtPhone" runat="server" Text='<%# Bind("Phone") %>' CssClass="form-control" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Descripción</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDiscriminator" runat="server" Text='<%# Bind("Discriminator") %>' CssClass="form-control" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Nro. Documento</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDocumentNumber" runat="server" Text='<%# Bind("DocumentNumber") %>' CssClass="form-control" /></div>
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
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="Phone" Type="String" />
                <asp:Parameter Name="Discriminator" Type="String" />
                <asp:Parameter Name="DocumentNumber" Type="String" />

            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>


      

        <!-- #endregion -->


    </div>
</asp:Content>
