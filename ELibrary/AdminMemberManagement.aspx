<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminMemberManagement.aspx.cs" Inherits="ELibrary.AdminMemberManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.table').prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-5">
                <div class="card p-3">
                    <div class="row mx-auto text-center">
                        <div class="col">
                            <h4>Member Details</h4>
                        </div>
                        <div class="row mx-auto text-center mb-3">
                            <div class="col">
                                <img src="Images/imgs/generaluser.png" width="100" class="" alt="UserLogo">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="row g-3 mb-3">
                                <div class="col-md-3">
                                    <label for="memberID" class="form-label">Member ID</label>
                                    <div class="input-group">
                                        <asp:TextBox runat="server" type="text"  placeholder="ID" class="form-control" ID="memberID"></asp:TextBox>
                                        <asp:Button runat="server" type="submit" Text="Go" class="btn btn-primary" ID="btnGo" OnClick="btnGo_Click"></asp:Button>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="fullName" class="form-label">Full Name</label>
                                    <asp:TextBox runat="server" ReadOnly="true" type="text" class="form-control bg-secondary-subtle" ID="fullName"></asp:TextBox>
                                </div>
                                <div class="col-md-5">
                                    <label for="status" class="form-label">Account Status</label>
                                    <div class="input-group gap-1">
                                        <asp:TextBox runat="server" ReadOnly="true" type="text" class="form-control bg-secondary-subtle" ID="status"></asp:TextBox>
                                        <asp:LinkButton runat="server" class="btn btn-success" ID="btnActive" OnClick="btnActive_Click"><i class="fa fa-check-circle-o"></i></asp:LinkButton>
                                        <asp:LinkButton runat="server" class="btn btn-warning" ID="btnPending" OnClick="btnPending_Click"><i class="fa fa-pause-circle-o"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton runat="server" class="btn btn-danger" ID="btnDeactivated" OnClick="btnDeactivated_Click"><i class="fa fa-times"></i></asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                            <div class="row g-4 mb-3">
                                <div class="col-md-3">
                                    <label for="dob" class="form-label">Date of Birth</label>
                                    <asp:TextBox runat="server" ReadOnly="true" class="form-control bg-secondary-subtle" ID="dob"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label for="contactNumber" class="form-label">Contact Number</label>
                                    <asp:TextBox runat="server" ReadOnly="true" TextMode="Phone" class="form-control bg-secondary-subtle" ID="contactNumber"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email</label>
                                    <asp:TextBox runat="server" ReadOnly="true" TextMode="Email" class="form-control bg-secondary-subtle" ID="email"></asp:TextBox>
                                </div>

                            </div>
                            <div class="row g-4 mb-3">
                                <div class="col-md-4">
                                    <label for="province" class="form-label">Province</label> 
                                    <asp:TextBox runat="server" ReadOnly="true" class="form-control bg-secondary-subtle" ID="province"></asp:TextBox>
                                </div>
                                <div class="col-md-5">
                                    <label for="city" class="form-label">City</label>
                                    <asp:TextBox runat="server" ReadOnly="true" class="form-control bg-secondary-subtle" ID="city"></asp:TextBox>
                                </div>
                                <div class="col-md-3">
                                    <label for="postalCode" class="form-label">Postal Code</label>
                                    <asp:TextBox runat="server" ReadOnly="true" TextMode="Number" class="form-control bg-secondary-subtle" ID="postalCode"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col">
                                    <label for="address" class="form-label">Full Address</label>
                                    <asp:TextBox runat="server" Rows="5" ReadOnly="true" TextMode="MultiLine" class="form-control bg-secondary-subtle" ID="address"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-8 mx-auto d-grid">
                                    <asp:Button runat="server" Text="Delete User Permanently" class="btn btn-danger btn-lg" ID="btnDeleteMember" OnClick="btnDeleteMember_Click"></asp:Button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-7">
                <div class="card p-3">
                    <div class="row mx-auto text-center">
                        <div class="col">
                            <h4>Member List</h4>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="container-fluid">
                            <asp:SqlDataSource runat="server" ID="membersDataSource" ConnectionString="<%$ ConnectionStrings:elibraryDBConnectionString %>" SelectCommand="SELECT [member_id] as Id, [full_name] as 'Name', [status] as Status, [email] as Email FROM [member_master_tbl]"></asp:SqlDataSource>
                            <asp:GridView runat="server" ID="membersTable" DataSourceID="membersDataSource" class="table table-bordered table-striped">
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
