<%@ Page Title="Ingresos" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Transaccion.aspx.cs" Inherits="Almacenes.Transaccion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="container-fluid" style="background-color: white">
            <div class="row">
                <div class="col-1">
                    <div class="col-form-label-lg azul" runat="server" id="divTitle">Transacciones</div>
                </div>
                <div class="col-3">
                    <asp:TextBox ID="txtSearchKey" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-2">
                    <asp:DropDownList ID="searchParameterDDL" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Nro. transacción" Value="NROTRANSACCION"></asp:ListItem>
                        <asp:ListItem Text="Definición" Value="DEFINICION"></asp:ListItem>
                        <asp:ListItem Text="Nro. factura" Value="NROFACTURA"></asp:ListItem>
                        <asp:ListItem Text="Nro. contrato" Value="NROCONTRATO"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-1">
                    <button class="btn btn-primary" type="button" runat="server" id="SearchBtn" onserverclick="SearchBtn_ServerClick">
                        <i class="fas fa-search fa-sm"></i>
                    </button>
                </div>
                <div class="col-2">
                    <button class="btn btn-primary" type="button" runat="server" id="AddTransaccionBtn" data-toggle="modal" data-target="#addModal">
                        <span>Agregar
                            <i class="fas fa-sign-in-alt"></i>
                        </span>
                    </button>
                </div>
                <div class="col-2">
                    <button class="btn btn-primary" type="button" runat="server" id="AddtransaccionSalidaBtn" data-toggle="modal" data-target="#addModalSalida">
                        <span>Agregar
                        <i class="fas fa-sign-out-alt"></i>
                        </span>
                    </button>
                </div>
            </div>
            <div class="row">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
            </div>
        </div>
    </div>

    <div class="container-fluid" style="background-color: white">
        <asp:DataPager ID="TransaccionDataPager" runat="server" PagedControlID="TransaccionListView" PageSize="10">
            <Fields>
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
            </Fields>
        </asp:DataPager>

        <asp:ListView ID="TransaccionListView"
            runat="server"
            DataSourceID="TransaccionDS"
            DataKeyNames="IdTransaccion"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Fecha</th>
                            <th>Nro. Transacción</th>
                            <th>Definición</th>
                            <th>Nro. Factura</th>
                            <th>Usuario</th>
                            <th>NroContrato</th>
                            <th>Solicitante</th>
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
                        <asp:Label ID="lblIdtransaccion" runat="server" Text='<%# Eval("Idtransaccion") %>' /></td>
                    <td>
                        <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("Fecha") %>' /></td>
                    <td>
                        <asp:Label ID="lblNroTransaccion" runat="server" Text='<%# Eval("NroTransaccion") %>' /></td>
                    <td>
                        <asp:Label ID="lblDefinicion" runat="server" Text='<%# Eval("Definicion") %>' /></td>
                    <td>
                        <asp:Label ID="lblNroFactura" runat="server" Text='<%# Eval("NroFactura") %>' /></td>
                    <td>
                        <asp:Label ID="lblUser" runat="server" Text='<%# Eval("UserName") %>' /></td>
                    <td>
                        <asp:Label ID="lblNroContrato" runat="server" Text='<%# Eval("NroContrato") %>' /></td>
                    <td>
                        <asp:Label ID="lblSolicitante" runat="server" Text='<%# Eval("Solicitante") %>' /></td>

                    <td>
                        <asp:LinkButton runat="server" ID="ReportTransaccionBtn" CommandName="ViewReport" CommandArgument='<%# Eval("IdTransaccion")%>' ToolTip="Ver reporte">
                            <i class="fas fa-book-reader"></i>

                        </asp:LinkButton>
                    </td>
                    <td>
                        <asp:LinkButton runat="server" ID="DetailsTransaccionBtn" CommandName="Editar" CommandArgument='<%# Eval("IdTransaccion")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton runat="server" ID="DeleteTransaccionBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdTransaccion")%>' ToolTip="Eliminar Transaccion">
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

        <div id="addModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="modal-content">
                            <div class="modal-header">
                                <b id="addModalLabel">Agregar entrada.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">

                                <div class="container-fluid">

                                    <div class="row">
                                        <div class="col-3">Descripción</div>
                                        <div class="col-9">
                                            <asp:TextBox ID="txtDefinicion" runat="server" Text='<%# Bind("Definicion") %>' CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-3">Nro. de Remisión</div>
                                        <div class="col-9">
                                            <asp:TextBox ID="txtNroFactura" runat="server" Text='<%# Bind("NroFactura") %>' CssClass="form-control" />
                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="col-3">Contrato</div>
                                        <div class="col-9">
                                            <asp:DropDownList ID="IdContratoDDL"
                                                runat="server"
                                                DataSourceID="ContratoDS"
                                                DataTextField="NroContrato"
                                                DataValueField="IdContrato"
                                                CssClass="form-control form-control-sm">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>

                                <hr />

                                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Aceptar" CssClass="btn btn-success" OnClick="InsertButton_Click" />
                                <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancelar" Text="Cancelar" CssClass="btn btn-danger" OnClick="CancelButton_Click" />

                            </div>
                            <div class="modal-footer">
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>


        </div>


        <div id="addModalSalida" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addModalSalidaLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="modal-content">
                            <div class="modal-header">
                                <b id="addModalSalidaLabel">Agregar Salida.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">

                                <div class="container-fluid">

                                    <div class="row">
                                        <div class="col-3">Descripción</div>
                                        <div class="col-9">
                                            <asp:TextBox ID="txtDefinicionSalida" runat="server" Text='<%# Bind("Definicion") %>' CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-3">Dependencia</div>
                                        <div class="col-9">
                                            <asp:DropDownList ID="DependenciaDDL"
                                                runat="server"
                                                DataSourceID="DependenciaDS"
                                                DataTextField="Dependencia"
                                                DataValueField="IdDependencia"
                                                CssClass="form-control form-control-sm">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-3">Contrato</div>
                                        <div class="col-9">
                                            <asp:DropDownList ID="ContratoExistenciaDDL"
                                                runat="server"
                                                DataSourceID="ContratoExistenciaDS"
                                                DataTextField="Contrato"
                                                DataValueField="IdContrato"
                                                CssClass="form-control form-control-sm">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-3">Solicitante</div>
                                        <div class="col-9">
                                            <asp:TextBox ID="txtSolicitanteSalida" runat="server" Text="" CssClass="form-control" />
                                        </div>
                                    </div>

                                </div>

                                <hr />
                                <asp:LinkButton ID="InsertSalidaBtn" runat="server" CausesValidation="True" CommandName="Insert" Text="Aceptar" CssClass="btn btn-success" OnClick="InsertSalidaBtn_Click" />
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancelar" Text="Cancelar" CssClass="btn btn-danger" OnClick="CancelButton_Click" />

                            </div>
                            <div class="modal-footer">
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>

        <!-- #region DataSources -->
        <asp:SqlDataSource ID="TransaccionDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="[warehouse].[sp_Transaccion_get_all]" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtSearchKey" PropertyName="Text" Name="key" DefaultValue="*" />
                <asp:ControlParameter ControlID="searchParameterDDL" PropertyName="SelectedValue" Name="parameter" />
                <asp:QueryStringParameter Name="tipo_transaccion" Type="String" DefaultValue="Entrada" QueryStringField="Tipo" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="ContratoDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdContrato, NroContrato from management.Contrato order by 2 ;"
            SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="ContratoExistenciaDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="management.sp_get_Contrato_ExistenciaDDL"
            SelectCommandType="StoredProcedure"></asp:SqlDataSource>

        <asp:SqlDataSource ID="DependenciaDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdDependencia, Dependencia from warehouse.Dependencia where Activo = 'S' order by 2 asc"
            SelectCommandType="Text"></asp:SqlDataSource>
        <!-- #endregion -->




    </div>
</asp:Content>
