<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminBookIssuing.aspx.cs" Inherits="ELibrary.AdminBookIssuing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.table').prepend($('<thead></thead>').append($(this).find("tr:first"))).DataTable();
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
                            <h4>Book Issuing</h4>
                        </div>
                        <div class="row mx-auto text-center mb-3">
                            <div class="col">
                                <img src="Images/imgs/books.png" width="100" class="" alt="UserLogo">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="row g-4 mb-3">
                                <div class="col-md-6">
                                    <label for="memberID" class="form-label">Member ID</label>
                                    <asp:TextBox runat="server" placeholder="Member ID" type="text" class="form-control" ID="memberID"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label for="bookID" class="form-label">Book ID</label>
                                    <div class="input-group">
                                        <asp:TextBox runat="server" placeholder="Book ID" type="text" class="form-control" ID="bookID"></asp:TextBox>
                                        <asp:Button runat="server" type="submit" Text="Go" class="btn btn-primary" ID="btnGo" OnClick="btnGo_Click"></asp:Button>
                                    </div>
                                </div>
                            </div>
                            <div class="row g-4 mb-3">
                                <div class="col-md-6">
                                    <label for="memberName" class="form-label">Member Name</label>
                                    <asp:TextBox runat="server" ReadOnly="true" placeholder="Member Name" type="text" class="form-control bg-secondary-subtle" ID="memberName"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label for="bookName" class="form-label">Book Name</label>
                                    <asp:TextBox runat="server" ReadOnly="true" placeholder="Book Name" type="text" class="form-control bg-secondary-subtle" ID="bookName"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row g-4 mb-3">
                                <div class="col-md-6">
                                    <label for="startDate" class="form-label">Start Date</label>
                                    <asp:TextBox runat="server" TextMode="Date" class="form-control" ID="startDate"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label for="endDate" class="form-label">End Date</label>
                                    <asp:TextBox runat="server" TextMode="Date" class="form-control" ID="endDate"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mb-3 g-3">
                                <div class="col-md-6 mx-auto d-grid">
                                    <asp:Button runat="server" type="submit" Text="Issue" class="btn btn-primary btn-lg" ID="btnIssue" OnClick="btnIssue_Click"></asp:Button>
                                </div>
                                <div class="col-md-6 mx-auto d-grid">
                                    <asp:Button runat="server" type="submit" Text="Return" class="btn btn-success btn-lg" ID="btnReturn" OnClick="btnReturn_Click"></asp:Button>
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
                            <h4>Issue Book List</h4>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="container-fluid">
                            <asp:SqlDataSource runat="server" ID="bookIssueDS" ConnectionString="<%$ ConnectionStrings:elibraryDBConnectionString %>" SelectCommand="SELECT member_id AS 'Member Id', member_name AS 'Member Name', book_id AS 'Book Id', book_name AS 'Book Name', issue_date AS 'Issue Date', due_date AS 'Due Date' FROM book_issue_tbl"></asp:SqlDataSource>
                            <asp:GridView runat="server" ID="booksTable" class="table table-bordered table-striped" DataSourceID="bookIssueDS" AutoGenerateColumns="False" OnRowDataBound="booksTable_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="Member Id" HeaderText="Member Id" ReadOnly="True" SortExpression="Member Id" />
                                    <asp:BoundField DataField="Member Name" HeaderText="Member Name" SortExpression="Member Name" />
                                    <asp:BoundField DataField="Book Id" HeaderText="Book Id" ReadOnly="True" SortExpression="Book Id" />
                                    <asp:BoundField DataField="Book Name" HeaderText="Book Name" SortExpression="Book Name" />
                                    <asp:BoundField DataField="Issue Date" HeaderText="Issue Date" SortExpression="Issue Date" />
                                    <asp:BoundField DataField="Due Date" HeaderText="Due Date" SortExpression="Due Date" />
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
