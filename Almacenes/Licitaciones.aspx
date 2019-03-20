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
                    <button class="btn btn-primary" type="button" runat="server" id="AddLicitacionBtn" data-toggle="modal" data-target="#addModal">
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
            DataKeyNames="IdTipoLicitacion">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped" style="font-size: x-small; font-family: 'Segoe UI'">
                        <thead>
                            <th>ID</th>
                            <th>Número</th>
                            <th>Fecha</th>
                            <th>Tipo</th>
                            <th>Referancia (UOC)</th>
                            <th>ID (UOC)</th>
                            <th>Activo</th>
                            <th>Fecha Desactivación</th>
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
                        <asp:Label ID="lblIdLicitacion" runat="server" Text='<%# Eval("IdLicitacion") %>' /></td>
                    <td>
                        <asp:Label ID="lblNroLicitacion" runat="server" Text='<%# Eval("NroLicitacion") %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaLicitacion" runat="server" Text='<%# String.Format("{0:d}",Eval( "FechaLicitacion") ) %>' /></td>
                    <td>
                        <asp:Label ID="lblIdTipoLicitacion" runat="server" Text='<%# Eval("TipoLicitacion") %>' /></td>
                    <td>
                        <asp:Label ID="lblUOCReferancia" runat="server" Text='<%# Eval("UOCReferancia") %>' /></td>
                    <td>
                        <asp:Label ID="lblUOCIdLicitacion" runat="server" Text='<%# Eval("UOCIdLicitacion") %>' /></td>
                    <td>
                        <asp:Label ID="lblActivo" runat="server" Text='<%# Eval("Activo") %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaDesactivacion" runat="server" Text='<%# Eval("FechaDesactivacion") %>' /></td>

                    <td>
                        <div class="col-1">
                            <button class="btn btn-primary btn-sm" type="button" runat="server" id="EditLicitacionBtn" data-toggle="modal" data-target="#editModal">
                                <i class="fas fa-highlighter"></i>
                            </button>
                        </div>
                    </td>
                    <td>
                        <div class="col-1">
                            <button class="btn btn-primary btn-sm" type="button" runat="server" id="DeleteLicitacionBtn" data-toggle="modal" data-target="#logoutModal">
                                <i class="fas fa-window-close"></i>
                            </button>
                        </div>
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
                                <b id="addModalLabel">Agregar nueva licitación.</b>
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
                                                    <asp:TextBox ID="txtNroLicitacion" runat="server" Text='<%# Bind("NroLicitacion") %>' CssClass="form-control" Font-Size="X-Small" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Fecha</b></div>
                                                <div class="col-9">
                                                    <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("FechaLicitacion") %>'></asp:Calendar>
                                                    <%--<asp:TextBox ID="txtFechaLicitacion" runat="server" Text='<%# Bind("FechaLicitacion") %>' CssClass="form-control" Font-Size="X-Small" />--%>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-3"><b>Referencia (UOC)</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtUOCReferancia" runat="server" Text='<%# Bind("UOCReferancia") %>' CssClass="form-control" Font-Size="X-Small" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>ID (UOC)</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtUOCIdLicitacion" runat="server" Text='<%# Bind("UOCIdLicitacion") %>' CssClass="form-control" Font-Size="X-Small" />
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
                                <asp:FormView ID="EditFormView" runat="server" DataSourceID="LicitacionDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdLicitacion" ForeColor="#333333"
                                    DefaultMode="Edit">
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
                                                    <asp:TextBox ID="txtNroLicitacion" runat="server" Text='<%# Bind("NroLicitacion") %>' CssClass="form-control" Font-Size="X-Small" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>Fecha</b></div>
                                                <div class="col-9">
                                                    <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("FechaLicitacion") %>'></asp:Calendar>

                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-3"><b>Referencia (UOC)</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtUOCReferancia" runat="server" Text='<%# Bind("UOCReferancia") %>' CssClass="form-control" Font-Size="X-Small" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3"><b>ID (UOC)</b></div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtUOCIdLicitacion" runat="server" Text='<%# Bind("UOCIdLicitacion") %>' CssClass="form-control" Font-Size="X-Small" />
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


                                        <asp:LinkButton ID="AcceptButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Aceptar" CssClass="btn btn-success" />
                                        <asp:LinkButton ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancelar" Text="Cancelar" CssClass="btn btn-danger" />
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

        <asp:SqlDataSource ID="TipoLicitacionDS" runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
            SelectCommand="select IdTipoLicitacion, TipoLicitacion from management.TipoLicitacion order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <!-- #endregion -->


    </div>

</asp:Content>
