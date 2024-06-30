<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPublisherManagement.aspx.cs" Inherits="ELibrary.AdminPublisherManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-md-5">
                <div class="card p-3">
                    <div class="row mx-auto text-center">
                        <div class="col">
                            <h4>Publisher Details</h4>
                        </div>
                        <div class="row mx-auto text-center mb-3">
                            <div class="col">
                                <img src="Images/imgs/publisher.png" width="100" class="" alt="UserLogo">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="row g-4 mb-3">
                                <div class="col-md-4">
                                    <label for="publisherID" class="form-label">Publisher ID</label>
                                    <div class="input-group">
                                        <asp:TextBox runat="server" placeholder="ID" type="text" class="form-control" ID="publisherID"></asp:TextBox>
                                        <asp:Button runat="server" type="submit" Text="Go" class="btn btn-secondary" ID="btnGo" OnClick="btnGo_Click"></asp:Button>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <label for="publisherName" class="form-label">Publisher Name</label>
                                    <asp:TextBox runat="server" placeholder="Publisher Name" type="text" class="form-control" ID="publisherName"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mb-3 g-3">
                                <div class="col-md-4 mx-auto d-grid">
                                    <asp:Button runat="server" type="submit" Text="Add" class="btn btn-success btn-lg" ID="btnAdd" OnClick="btnAdd_Click"></asp:Button>
                                </div>
                                <div class="col-md-4 mx-auto d-grid">
                                    <asp:Button runat="server" type="submit" Text="Update" class="btn btn-primary btn-lg" ID="btnUpdate" OnClick="btnUpdate_Click"></asp:Button>
                                </div>
                                <div class="col-md-4 mx-auto d-grid">
                                    <asp:Button runat="server" type="submit" Text="Delete" class="btn btn-danger btn-lg" ID="btnDel" OnClick="btnDel_Click"></asp:Button>
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
                            <h4>Publisher List</h4>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="container-fluid">
                            <asp:SqlDataSource runat="server" ID="publishersDataSource" ConnectionString="<%$ ConnectionStrings:elibraryDBConnectionString %>" SelectCommand="SELECT publisher_id AS Id, publisher_name AS 'Publisher Name' FROM publisher_master_tbl ORDER BY publisher_name"></asp:SqlDataSource>
                            <asp:GridView runat="server" ID="publishersTable" DataSourceID="publishersDataSource" class="table table-bordered table-striped">
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
