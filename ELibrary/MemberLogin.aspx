<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MemberLogin.aspx.cs" Inherits="ELibrary.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card pt-4 px-4">
                    <div class="row mx-auto">
                        <div class="col">
                            <img src="Images/imgs/generaluser.png" width="150" class="" alt="UserLogo">
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row text-center">
                            <div class="col">
                                <h3>Member Login</h3>
                            </div>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="mb-3">
                                <label for="memberID" class="form-label">Member ID</label>
                                <asp:TextBox type="text" CssClass="form-control" placeholder="Member ID" ID="memberID" runat="server"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="memberPwd" class="form-label">Password</label>
                                <asp:TextBox type="password" CssClass="form-control" placeholder="Password" ID="memberPwd" runat="server"></asp:TextBox>
                            </div>
                            <div class="d-grid gap-3">
                                <asp:Button type="submit" class="btn btn-success btn-lg" OnClick="MemberLogin_Click" Text="Login" runat="server" ID="login"></asp:Button>
                                <asp:Button runat="server" type="submit" class="btn btn-primary btn-lg" id="signup" Text="Sign Up" onclick="signup_Click"></asp:Button>
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
