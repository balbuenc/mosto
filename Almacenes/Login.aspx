<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Almacenes.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - Almacenes</title>
    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css" />

    <!-- Custom styles for this template-->
    <link href="css/sb-admin.css" rel="stylesheet" />
</head>
<body class="bg-dark">
    <form id="form1" runat="server">
        <div class="container">
            <div class="card card-login mx-auto mt-5">
                <div class="card-header">Almacenes | Login</div>
                <div class="card-body">

                    <div class="form-group">
                        <div class="form-label-group">
                            Usuario:
                                <asp:TextBox ID="UsernameTextbox" CssClass="form-control" runat="server" />

                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-label-group">
                            Contraseña:
                               
                            <asp:TextBox ID="PasswordTextbox" runat="server" TextMode="Password" CssClass="form-control" />

                        </div>
                    </div>
                    <asp:Button ID="LoginButton" Text="Login" OnClick="Login_OnClick" runat="server" CssClass="btn btn-primary btn-block" />

                    <div class="text-center">
                        <asp:Label ID="Msg" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
</body>
</html>
