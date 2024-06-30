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
	public partial class AdminAuthorManagement : System.Web.UI.Page
	{
		string strConn = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
		protected void Page_Load(object sender, EventArgs e)
		{
			authorsTable.DataBind();
		}

		protected void btnUpdate_Click(object sender, EventArgs e)
		{
			if (authorExists())
			{
				try
				{
					SqlConnection conn = new SqlConnection(strConn);
					if (conn != null)
					{
						conn.Open();
						SqlCommand command = new SqlCommand("UPDATE author_master_tbl set author_name=@fullname where author_id='"+ authorID.Text.Trim() + "'", conn);
						command.Parameters.AddWithValue("@fullname", authorName.Text.Trim());
						command.ExecuteNonQuery();
						conn.Close();
						clearForm();
						Response.Write("<script>alert('Author updated successfully!')</script>");
						authorsTable.DataBind();
					}
				}
				catch (Exception ex)
				{
					Response.Write("<script>alert('" + ex.Message + "')</script>");
				}
			}
			else
			{
				Response.Write("<script>alert('Author with specified ID does not exist!')</script>");
			}
		}

		protected void btnAdd_Click(object sender, EventArgs e)
		{
			if (authorExists())
			{
				Response.Write("<script>alert('Cannot add existing author!')</script>");
			}
			else
			{
				try
				{
					SqlConnection conn = new SqlConnection(strConn);
					if(conn != null)
					{
						conn.Open();
						SqlCommand command = new SqlCommand("INSERT into author_master_tbl values (@id, @fullname)", conn);
						command.Parameters.AddWithValue("@id", authorID.Text.Trim());
						command.Parameters.AddWithValue("@fullname", authorName.Text.Trim());
						command.ExecuteNonQuery();
						conn.Close();
						clearForm();
						Response.Write("<script>alert('Author added successfully!')</script>");
						authorsTable.DataBind();
					}
				}
				catch(Exception ex)
				{
					Response.Write("<script>alert('" + ex.Message + "')</script>");
				}
			}
		}

		protected void btnDel_Click(object sender, EventArgs e)
		{
			if (authorExists())
			{
				try
				{
					SqlConnection conn = new SqlConnection(strConn);
					if (conn != null)
					{
						conn.Open();
						SqlCommand command = new SqlCommand("DELETE from author_master_tbl where author_id='" + authorID.Text.Trim() + "'", conn);
						command.ExecuteNonQuery();
						conn.Close();
						clearForm();
						Response.Write("<script>alert('Author deleted successfully!')</script>");
						authorsTable.DataBind();
					}
				}
				catch (Exception ex)
				{
					Response.Write("<script>alert('" + ex.Message + "')</script>");
				}
			}
			else
			{
				Response.Write("<script>alert('Author with specified ID does not exist!')</script>");
			}
		}

		protected void btnGo_Click(object sender, EventArgs e)
		{
			if (authorExists())
			{
				SqlConnection conn = new SqlConnection(strConn);
				if (conn != null)
				{
					conn.Open();
					SqlCommand command = new SqlCommand("SELECT * from author_master_tbl where author_id='" + authorID.Text.Trim() + "'", conn);
					SqlDataReader dr = command.ExecuteReader();
					if (dr.HasRows)
					{
						while (dr.Read())
						{
							// show author information
							authorID.Text = dr.GetValue(0).ToString().Trim();
							authorName.Text = dr.GetValue(1).ToString();
						}
					}
				}
			}
			else
			{
				Response.Write("<script>alert('Author with specified ID does not exist!')</script>");
			}
		}
		// check author if it exists
		private bool authorExists()
		{
			try
			{
				SqlConnection conn = new SqlConnection(strConn);
				if(conn != null)
				{
					conn.Open();
					SqlCommand command = new SqlCommand("SELECT * from author_master_tbl where author_id='"+authorID.Text.Trim()+"'", conn);
					SqlDataAdapter da = new SqlDataAdapter(command);
					DataTable dt = new DataTable();
					da.Fill(dt);
					if(dt.Rows.Count != 0)
					{
						return true;
					}
				}
			}
			catch(Exception ex)
			{
				Response.Write("<script>alert('" + ex.Message + "')</script>");
				return false;
			}

			return false;
		}
		void clearForm()
		{
			authorID.Text = "";
			authorName.Text = "";
		}
	}
}