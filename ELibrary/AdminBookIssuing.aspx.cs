using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ELibrary
{
	public partial class AdminBookIssuing : System.Web.UI.Page
	{
		string strConn = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack) { clearForm(); }
		}

		protected void btnGo_Click(object sender, EventArgs e)
		{
			if (issueExists())
			{
				try
				{
					// get the member and book name
					getNames();

					SqlConnection conn = new SqlConnection(strConn);
					if (conn != null)
					{
						conn.Open();
						// get the dates
						SqlCommand cmd = new SqlCommand("SELECT * from book_issue_tbl where book_id='" + bookID.Text.Trim() + "' AND member_id = '" + memberID.Text.Trim() + "'", conn);
						SqlDataReader dr = cmd.ExecuteReader();
						if (dr.HasRows)
						{
							while (dr.Read())
							{
								startDate.Text = dr.GetValue(4).ToString();
								endDate.Text = dr.GetValue(5).ToString();
							}
						}
						dr.Close();
					}
				}
				catch (Exception ex)
				{
					Response.Write("<script>alert('" + ex.Message + "')</script>");
				}
			}
			else
			{
				clearForm();
				// just get the names
				getNames();
			}
		}

		protected void btnIssue_Click(object sender, EventArgs e)
		{
			if (validData())
			{
				if (bookAvailable())
				{
					try
					{
						SqlConnection conn = new SqlConnection(strConn);
						if (conn != null)
						{
							conn.Open();
							SqlCommand command = new SqlCommand("INSERT into book_issue_tbl values (@member_id, @member_name, @book_id, @book_name, @start, @end)", conn);
							command.Parameters.AddWithValue("@member_id", memberID.Text.Trim());
							command.Parameters.AddWithValue("@member_name", memberName.Text.Trim());
							command.Parameters.AddWithValue("@book_id", bookID.Text.Trim());
							command.Parameters.AddWithValue("@book_name", bookName.Text.Trim());
							command.Parameters.AddWithValue("@start", startDate.Text.Trim());
							command.Parameters.AddWithValue("@end", endDate.Text.Trim());
							command.ExecuteNonQuery();
							Response.Write("<script>alert('Book issued successfully!')</script>");
							
							// updating the available books
							command = new SqlCommand("UPDATE book_master_tbl set current_stock=current_stock-1 where book_id='" + bookID.Text.Trim() + "'", conn);
							command.ExecuteNonQuery();
							conn.Close();
							clearAll();
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
					Response.Write("<script>alert('Book UNAVAILABLE!')</script>");
				}
			}
			clearForm();
		}

		protected void btnReturn_Click(object sender, EventArgs e)
		{
			if (issueExists())
			{
				try
				{
					SqlConnection conn = new SqlConnection(strConn);
					if (conn != null)
					{
						conn.Open();
						SqlCommand cmd = new SqlCommand("DELETE from book_issue_tbl where book_id='" + bookID.Text.Trim() + "' AND member_id = '" + memberID.Text.Trim() + "'", conn);
						cmd.ExecuteNonQuery();
						Response.Write("<script>alert('Book returned successfully!')</script>");
						
						// updating the available books
						cmd = new SqlCommand("UPDATE book_master_tbl set current_stock=current_stock+1 where book_id='" + bookID.Text.Trim() + "'", conn);
						cmd.ExecuteNonQuery();
						conn.Close();
						clearAll();
						booksTable.DataBind();
					}
				}
				catch (Exception ex)
				{
					Response.Write("<script>alert('" + ex.Message + "')</script>");
				}
			}
		}
		bool validData()
		{
			if (!issueExists())
			{
				if (bookName.Text == "" || memberName.Text == "") { return false; }
				if (startDate.Text == "" || endDate.Text == "") { return false; }
				return true;
			}
			else
			{
				Response.Write("<script>alert('Member has issued out the book already!')</script>");
			}
			return false;
		}
		private void getNames()
		{
			try
			{
				SqlConnection conn = new SqlConnection(strConn);
				if (conn != null)
				{
					conn.Open();
					// get the book name
					SqlCommand cmd1 = new SqlCommand("SELECT * from book_master_tbl where book_id='" + bookID.Text.Trim() + "'", conn);
					SqlDataReader dr1 = cmd1.ExecuteReader();
					if (dr1.HasRows)
					{
						while (dr1.Read())
						{
							bookName.Text = dr1.GetValue(1).ToString();
						}
					}
					dr1.Close();

					// get the member name
					SqlCommand cmd = new SqlCommand("SELECT * from member_master_tbl where member_id='" + memberID.Text.Trim() + "'", conn);
					SqlDataReader dr2 = cmd.ExecuteReader();
					if (dr2.HasRows)
					{
						while (dr2.Read())
						{
							memberName.Text = dr2.GetValue(1).ToString();
						}
					}
					dr2.Close();
				}
			}
			catch (Exception ex)
			{
				Response.Write("<script>alert('" + ex.Message + "')</script>");
			}
		}

		private bool issueExists()
		{
			try
			{
				SqlConnection conn = new SqlConnection(strConn);
				if (conn != null)
				{
					conn.Open();
					SqlCommand command = new SqlCommand("SELECT * from book_issue_tbl where book_id='" + bookID.Text.Trim() + "' AND member_id='" + memberID.Text.Trim() + "'", conn);
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
		bool bookAvailable()
		{
			try
			{
				SqlConnection conn = new SqlConnection(strConn);
				if (conn != null)
				{
					conn.Open();
					SqlCommand command = new SqlCommand("SELECT * from book_master_tbl where book_id='" + bookID.Text.Trim() + "' AND current_stock>0", conn);
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
		void clearForm()
		{
			memberName.Text = "";
			bookName.Text = "";
			startDate.Text = "";
			endDate.Text = "";
		}
		void clearAll()
		{
			memberID.Text = "";
			bookID.Text = "";
			memberName.Text = "";
			bookName.Text = "";
			startDate.Text = "";
			endDate.Text = "";
		}

		protected void booksTable_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			try
			{
				if(e.Row.RowType == DataControlRowType.DataRow)
				{
					// date conditions here
					DateTime dt = Convert.ToDateTime(e.Row.Cells[5].Text);
					DateTime today = DateTime.Now.Date;
					if(today > dt)
					{
						e.Row.Cells[5].CssClass = "text-danger";
					}
				}
			} 
			catch(Exception ex)
			{
				Response.Write("<script>alert('" + ex.Message + "')</script>");
			}
		}
	}
}