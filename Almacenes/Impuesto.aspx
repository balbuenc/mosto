﻿<%@ Page Title="Impuestos" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Impuesto.aspx.cs" Inherits="Almacenes.Impueto" %>

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
                                 <asp:ListItem Text="Impuesto" Value="IMPUESTO"></asp:ListItem>
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

                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="AddRegistroBtn" data-toggle="modal" data-target="#addModal" ToolTip="Agregar impuesto">
                                <div class="form-row">
                                <asp:Label  Text="Agregar impuesto" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label> 
                                <i class="fas fa-plus fa-sm"  style="padding:5px"></i>
                                </div>
                                </asp:LinkButton>
                                <div class="btn-group" role="group">
                                    <button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle btn-border" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        #
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                        <a class="dropdown-item" href="/Impuesto.aspx?PageSize=10" runat="server">10</a>
                                        <a class="dropdown-item" href="/Impuesto.aspx?PageSize=20" runat="server">20</a>
                                        <a class="dropdown-item" href="/Impuesto.aspx?PageSize=30" runat="server">30</a>
                                        <a class="dropdown-item" href="/Impuesto.aspx?PageSize=50" runat="server">50</a>
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

        <div class="container-fluid" >
            <div class="row pie" style="padding-left: 15px">
                <asp:DataPager ID="ImpuestoDataPager" runat="server" PagedControlID="ImpuestoListView" PageSize="10">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                        <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm font-weight-bold  border" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary  btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                    </Fields>
                </asp:DataPager>
            </div>
           
            <asp:ListView ID="ImpuestoListView"
                runat="server"
                DataSourceID="ImpuestoDS"
                DataKeyNames="IdImpuesto"
                 OnItemDataBound="ImpuestoListView_ItemDataBound"
                OnItemCommand="ListView_ItemCommand">
                <LayoutTemplate>
                    <div class="table table-responsive">
                        <table class="table table-striped table-condensed">
                            <thead>
                                <th>ID</th>
                                <th>Impuesto</th>
                                <th>Porcentaje</th>
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
                            <asp:Label ID="lblIdImpuesto" runat="server" Text='<%# Eval("IdImpuesto") %>' /></td>
                        <td>
                            <asp:Label ID="lblImpuesto" runat="server" Text='<%# Eval("Impuesto") %>' /></td>
                        <td>
                            <asp:Label ID="lblPorcentaje" runat="server" Text='<%# Eval("Porcentaje") %>' /></td>

                        <td>
                            <asp:LinkButton runat="server" ID="EditImpuestoBtn" CommandName="Editar" CommandArgument='<%# Eval("IdImpuesto")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                            </asp:LinkButton>
                        </td>

                        <td>

                            <asp:LinkButton runat="server" ID="DeleteImpuestoBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdImpuesto")%>' ToolTip="Eliminar" OnClientClick="return confirm('Desea eliminar el registro?');">
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
                                    <b id="addModalLabel">Agregar nuevo Impuesto.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                    <asp:FormView ID="InsertFormView" runat="server" DataSourceID="ImpuestoDS" Width="100%"
                                        CellPadding="4" DataKeyNames="IdImpuesto" ForeColor="#333333"
                                        DefaultMode="Insert"
                                        OnItemInserted="FormView1_ItemInserted">
                                        <EditItemTemplate>
                                        </EditItemTemplate>
                                        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                        <InsertItemTemplate>
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-3">IdImpuesto</div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtIdImpuesto" runat="server" Text="" CssClass="form-control mitad" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3">Impuesto</div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtImpuesto" runat="server" Text='<%# Bind("Impuesto") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3">Porcentaje</div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtPorcentaje" runat="server" Text='<%# Bind("Porcentaje") %>' CssClass="form-control" />
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
                                    <b id="editModalLabel">Modificar Impuesto.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                    <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                        CellPadding="4" DataKeyNames="IdImpuesto" ForeColor="#333333"
                                        DefaultMode="Edit"
                                        OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                        <EditItemTemplate>
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-3">IdImpuesto</div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtIdImpuesto" runat="server" Text='<%# Bind("IdImpuesto") %>' CssClass="form-control mitad" Enabled="false" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3">Impuesto</div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtImpuesto" runat="server" Text='<%# Bind("Impuesto") %>' CssClass="form-control" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3">Porcentaje</div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtPorcentaje" runat="server" Text='<%# Bind("Porcentaje") %>' CssClass="form-control" />
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
            <asp:SqlDataSource ID="ImpuestoDS"
                runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                InsertCommand="management.sp_Impuesto_insert" InsertCommandType="StoredProcedure"
                SelectCommand="management.sp_Impuesto_get_all" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Impuesto" Type="String" />
                    <asp:Parameter Name="Porcentaje" Type="Decimal" />
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

