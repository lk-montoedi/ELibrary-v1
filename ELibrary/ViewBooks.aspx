<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewBooks.aspx.cs" Inherits="ELibrary.ViewBooks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-10 mx-auto">
                <div class="card p-3">
                    <div class="row mx-auto text-center">
                        <div class="col">
                            <h1>Books List</h1>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="container-fluid">
                            <asp:SqlDataSource runat="server" ID="booksDataSource" ConnectionString="<%$ ConnectionStrings:elibraryDBConnectionString %>" SelectCommand="SELECT [book_id] as Id, [book_name] as Name, [genre] as Genre, [author_name] as Author, [publisher_name] as Publisher, [publish_date] as Date, [language] as Language, [edition] as Edition, [book_cost] as Cost, [no_of_paages] as Pages, [book_description] as Description, [actual_stock] as Stock, [current_stock] as Available, [book_img_link] as 'Image Link' FROM [book_master_tbl]"></asp:SqlDataSource>
                            <asp:GridView runat="server" ID="booksTable" DataSourceID="booksDataSource" class="table table-bordered table-striped" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-md-3 mx-md-0 mx-auto">
                                                        <asp:Image runat="server" CssClass="img-fluid p-2" ID="imgBook" ImageUrl='<%# Eval("[Image Link]") %>' />
                                                    </div>
                                                    <div class="col-md-9 mx-md-0 mx-auto">
                                                        <div class="row mb-2">
                                                            <div class="col-md-12">
                                                                <asp:Label runat="server" ID="title" CssClass="fs-5 fw-bold" Text='<%# Eval("Name") %>'></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-2">
                                                            <div class="col-md-12">
                                                                Author -
                                                            <asp:Label runat="server" ID="lblAuthor" CssClass="fw-semibold" Text='<%# Eval("Author") %>'></asp:Label>
                                                                | Genre -
                                                            <asp:Label runat="server" ID="genre" CssClass="fw-semibold" Text='<%# Eval("Genre") %>'></asp:Label>
                                                                | Language -
                                                            <asp:Label runat="server" ID="language" CssClass="fw-semibold" Text='<%# Eval("Language") %>'></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-2">
                                                            <div class="col-md-12">
                                                                Publisher -
                                                            <asp:Label runat="server" ID="publisher" CssClass="fw-semibold" Text='<%# Eval("Publisher") %>'></asp:Label>
                                                                | Publish Date -
                                                            <asp:Label runat="server" ID="date" CssClass="fw-semibold" Text='<%# Eval("Date") %>'></asp:Label>
                                                                | Pages -
                                                            <asp:Label runat="server" ID="Label1" CssClass="fw-semibold" Text='<%# Eval("Pages") %>'></asp:Label>
                                                                | Edition -
                                                            <asp:Label runat="server" ID="edition" CssClass="fw-semibold" Text='<%# Eval("Edition") %>'></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-2">
                                                            <div class="col-md-12">
                                                                Cost -
                                                            <asp:Label runat="server" ID="cost" CssClass="fw-semibold" Text='<%# Eval("Cost") %>'></asp:Label>
                                                                | In Stock -
                                                            <asp:Label runat="server" ID="stock" CssClass="fw-semibold" Text='<%# Eval("Stock") %>'></asp:Label>
                                                                | Available -
                                                            <asp:Label runat="server" ID="avail" CssClass="fw-semibold" Text='<%# Eval("Available") %>'></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-2">
                                                            <div class="col-md-12">
                                                                Description -
                                                            <asp:Label runat="server" ID="descrip" CssClass="fw-semibold" Text='<%# Eval("Description") %>'></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
