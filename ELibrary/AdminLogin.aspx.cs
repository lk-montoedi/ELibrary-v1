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
	public partial class WebForm2 : System.Web.UI.Page
	{
		private string strConn = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void Login_Click(object sender, EventArgs e)
		{
			if(isAdmin())
			{
				Response.Write("<script>alert('Welcome Admin')</script>");
				Response.Redirect("Home.aspx");
			}
			else
			{
				Response.Write("<script>alert('Invalid Credentials')</script>");
			}
		}
		// check credentials
		private bool isAdmin()
		{
			try
			{
				SqlConnection conn = new SqlConnection(strConn);
				if (conn != null)
				{
					conn.Open();
					SqlCommand command = new SqlCommand("select * from admin_login_tbl where username='"+adminID.Text+"' and password='"+adminPwd.Text+"'", conn);
					SqlDataReader dr = command.ExecuteReader();

					if (dr.HasRows)
					{
						while (dr.Read())
						{
							// the credentials are correct, proceed logging admin in
							Session["username"] = dr.GetValue(0).ToString();
							Session["fullname"] = dr.GetValue(2).ToString();
							Session["role"] = "admin";
							return true;
						}
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
	}
}