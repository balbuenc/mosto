<%@ Page Title="Artículos" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="ArticuloMaestroMaestro.aspx.cs" Inherits="Almacenes.ArticuloMaestro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/Enigma.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-4">
                    <div class="col-form-label-lg azul"><%: Page.Title %> </div>
                </div>
                <div class="col-4">
                    <asp:TextBox ID="txtSearchKey" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-2">
                    <asp:DropDownList ID="searchParameterDDL" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Código" Value="CODIGO"></asp:ListItem>
                        <asp:ListItem Text="Artículo" Value="ARTICULO"></asp:ListItem>
                        <asp:ListItem Text="Descripción" Value="DESCRIPCION"></asp:ListItem>
                    </asp:DropDownList>

                </div>
                <div class="col-1">
                    <button class="btn btn-primary" type="button" runat="server" id="SearchBtn"   onserverclick="SearchBtn_ServerClick" >
                        <i class="fas fa-search fa-sm"></i>
                    </button>
                </div>
                <div class="col-1">
                    <button class="btn btn-primary" type="button" runat="server" id="AddLicitacionBtn" data-toggle="modal" data-target="#addModal">
                        <i class="fas fa-plus fa-sm"></i>
                    </button>
                </div>
            </div>
            <div class="row">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <asp:DataPager ID="ArticuloMaestroListViewDataPager" runat="server" PagedControlID="ArticuloMaestroListView" PageSize="15">
            <Fields>
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
            </Fields>
        </asp:DataPager>
        <asp:ListView ID="ArticuloMaestroListView"
            runat="server"
            DataSourceID="ArticuloMaestroDS"
            DataKeyNames="IdArticuloMaestro"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Código</th>
                            <th>Artículo</th>
                            <th>Descripción</th>
                            <th>UM</th>
                            <th>Cod. de barras</th>
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
                        <asp:Label ID="lblIdArticuloMaestro" runat="server" Text='<%# Eval("IdArticuloMaestro") %>' /></td>
                    <td>
                        <asp:Label ID="lblCodigo" runat="server" Text='<%# Eval("Codigo") %>' /></td>
                    <td>
                        <asp:Label ID="lblArticulo" runat="server" Text='<%# Eval("Articulo") %>' /></td>
                    <td>
                        <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("Descripcion") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdUnidadMedida" runat="server" Text='<%# Eval("UnidadMedida") %>' /></td>
                    <td>
                        <asp:Label ID="lblCodigoDeBarra" runat="server" Text='<%# Eval("CodigoDeBarra") %>' /></td>


                    <td>
                        <asp:LinkButton runat="server" ID="EditArticuloMaestroBtn" CommandName="Editar" CommandArgument='<%# Eval("IdArticuloMaestro")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton runat="server" ID="DeleteArticuloMaestroBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdArticuloMaestro")%>' ToolTip="Eliminar">
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
                                <b id="addModalLabel">Agregar nuevo ArticuloMaestro.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="ArticuloMaestroDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdArticuloMaestro" ForeColor="#333333"
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
                                                    <asp:TextBox ID="txtIdArticuloMaestro" runat="server" Text="" CssClass="form-control mitad" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Código</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCodigo" runat="server" Text='<%# Bind("Codigo") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Artículo</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtArticulo" runat="server" Text='<%# Bind("Articulo") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Descripción</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Bind("Descripcion") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Unidad de medida</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdUnidadMedidaDDL"
                                                        runat="server"
                                                        DataSourceID="UnidadMedidaDS"
                                                        DataTextField="UnidadMedida"
                                                        DataValueField="IdUnidadMedida"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdUnidadMedida") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Cód. de Barras</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCodigoDeBarra" runat="server" Text='<%# Bind("CodigoDeBarra") %>' CssClass="form-control" />
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
                                <b id="editModalLabel">Modificar ArticuloMaestro.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdArticuloMaestro" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">ID</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdArticuloMaestro" runat="server" Text='<%# Bind("IdArticuloMaestro") %>' CssClass="form-control mitad" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Código</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCodigo" runat="server" Text='<%# Bind("Codigo") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Artículo</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtArticulo" runat="server" Text='<%# Bind("Articulo") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Descripción</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Bind("Descripcion") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Unidad de medida</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdUnidadMedidaDDL"
                                                        runat="server"
                                                        DataSourceID="UnidadMedidaDS"
                                                        DataTextField="UnidadMedida"
                                                        DataValueField="IdUnidadMedida"
                                                        CssClass="form-control"
                                                        SelectedValue='<%# Bind("IdUnidadMedida") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Cód. de Barras</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCodigoDeBarra" runat="server" Text='<%# Bind("CodigoDeBarra") %>' CssClass="form-control" />
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
        <asp:SqlDataSource ID="ArticuloMaestroDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            InsertCommand="warehouse.sp_ArticuloMaestro_insert" InsertCommandType="StoredProcedure"
            SelectCommand="warehouse.sp_ArticuloMaestro_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Codigo" Type="String" />
                <asp:Parameter Name="Articulo" Type="String" />
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter Name="IdUnidadMedida" Type="Int32" />
                <asp:Parameter Name="CodigoDeBarra" Type="String" />
            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtSearchKey" PropertyName="Text" Name="key" DefaultValue="*" />
                <asp:ControlParameter ControlID="searchParameterDDL" PropertyName="SelectedValue" Name="parameter" />
            </SelectParameters>
        </asp:SqlDataSource>



        <asp:SqlDataSource ID="UnidadMedidaDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdUnidadMedida, UnidadMedida from warehouse.UnidadMedida  order by 2" SelectCommandType="Text"></asp:SqlDataSource>



        <!-- #endregion -->




    </div>
</asp:Content>
