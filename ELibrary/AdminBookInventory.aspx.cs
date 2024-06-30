using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ELibrary
{
	public partial class AdminBookInventory : System.Web.UI.Page
	{
		string strConn = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
		static string global_filepath;
		static int global_actual_stock, global_current_stock, global_issued_books;
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				fillAuthorPublisherValues();
			}
			booksTable.DataBind();
		}

		protected void btnGo_Click(object sender, EventArgs e)
		{
			if (bookExists())
			{
				SqlConnection conn = new SqlConnection(strConn);
				if(conn != null)
				{
					conn.Open();
					SqlCommand cmd = new SqlCommand("SELECT * from book_master_tbl where book_id='" + bookID.Text.Trim() + "'", conn);
					SqlDataReader dr = cmd.ExecuteReader();
					if (dr.HasRows)
					{
						while (dr.Read())
						{
							bookName.Text = dr.GetValue(1).ToString();
							publishedDate.Text = dr.GetValue(5).ToString();
							edition.Text = dr.GetValue(7).ToString();
							cost.Text = dr.GetValue(8).ToString();
							pages.Text = dr.GetValue(9).ToString();
							description.Text = dr.GetValue(10).ToString();
							actualStock.Text = dr.GetValue(11).ToString();
							currStock.Text = dr.GetValue(12).ToString();
							language.SelectedValue = dr.GetValue(6).ToString();
							authorName.SelectedValue = dr.GetValue(3).ToString();
							publisherName.SelectedValue = dr.GetValue(4).ToString();
							issuedBooks.Text = "" + (Convert.ToInt32(actualStock.Text) - Convert.ToInt32(currStock.Text));

							// getting the genre
							genre.ClearSelection();
							string[] genres = dr.GetValue(2).ToString().Trim().Split(',');
							foreach(string val in genres)
							{
								for(int j = 0; j < genre.Items.Count; j++)
								{
									if(genre.Items[j].ToString() == val)
									{
										genre.Items[j].Selected = true;
									}
								}
							}

							// setting gloabal variables
							global_actual_stock = Convert.ToInt32(actualStock.Text);
							global_current_stock = Convert.ToInt32(currStock.Text);
							global_issued_books = Convert.ToInt32(issuedBooks.Text);
							global_filepath = dr.GetValue(13).ToString();
						}
					}
				}
			}
		}

		protected void btnAdd_Click(object sender, EventArgs e)
		{
			if (bookExists())
			{
				Response.Write("<script>alert('Cannot add existing book!')</script>");
			}
			else
			{
				try
				{
					// getting the genres
					string genres = "";
					foreach(int i in genre.GetSelectedIndices())
					{
						genres += genre.Items[i] + ",";
					}
					// removing trailing coma
					genres = genres.Remove(genres.Length - 1);
					// saving uploaded image on the project then file link on the db
					string filepath = "";
					string filename = Path.GetFileName(formFile.PostedFile.FileName); // get file name 
					formFile.SaveAs(Server.MapPath("book_inventory/" + filename)); // save file in the project (our computer)
					filepath = "~/book_inventory/" + filename;

					SqlConnection conn = new SqlConnection(strConn);
					if (conn != null)
					{
						conn.Open();
						SqlCommand command = new SqlCommand("INSERT into book_master_tbl values (@id, @name, @genre, @author, @publisher, @date, @language, @edition, @cost, @pages, @description, @actual_stock, @current_stock, @img_link)", conn);
						command.Parameters.AddWithValue("@id", bookID.Text.Trim());
						command.Parameters.AddWithValue("@name", bookName.Text.Trim());
						command.Parameters.AddWithValue("@genre", genres);
						command.Parameters.AddWithValue("@author", authorName.SelectedItem.Value);
						command.Parameters.AddWithValue("@publisher", publisherName.SelectedItem.Value);
						command.Parameters.AddWithValue("@date", publishedDate.Text.Trim());
						command.Parameters.AddWithValue("@language", language.SelectedItem.Value);
						command.Parameters.AddWithValue("@edition", edition.Text.Trim());
						command.Parameters.AddWithValue("@cost", cost.Text.Trim());
						command.Parameters.AddWithValue("@pages", pages.Text.Trim());
						command.Parameters.AddWithValue("@description", description.Text.Trim());
						command.Parameters.AddWithValue("@actual_stock", actualStock.Text.Trim());
						command.Parameters.AddWithValue("@current_stock", actualStock.Text.Trim());
						command.Parameters.AddWithValue("@img_link", filepath);
						command.ExecuteNonQuery();
						conn.Close();
						clearForm();
						Response.Write("<script>alert('Book added successfully!')</script>");
						booksTable.DataBind();
					}
				}
				catch (Exception ex)
				{
					Response.Write("<script>alert('" + ex.Message + "')</script>");
				}
			}
		}

		protected void btnUpdate_Click(object sender, EventArgs e)
		{
			if (bookExists())
			{
				try
				{
					// updating stock values
					int actual_stock = Convert.ToInt32(actualStock.Text.Trim());
					int curr_stock;
					if (actual_stock >= global_issued_books)
					{
						curr_stock = actual_stock - global_issued_books;
						currStock.Text = Convert.ToString(curr_stock);
					}
					else
					{
						return;
					}

					// getting the genres
					string genres = "";
					foreach (int i in genre.GetSelectedIndices())
					{
						genres += genre.Items[i] + ",";
					}
					// removing trailing coma
					genres = genres.Remove(genres.Length - 1);

					// saving uploaded image on the project then file link on the db
					string filepath = "";
					string filename = Path.GetFileName(formFile.PostedFile.FileName); // get file name 
					if(filename == "" || filename == null)
					{
						filepath = global_filepath;
					}
					else
					{
						formFile.SaveAs(Server.MapPath("book_inventory/" + filename)); // save file in the project (our computer)
						filepath = "~/book_inventory/" + filename;
					}
					
					SqlConnection conn = new SqlConnection(strConn);
					if (conn != null)
					{
						conn.Open();
						SqlCommand command = new SqlCommand("UPDATE book_master_tbl set book_name=@name, genre=@genre, author_name=@author, publisher_name=@publisher, publish_date=@date, language=@language, edition=@edition, book_cost=@cost, no_of_paages=@pages, book_description=@description, actual_stock=@actual_stock, current_stock=@current_stock, book_img_link=@img_link where book_id='" + bookID.Text.Trim() + "'", conn);
						command.Parameters.AddWithValue("@name", bookName.Text.Trim());
						command.Parameters.AddWithValue("@genre", genres);
						command.Parameters.AddWithValue("@author", authorName.SelectedItem.Value);
						command.Parameters.AddWithValue("@publisher", publisherName.SelectedItem.Value);
						command.Parameters.AddWithValue("@date", publishedDate.Text.Trim());
						command.Parameters.AddWithValue("@language", language.SelectedItem.Value);
						command.Parameters.AddWithValue("@edition", edition.Text.Trim());
						command.Parameters.AddWithValue("@cost", cost.Text.Trim());
						command.Parameters.AddWithValue("@pages", pages.Text.Trim());
						command.Parameters.AddWithValue("@description", description.Text.Trim());
						command.Parameters.AddWithValue("@actual_stock", actualStock.Text.Trim());
						command.Parameters.AddWithValue("@current_stock", Convert.ToString(curr_stock));
						command.Parameters.AddWithValue("@img_link", filepath);
						command.ExecuteNonQuery();
						conn.Close();
						clearForm();
						Response.Write("<script>alert('Book updated successfully!')</script>");
						booksTable.DataBind();
					}
				}
				catch (Exception ex)
				{
					Response.Write("<script>alert('" + ex.Message + "')</script>");
				}
			}
			else
			{
				Response.Write("<script>alert('Book with specified ID does not exist!')</script>");
			}
		}

		protected void btnDel_Click(object sender, EventArgs e)
		{
			if (bookExists())
			{
				try
				{
					SqlConnection conn = new SqlConnection(strConn);
					if (conn != null)
					{
						conn.Open();
						SqlCommand command = new SqlCommand("DELETE from book_master_tbl where book_id='" + bookID.Text.Trim() + "'", conn);
						command.ExecuteNonQuery();
						conn.Close();
						clearForm();
						Response.Write("<script>alert('Book deleted successfully!')</script>");
						booksTable.DataBind();
					}
				}
				catch (Exception ex)
				{
					Response.Write("<script>alert('" + ex.Message + "')</script>");
				}
			}
			else
			{
				Response.Write("<script>alert('Book with specified ID does not exist!')</script>");
			}
		}
		private bool bookExists()
		{
			try
			{
				SqlConnection conn = new SqlConnection(strConn);
				if (conn != null)
				{
					conn.Open();
					SqlCommand command = new SqlCommand("SELECT * from book_master_tbl where book_id='" + bookID.Text.Trim() + "' Or book_name='"+bookName.Text.Trim()+"'", conn);
					SqlDataAdapter da = new SqlDataAdapter(command);
					DataTable dt = new DataTable();
					da.Fill(dt);
					if (dt.Rows.Count != 0)
					{
						return true;
					}
				}
			}
			catch (Exception ex)
			{
				Response.Write("<script>alert('" + ex.Message + "')</script>");
				return false;
			}

			return false;
		}
		private void fillAuthorPublisherValues()
		{
			try
			{
				SqlConnection conn = new SqlConnection(strConn);
				if (conn != null)
				{
					conn.Open();
					SqlCommand command = new SqlCommand("SELECT author_name from author_master_tbl", conn);
					SqlDataAdapter da = new SqlDataAdapter(command);
					DataTable dt = new DataTable();
					da.Fill(dt);
					authorName.DataSource = dt;
					authorName.DataValueField = "author_name";
					authorName.DataBind();

					command = new SqlCommand("SELECT publisher_name from publisher_master_tbl", conn);
					da = new SqlDataAdapter(command);
					dt = new DataTable();
					da.Fill(dt);
					publisherName.DataSource = dt;
					publisherName.DataValueField = "publisher_name";
					publisherName.DataBind();
				}
			}
			catch (Exception ex)
			{
				Response.Write("<script>alert('" + ex.Message + "')</script>");
			}
		}
		private void clearForm()
		{
			genre.ClearSelection();
			bookID.Text = "";
			bookName.Text = "";
			language.Text = "";
			genre.Text = "";
			publishedDate.Text = "";
			edition.Text = "";
			cost.Text = "";
			pages.Text = "";
			actualStock.Text = "";
			currStock.Text = "";
			issuedBooks.Text = "";
			description.Text = "";
		}
	}
}