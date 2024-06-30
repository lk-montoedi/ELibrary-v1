<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminAuthorManagement.aspx.cs" Inherits="ELibrary.AdminAuthorManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.table').prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();
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
                            <h4>Author Details</h4>
                        </div>
                        <div class="row mx-auto text-center mb-3">
                            <div class="col">
                                <img src="Images/imgs/writer.png" width="100" class="" alt="UserLogo">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="row g-4 mb-3">
                                <div class="col-md-4">
                                    <label for="authorID" class="form-label">Author ID</label>
                                    <div class="input-group">
                                        <asp:TextBox runat="server" placeholder="ID" type="text" class="form-control" ID="authorID"></asp:TextBox>
                                        <asp:Button runat="server" type="submit" Text="Go" class="btn btn-secondary" ID="btnGo" OnClick="btnGo_Click"></asp:Button>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <label for="authorName" class="form-label">Author Name</label>
                                    <asp:TextBox runat="server" placeholder="Author Name" type="text" class="form-control" ID="authorName"></asp:TextBox>
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
                            <h4>Author List</h4>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="container-fluid">
                            <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:elibraryDBConnectionString %>" SelectCommand="SELECT [author_id] AS Id, [author_name] AS 'Author Name' FROM [author_master_tbl] ORDER BY [author_name]" ID="authorDataSource"></asp:SqlDataSource>
                            <asp:GridView runat="server" ID="authorsTable" DataSourceID="authorDataSource" class="table table-bordered table-striped">
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
