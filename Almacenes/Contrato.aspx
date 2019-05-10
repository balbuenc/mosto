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
                    <button class="btn btn-primary" type="button" runat="server" id="AddLicitacionBtn" onserverclick="AddLicitacionBtn_ServerClick" >
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
                        <asp:Label ID="lblFechaInicioContrato" runat="server" Text='<%# Eval("FechaInicioContrato") %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaFinContrato" runat="server" Text='<%# Eval("FechaFinContrato") %>' /></td>
                    <td>
                        <asp:Label ID="lblNroContrato" runat="server" Text='<%# Eval("NroContrato") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdLicitacion" runat="server" Text='<%# Eval("Licitacion") %>' /></td>

                    <td>
                        <asp:LinkButton runat="server" ID="EditContratoBtn" CommandName="Editar" CommandArgument='<%# Eval("IdContrato")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton runat="server" ID="DeleteContratoBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdContrato")%>' ToolTip="Eliminar">
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
        <asp:SqlDataSource ID="ContratoDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            InsertCommand="management.sp_Contrato_insert" InsertCommandType="StoredProcedure"
            SelectCommand="management.sp_Contrato_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Contrato" Type="String" />
                <asp:Parameter Name="Descripcion" Type="String" />
                <asp:Parameter Name="Activo" Type="String" />
            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>


        <!-- #endregion -->




    </div>
</asp:Content>
