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
	public partial class AdminPublisherManagement : System.Web.UI.Page
	{
		string strConn = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
		protected void Page_Load(object sender, EventArgs e)
		{
			publishersTable.DataBind();
		}

		protected void btnGo_Click(object sender, EventArgs e)
		{
			if (publisherExists())
			{
				SqlConnection conn = new SqlConnection(strConn);
				if (conn != null)
				{
					conn.Open();
					SqlCommand command = new SqlCommand("SELECT * from publisher_master_tbl where publisher_id='" + publisherID.Text.Trim() + "'", conn);
					SqlDataReader dr = command.ExecuteReader();
					if (dr.HasRows)
					{
						while (dr.Read())
						{
							// show author information
							publisherID.Text = dr.GetValue(0).ToString().Trim();
							publisherName.Text = dr.GetValue(1).ToString();
						}
					}
				}
			}
			else
			{
				Response.Write("<script>alert('Publisher with specified ID does not exist!')</script>");
			}
		}

		protected void btnAdd_Click(object sender, EventArgs e)
		{
			if (publisherExists())
			{
				Response.Write("<script>alert('Cannot add existing publisher!')</script>");
			}
			else
			{
				try
				{
					SqlConnection conn = new SqlConnection(strConn);
					if (conn != null)
					{
						conn.Open();
						SqlCommand command = new SqlCommand("INSERT into publisher_master_tbl values (@id, @fullname)", conn);
						command.Parameters.AddWithValue("@id", publisherID.Text.Trim());
						command.Parameters.AddWithValue("@fullname", publisherName.Text.Trim());
						command.ExecuteNonQuery();
						conn.Close();
						clearForm();
						Response.Write("<script>alert('Publisher added successfully!')</script>");
						publishersTable.DataBind();
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
			if (publisherExists())
			{
				try
				{
					SqlConnection conn = new SqlConnection(strConn);
					if (conn != null)
					{
						conn.Open();
						SqlCommand command = new SqlCommand("UPDATE publisher_master_tbl set publisher_name=@fullname where publisher_id='" + publisherID.Text.Trim() + "'", conn);
						command.Parameters.AddWithValue("@fullname", publisherName.Text.Trim());
						command.ExecuteNonQuery();
						conn.Close();
						clearForm();
						Response.Write("<script>alert('Publisher updated successfully!')</script>");
						publishersTable.DataBind();
					}
				}
				catch (Exception ex)
				{
					Response.Write("<script>alert('" + ex.Message + "')</script>");
				}
			}
			else
			{
				Response.Write("<script>alert('Publisher with specified ID does not exist!')</script>");
			}
		}

		protected void btnDel_Click(object sender, EventArgs e)
		{
			if (publisherExists())
			{
				try
				{
					SqlConnection conn = new SqlConnection(strConn);
					if (conn != null)
					{
						conn.Open();
						SqlCommand command = new SqlCommand("DELETE from publisher_master_tbl where publisher_id='" + publisherID.Text.Trim() + "'", conn);
						command.ExecuteNonQuery();
						conn.Close();
						clearForm();
						Response.Write("<script>alert('Publisher deleted successfully!')</script>");
						publishersTable.DataBind();
					}
				}
				catch (Exception ex)
				{
					Response.Write("<script>alert('" + ex.Message + "')</script>");
				}
			}
			else
			{
				Response.Write("<script>alert('Publisher with specified ID does not exist!')</script>");
			}
		}
		// check author if it exists
		private bool publisherExists()
		{
			try
			{
				SqlConnection conn = new SqlConnection(strConn);
				if (conn != null)
				{
					conn.Open();
					SqlCommand command = new SqlCommand("SELECT * from publisher_master_tbl where publisher_id='" + publisherID.Text.Trim() + "'", conn);
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
			publisherID.Text = "";
			publisherName.Text = "";
		}
	}
}