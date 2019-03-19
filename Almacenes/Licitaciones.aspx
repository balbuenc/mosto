﻿<%@ Page Title="Licitaciones" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Licitaciones.aspx.cs" Inherits="Almacenes.Management.Licitaciones" %>

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


        <div id="addModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <b id="addModalLabel">Agregar nueva licitación.</b>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    </div>

                    <div class="modal-body">
                        <asp:FormView ID="FormView1" runat="server" DataSourceID="LicitacionDS" Width="100%"
                            CellPadding="4" DataKeyNames="IdLicitacion" ForeColor="#333333"
                            DefaultMode="Insert">
                            <EditItemTemplate>
                            </EditItemTemplate>
                            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <InsertItemTemplate>
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-3">Tipo:</div>
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


                                            <div class="form-control">
                                                <input type="text" placeholder="click to show datepicker" id="Demo">
                                            </div>


                                            <script type="text/javascript">
                                                // When the document is ready
                                                $(document).ready(function () {

                                                    $('#Demo').datepicker({
                                                        format: "dd/mm/yyyy"
                                                    });

                                                });
                                            </script>
                                            <%--<asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("FechaLicitacion") %>'    ></asp:Calendar>--%>
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

                                <br />
                                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            </InsertItemTemplate>
                            <ItemTemplate>
                            </ItemTemplate>
                            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />


                        </asp:FormView>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnAddRecord" runat="server" Text="Add" CssClass="btn btn-info" />
                        <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>

                    </div>

                </div>

            </div>

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
        </div>


        <!-- #endregion -->
    </div>

</asp:Content>
