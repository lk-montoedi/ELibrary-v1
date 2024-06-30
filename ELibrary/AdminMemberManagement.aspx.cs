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
	public partial class AdminMemberManagement : System.Web.UI.Page
	{
		string strConn = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
		protected void Page_Load(object sender, EventArgs e)
		{
			membersDataSource.DataBind();
		}

		protected void btnGo_Click(object sender, EventArgs e)
		{
			if (isMember())
			{
				showDetails();
			}
			else
			{
				clearForm();
				Response.Write("<script>alert('Member with specified ID does not exist!')</script>");
			}
		}

		protected void btnDeleteMember_Click(object sender, EventArgs e)
		{
			if (isMember())
			{
				try
				{
					SqlConnection conn = new SqlConnection(strConn);
					if (conn != null)
					{
						conn.Open();
						SqlCommand command = new SqlCommand("DELETE from member_master_tbl where member_id='" + memberID.Text.Trim() + "'", conn);
						command.ExecuteNonQuery();
						conn.Close();
						clearForm();
						Response.Write("<script>alert('Member deleted successfully!')</script>");
						membersTable.DataBind();
					}
				}
				catch (Exception ex)
				{
					Response.Write("<script>alert('" + ex.Message + "')</script>");
				}
			}
			else
			{
				Response.Write("<script>alert('Member with specified ID does not exist!')</script>");
			}
		}
		protected void btnActive_Click(object sender, EventArgs e)
		{
			if(status.Text != "")
			{
				changeStatus("Active");
				membersTable.DataBind();
				showDetails();
			}
		}
		protected void btnPending_Click(object sender, EventArgs e)
		{
			if(status.Text != "")
			{
				changeStatus("Pending");
				membersTable.DataBind();
				showDetails();
			}
		}
		protected void btnDeactivated_Click(object sender, EventArgs e)
		{
			if(status.Text != "")
			{
				changeStatus("Deactivated");
				membersTable.DataBind();
				showDetails();
			}
		}
		private void showDetails()
		{
			try
			{
				SqlConnection conn = new SqlConnection(strConn);
				if (conn != null)
				{
					conn.Open();
					SqlCommand cmd = new SqlCommand("select * from member_master_tbl where member_id='" + memberID.Text.Trim() + "'", conn);
					SqlDataReader dr = cmd.ExecuteReader();
					if (dr.HasRows)
					{
						while (dr.Read())
						{
							fullName.Text = dr.GetValue(1).ToString();
							dob.Text = dr.GetValue(2).ToString();
							contactNumber.Text = dr.GetValue(3).ToString();
							email.Text = dr.GetValue(4).ToString();
							province.Text = dr.GetValue(5).ToString();
							city.Text = dr.GetValue(6).ToString();
							postalCode.Text = dr.GetValue(7).ToString();
							address.Text = dr.GetValue(8).ToString();
							status.Text = dr.GetValue(10).ToString();
						}
					}
				}
			}
			catch (Exception ex)
			{
				Response.Write("<script>alert('" + ex.Message + "')</script>");
			}
		}
		private bool isMember()
		{
			try
			{
				SqlConnection conn = new SqlConnection(strConn);
				if (conn != null)
				{
					conn.Open();
					SqlCommand cmd = new SqlCommand("select * from member_master_tbl where member_id='" + memberID.Text.Trim() + "'", conn);
					SqlDataAdapter da = new SqlDataAdapter(cmd);
					DataTable dt = new DataTable();
					da.Fill(dt);
					if (dt.Rows.Count != 0)
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
		private void changeStatus(string newStatus)
		{
			if (isMember())
			{
				try
				{
					SqlConnection conn = new SqlConnection(strConn);
					if (conn != null)
					{
						conn.Open();
						SqlCommand command = new SqlCommand("UPDATE member_master_tbl set status=@status where member_id='" + memberID.Text.Trim() + "'", conn);
						command.Parameters.AddWithValue("@status", newStatus);
						command.ExecuteNonQuery();
						conn.Close();
						membersTable.DataBind();
					}
				}
				catch (Exception ex)
				{
					Response.Write("<script>alert('" + ex.Message + "')</script>");
				}
			}
		}
		private void clearForm()
		{
			memberID.Text = "";
			fullName.Text = "";
			dob.Text = "";
			contactNumber.Text = "";
			email.Text = "";
			province.Text = "";
			city.Text = "";
			postalCode.Text = "";
			address.Text = "";
			status.Text = "";
		}
	}
}