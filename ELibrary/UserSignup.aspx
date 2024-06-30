<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserSignup.aspx.cs" Inherits="ELibrary.WebForm4" EnableEventValidation="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="card pt-4 px-4">
                    <div class="row mx-auto">
                        <div class="col">
                            <img src="Images/imgs/generaluser.png" width="100" class="" alt="UserLogo">
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row text-center">
                            <div class="col">
                                <h4>User Registration</h4>
                            </div>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="col">
                                <div class="row g-4 mb-3">
                                    <div class="col-md-6">
                                        <label for="fullName" class="form-label">Full Name</label>
                                        <asp:TextBox runat="server" type="text" placeholder="Full Name" class="form-control" ID="fullName"></asp:TextBox>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="dob" class="form-label">Date of Birth</label>
                                        <asp:TextBox runat="server" type="date" placeholder="Date of Birth" class="form-control" ID="dob"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row g-4 mb-3">
                                    <div class="col-md-6">
                                        <label for="contactNumber" class="form-label">Contact Number</label>
                                        <asp:TextBox runat="server" type="number" placeholder="Contact Number" class="form-control" ID="contactNumber"></asp:TextBox>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="email" class="form-label">Email Address</label>
                                        <asp:TextBox runat="server" type="email" placeholder="Email Address" class="form-control" ID="email"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row g-4 mb-3">
                                    <div class="col-md-4">
                                        <label for="province" class="form-label">Province</label>
                                        <asp:DropDownList runat="server" ID="province" class="form-select">
                                            <asp:ListItem Selected="True" Text="Selected" />
                                            <asp:ListItem Value="Gauteng" Text="Gauteng" />
                                            <asp:ListItem Value="Limpopo" Text="Limpopo" />
                                            <asp:ListItem Value="North West" Text="North West" />
                                            <asp:ListItem Value="Mpumalanga" Text="Mpumalanga" />
                                            <asp:ListItem Value="Western Cape" Text="Western Cape" />
                                            <asp:ListItem Value="KwaZulu Natal" Text="KwaZulu Natal" />
                                            <asp:ListItem Value="Eastern Cape" Text="Eastern Cape" />
                                            <asp:ListItem Value="Northern Cape" Text="Northern Cape" />
                                            <asp:ListItem Value="Free State" Text="Free State" />
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="city" class="form-label">City</label>
                                        <asp:TextBox runat="server" type="text" placeholder="City" class="form-control" ID="city"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="postCode" class="form-label">Postal Code</label>
                                        <asp:TextBox runat="server" type="text" placeholder="Postal Code" class="form-control" ID="postCode"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class="form-label" for="fullAddress">Full Address</label>
                                    <asp:TextBox ID="fullAddress" TextMode="MultiLine" runat="server" placeholder="Full Address" class="form-control"></asp:TextBox>
                                </div>
                                <div class="row mb-3">
                                    <span class="col-3 mx-auto badge rounded-pill text-bg-info text-center text-white">Login Credentials</span>
                                </div>
                                <div class="row g-4 mb-3">
                                    <div class="col-md-6">
                                        <label for="userID" class="form-label">User ID</label>
                                        <asp:TextBox runat="server" type="text" placeholder="User ID" class="form-control" ID="userID"></asp:TextBox>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="password" class="form-label">Password</label>
                                        <asp:TextBox runat="server" type="password" placeholder="Password" class="form-control" ID="password"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="d-grid gap-3">
                                    <asp:Button runat="server" type="submit" Text="Sign Up" class="btn btn-success btn-lg" ID="signup" OnClick="signup_Click"></asp:Button>
                                </div>
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
