<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminBookInventory.aspx.cs" Inherits="ELibrary.AdminBookInventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('.table').prepend($('<thead></thead>').append($(this).find("tr:first"))).DataTable();
        });
        function readURL(input) {
            if (input.files && input.files[0]) {
                let reader = new FileReader();
                reader.onload = function (e) {
                    $('#imgview').attr('src', e.target.result);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-5">
                <div class="card p-3">
                    <div class="row mx-auto text-center">
                        <div class="col">
                            <h4>Book Details</h4>
                        </div>
                        <div class="row mx-auto text-center mb-3">
                            <div class="col">
                                <img id="imgview" src="Images/imgs/books.png" width="100" height="150" alt="Book Logo">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="row mb-3">
                                <label for="formFile" class="form-label">Book Logo</label>
                                <asp:FileUpload runat="server" onchange="readURL(this);" class="form-control" ID="formFile" />
                            </div>
                            <div class="row g-4 mb-3">
                                <div class="col-md-3">
                                    <label for="bookID" class="form-label">Book ID</label>
                                    <div class="input-group">
                                        <asp:TextBox runat="server" placeholder="ID" type="text" class="form-control" ID="bookID"></asp:TextBox>
                                        <asp:Button runat="server" type="submit" Text="Go" class="btn btn-primary" ID="btnGo" OnClick="btnGo_Click"></asp:Button>
                                    </div>
                                </div>
                                <div class="col-md-9">
                                    <label for="bookName" class="form-label">Book Name</label>
                                    <asp:TextBox runat="server" placeholder="Book Name" type="text" class="form-control" ID="bookName"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row g-4 mb-3">
                                <div class="col-md-4">
                                    <!--Languages List Items-->
                                    <label for="language" class="form-label">Language</label>
                                    <asp:DropDownList runat="server" class="form-select mb-3" ID="language">
                                        <asp:ListItem Value="English" Text="English" Selected="True"></asp:ListItem>
                                    </asp:DropDownList>
                                    <!--Publishers List Items-->
                                    <label for="publisherName" class="form-label">Publisher Name</label>
                                    <asp:DropDownList runat="server" class="form-select" ID="publisherName">
                                        <asp:ListItem Value="Select" Text="Select" Selected="True"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-4">
                                    <label for="authorName" class="form-label">Author Name</label>
                                    <!--Authors List Items-->
                                    <asp:DropDownList runat="server" class="form-select mb-3" ID="authorName">
                                        <asp:ListItem Value="Select" Text="Select" Selected="True"></asp:ListItem>
                                    </asp:DropDownList>
                                    <label for="publishedDate" class="form-label">Published Date</label>
                                    <asp:TextBox runat="server" TextMode="Date" class="form-control" ID="publishedDate"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label for="genre" class="form-label">Genre</label>
                                    <asp:ListBox runat="server" class="form-control my-auto" Rows="5" ID="genre" SelectionMode="Multiple">
                                        <asp:ListItem Text="Action" Value="Action" />
                                        <asp:ListItem Text="Adventure" Value="Adventure" />
                                        <asp:ListItem Text="Comic Book" Value="Comic Book" />
                                        <asp:ListItem Text="Self Help" Value="Self Help" />
                                        <asp:ListItem Text="Motivation" Value="Motivation" />
                                        <asp:ListItem Text="Healthy Living" Value="Healthy Healthy" />
                                        <asp:ListItem Text="Wellness" Value="Wellness" />
                                        <asp:ListItem Text="Crime" Value="Crime" />
                                        <asp:ListItem Text="Drama" Value="Drama" />
                                        <asp:ListItem Text="Fantasy" Value="Fantasy" />
                                        <asp:ListItem Text="Horror" Value="Horror" />
                                        <asp:ListItem Text="Poetry" Value="Poetry" />
                                        <asp:ListItem Text="Personal Development" Value="Personal Development" />
                                    </asp:ListBox>
                                </div>
                            </div>
                            <div class="row g-4 mb-3">
                                <div class="col-md-4">
                                    <label for="edition" class="form-label">Edition</label>
                                    <asp:TextBox runat="server" placeholder="Edition" class="form-control" ID="edition"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label for="cost" class="form-label">Book Cost(per unit)</label>
                                    <asp:TextBox runat="server" TextMode="Number" placeholder="Book Cost" class="form-control" ID="cost"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label for="pages" class="form-label">Pages</label>
                                    <asp:TextBox runat="server" TextMode="Number" placeholder="Pages" class="form-control" ID="pages"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row g-4 mb-3">
                                <div class="col-md-4">
                                    <label for="actualStock" class="form-label">In Stock</label>
                                    <asp:TextBox runat="server" TextMode="Number" placeholder="In Stock" class="form-control" ID="actualStock"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label for="currStock" class="form-label">Available</label>
                                    <asp:TextBox runat="server" ReadOnly="true" TextMode="Number" class="form-control bg-secondary-subtle" ID="currStock"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label for="issuedBooks" class="form-label">Issued Books</label>
                                    <asp:TextBox runat="server" ReadOnly="true" TextMode="Number" class="form-control bg-secondary-subtle" ID="issuedBooks"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-12">
                                    <label for="description" class="form-label">Book Description</label>
                                    <asp:TextBox runat="server" placeholder="Description..." TextMode="MultiLine" Rows="5" CssClass="form-control" ID="description"></asp:TextBox>
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
                            <h4>Book Inventory List</h4>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="container-fluid">
                            <asp:SqlDataSource runat="server" ID="booksDataSource" ConnectionString="<%$ ConnectionStrings:elibraryDBConnectionString %>" SelectCommand="SELECT [book_id] as Id, [book_name] as Name, [genre] as Genre, [author_name] as Author, [publisher_name] as Publisher, [publish_date] as Date, [language] as Language, [edition] as Edition, [book_cost] as Cost, [no_of_paages] as Pages, [book_description] as Description, [actual_stock] as Stock, [current_stock] as Available, [book_img_link] as 'Image Link' FROM [book_master_tbl]"></asp:SqlDataSource>
                            <asp:GridView runat="server" ID="booksTable" DataSourceID="booksDataSource" class="table table-bordered table-striped" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="Id" ItemStyle-CssClass="fw-bold" HeaderText="Id" ReadOnly="True" SortExpression="Id" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-lg-10">
                                                        <div class="row mb-2">
                                                            <div class="col-md-12">
                                                                <asp:Label runat="server" ID="title" CssClass="fs-5 fw-bold" Text='<%# Eval("Name") %>'></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-2">
                                                            <div class="col-md-12">
                                                                Author - <asp:Label runat="server" ID="lblAuthor" CssClass="fw-semibold" Text='<%# Eval("Author") %>'></asp:Label> | Genre - <asp:Label runat="server" ID="genre" CssClass="fw-semibold" Text='<%# Eval("Genre") %>'></asp:Label> | Language - <asp:Label runat="server" ID="language" CssClass="fw-semibold" Text='<%# Eval("Language") %>'></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-2">
                                                            <div class="col-md-12">
                                                                Publisher - <asp:Label runat="server" ID="publisher" CssClass="fw-semibold" Text='<%# Eval("Publisher") %>'></asp:Label> | Publish Date - <asp:Label runat="server" ID="date" CssClass="fw-semibold" Text='<%# Eval("Date") %>'></asp:Label> | Pages - <asp:Label runat="server" ID="Label1" CssClass="fw-semibold" Text='<%# Eval("Pages") %>'></asp:Label> | Edition - <asp:Label runat="server" ID="edition" CssClass="fw-semibold" Text='<%# Eval("Edition") %>'></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-2">
                                                            <div class="col-md-12">
                                                                Cost - <asp:Label runat="server" ID="cost" CssClass="fw-semibold" Text='<%# Eval("Cost") %>'></asp:Label> | In Stock - <asp:Label runat="server" ID="stock" CssClass="fw-semibold" Text='<%# Eval("Stock") %>'></asp:Label> | Available - <asp:Label runat="server" ID="avail" CssClass="fw-semibold" Text='<%# Eval("Available") %>'></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-2">
                                                            <div class="col-md-12">
                                                                Description - <asp:Label runat="server" ID="descrip" CssClass="fw-semibold" Text='<%# Eval("Description") %>'></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-2">
                                                        <asp:Image runat="server" CssClass="img-fluid p-2" ID="imgBook" ImageUrl='<%# Eval("[Image Link]") %>' />
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
        <a href="Home.aspx"><< Back to Home</a>
        <br />
        <br />
    </div>

</asp:Content>
