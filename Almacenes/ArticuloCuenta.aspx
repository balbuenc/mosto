<%@ Page Title="Asignación de cuentas" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="ArticuloCuenta.aspx.cs" Inherits="Almacenes.ArticuloCuenta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="fondo">
        <div class="page-header encabezado">
            <div class="container-fluid">
                <asp:Panel runat="server" DefaultButton="SearchBtn">
                    <div class="row">
                        <div class="col-4 font-weight-bold">
                            Palabra clave
                        </div>
                        <div class="col-2 font-weight-bold">
                            Criterio
                        </div>
                        <div class="col-6">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-4">
                            <asp:TextBox ID="txtSearchKey" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-2">
                            <asp:DropDownList ID="searchParameterDDL" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Artículo" Value="ARTICULO"></asp:ListItem>
                                <asp:ListItem Text="Cuenta" Value="CUENTA"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-6">
                            <div class="btn-group btn-shadow">
                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="SearchBtn" onserverclick="SearchBtn_ServerClick" ToolTip="Buscar">
                                <div class="form-row">
                                <asp:Label Text="Buscar" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label>
                                <i class="fas fa-search fa-sm" style="padding:5px"></i>
                              </div>
                                </asp:LinkButton>

                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="AddLicitacionBtn" data-toggle="modal" data-target="#addModal" ToolTip="Agregar asignación">
                                <div class="form-row">
                                <asp:Label  Text="Agregar asigación" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label> 
                                <i class="fas fa-plus fa-sm"  style="padding:5px"></i>
                                </div>
                                </asp:LinkButton>
                                <div class="btn-group" role="group">
                                    <button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle btn-border" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        #
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                        <a class="dropdown-item" href="/ArticuloCuenta.aspx?PageSize=10" runat="server">10</a>
                                        <a class="dropdown-item" href="/ArticuloCuenta.aspx?PageSize=20" runat="server">20</a>
                                        <a class="dropdown-item" href="/ArticuloCuenta.aspx?PageSize=30" runat="server">30</a>
                                        <a class="dropdown-item" href="/ArticuloCuenta.aspx?PageSize=50" runat="server">50</a>
                                    </div>
                                </div>
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
                <asp:DataPager ID="ArticuloCuentaListViewDataPager" runat="server" PagedControlID="ArticuloCuentaListView" PageSize="10">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                        <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm font-weight-bold  border" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary  btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                    </Fields>
                </asp:DataPager>
            </div>
            <asp:ListView ID="ArticuloCuentaListView"
                runat="server"
                DataSourceID="ArticuloCuentaDS"
                DataKeyNames="IdArticuloCuenta"
                OnItemCommand="ListView_ItemCommand">
                <LayoutTemplate>
                    <div class="table table-responsive">
                        <table class="table table-striped table-condensed">
                            <thead>
                                <th>ID</th>
                                <th>Artículo</th>
                                <th>Cuenta</th>
                                <th>Conc. contable</th>
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
                            <asp:Label ID="lblIdArticuloCuenta" runat="server" Text='<%# Eval("IdArticuloCuenta") %>' /></td>
                        <td>
                            <asp:Label ID="lblIdArticuloMaestro" runat="server" Text='<%# Eval("Articulo") %>' /></td>
                        <td>
                            <asp:Label ID="lblIdCuenta" runat="server" Text='<%# Eval("Cuenta") %>' /></td>
                          <td>
                            <asp:Label ID="lblConceptoContable" runat="server" Text='<%# Eval("Concepto") %>' /></td>

                        <td>
                            <asp:LinkButton runat="server" ID="EditArticuloCuentaBtn" CommandName="Editar" CommandArgument='<%# Eval("IdArticuloCuenta")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                            </asp:LinkButton>
                        </td>

                        <td>

                            <asp:LinkButton runat="server" ID="DeleteArticuloCuentaBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdArticuloCuenta")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');">
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
                                    <b id="addModalLabel">Agregar asignación.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                    <asp:FormView ID="InsertFormView" runat="server" DataSourceID="ArticuloCuentaDS" Width="100%"
                                        CellPadding="4" DataKeyNames="IdArticuloCuenta" ForeColor="#333333"
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
                                                        <asp:TextBox ID="txtIdArticuloCuenta" runat="server" Text="" CssClass="form-control mitad" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Artículo</b></div>
                                                    <div class="col-9">
                                                        <asp:DropDownList ID="IdArticuloMaestro"
                                                            runat="server"
                                                            DataSourceID="ArticuloInsertDS_DDL"
                                                            DataTextField="Articulo"
                                                            DataValueField="IdArticuloMaestro"
                                                            CssClass="form-control spacing"
                                                            SelectedValue='<%# Bind("IdArticuloMaestro") %>'>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-3"><b>Cuenta</b></div>
                                                    <div class="col-9">
                                                        <asp:DropDownList ID="IdCuenta"
                                                            runat="server"
                                                            DataSourceID="CuentaDS_DDL"
                                                            DataTextField="Cuenta"
                                                            DataValueField="IdCuenta"
                                                            CssClass="form-control spacing"
                                                            SelectedValue='<%# Bind("IdCuenta") %>'>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Conc. contable</b></div>
                                                    <div class="col-9">
                                                        <asp:DropDownList ID="ConceptoContableDDL"
                                                            runat="server"
                                                            DataSourceID="ConceptoContableDS_DDL"
                                                            DataTextField="Concepto"
                                                            DataValueField="IdConceptoContable"
                                                            CssClass="form-control spacing"
                                                            SelectedValue='<%# Bind("IdConceptoContable") %>'>
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
                                    <b id="editModalLabel">Modificar asignacón.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                    <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                        CellPadding="4" DataKeyNames="IdArticuloCuenta" ForeColor="#333333"
                                        DefaultMode="Edit"
                                        OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                        <EditItemTemplate>
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-3">ID</div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtIdArticuloCuenta" runat="server" Text='<%# Bind("IdArticuloCuenta") %>' CssClass="form-control mitad" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Artículo</b></div>
                                                    <div class="col-9">
                                                        <asp:DropDownList ID="IdArticuloMaestro"
                                                            runat="server"
                                                            DataSourceID="ArticuloDS_DDL"
                                                            DataTextField="Articulo"
                                                            DataValueField="IdArticuloMaestro"
                                                            CssClass="form-control spacing"
                                                            SelectedValue='<%# Bind("IdArticuloMaestro") %>'>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-3"><b>Cuenta</b></div>
                                                    <div class="col-9">
                                                        <asp:DropDownList ID="IdCuenta"
                                                            runat="server"
                                                            DataSourceID="CuentaDS_DDL"
                                                            DataTextField="Cuenta"
                                                            DataValueField="IdCuenta"
                                                            CssClass="form-control spacing"
                                                            SelectedValue='<%# Bind("IdCuenta") %>'>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                 <div class="row">
                                                    <div class="col-3"><b>Conc. contable</b></div>
                                                    <div class="col-9">
                                                        <asp:DropDownList ID="ConceptoContableDDL"
                                                            runat="server"
                                                            DataSourceID="ConceptoContableDS_DDL"
                                                            DataTextField="Concepto"
                                                            DataValueField="IdConceptoContable"
                                                            CssClass="form-control spacing"
                                                            SelectedValue='<%# Bind("IdConceptoContable") %>'>
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
            <asp:SqlDataSource ID="ArticuloCuentaDS"
                runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                InsertCommand="accounting.sp_ArticuloCuenta_insert" InsertCommandType="StoredProcedure"
                SelectCommand="accounting.sp_ArticuloCuenta_get_all" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                </DeleteParameters>
                <InsertParameters>
                    
                    <asp:Parameter Name="IdCuenta" Type="Int32" />
                    <asp:Parameter Name="IdArticuloMaestro" Type="Int32" />
                    <asp:Parameter Name="IdConceptoContable" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSearchKey" PropertyName="Text" Name="key" DefaultValue="*" />
                    <asp:ControlParameter ControlID="searchParameterDDL" PropertyName="SelectedValue" Name="parameter" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="ArticuloDS_DDL" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="select IdArticuloMaestro, Articulo from warehouse.ArticuloMaestro order by ltrim(rtrim(Articulo))" SelectCommandType="Text"></asp:SqlDataSource>

            <asp:SqlDataSource ID="CuentaDS_DDL" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="select pc.IdCuenta, pc.Cuenta + ' [' + pc.NroCuenta + ']' as Cuenta  from accounting.PlanCuenta pc  order by 2" SelectCommandType="Text"></asp:SqlDataSource>

            <asp:SqlDataSource ID="ArticuloInsertDS_DDL" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="select IdArticuloMaestro, Articulo from warehouse.ArticuloMaestro  order by ltrim(rtrim(Articulo)) " SelectCommandType="Text"></asp:SqlDataSource>
            
            <asp:SqlDataSource ID="ConceptoContableDS_DDL" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="select IdConceptoContable, Concepto from [accounting].[ConceptoContable] order by 2" SelectCommandType="Text"></asp:SqlDataSource>
            
            <!-- #endregion -->

            


        </div>
    </div>
</asp:Content>
