<%@ Page Title="Seguridad" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Seguridad.aspx.cs" Inherits="Almacenes.Seguridad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="fondo">
        <div class="page-header encabezado">
            <div class="container-fluid">
                <asp:Panel runat="server" DefaultButton="AddPrivilegeBtn">
                    <div class="row">
                        <div class="col-3"><b>Rol</b></div>
                        <div class="col-9">
                            <asp:DropDownList ID="IdRoleDDL"
                                runat="server"
                                DataSourceID="RolesDS_DDL"
                                DataTextField="Role"
                                DataValueField="IdRole"
                                CssClass="form-control spacing"
                                AutoPostBack="true">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-3"><b>Modulo</b></div>
                        <div class="col-9">
                            <asp:DropDownList ID="IdModuleDDL"
                                runat="server"
                                DataSourceID="ModulesDS_DDL"
                                DataTextField="Module"
                                DataValueField="IdMOdule"
                                CssClass="form-control spacing"
                                AutoPostBack="true">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-3"><b>Permiso</b></div>
                        <div class="col-9">
                            <asp:DropDownList ID="IdPrivilegeDDL"
                                runat="server"
                                DataSourceID="PrivilegesDS_DDL"
                                DataTextField="Privilege"
                                DataValueField="IdPrivilege"
                                CssClass="form-control spacing"
                                AutoPostBack="false">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-10"></div>
                        <div class="col-2" style="text-align:right">
                            <div class="btn-group btn-shadow">
                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="AddPrivilegeBtn" ToolTip="Agregar permiso" OnClick="AddPrivilegeBtn_Click">
                                <div class="form-row">
                                <asp:Label Text="Agregar" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label>
                                <i class="fas fa-plus" style="padding:5px"></i>
                              </div>
                                </asp:LinkButton>

                            </div>
                        </div>

                    </div>
                </asp:Panel>
            </div>
            <div class="row">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
            </div>
        </div>

        <div class="container-fluid">
            <div class="row pie" style="padding-left: 15px">
                <asp:DataPager ID="AsignacionesListViewDataPager" runat="server" PagedControlID="AsignacionesListView" PageSize="10">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                        <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm font-weight-bold  border" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary  btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                    </Fields>
                </asp:DataPager>
            </div>
            <asp:ListView ID="AsignacionesListView"
                runat="server"
                DataSourceID="AsignacionesDS"
                DataKeyNames="IdSecurable"
                 OnItemDeleted="AsignacionesListView_ItemDeleted">
                <LayoutTemplate>
                    <div class="table table-responsive">
                        <table class="table table-striped table-condensed">
                            <thead>
                                <th>ID</th>
                                <th>Permiso</th>
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
                            <asp:Label ID="lblIdSecurable" runat="server" Text='<%# Eval("IdSecurable") %>' /></td>
                        <td>
                            <asp:Label ID="lblPermiso" runat="server" Text='<%# Eval("Privilege") %>' /></td>



                        <td>

                            <asp:LinkButton runat="server" ID="DeleteArticuloCuentaBtn" CommandName="Delete" CommandArgument='<%# Eval("IdSecurable")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');">
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






            <!-- #region DataSources -->
            <asp:SqlDataSource ID="AsignacionesDS"
                runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="secure.sp_Get_Role_Securables" SelectCommandType="StoredProcedure"
                DeleteCommand="delete  from secure.Securable where IdSecurable = @IdSecurable" DeleteCommandType="Text">
                <DeleteParameters>
                    <asp:Parameter Name="IdSecurable" DbType="Int32" />
                </DeleteParameters>

                <InsertParameters>
                </InsertParameters>
                <UpdateParameters>
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="IdModuleDDL" Name="IdModule" PropertyName="" DbType="Int16" />
                    <asp:ControlParameter ControlID="IdRoleDDL" Name="IdRole" PropertyName="" DbType="Int16" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="ModulesDS_DDL" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="[secure].[sp_Module_get_all]" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

            <asp:SqlDataSource ID="RolesDS_DDL" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="select IdRole, Role from secure.Role order by Role" SelectCommandType="Text"></asp:SqlDataSource>

            <asp:SqlDataSource ID="PrivilegesDS_DDL" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="select p.IdPrivilege, p.Privilege
                                from secure.Privilege p
                                where p.IdPrivilege not in 
                                (   select s.IdPrivilege from secure.Securable s 
                                    where s.IdRole = @IdRole 
                                    and s.IdModule = @IdModule
                                )"
                SelectCommandType="Text">

                <SelectParameters>
                    <asp:ControlParameter ControlID="IdModuleDDL" Name="IdModule" PropertyName="" DbType="Int16" />
                    <asp:ControlParameter ControlID="IdRoleDDL" Name="IdRole" PropertyName="" DbType="Int16" />
                </SelectParameters>
            </asp:SqlDataSource>


            <!-- #endregion -->




        </div>
    </div>
</asp:Content>
