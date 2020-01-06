<%@ Page Title="Detalle de asiento" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="DiarioDetalle.aspx.cs" Inherits="Almacenes.DiarioDetalle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="fondo">
        <div class="page-header  encabezado">
            <div class="row">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
            </div>
        </div>

        <div class="container-fluid">


            <div class="row" style="font-size: small">
                <div class="alert alert-primary" role="alert">
                    <asp:Label ID="txtIdDiario" runat="server" Text=""></asp:Label>
                </div>

                <div class="alert alert-primary" role="alert">
                    <asp:Label ID="txtDescripcion" runat="server" Text=""></asp:Label>
                </div>

                <div class="alert alert-primary" role="alert">
                    <asp:Label ID="txtFecha" runat="server" Text=""></asp:Label>
                </div>

            </div>
            <div class="row">
                <asp:ListView ID="DiarioListView"
                    runat="server"
                    DataSourceID="DiarioDS"
                    DataKeyNames="IdDiarioDetalle"
                    OnItemDataBound="DiarioListView_ItemDataBound">
                    <LayoutTemplate>
                        <div class="table table-responsive">
                            <table class="table table-striped table-condensed">
                                <thead>
                                    <th>ID</th>
                                    <th>#Cuenta</th>
                                    <th>Cuenta</th>
                                    <th>Tipo</th>
                                    <th>Haber</th>
                                    <th>Debe</th>
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
                                <asp:Label ID="lblIdDiarioDetalle" runat="server" Text='<%#Eval("IdDiarioDetalle") %>' /></td>

                            <td>
                                <asp:Label ID="lblIdDiario" runat="server" Text='<%# Eval("IdDiario") %>' Visible="false" />
                                <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("Descripcion") %>' Visible="false" />
                                <asp:Label ID="lblFecha" runat="server" Text='<%# DateTime.Parse( Eval("Fecha").ToString()).ToShortDateString() %>' Visible="false" />
                                <asp:Label ID="lbbNroCuenta" runat="server" Text='<%# Eval("NroCuenta") %>' /></td>

                            <td>
                                <asp:Label ID="lblCuenta" runat="server" Text='<%#Eval("Cuenta") %>' /></td>
                            <td>
                                <asp:Label ID="lblTipo" runat="server" Text='<%# Eval("Tipo") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblHaber" runat="server" Text='<%# Eval("Haber") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblDebe" runat="server" Text='<%# Eval("Debe") %>' />
                            </td>

                            <td>
                                <asp:LinkButton runat="server" ID="EditDiarioBtn" CommandName="Edit" CommandArgument='<%# Eval("IdDiario")%>' ToolTip="Editar">
                            <i class="fa fa-edit" aria-hidden="true"></i>

                                </asp:LinkButton>
                            </td>

                            <td>
                        </tr>

                    </ItemTemplate>
                    <EditItemTemplate>
                        <tr>
                            <td>
                                <asp:Label ID="lblIdDiarioDetalle" runat="server" Text='<%#Bind("IdDiarioDetalle") %>' /></td>
                            <td>
                                <asp:TextBox ID="txtNroCuenta" runat="server" Text='<%# Bind("NroCuenta") %>' />
                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="SearchCuentaContable" data-toggle="modal" data-target="#SearchModal" ToolTip="Buscar cuenta">
                                <div class="form-row">
                                
                                <i class="fas fa-search"></i>
                                </div>
                                </asp:LinkButton>

                            </td>
                            <td>
                                <asp:Label ID="lblCuenta" runat="server" Text='<%#Eval("Cuenta") %>' /></td>

                            <td>
                                <asp:Label ID="lblTipo" runat="server" Text='<%# Eval("Tipo") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblHaber" runat="server" Text='<%# Eval("Haber") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lblDebe" runat="server" Text='<%# Eval("Debe") %>' />
                            </td>

                            <td>
                                <asp:LinkButton runat="server" ID="btnEdit" CommandName="Update" ToolTip="Aceptar">
                            <i class="fas fa-check"></i>
                                </asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton runat="server" ID="btnCancel" CommandName="Cancel" ToolTip="Cancelar">
                            <i class="fas fa-times"></i>
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                    </InsertItemTemplate>
                </asp:ListView>

            </div>


            <!-- #region Modals -->
            <div id="SearchModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="CodigoBarraModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <asp:UpdatePanel ID="CuentaContableUP" runat="server">
                        <ContentTemplate>
                            <div class="modal-content">
                                <div class="modal-header">
                                    <b id="CodigoBarraModalLabel" runat="server">Cuentas contables</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                    <div class="container">
                                        <div class="row">
                                            <asp:Panel runat="server" DefaultButton="SearchBtn">
                                                <div class="container-fluid">
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <asp:TextBox ID="txtSearchKey" runat="server" CssClass="form-control"></asp:TextBox>
                                                        </div>
                                                        <div class="col-3">
                                                            <asp:DropDownList ID="searchParameterDDL" runat="server" CssClass="form-control">
                                                                <asp:ListItem Text="Nro. Cuenta" Value="NROCUENTA"></asp:ListItem>
                                                                <asp:ListItem Text="Cuenta" Value="CUENTA"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>

                                                        <div class="col-3">
                                                            <div class="btn-group btn-shadow">
                                                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="SearchBtn" onserverclick="SearchBtn_ServerClick" ToolTip="Buscar">
                                                            <div class="form-row">
                                                            <asp:Label Text="Buscar" CssClass="btn-label d-none  d-xl-block d-lg-block" runat="server"></asp:Label>
                                                            <i class="fas fa-search fa-sm" style="padding:5px"></i>
                                                          </div>
                                                                </asp:LinkButton>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                        </div>

                                        <div class="row">
                                            <asp:ListView ID="PlanCuentaListView"
                                                runat="server"
                                                DataSourceID="PlanCuentaDS"
                                                DataKeyNames="IdCuenta"
                                                OnItemCommand="PlanCuentaListView_ItemCommand">
                                                <LayoutTemplate>
                                                    <div class="table table-responsive">
                                                        <table class="table table-striped table-condensed">
                                                            <thead>
                                                                <th>#</th>
                                                                <th>Nro. Cuenta</th>
                                                                <th>Cuenta</th>
                                                                <th>Tipo</th>
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
                                                            <asp:Label ID="lblIdCuenta" runat="server" Text='<%# Eval("IdCuenta") %>' /></td>
                                                        <td>
                                                            <asp:Label ID="lblNroCuenta" runat="server" Text='<%# Eval("NroCuenta") %>' /></td>
                                                        <td>
                                                            <asp:Label ID="lblCuenta" runat="server" Text='<%# Eval("Cuenta") %>' /></td>
                                                        <td>
                                                            <asp:Label ID="lblTipo" runat="server" Text='<%# Eval("Tipo") %>' /></td>

                                                        <td>
                                                            <asp:LinkButton runat="server" ID="SelectPlanCuentaBtn" CommandName="Seleccionar" CommandArgument='<%# Eval("NroCuenta")%>' ToolTip="Seleccionar cuenta">
                                                                    <i class="fas fa-check"></i>
                                                            </asp:LinkButton>
                                                        </td>



                                                    </tr>

                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                </EditItemTemplate>
                                                <InsertItemTemplate>
                                                </InsertItemTemplate>
                                            </asp:ListView>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <td>
                                        <asp:Button runat="server" ID="AceptarBtn" CssClass="btn btn-info btn-sm" ToolTip="Aceptar" Text="Aceptar" data-dismiss="modal"></asp:Button>
                                    </td>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>

            <!-- #endregion -->

            <!-- #region DataSources -->
            <asp:SqlDataSource ID="DiarioDS"
                runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="[accounting].[sp_GetAsientoContable_By_IdDiario]" SelectCommandType="StoredProcedure"
                UpdateCommand="[accounting].[sp_DiarioDetalle_update]" UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                </DeleteParameters>
                <InsertParameters>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="IdDiarioDetalle" Type="Int32" />
                    <asp:Parameter Name="NroCuenta" Type="String" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="IdDIario" QueryStringField="IdDiario" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="PlanCuentaDS"
                runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                InsertCommand="accounting.sp_PlanCuenta_insert" InsertCommandType="StoredProcedure"
                SelectCommand="accounting.sp_PlanCuenta_get_all" SelectCommandType="StoredProcedure">
                <DeleteParameters>
                </DeleteParameters>
                <InsertParameters>

                    <asp:Parameter Name="NroCuenta" Type="String" />
                    <asp:Parameter Name="Cuenta" Type="String" />
                    <asp:Parameter Name="IdTipoCuenta" Type="Int32" />

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
