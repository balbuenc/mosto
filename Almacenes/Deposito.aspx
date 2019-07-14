<%@ Page Title="Depositos" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Deposito.aspx.cs" Inherits="Almacenes.Deposito" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="fondo">
        <div class="page-header">
            <div class="container-fluid" >
                <div class="row">
                    <div class="col-2">
                        <div class="col-form-label-lg azul"><%: Page.Title %> </div>

                    </div>
                    <div class="col-4">
                        <asp:TextBox ID="txtSearchKey" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-2">
                        <asp:DropDownList ID="searchParameterDDL" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Deposito" Value="DEPOSITO"></asp:ListItem>
                            <asp:ListItem Text="Descripción" Value="DESCRIPCION"></asp:ListItem>
                            <asp:ListItem Text="Contenido" Value="CONTENIDO"></asp:ListItem>
                            <asp:ListItem Text="Ubicación" Value="UBICACION"></asp:ListItem>

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

        <div class="container-fluid" >
            <asp:DataPager ID="DepositoDataPager" runat="server" PagedControlID="DepositoListView" PageSize="10">
                <Fields>
                    <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                    <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                    <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                </Fields>
            </asp:DataPager>
            <asp:ListView ID="DepositoListView"
                runat="server"
                DataSourceID="DepositoDS"
                DataKeyNames="IdDeposito"
                OnItemCommand="ListView_ItemCommand">
                <LayoutTemplate>
                    <div class="table table-responsive">
                        <table class="table table-striped table-condensed">
                            <thead>
                                <th>ID</th>
                                <th>Depósito</th>
                                <th>Descripción</th>
                                <th>Ubicación</th>
                                <th>Contenido</th>
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
                            <asp:Label ID="lblIdDeposito" runat="server" Text='<%# Eval("IdDeposito") %>' /></td>
                        <td>
                            <asp:Label ID="lblDeposito" runat="server" Text='<%# Eval("Deposito") %>' /></td>
                        <td>
                            <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("Descripcion") %>' /></td>
                        <td>
                            <asp:Label ID="lblUbicacion" runat="server" Text='<%# Eval("Ubicacion") %>' /></td>
                        <td>
                            <asp:Label ID="lblContenido" runat="server" Text='<%# Eval("Contenido") %>' /></td>
                        <td>
                            <asp:Label ID="lblActivo" runat="server" Text='<%# Eval("Activo") %>' /></td>

                        <td>
                            <asp:LinkButton runat="server" ID="EditDepositoBtn" CommandName="Editar" CommandArgument='<%# Eval("IdDeposito")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                            </asp:LinkButton>
                        </td>

                        <td>

                            <asp:LinkButton runat="server" ID="DeleteDepositoBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdDeposito")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');">
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
                                    <b id="addModalLabel">Agregar nuevo Depósito.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                    <asp:FormView ID="InsertFormView" runat="server" DataSourceID="DepositoDS" Width="100%"
                                        CellPadding="4" DataKeyNames="IdDeposito" ForeColor="#333333"
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
                                                        <asp:TextBox ID="txtIdDeposito" runat="server" Text="" CssClass="form-control mitad" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Depósito</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtDeposito" runat="server" Text='<%# Bind("Deposito") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Descripción</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Bind("Descripcion") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Ubicación</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtUbicacion" runat="server" Text='<%# Bind("Ubicacion") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Contenido</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtContenido" runat="server" Text='<%# Bind("Contenido") %>' CssClass="form-control" />
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
                                    <b id="editModalLabel">Modificar Depósito.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                    <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                        CellPadding="4" DataKeyNames="IdDeposito" ForeColor="#333333"
                                        DefaultMode="Edit"
                                        OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                        <EditItemTemplate>
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-3"><b>ID</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtIdDeposito" runat="server" Text='<%# Bind("IdDeposito") %>' CssClass="form-control mitad" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Depósito</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtDeposito" runat="server" Text='<%# Bind("Deposito") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Descripción</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Bind("Descripcion") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Ubicación</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtUbicacion" runat="server" Text='<%# Bind("Ubicacion") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Contenido</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtContenido" runat="server" Text='<%# Bind("Contenido") %>' CssClass="form-control" />
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
            <asp:SqlDataSource ID="DepositoDS"
                runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                InsertCommand="warehouse.sp_Deposito_insert" InsertCommandType="StoredProcedure"
                SelectCommand="warehouse.sp_Deposito_get_all" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Deposito" Type="String" />
                    <asp:Parameter Name="Descripcion" Type="String" />
                    <asp:Parameter Name="Ubicacion" Type="String" />
                    <asp:Parameter Name="Contenido" Type="String" />
                    <asp:Parameter Name="Activo" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSearchKey" PropertyName="Text" Name="key" DefaultValue="*" />
                    <asp:ControlParameter ControlID="searchParameterDDL" PropertyName="SelectedValue" Name="parameter" />
                </SelectParameters>
            </asp:SqlDataSource>


            <!-- #endregion -->




        </div>
    </div>
</asp:Content>
