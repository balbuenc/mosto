<%@ Page Title="Libro diario" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="Diario.aspx.cs" Inherits="Almacenes.Diario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="fondo">
        <div class="page-header  encabezado">
            <div class="container-fluid">
                <asp:Panel runat="server" DefaultButton="SearchBtn">
                    <div class="row">
                        <div class="col-4 font-weight-bold">
                            Palabra clave
                        </div>
                        <div class="col-2 font-weight-bold">
                            Criterio
                        </div>
                        <div class="col-2 font-weight-bold">
                            Desde
                        </div>
                        <div class="col-2 font-weight-bold">
                           Hasta
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-4">
                            <asp:TextBox ID="txtSearchKey" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-2">
                            <asp:DropDownList ID="searchParameterDDL" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Asiento" Value="DESCRIPCION"></asp:ListItem>
                                <asp:ListItem Text="Lote" Value="LOTE"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-2">
                            <asp:TextBox ID="txtFechaInicio" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-2">
                            <asp:TextBox ID="txtFechaFin" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-2">
                            <div class="btn-group btn-shadow">
                                <asp:LinkButton CssClass="btn btn-primary btn-border" runat="server" ID="SearchBtn" onserverclick="SearchBtn_ServerClick" ToolTip="Buscar">
                                <div class="form-row">
                                
                                <i class="fas fa-search fa-sm" style="padding:5px"></i>
                              </div>
                                </asp:LinkButton>

                               
                                <div class="btn-group" role="group">
                                    <button id="btnGroupDrop1" type="button" class="btn btn-primary dropdown-toggle btn-border" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        #
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                        <a class="dropdown-item" href="/Diario.aspx?PageSize=10" runat="server">10</a>
                                        <a class="dropdown-item" href="/Diario.aspx?PageSize=20" runat="server">20</a>
                                        <a class="dropdown-item" href="/Diario.aspx?PageSize=30" runat="server">30</a>
                                        <a class="dropdown-item" href="/Diario.aspx?PageSize=50" runat="server">50</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </asp:Panel>
            </div>
            <div class="row">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
            </div>

        </div>

        <div class="container-fluid">
            <div class="row pie" style="padding-left: 15px">
                <asp:DataPager ID="DiarioDataPager" runat="server" PagedControlID="DiarioListView" PageSize="10">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                        <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm font-weight-bold  border" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                        <asp:NextPreviousPagerField ButtonCssClass="btn btn-primary btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
                    </Fields>
                </asp:DataPager>
            </div>

            <asp:ListView ID="DiarioListView"
                runat="server"
                DataSourceID="DiarioDS"
                DataKeyNames="IdDiario"
                OnItemCommand="ListView_ItemCommand">
                <LayoutTemplate>
                    <div class="table table-responsive">
                        <table class="table table-striped table-condensed">
                            <thead>
                                <th>ID</th>
                                <th>Asiento</th>
                                <th>Fecha</th>
                                <th>Lote</th>
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
                            <asp:Label ID="lblIdDiario" runat="server" Text='<%# Eval("IdDiario") %>' /></td>
                        <td>
                            <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("Descripcion") %>' /></td>
                        <td>
                            <asp:Label ID="lblFecha" runat="server" Text='<%# DateTime.Parse( Eval("Fecha").ToString()).ToShortDateString() %>' /></td>
                       
                        <td>
                            <asp:Label ID="lblLote" runat="server" Text='<%# Eval("IdLote") %>' /></td>
                        

                        <td>
                            <asp:LinkButton runat="server" ID="EditDiarioBtn" CommandName="Edit" CommandArgument='<%# Eval("IdDiario")%>' ToolTip="Editar">
                            <i class="fa fa-edit" aria-hidden="true"></i>

                            </asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton runat="server" ID="DetailsDiarioBtn" CommandName="Editar" CommandArgument='<%# Eval("IdDiario")%>' ToolTip="Ver detalles">
                            <i class="fa fa-keyboard fa-sm"></i>
                            </asp:LinkButton>
                        </td>

                      

                    </tr>

                </ItemTemplate>
                <EditItemTemplate>
                    <tr>
                        <td>
                            <asp:Label ID="lblIdDiario" runat="server" Text='<%# Eval("IdDiario") %>' /></td>
                        <td>
                            <asp:TextBox ID="txtDescripcion" runat="server" Text='<%# Bind("Descripcion") %>'  CssClass="form-control"/></td>
                        <td>
                            <asp:label ID="lblFecha" runat="server" Text='<%# DateTime.Parse( Eval("Fecha").ToString()).ToShortDateString() %>' />
                            
                        </td>
                        <td>
                            <asp:Label ID="lblLote" runat="server" Text='<%# Eval("IdLote")  %>' />
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
            <asp:SqlDataSource ID="DiarioDS"
                runat="server" ConnectionString="<%$ ConnectionStrings:AlmacenesConnectionString %>"
                SelectCommand="accounting.sp_Diario_get_all" SelectCommandType="StoredProcedure"
                UpdateCommand="[accounting].[sp_Diario_update]" UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                </DeleteParameters>
                <InsertParameters>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="IdDiario" DbType="Int32" />
                   
                    <asp:Parameter Name="Descripcion" DbType="String" />
                    
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtSearchKey" PropertyName="Text" Name="key" DefaultValue="*" />
                    <asp:ControlParameter ControlID="searchParameterDDL" PropertyName="SelectedValue" Name="parameter" />
                    <asp:ControlParameter ControlID="txtFechaInicio" PropertyName="Text" Name="Desde" Type="DateTime" />
                    <asp:ControlParameter ControlID="txtFechaFin" PropertyName="Text" Name="Hasta" Type="DateTime" />
                </SelectParameters>
            </asp:SqlDataSource>

           

            <!-- #endregion -->




        </div>
    </div>
</asp:Content>
