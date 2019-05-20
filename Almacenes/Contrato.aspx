<%@ Page Title="Contrato" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Contrato.aspx.cs" Inherits="Almacenes.Contrato" %>

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
                    <button class="btn btn-primary" type="button" runat="server" id="AddLicitacionBtn" onserverclick="AddLicitacionBtn_ServerClick">
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
        <asp:DataPager ID="ContratoDataPager" runat="server" PagedControlID="ContratoListView" PageSize="10">
            <Fields>
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
            </Fields>
        </asp:DataPager>

        <asp:ListView ID="ContratoListView"
            runat="server"
            DataSourceID="ContratoDS"
            DataKeyNames="IdContrato"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Proveedor</th>
                            <th>Inicio</th>
                            <th>Fin</th>
                            <th>#</th>
                            <th>Liticación</th>
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
                        <asp:Label ID="lblIdContrato" runat="server" Text='<%# Eval("IdContrato") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdProveedor" runat="server" Text='<%# Eval("Proveedor") %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaInicioContrato" runat="server" Text='<%# DateTime.Parse( Eval("FechaInicioContrato").ToString()).ToShortDateString() %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaFinContrato" runat="server" Text='<%# DateTime.Parse( Eval("FechaFinContrato").ToString()).ToShortDateString()  %>' /></td>
                    <td>
                        <asp:Label ID="lblNroContrato" runat="server" Text='<%# Eval("NroContrato") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdLicitacion" runat="server" Text='<%# Eval("Licitacion") %>' />
                    </td>

                    <td>
                        <asp:LinkButton runat="server" ID="EditContratoBtn" CommandName="Edit" CommandArgument='<%# Eval("IdContrato")%>' ToolTip="Editar">
                            <i class="fa fa-edit" aria-hidden="true"></i>

                        </asp:LinkButton>
                    </td>
                    <td>
                        <asp:LinkButton runat="server" ID="DetailsContratoBtn" CommandName="Editar" CommandArgument='<%# Eval("IdContrato")%>' ToolTip="Ver detalles">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton runat="server" ID="DeleteContratoBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdContrato")%>' ToolTip="Eliminar Contrato">
                            <i class="fas fa-trash-alt"></i>
                        </asp:LinkButton>

                    </td>

                </tr>

            </ItemTemplate>
            <EditItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="lblIdContrato" runat="server" Text='<%# Eval("IdContrato") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdProveedor" runat="server" Text='<%# Eval("Proveedor") %>' /></td>
                    <td>
                        <asp:TextBox ID="lblFechaInicioContrato" runat="server" Text='<%# Bind("FechaInicioContrato") %>' />
                        <asp:CompareValidator ID="cvFechaInicioContrato" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="lblFechaInicioContrato" ErrorMessage="Fecha inválida."></asp:CompareValidator>
                    </td>
                    <td>
                        <asp:TextBox ID="lblFechaFinContrato" runat="server" Text='<%# Bind("FechaFinContrato")  %>' />
                        <asp:CompareValidator ID="cvFechaFinContrato" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="lblFechaFinContrato" ErrorMessage="Fecha inválida."></asp:CompareValidator>
                    </td>
                    <td>
                        <asp:TextBox ID="lblNroContrato" runat="server" Text='<%# Bind("NroContrato") %>' /></td>
                    <td>
                        <asp:DropDownList ID="IdLicitacionDDL"
                            runat="server"
                            DataSourceID="LicitacionDS"
                            DataTextField="Licitacion"
                            DataValueField="IdLicitacion"
                            CssClass="form-control form-control-sm"
                            SelectedValue='<%# Bind("IdLicitacion") %>'>
                        </asp:DropDownList>

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





        <!-- #region DataSources -->
        <asp:SqlDataSource ID="ContratoDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="management.sp_Contrato_get_all" SelectCommandType="StoredProcedure"
            UpdateCommand="[management].[sp_Contrato_update]" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="IdContrato" DbType="Int32" />
                <asp:Parameter Name="FechaInicioContrato" DbType="Date" />
                <asp:Parameter Name="FechaFinContrato" DbType="Date" />
                <asp:Parameter Name="NroContrato" DbType="String" />
                <asp:Parameter Name="IdLicitacion" DbType="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="LicitacionDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select l.IdLicitacion, upper(l.llamado) + ' | Nro. [' + cast(l.NroLicitacion as varchar(50)) + ']'  as Licitacion
                            from management.licitacion l;"
            SelectCommandType="Text"></asp:SqlDataSource>

        <!-- #endregion -->




    </div>
</asp:Content>
