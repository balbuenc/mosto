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
                    OnItemCommand="ListView_ItemCommand"
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
                                
                                <i class="fas fa-plus fa-sm"  style="padding:5px"></i>
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
            <div id="SearchModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="modal-content">
                                <div class="modal-header">
                                    <b id="addModalLabel">Seleccionar cuenta contable.</b>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                </div>
                                <div class="modal-body">
                                   
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



            <!-- #endregion -->




        </div>
    </div>
</asp:Content>
