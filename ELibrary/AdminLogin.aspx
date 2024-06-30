<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="ELibrary.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card pt-4 px-4">
                    <div class="row mx-auto">
                        <div class="col">
                            <img src="Images/imgs/adminuser.png" width="150" class="" alt="UserLogo">
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row text-center">
                            <div class="col">
                                <h3>Admin Login</h3>
                            </div>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="mb-3">
                                <label for="adminID" class="form-label">Admin ID</label>
                                <asp:TextBox type="text" CssClass="form-control" placeholder="Admin ID" ID="adminID" runat="server"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="adminPwd" class="form-label">Password</label>
                                <asp:TextBox type="password" CssClass="form-control" placeholder="Password" ID="adminPwd" runat="server"></asp:TextBox>
                            </div>
                            <div class="d-grid gap-3">
                                <asp:LinkButton runat="server" type="submit" class="btn btn-success btn-lg" OnClick="Login_Click">Login</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <a href="Home.aspx"><< Back to Home</a>
                <br />
                <br />
            </div>
        </div>
    </div>

</asp:Content>
