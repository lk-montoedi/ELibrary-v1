using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ELibrary
{
	public partial class WebForm5 : System.Web.UI.Page
	{
		string strConn = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["username"] == null || Session["username"].ToString() == "") { Response.Redirect("~/Home.aspx"); }
			if (!IsPostBack)
			{
				showDetails();
			}
		}

		protected void update_Click(object sender, EventArgs e)
		{
			if (Session["username"].ToString() != "")
			{
				try
				{
					SqlConnection conn = new SqlConnection(strConn);
					if (conn != null)
					{
						conn.Open();
						SqlCommand command = new SqlCommand("UPDATE member_master_tbl set full_name=@full_name, dob=@dob, contact_no=@contact_no, email=@email, province=@province, city=@city, postal_code=@postal_code, full_address=@full_address, password=@password where member_id='" + memberID.Text + "'", conn);
						command.Parameters.AddWithValue("@full_name", fullName.Text.Trim());
						command.Parameters.AddWithValue("@dob", dob.Text.Trim());
						command.Parameters.AddWithValue("@contact_no", contactNumber.Text.Trim());
						command.Parameters.AddWithValue("@email", email.Text.Trim());
						command.Parameters.AddWithValue("@province", province.SelectedItem.Value);
						command.Parameters.AddWithValue("@city", city.Text.Trim());
						command.Parameters.AddWithValue("@postal_code", postCode.Text.Trim());
						command.Parameters.AddWithValue("@full_address", fullAddress.Text.Trim());

						// check password
						string password = newPwd.Text.Trim();
						if (password == "") { password = oldPwd.Text; }
						command.Parameters.AddWithValue("@password", password);
						command.ExecuteNonQuery();
						conn.Close();
						showDetails();
						booksTable.DataBind();
						Response.Write("<script>alert('Information updated successfully!')</script>");
					}
				}
				catch (Exception ex)
				{
					Response.Write("<script>alert('" + ex.Message + "')</script>");
				}
			}
			else { Response.Redirect("~/Home.aspx"); }
		}
		private void showDetails()
		{
			try
			{
				SqlConnection conn = new SqlConnection(strConn);
				if (conn != null)
				{
					conn.Open();
					SqlCommand cmd = new SqlCommand("select * from member_master_tbl where member_id='" + Session["username"].ToString() + "'", conn);
					SqlDataReader dr = cmd.ExecuteReader();
					if (dr.HasRows)
					{
						while (dr.Read())
						{
							memberID.Text = Session["username"].ToString();
							fullName.Text = dr.GetValue(1).ToString();
							dob.Text = dr.GetValue(2).ToString();
							contactNumber.Text = dr.GetValue(3).ToString();
							email.Text = dr.GetValue(4).ToString();
							province.Text = dr.GetValue(5).ToString();
							city.Text = dr.GetValue(6).ToString();
							postCode.Text = dr.GetValue(7).ToString();
							fullAddress.Text = dr.GetValue(8).ToString();
							status.Text = dr.GetValue(10).ToString();
							oldPwd.Text = dr.GetValue(9).ToString();
							newPwd.Text = "";

							// choosing color for account status
							switch (status.Text)
							{
								case "Active":
									status.CssClass = "badge rounded-pill text-bg-success";
									break;
								case "Pending":
									status.CssClass = "badge rounded-pill text-bg-warning";
									break;
								case "Deactivated":
									status.CssClass = "badge rounded-pill text-bg-danger";
									break;
							}
						}
					}
				}
			}
			catch (Exception ex)
			{
				Response.Write("<script>alert('" + ex.Message + "')</script>");
			}
		}

		protected void booksTable_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			try
			{
				if (e.Row.RowType == DataControlRowType.DataRow)
				{
					// date conditions here
					DateTime dt = Convert.ToDateTime(e.Row.Cells[2].Text);
					DateTime today = DateTime.Now.Date;
					if (today > dt)
					{
						e.Row.Cells[2].CssClass = "text-danger";
					}
				}
			}
			catch (Exception ex)
			{
				Response.Write("<script>alert('" + ex.Message + "')</script>");
			}
		}
	}
}