using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Z_Kart
{
    public partial class Register : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Z_KartDBConnectionString"].ConnectionString);
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] != null)
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        protected void Button1_Click(object sender,EventArgs e)
        {
            con.Open();
            
            cmd = new SqlCommand("User_SP", con);
            cmd.Parameters.AddWithValue("@Action", "INSERT");
            cmd.Parameters.AddWithValue("@Name", TextBox1.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", TextBox3.Text.Trim());
            cmd.Parameters.AddWithValue("@Gender", DropDownList1.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@Address", TextBox5.Text.Trim());
            cmd.Parameters.AddWithValue("@Phone", TextBox6.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", TextBox7.Text.Trim());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            con.Close();
            ClearText();
            Label1.Text = "Registered Successfull";
            ClearText();
        }


        private void ClearText()
        {
            TextBox1.Text = string.Empty;
            TextBox3.Text = string.Empty;
            TextBox5.Text = string.Empty;
            TextBox6.Text = string.Empty;
            TextBox7.Text = string.Empty;
        }
    }
}