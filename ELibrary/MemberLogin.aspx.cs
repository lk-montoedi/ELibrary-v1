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
	public partial class WebForm3 : System.Web.UI.Page
	{
		private string strConn = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
		protected void Page_Load(object sender, EventArgs e)
		{

		}
		protected void MemberLogin_Click(object o, EventArgs e)
		{
			if (isMember())
			{
				Response.Write("<script>alert('Welcome Member')</script>");
				Response.Redirect("Home.aspx");
			}
			else
			{
				Response.Write("<script>alert('Invalid Credentials')</script>");
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
					SqlCommand command = new SqlCommand("select * from member_master_tbl where member_id='" + memberID.Text + "' and password='" + memberPwd.Text + "'", conn);
					SqlDataReader dr = command.ExecuteReader();

					if (dr.HasRows)
					{
						while (dr.Read())
						{
							// the credentials are correct, proceed logging admin in
							Session["username"] = dr.GetValue(0).ToString();
							Session["fullname"] = dr.GetValue(1).ToString();
							Session["role"] = "user";
							Session["status"] = dr.GetValue(10).ToString();
							return true;
						}
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
		protected void signup_Click(object o, EventArgs e)
		{
			Response.Redirect("UserSignup.aspx");
		}

	}
}