<%@ Page Title="" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="TransaccionMovimiento.aspx.cs" Inherits="Almacenes.TransaccionMovimiento" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="container-fluid" style="background-color: white">
            <div class="row">
                <div class="col-3">
                    <div class="col-form-label-lg azul" runat="server" id="divTitle">Movimiento de Dependencias</div>
                </div>
                <div class="col-4">
                    <asp:TextBox ID="txtSearchKey" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-2">
                    <asp:DropDownList ID="searchParameterDDL" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Nro. transacción" Value="NROTRANSACCION"></asp:ListItem>
                        <asp:ListItem Text="Descripción" Value="DESCRIPCION"></asp:ListItem>
                        <asp:ListItem Text="Usuario" Value="USUARIO"></asp:ListItem>
                        <asp:ListItem Text="Solicitante" Value="SOLICITANTE"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-1">
                    <button class="btn btn-primary" type="button" runat="server" id="SearchBtn" onserverclick="SearchBtn_ServerClick" >
                        <i class="fas fa-search fa-sm"></i>
                    </button>
                </div>
                
                <div class="col-2" style="text-align:right">
                    <button class="btn btn-primary" type="button" runat="server" id="AddTransaccionBtn"  onserverclick="AddTransaccionBtn_ServerClick">
                        <span>Nuevo movimiento
                            <i class="fas fa-plus fa-sm"></i>
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
            DataKeyNames="IdTransaccion">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Fecha</th>
                            <th>Nro. Transacción</th>
                            <th>Descripción</th>
                            <th>Usuario</th>
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
                        <asp:Label ID="lblUser" runat="server" Text='<%# Eval("UserName") %>' /></td>
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
                        <asp:LinkButton runat="server" ID="DeleteTransaccionBtn" CommandName="delete" CommandArgument='<%# Eval("IdTransaccion")%>' ToolTip="Eliminar Transaccion">
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

        <!-- #region DataSources -->
        <asp:SqlDataSource ID="TransaccionDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="[warehouse].[sp_TransaccionMovimiento_get_all]" SelectCommandType="StoredProcedure"
             DeleteCommand="warehouse.[sp_Transaccion_delete]" DeleteCommandType="StoredProcedure"> 
            <DeleteParameters>
                <asp:Parameter Name="IdTransaccion" DbType="Int32" />
            </DeleteParameters>
            <InsertParameters>
            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtSearchKey" PropertyName="Text" Name="key" DefaultValue="*" />
                <asp:ControlParameter ControlID="searchParameterDDL" PropertyName="SelectedValue" Name="parameter" />
                <asp:QueryStringParameter Name="tipo_transaccion" Type="String" DefaultValue="Dependencia" QueryStringField="Tipo" />
            </SelectParameters>
        </asp:SqlDataSource>

        
        <asp:SqlDataSource ID="DependenciaDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdDependencia, Dependencia + ' [' + Descripcion + ']' as Dependencia from warehouse.Dependencia where Activo = 'S' order by 2 asc"
            SelectCommandType="Text"></asp:SqlDataSource>
        <!-- #endregion -->




    </div>

</asp:Content>
