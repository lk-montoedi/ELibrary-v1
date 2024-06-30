<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="ELibrary.WebForm5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-5">
                <div class="card p-3">
                    <div class="row mx-auto text-center">
                        <div class="col">
                            <img src="Images/imgs/generaluser.png" width="100" class="" alt="UserLogo">
                        </div>
                    </div>
                    <div class="row mx-auto text-center">
                        <div class="col">
                            <h4>Your Profile</h4>
                            <p>Account Status -
                                <asp:Label runat="server" class="badge rounded-pill text-bg-success" Text="Status" ID="status"></asp:Label></p>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col">
                            <div class="row g-4 mb-3">
                                <div class="col-md-6">
                                    <label for="fullName" class="form-label">Full Name</label>
                                    <asp:TextBox runat="server" ID="fullName" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label for="dob" class="form-label">Date of Birth</label>
                                    <asp:TextBox type="date" runat="server" ID="dob" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row g-4 mb-3">
                                <div class="col-md-6">
                                    <label for="contactNumber" class="form-label">Contact Number</label>
                                    <asp:TextBox type="number" runat="server" ID="contactNumber" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email Address</label>
                                    <asp:TextBox type="email" runat="server" ID="email" CssClass="form-control"></asp:TextBox>
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
                                    <asp:TextBox runat="server" type="text" class="form-control" ID="city"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label for="postCode" class="form-label">Postal Code</label>
                                    <asp:TextBox runat="server" type="text" class="form-control" ID="postCode"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <label class="form-label" for="fullAddress">Full Address</label>
                                <asp:TextBox ID="fullAddress" Rows="5" TextMode="MultiLine" runat="server" class="form-control"></asp:TextBox>
                            </div>
                            <div class="row mb-3 text-center">
                                <div class="col">
                                    <span class="badge rounded-pill text-bg-info text-center text-white">Login Credentials</span>
                                </div>
                            </div>
                            <div class="row g-4 mb-3">
                                <div class="col-md-4">
                                    <label for="memberID" class="form-label">Member ID</label>
                                    <asp:TextBox runat="server" type="text" ReadOnly="true" class="form-control bg-secondary-subtle" ID="memberID"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label for="oldPwd" class="form-label">Old Password</label>
                                    <asp:TextBox runat="server" type="text" ReadOnly="true" class="form-control bg-secondary-subtle" ID="oldPwd"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label for="newPwd" class="form-label">New Password</label>
                                    <asp:TextBox runat="server" placeholder="New Password" type="password" class="form-control" ID="newPwd"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-8 mx-auto d-grid">
                                    <asp:Button runat="server" type="submit" Text="Update" class="btn btn-primary btn-lg" ID="update" OnClick="update_Click"></asp:Button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-7">
                <div class="card p-3">
                    <div class="row mx-auto">
                        <div class="col">
                            <img src="Images/imgs/books.png" width="100" class="" alt="UserLogo">
                        </div>
                    </div>
                    <div class="row mx-auto text-center">
                        <div class="col">
                            <h4>Your Issued Books</h4>
                            <p><span class="badge rounded-pill text-bg-success">Info about book due date</span></p>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="container-fluid">
                            <asp:SqlDataSource runat="server" ID="issuedBooksDS" ConnectionString="<%$ ConnectionStrings:elibraryDBConnectionString %>" SelectCommand="SELECT [member_id], [member_name], [book_id], [book_name], [issue_date], [due_date] FROM [book_issue_tbl] WHERE ([member_id] = @member_id)">
                                <SelectParameters>
                                    <asp:SessionParameter DefaultValue="" Name="member_id" SessionField="username" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView runat="server" ID="booksTable" DataSourceID="issuedBooksDS" class="table table-bordered table-striped" AutoGenerateColumns="False" OnRowDataBound="booksTable_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="book_name" HeaderText="Book" SortExpression="book_name" />
                                    <asp:BoundField DataField="issue_date" HeaderText="Issue Date" SortExpression="issue_date" />
                                    <asp:BoundField DataField="due_date" HeaderText="Due Date" SortExpression="due_date" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <a href="Home.aspx"><< Back to Home</a>
        <br />
        <br />
    </div>

</asp:Content>
