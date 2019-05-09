<%@ Page Title="Impuestos" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Impuesto.aspx.cs" Inherits="Almacenes.Impueto" %>

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
        <asp:ListView ID="ImpuestoListView"
            runat="server"
            DataSourceID="ImpuestoDS"
            DataKeyNames="IdImpuesto"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
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

                        <asp:LinkButton runat="server" ID="DeleteImpuestoBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdImpuesto")%>' ToolTip="Eliminar">
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
        </asp:SqlDataSource>


        <!-- #endregion -->




    </div>
</asp:Content>

