<%@ Page Title="Artículos" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="ArticuloMaestro.aspx.cs" Inherits="Almacenes.ArticuloMaestro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/Enigma.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="fondo">
        <div class="page-header  encabezado">
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
                                <asp:ListItem Text="Código" Value="CODIGO"></asp:ListItem>
                                <asp:ListItem Text="Descripción" Value="DESCRIPCION"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-6">
                            <div class="btn-group btn-shadow">
                                <asp:LinkButton CssClass="btn btn-primary" runat="server" ID="SearchBtn" onserverclick="SearchBtn_ServerClick" ToolTip="Buscar">
                                <div class="form-row">
                                <asp:Label Text="Buscar" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label>
                                <i class="fas fa-search fa-sm" style="padding:5px"></i>
                              </div>
                                </asp:LinkButton>

                                <asp:LinkButton CssClass="btn btn-primary" runat="server" ID="AddLicitacionBtn" data-toggle="modal" data-target="#addModal" ToolTip="Agregar Artículo">
                                <div class="form-row">
                                <asp:Label  Text="Agregar Artículo" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label> 
                                <i class="fas fa-plus fa-sm"  style="padding:5px"></i>
                                </div>
                                </asp:LinkButton>
                                <div class="btn-group" role="group">
                                    <button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        #
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                        <a class="dropdown-item" href="/ArticuloMaestro.aspx?PageSize=10" runat="server">10</a>
                                        <a class="dropdown-item" href="/ArticuloMaestro.aspx?PageSize=20" runat="server">20</a>
                                        <a class="dropdown-item" href="/ArticuloMaestro.aspx?PageSize=30" runat="server">30</a>
                                        <a class="dropdown-item" href="/ArticuloMaestro.aspx?PageSize=50" runat="server">50</a>
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
                <asp:DataPager ID="ArticuloMaestroListViewDataPager" runat="server" PagedControlID="ArticuloMaestroListView" PageSize="10">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                        <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm font-weight-bold  border" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary  btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                    </Fields>
                </asp:DataPager>
            </div>
            <asp:ListView ID="ArticuloMaestroListView"
                runat="server"
                DataSourceID="ArticuloMaestroDS"
                DataKeyNames="IdArticuloMaestro"
                OnItemCommand="ListView_ItemCommand">
                <LayoutTemplate>
                    <div class="table table-responsive">
                        <table class="table table-striped table-condensed">
                            <thead>
                                <th>ID</th>
                                <th>Código</th>
                                <th>Artículo</th>
                                <th>Descripción</th>
                                <th>UM</th>
                                <th>...</th>
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
                            <asp:LinkButton runat="server" ID="CodigoBarraBtn" CommandName="CodigoBarra" CommandArgument='<%# Eval("IdArticuloMaestro")%>' ToolTip="Ver código de barras">
                                <i class="fas fa-barcode fa-sm"></i>
                            </asp:LinkButton>
                        </td>

                        <td>
                            <asp:LinkButton runat="server" ID="EditArticuloMaestroBtn" CommandName="Editar" CommandArgument='<%# Eval("IdArticuloMaestro")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                            </asp:LinkButton>
                        </td>

                        <td>
                            <asp:LinkButton runat="server" ID="DeleteArticuloMaestroBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdArticuloMaestro")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');">
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
                                    <b id="addModalLabel">Agregar Articulo.</b>
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
                                                    <div class="col-3">Nombre de Artículo</div>
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
                                    <b id="editModalLabel">Modificar Articulo.</b>
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
                                                    <div class="col-3">Nombre de Artículo</div>
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

            <div id="CodigoBarraModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="CodigoBarraModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <asp:UpdatePanel ID="CodigoBarraUP" runat="server">
                        <ContentTemplate>
                            <div class="modal-content">
                                <div class="modal-header">
                                    <b id="CodigoBarraModalLabel">Código de barras.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                    <asp:HiddenField ID="IdArticuloMaestroHF" runat="server" />
                                    <asp:ListView ID="CodigoBarraListView"
                                        runat="server"
                                        DataSourceID="CodigoBarraDS"
                                        DataKeyNames="IdCodigoBarra"
                                         InsertItemPosition="FirstItem">
                                        <LayoutTemplate>
                                            <div class="table table-responsive">
                                                <table class="table table-striped table-condensed">
                                                    <thead>
                                                        <th>ID</th>
                                                        <th>Dato</th>
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
                                                    <asp:Label ID="lblIdCodigoBarra" runat="server" Text='<%# Eval("IdCodigoBarra") %>' /></td>
                                               
                                                <td>
                                                    <asp:Label ID="lblDato" runat="server" Text='<%# Eval("Dato") %>' /></td>


                                                <td>
                                                    <asp:LinkButton runat="server" ID="EditCodigoBarraBtn" CommandName="Edit" CommandArgument='<%# Eval("IdCodigoBarra")%>' ToolTip="Editar" >
                                                        <i class="fa fa-edit fa-sm"></i>
                                                    </asp:LinkButton>
                                                </td>

                                                <td>
                                                    <asp:LinkButton runat="server" ID="DeleteCodigoBarraBtn" CommandName="Delete" CommandArgument='<%# Eval("IdCodigoBarra")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');" >
                                                        <i class="fas fa-trash-alt"></i>
                                                    </asp:LinkButton>
                                                </td>

                                            </tr>

                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <td>
                                                <asp:Label ID="txtIdCodigoBarra" runat="server" Text='<%# Bind("IdCodigoBarra") %>' CssClass="form-control mitad" Enabled="false" /></td>

                                            <td>
                                                <asp:TextBox ID="txtDato" runat="server" Text='<%# Bind("Dato") %>' CssClass="form-control" /></td>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <td>
                                                <asp:Label ID="txtIdCodigoBarra" runat="server" Text="#"  Enabled="false" /></td>

                                            <td>
                                                <asp:TextBox ID="txtDato" runat="server" Text='<%# Bind("Dato") %>' CssClass="form-control" /></td>

                                            <td>
                                                <asp:Button runat="server" ID="InsertarCNBtn" CssClass="btn btn-primary btn-sm" CommandName="Insert" ToolTip="Insertar código" Text="Insertar código"  UseSubmitBehavior="false">
                                                </asp:Button>
                                            </td>

                                            <td>
                                                <asp:Button runat="server" ID="CancelarBtn" CssClass="btn btn-danger btn-sm" CommandName="Cancel" ToolTip="Cancelar"  Text="Cancelar" >
                                                </asp:Button>
                                            </td>
                                        </InsertItemTemplate>
                                    </asp:ListView>
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

            <asp:SqlDataSource ID="CodigoBarraDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="[warehouse].[sp_CodigoBarra_get_CodigoBarra_By_IdArticuloMaestro]" SelectCommandType="StoredProcedure"
                InsertCommand="[warehouse].[sp_CodigoBarra_insert]" InsertCommandType="StoredProcedure"
                DeleteCommand="[warehouse].[sp_CodigoBarra_delete]" DeleteCommandType="StoredProcedure"
                UpdateCommand="[warehouse].[sp_CodigoBarra_update]" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="IdArticuloMaestroHF" Name="IdArticuloMaestro" PropertyName="Value" Type="Int32" />
                </SelectParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="IdArticuloMaestroHF" Name="IdArticuloMaestro" PropertyName="Value" Type="Int32" />
                    <asp:Parameter Name="Dato" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="IdCodigoBarra" Type="Int32" />
                    <asp:ControlParameter ControlID="IdArticuloMaestroHF" Name="IdArticuloMaestro" PropertyName="Value" Type="Int32" />
                    <asp:Parameter Name="Dato" Type="String" />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:Parameter Name="IdCodigoBarra" Type="Int32" />
                </DeleteParameters>
            </asp:SqlDataSource>



            <!-- #endregion -->




        </div>
    </div>

</asp:Content>
