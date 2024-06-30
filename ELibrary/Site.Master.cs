using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ELibrary
{
	public partial class Site : System.Web.UI.MasterPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			try
			{
				if (Session["role"] == null)
				{
					defaultButtons();
				}
				else if (Session["role"].ToString().Equals("user"))
				{
					LinkButton6.Visible = false; // admin login
					LinkButton8.Visible = false; // book inventory
					LinkButton9.Visible = false; // book issuing
					LinkButton10.Visible = false; // member management
					LinkButton11.Visible = false; // author management
					LinkButton12.Visible = false; // publisher management
					LinkButton0.Visible = false; // sign up
					LinkButton1.Visible = false; // user login
					LinkButton2.Visible = true; // logout
					LinkButton3.Visible = true; // hello user

					LinkButton3.Text = "Hello " + Session["username"].ToString(); // hello user
				}
				else if (Session["role"].ToString().Equals("admin"))
				{
					LinkButton8.Visible = true; // book inventory
					LinkButton9.Visible = true; // book issuing
					LinkButton10.Visible = true; // member management
					LinkButton11.Visible = true; // author management
					LinkButton12.Visible = true; // publisher management
					LinkButton6.Visible = false; // admin login
					LinkButton0.Visible = false; // sign up
					LinkButton1.Visible = false; // user login
					LinkButton2.Visible = true; // logout
					LinkButton3.Visible = true; // hello user

					LinkButton3.Text = "Hello Admin"; // hello user
				}
			}
			catch(Exception ex) { }
		}

		protected void LinkButton6_Click(object sender, EventArgs e)
		{
			Response.Redirect("~/AdminLogin.aspx");
		}

		protected void LinkButton11_Click(object sender, EventArgs e)
		{
			Response.Redirect("~/AdminAuthorManagement.aspx");
		}

		protected void LinkButton12_Click(object sender, EventArgs e)
		{
			Response.Redirect("~/AdminPublisherManagement.aspx");
		}

		protected void LinkButton8_Click(object sender, EventArgs e)
		{
			Response.Redirect("~/AdminBookInventory.aspx");
		}

		protected void LinkButton9_Click(object sender, EventArgs e)
		{
			Response.Redirect("~/AdminBookIssuing.aspx");
		}

		protected void LinkButton10_Click(object sender, EventArgs e)
		{
			Response.Redirect("~/AdminMemberManagement.aspx");
		}

		protected void LinkButton1_Click(object sender, EventArgs e)
		{
			Response.Redirect("~/MemberLogin.aspx");
		}
		protected void LinkButton0_Click(object sender, EventArgs e)
		{
			Response.Redirect("~/UserSignup.aspx");
		}

		protected void LinkButton2_Click(object sender, EventArgs e)
		{
			defaultButtons();
			Session["username"] = "";
			Session["fullname"] = "";
			Session["role"] = "";
			Session["status"] = "";
			Response.Redirect("Home.aspx");
		}
		// default button view
		private void defaultButtons()
		{
			LinkButton8.Visible = false; // book inventory
			LinkButton9.Visible = false; // book issuing
			LinkButton10.Visible = false; // member management
			LinkButton11.Visible = false; // author management
			LinkButton12.Visible = false; // publisher management
			LinkButton6.Visible = true; // admin login
			LinkButton0.Visible = true; // sign up
			LinkButton1.Visible = true; // user login
			LinkButton4.Visible = true; // view books
			LinkButton2.Visible = false; // logout
			LinkButton3.Visible = false; // hello user
		}

		protected void LinkButton4_Click(object sender, EventArgs e)
		{
			Response.Redirect("~/ViewBooks.aspx");
		}

		protected void LinkButton3_Click(object sender, EventArgs e)
		{
			Response.Redirect("~/UserProfile.aspx");
		}
	}
}