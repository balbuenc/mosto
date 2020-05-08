<%@ Page Title="Licitaciones" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Licitaciones.aspx.cs" Inherits="Almacenes.Management.Licitaciones" %>


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
                                <asp:ListItem Text="Llamado" Value="LLAMADO"></asp:ListItem>
                                <asp:ListItem Text="Número" Value="NUMERO"></asp:ListItem>
                                <asp:ListItem Text="Referencia" Value="UOCREFERENCIA"></asp:ListItem>
                                <asp:ListItem Text="ID" Value="UOCIDLICITACION"></asp:ListItem>
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

                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="AddRegistroBtn" data-toggle="modal" data-target="#addModal" ToolTip="Agregar licitación">
                                <div class="form-row">
                                <asp:Label  Text="Agregar licitación" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label> 
                                <i class="fas fa-plus fa-sm"  style="padding:5px"></i>
                                </div>
                                </asp:LinkButton>
                                <div class="btn-group" role="group">
                                    <button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle btn-border" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        #
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                        <a class="dropdown-item" href="/Licitacion.aspx?PageSize=10" runat="server">10</a>
                                        <a class="dropdown-item" href="/Licitacion.aspx?PageSize=20" runat="server">20</a>
                                        <a class="dropdown-item" href="/Licitacion.aspx?PageSize=30" runat="server">30</a>
                                        <a class="dropdown-item" href="/Licitacion.aspx?PageSize=50" runat="server">50</a>
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
                <asp:DataPager ID="LicitacionDataPager" runat="server" PagedControlID="LicitacionListView" PageSize="10">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                        <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm font-weight-bold  border" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary  btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                    </Fields>
                </asp:DataPager>
            </div>

            <asp:ListView ID="LicitacionListView"
                runat="server"
                DataSourceID="LicitacionDS"
                DataKeyNames="IdTipoLicitacion"
                OnItemDataBound="LicitacionListView_ItemDataBound"
                OnItemCommand="LicitacionListView_ItemCommand">
                <LayoutTemplate>
                    <div class="table table-responsive">
                        <table class="table table-striped table-condensed">
                            <thead>
                                <th>ID</th>
                                <th>Número</th>
                                <th>Llamado</th>
                                <th>Fecha</th>
                                <th>Tipo</th>
                                <th style="text-align: center">Ref. UOC</th>
                                <th>Id (UOC)</th>
                                <th>Activo</th>
                                <th>Desactivación</th>
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
                            <asp:Label ID="lblIdLicitacion" runat="server" Text='<%# Eval("IdLicitacion") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblNroLicitacion" runat="server" Text='<%# Eval("NroLicitacion") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblLlamdo" runat="server" Text='<%# Eval("Llamado") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblFechaLicitacion" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval( "FechaLicitacion") ) %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblIdTipoLicitacion" runat="server" Text='<%# Eval("TipoLicitacion") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblUOCReferancia" runat="server" Text='<%# Eval("UOCReferancia") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblUOCIdLicitacion" runat="server" Text='<%# Eval("UOCIdLicitacion") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblActivo" runat="server" Text='<%# Eval("Activo") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblFechaDesactivacion" runat="server" Text='<%# Eval("FechaDesactivacion") %>' />
                        </td>

                        <td>
                            <asp:LinkButton runat="server" ID="EditLicitacionBtn" CommandName="Editar" CommandArgument='<%# Eval("IdLicitacion")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                            </asp:LinkButton>
                        </td>

                        <td>

                            <asp:LinkButton runat="server" ID="DeleteLicitacionBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdLicitacion")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');">
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
                                    <b id="addModalLabel">Agregar Licitación.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                    <asp:FormView ID="InsertFormView" runat="server" DataSourceID="LicitacionDS" Width="100%"
                                        CellPadding="4" DataKeyNames="IdLicitacion" ForeColor="#333333"
                                        DefaultMode="Insert"
                                        OnItemInserted="FormView1_ItemInserted">
                                        <EditItemTemplate>
                                        </EditItemTemplate>
                                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                        <InsertItemTemplate>
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-3"><b>Tipo</b></div>
                                                    <div class="col-9">
                                                        <asp:DropDownList ID="IdLicitacionDDL"
                                                            runat="server"
                                                            DataSourceID="TipoLicitacionAddDS"
                                                            DataTextField="TipoLicitacion"
                                                            DataValueField="IdTipoLicitacion"
                                                            CssClass="form-control spacing"
                                                            SelectedValue='<%# Bind("IdTipoLicitacion") %>'>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-3"><b>Nro. Licitacion</b></div>
                                                    <div class="col-6">
                                                        <asp:TextBox ID="txtNroLicitacion" runat="server" Text='<%# Bind("NroLicitacion") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Llamado</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtLlamado" runat="server" Text='<%# Bind("Llamado") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Fecha</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtFechaLicitacion" runat="server" Text='<%# Bind("FechaLicitacion") %>' CssClass="form-control" TextMode="Date" />
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-3"><b>Referencia (UOC)</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtUOCReferancia" runat="server" Text='<%# Bind("UOCReferancia") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>ID (UOC)</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtUOCIdLicitacion" runat="server" Text='<%# Bind("UOCIdLicitacion") %>' CssClass="form-control" />
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
                                            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancelar" Text="Cancelar" CssClass="btn btn-danger" OnClick="InsertCancelButton_Click" />
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
                                    <b id="editModalLabel">Modificar licitación.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                    <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                        CellPadding="4" DataKeyNames="IdLicitacion" ForeColor="#333333"
                                        DefaultMode="Edit"
                                        OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                        <EditItemTemplate>
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-3"><b>ID</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtIdLicitacion" runat="server" Text='<%# Eval("IdLicitacion") %>' CssClass="form-control mitad" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Tipo</b></div>
                                                    <div class="col-9">
                                                        <asp:DropDownList ID="IdLicitacionDDL"
                                                            runat="server"
                                                            DataSourceID="TipoLicitacionDS"
                                                            DataTextField="TipoLicitacion"
                                                            DataValueField="IdTipoLicitacion"
                                                            CssClass="form-control"
                                                            SelectedValue='<%# Bind("IdTipoLicitacion") %>'>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-3"><b>Nro. Licitacion</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtNroLicitacion" runat="server" Text='<%# Bind("NroLicitacion") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Llamado</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtLlamado" runat="server" Text='<%# Bind("Llamado") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>Fecha</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtFechaLicitacion" runat="server" Text='<%#  Bind( "FechaLicitacion" )  %>' CssClass="form-control" />
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-3"><b>Referencia (UOC)</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtUOCReferancia" runat="server" Text='<%# Bind("UOCReferancia") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3"><b>ID (UOC)</b></div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtUOCIdLicitacion" runat="server" Text='<%# Bind("UOCIdLicitacion") %>' CssClass="form-control" />
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
                                            <asp:LinkButton ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancelar" CssClass="btn btn-danger" OnClick="InsertCancelButton_Click" />
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
            <asp:SqlDataSource ID="LicitacionDS"
                runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                InsertCommand="management.sp_licitacion_insert" InsertCommandType="StoredProcedure"
                SelectCommand="management.sp_licitacion_get_all" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="NroLicitacion" Type="String" />
                    <asp:Parameter DbType="Date" Name="FechaLicitacion" />

                    <asp:Parameter Name="IdTipoLicitacion" Type="Int16" />
                    <asp:Parameter Name="UOCReferancia" Type="String" />
                    <asp:Parameter Name="UOCIdLicitacion" Type="String" />
                    <asp:Parameter Name="Activo" Type="String" />
                    <asp:Parameter DbType="Date" Name="FechaDesactivacion" />
                    <asp:Parameter Name="Llamado" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSearchKey" PropertyName="Text" Name="key" DefaultValue="*" />
                    <asp:ControlParameter ControlID="searchParameterDDL" PropertyName="SelectedValue" Name="parameter" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="TipoLicitacionDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="select IdTipoLicitacion, TipoLicitacion from management.TipoLicitacion  order by 2" SelectCommandType="Text"></asp:SqlDataSource>

            <asp:SqlDataSource ID="TipoLicitacionAddDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="select IdTipoLicitacion, TipoLicitacion from management.TipoLicitacion where Activo = 'S' order by 2" SelectCommandType="Text"></asp:SqlDataSource>

            <!-- #endregion -->




        </div>
    </div>

</asp:Content>
