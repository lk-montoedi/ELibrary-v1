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
	public partial class WebForm4 : System.Web.UI.Page
	{
		// String to be used to connect to the database
		private string strConn = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void signup_Click(object sender, EventArgs e)
		{
			if(checkMemberExists())
			{
				Response.Write("<script>alert('User already exists with this user ID');</script>");
			}
			else
			{
				signUpUser();
			}
		}
		private void signUpUser()
		{
			try
			{
				SqlConnection conn = new SqlConnection(strConn);
				if (conn != null)
				{
					conn.Open();
					SqlCommand command = new SqlCommand("insert into member_master_tbl values(" +
						"@member_id, @full_name, @dob, @contact_no, @email, @province, @city, @postal_code, @full_address, @password, @account_status)", conn);

					command.Parameters.AddWithValue("@member_id", userID.Text.Trim());
					command.Parameters.AddWithValue("@full_name", fullName.Text.Trim());
					command.Parameters.AddWithValue("@dob", dob.Text.Trim());
					command.Parameters.AddWithValue("@contact_no", contactNumber.Text.Trim());
					command.Parameters.AddWithValue("@email", email.Text.Trim());
					command.Parameters.AddWithValue("@province", province.SelectedItem.Value);
					command.Parameters.AddWithValue("@city", city.Text.Trim());
					command.Parameters.AddWithValue("@postal_code", postCode.Text.Trim());
					command.Parameters.AddWithValue("@full_address", fullAddress.Text.Trim());
					command.Parameters.AddWithValue("@password", password.Text.Trim());
					command.Parameters.AddWithValue("@account_status", "Pending");

					command.ExecuteNonQuery();
					conn.Close();
					Response.Redirect("~/MemberLogin.aspx");
					Response.Write("<script>alert('Sign Up Successful');</script>");
				}
			}
			catch (Exception ex)
			{
				Response.Write("<script>alert(" + ex.Message + ")</script>");
			}
		}

		private bool checkMemberExists()
		{
			try
			{
				SqlConnection conn = new SqlConnection(strConn);
				if (conn != null)
				{
					conn.Open();
					SqlCommand command = new SqlCommand("select * from member_master_tbl where member_id='"+userID.Text.Trim()+"'", conn);
					SqlDataAdapter da = new SqlDataAdapter(command); //connection closes after query is executed
					DataTable dt = new DataTable();
					da.Fill(dt); //temporary table created by SQL is stored in the DataTable variable

					if(dt.Rows.Count != 0)
					{
						// if the data table is not empty then a record exists
						return true;
					}
				}
			}
			catch (Exception ex)
			{
				Response.Write("<script>alert(" + ex.Message + ")</script>");
				return true;
			}

			return false;
		}
	}
}