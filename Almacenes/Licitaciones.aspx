<%@ Page Title="Licitaciones" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Licitaciones.aspx.cs" Inherits="Almacenes.Management.Licitaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="alert alert-primary" role="alert">
            <div class="row">
                <div class="col-11">
                    <b><%: Page.Title %> </b>
                    <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="msg-box bg-danger" />
                </div>
                <div class="col-1">
                    <button class="btn btn-primary" type="button" runat="server" id="AddLicitacionBtn"  onserverclick="AddLicitacionBtn_ServerClick">
                        <i class="fas fa-plus"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <asp:ListView ID="LicitacionListView"
            runat="server"
            DataSourceID="LicitacionDS"
            DataKeyNames="IdTipoLicitacion"
            InsertItemPosition="FirstItem">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped" style="font-size: x-small; font-family: 'Segoe UI'">
                        <thead>
                            <th>ID</th>
                            <th>Número</th>
                            <th>Fecha</th>
                            <th>IdTipoLicitacion</th>
                            <th>UOCReferancia</th>
                            <th>UOCIdLicitacion</th>
                            <th>Activo</th>
                            <th>Desactivación</th>
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
                        <asp:Label ID="lblIdLicitacion" runat="server" Text='<%# Eval("IdLicitacion") %>' /></td>
                    <td>
                        <asp:Label ID="lblNroLicitacion" runat="server" Text='<%# Eval("NroLicitacion") %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaLicitacion" runat="server" Text='<%# Eval("FechaLicitacion") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdTipoLicitacion" runat="server" Text='<%# Eval("IdTipoLicitacion") %>' /></td>
                    <td>
                        <asp:Label ID="lblUOCReferancia" runat="server" Text='<%# Eval("UOCReferancia") %>' /></td>
                    <td>
                        <asp:Label ID="lblUOCIdLicitacion" runat="server" Text='<%# Eval("UOCIdLicitacion") %>' /></td>
                    <td>
                        <asp:Label ID="lblActivo" runat="server" Text='<%# Eval("Activo") %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaDesactivacion" runat="server" Text='<%# Eval("FechaDesactivacion") %>' /></td>

                    <td class="text-right">
                        <asp:Button ID="EditButton" runat="server" Text="Editar" CommandName="Edit" CssClass="btn btn-info" />
                        <asp:Button ID="DeleteButton" runat="server" Text="Borrar" CommandName="Delete" CssClass="btn btn-danger" />
                    </td>
                </tr>
            </ItemTemplate>
            <EditItemTemplate>
                <tr>
                    <td>
                        <asp:TextBox ID="txtIdLicitacion" runat="server" Text='<%# Bind("IdLicitacion") %>' CssClass="form-control" Font-Size="X-Small" /></td>
                    <td>
                        <asp:TextBox ID="txtNroLicitacion" runat="server" Text='<%# Bind("NroLicitacion") %>' CssClass="form-control" Font-Size="X-Small" /></td>
                    <td>
                        <asp:TextBox ID="txtFechaLicitacion" runat="server" Text='<%# Bind("FechaLicitacion") %>' CssClass="form-control" Font-Size="X-Small" /></td>
                    <td>
                        <asp:TextBox ID="txtIdTipoLicitacion" runat="server" Text='<%# Bind("IdTipoLicitacion") %>' CssClass="form-control" Font-Size="X-Small" /></td>
                    <td>
                        <asp:TextBox ID="txtUOCReferancia" runat="server" Text='<%# Bind("UOCReferancia") %>' CssClass="form-control" Font-Size="X-Small" /></td>
                    <td>
                        <asp:TextBox ID="txtUOCIdLicitacion" runat="server" Text='<%# Bind("UOCIdLicitacion") %>' CssClass="form-control" Font-Size="X-Small" /></td>
                    <td>
                        <asp:TextBox ID="txtActivo" runat="server" Text='<%# Bind("Activo") %>' CssClass="form-control" Font-Size="X-Small" /></td>
                    <td>
                        <asp:TextBox ID="txtFechaDesactivacion" runat="server" Text='<%# Bind("FechaDesactivacion") %>' CssClass="form-control" Font-Size="X-Small" /></td>


                    <td class="text-right">
                        <asp:Button ID="UpdateButton" runat="server" Text="Guardar" CommandName="Update" CssClass="btn btn-info" />
                        <asp:Button ID="CancelButton" runat="server" Text="Cancelar" CommandName="Cancel" CssClass="btn" />
                    </td>
                </tr>
            </EditItemTemplate>
            <InsertItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="txtIdLicitacion" runat="server" Text="" CssClass="form-control" Font-Size="X-Small" /></td>
                    <td>
                        <asp:TextBox ID="txtNroLicitacion" runat="server" Text='<%# Bind("NroLicitacion") %>' CssClass="form-control" Font-Size="X-Small" /></td>
                    <td>
                        <asp:TextBox ID="txtFechaLicitacion" runat="server" Text='<%# Bind("FechaLicitacion") %>' CssClass="form-control" Font-Size="X-Small" /></td>
                    <td>
                        <asp:TextBox ID="txtIdTipoLicitacion" runat="server" Text='<%# Bind("IdTipoLicitacion") %>' CssClass="form-control" Font-Size="X-Small" /></td>
                    <td>
                        <asp:TextBox ID="txtUOCReferancia" runat="server" Text='<%# Bind("UOCReferancia") %>' CssClass="form-control" Font-Size="X-Small" /></td>
                    <td>
                        <asp:TextBox ID="txtUOCIdLicitacion" runat="server" Text='<%# Bind("UOCIdLicitacion") %>' CssClass="form-control" Font-Size="X-Small" /></td>
                    <td>
                        <asp:TextBox ID="txtActivo" runat="server" Text='<%# Bind("Activo") %>' CssClass="form-control" Font-Size="X-Small" /></td>
                    <td>
                        <asp:TextBox ID="txtFechaDesactivacion" runat="server" Text='<%# Bind("FechaDesactivacion") %>' CssClass="form-control" Font-Size="X-Small" /></td>



                    <td>
                        <asp:Button ID="InsertButton" runat="server" Text="Agregar" CommandName="Insert" CssClass="btn btn-success" />
                    </td>

                </tr>

            </InsertItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="LicitacionDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            DeleteCommand="management.sp_licitacion_delete" DeleteCommandType="StoredProcedure"
            InsertCommand="management.sp_licitacion_insert" InsertCommandType="StoredProcedure"
            SelectCommand="management.sp_licitacion_get_all" SelectCommandType="StoredProcedure"
            UpdateCommand="management.sp_licitacion_update" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="IdLicitacion" Type="Int64" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="NroLicitacion" Type="Int32" />
                <asp:Parameter DbType="Date" Name="FechaLicitacion" />
                <asp:Parameter Name="IdTipoLicitacion" Type="Int16" />
                <asp:Parameter Name="UOCReferancia" Type="String" />
                <asp:Parameter Name="UOCIdLicitacion" Type="String" />
                <asp:Parameter Name="Activo" Type="String" />
                <asp:Parameter DbType="Date" Name="FechaDesactivacion" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="IdLicitacion" Type="Int32" />
                <asp:Parameter Name="NroLicitacion" Type="Int32" />
                <asp:Parameter DbType="Date" Name="FechaLicitacion" />
                <asp:Parameter Name="IdTipoLicitacion" Type="Int16" />
                <asp:Parameter Name="UOCReferancia" Type="String" />
                <asp:Parameter Name="UOCIdLicitacion" Type="String" />
                <asp:Parameter Name="Activo" Type="String" />
                <asp:Parameter DbType="Date" Name="FechaDesactivacion" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>

    <div id="addModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="addModalLabel">Add New Record</h3>
        </div>
       
                <div class="modal-body">
                    <table class="table table-bordered table-hover">
                        <tr>
                            <td>Name : </td>
                            <td>
                                <asp:TextBox ID="txtNameAdd" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>EmailID :</td>
                            <td>
                                <asp:TextBox ID="txtEmailIDAdd" runat="server"></asp:TextBox></td>

                        </tr>
                        <tr>
                            <td>Address:</td>
                            <td>
                                <asp:TextBox ID="txtAddressAdd" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>Contact No:</td>
                            <td>
                                <asp:TextBox ID="txtContactAdd" runat="server"></asp:TextBox></td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnAddRecord" runat="server" Text="Add" CssClass="btn btn-info" />
                    <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>

                </div>
           
          
       

    </div>

</asp:Content>
