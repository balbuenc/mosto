<%@ Page Title="Tipo de Licitaciones" Language="C#" MasterPageFile="~/Boot.Master" AutoEventWireup="true" CodeBehind="TipoLicitaciones.aspx.cs" Inherits="Almacenes.Management.TipoLicitaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/bootstrap.css" rel="stylesheet" />
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="alert alert-primary" role="alert">
            <b><%: Page.Title %> </b>
        </div>
    </div>
     <div class="container-fluid">
        <div style="width: 90%; margin-right: 5%; margin-left: 5%; text-align: center">
            <asp:ScriptManager runat="server" ID="ScriptManager1"/>
            <asp:UpdatePanel ID="upCrudGrid" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="grdvCrudOperation" runat="server" Width="940px" HorizontalAlign="Center"
                        AutoGenerateColumns="false" AllowPaging="true"
                        DataKeyNames="ID" CssClass="table table-hover table-striped">
                        <Columns>
                            <asp:ButtonField CommandName="detail" ControlStyle-CssClass="btn btn-info" ButtonType="Button" Text="Detail" HeaderText="Detailed View">
                                <ControlStyle CssClass="btn btn-info"></ControlStyle>
                            </asp:ButtonField>

                            <asp:ButtonField CommandName="editRecord" ControlStyle-CssClass="btn btn-info" ButtonType="Button" Text="Edit" HeaderText="Edit Record">
                                <ControlStyle CssClass="btn btn-info"></ControlStyle>
                            </asp:ButtonField>
                            <asp:ButtonField CommandName="deleteRecord" ControlStyle-CssClass="btn btn-info" ButtonType="Button" Text="Delete" HeaderText="Delete Record">
                                <ControlStyle CssClass="btn btn-info"></ControlStyle>
                            </asp:ButtonField>
                            <asp:BoundField DataField="ID" HeaderText="ID"/>
                            <asp:BoundField DataField="Name" HeaderText="Name"/>
                            <asp:BoundField DataField="EmailID" HeaderText="EmailID"/>
                            <asp:BoundField DataField="Address" HeaderText="Address"/>
                            <asp:BoundField DataField="Contact" HeaderText="Contact NO"/>
                        </Columns>
                    </asp:GridView>
                    <asp:Button ID="btnAdd" runat="server" Text="Agregar Licitación" CssClass="btn btn-info  btn-sm" OnClick="btnAdd_Click" />
                </ContentTemplate>
                <Triggers>
                </Triggers>
            </asp:UpdatePanel>



            <div id="detailModal" class="modal hide fade"tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 id="myModalLabel">Details</h3>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:DetailsView ID="DetailsView1" runat="server" CssClass="table table-bordered table-hover" BackColor="White" ForeColor="Black" FieldHeaderStyle-Wrap="false" FieldHeaderStyle-Font-Bold="true" FieldHeaderStyle-BackColor="LavenderBlush" FieldHeaderStyle-ForeColor="Black" BorderStyle="Groove" AutoGenerateRows="False">

                               <Fields>
                                    <asp:BoundField DataField="Name" HeaderText="Name"/>
                                    <asp:BoundField DataField="EmailID" HeaderText="EmailID"/>
                                    <asp:BoundField DataField="Address" HeaderText="Address"/>
                                    <asp:BoundField DataField="Contact" HeaderText="Contact NO"/>
                                </Fields>
                            </asp:DetailsView>
                        </ContentTemplate>

                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="grdvCrudOperation" EventName="RowCommand"/>
                            <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click"/>

                        </Triggers>
                    </asp:UpdatePanel>
                    <div class="modal-footer">
                        <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>
                    </div>
                </div>
            </div>

            <div id="editModal" class="modal hide fade"tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 id="editModalLabel">Edit Record</h3>
                </div>
                <asp:UpdatePanel ID="upEdit" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            <asp:HiddenField ID="HfUpdateID" runat="server"/>
                            <table class="table">
                                <tr>
                                    <td>Name : </td>
                                    <td>
                                        <asp:TextBox ID="txtNameUpdate" runat="server"></asp:TextBox></td>

                                    <td>
                                </tr>
                                <tr>    <td>EmailID</td>

                                    <td>
                                        <asp:TextBox ID="txtEmailIDUpdate" runat="server"></asp:TextBox></td>

                                </tr>
                                <tr>
                                    <td>Address</td>
                                    <td>
                                        <asp:TextBox ID="txtAddressUpdate" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>Contact No</td>
                                    <td>
                                        <asp:TextBox ID="txtContactUpdate" runat="server"></asp:TextBox></td>

                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <asp:Label ID="lblResult" Visible="false" runat="server"></asp:Label>
                            <asp:Button ID="btnSave" runat="server" Text="Update" CssClass="btn btn-info" />
                            <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>

                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="grdvCrudOperation" EventName="RowCommand"/>
                        <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click"/>
                    </Triggers>
                </asp:UpdatePanel>
            </div>


            <div id="addModal" class="modal hide fade"tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 id="addModalLabel">Add New Record</h3>
                </div>
                <asp:UpdatePanel ID="upAdd" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            <table class="table table-bordered table-hover">
                                <tr>     <td>Name : </td>
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
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnAddRecord" EventName="Click"/>
                    </Triggers>
                </asp:UpdatePanel>

            </div>

            <div id="deleteModal" class="modal hide fade"tabindex="-1" role="dialog" aria-labelledby="delModalLabel" aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 id="delModalLabel">Delete Record</h3>
                </div>
                <asp:UpdatePanel ID="upDel" runat="server">
                    <ContentTemplate>
                        <div class="modal-body">
                            Are you sure you want to delete the record?
                            <asp:HiddenField ID="HfDeleteID" runat="server"/>
                        </div>

                        <div class="modal-footer">
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-info" />
                            <buttonclass="btn btn-info" data-dismiss="modal" aria-hidden="true">Cancel</button>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click"/>
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

</asp:Content>
