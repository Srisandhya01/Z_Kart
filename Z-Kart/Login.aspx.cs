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
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Z_KartDBConnectionString"].ConnectionString);
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                if (Session["username"] != null)
                {
                    Response.Redirect("Default.aspx");
                }
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            SqlCommand cmd = new SqlCommand("User_SP", con);
            cmd.Parameters.AddWithValue("@Action", "LOGIN");
            cmd.Parameters.AddWithValue("@Email", TextBox1.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", TextBox2.Text.Trim());
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            if (TextBox1.Text == "admin@zoho.com" & TextBox2.Text == "xyzzy")
            {
                Session["admin"] = TextBox1.Text;
                Response.Redirect("AdminHome.aspx");
            }
            else if (dt.Rows.Count == 1)
            {
                Session["username"] = TextBox1.Text;
                Session["buyitems"] = null;
                fillSavedCart();
                Response.Redirect("Default.aspx");
            }
            else
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Login Failed";
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }


        private void fillSavedCart()
        {
            dt = new DataTable();
            DataRow dr;
            dt.Columns.Add("sno");
            dt.Columns.Add("pid");
            dt.Columns.Add("Brand");
            dt.Columns.Add("Model");
            dt.Columns.Add("Price");
            dt.Columns.Add("Stock");
            dt.Columns.Add("Totalprice");

            cmd = new SqlCommand("Cart_SP", con);
            cmd.Parameters.AddWithValue("@Action", "GETBYUSER");
            cmd.Parameters.AddWithValue("@Email", Session["username"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            ds = new DataSet();
            sda.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                int i = 0;
                int counter = ds.Tables[0].Rows.Count;
                while (i < counter)
                {
                    dr = dt.NewRow();
                    dr["sno"] = i + 1;
                    dr["pid"] = ds.Tables[0].Rows[i]["ProductId"].ToString();
                    dr["Brand"] = ds.Tables[0].Rows[i]["Brand"].ToString();
                    dr["Model"] = ds.Tables[0].Rows[0]["Model"].ToString();
                    dr["Price"] = ds.Tables[0].Rows[i]["Price"].ToString();
                    dr["Stock"] = ds.Tables[0].Rows[i]["Stock"].ToString();
                    decimal price = Convert.ToDecimal(ds.Tables[0].Rows[i]["Price"].ToString());
                    decimal quantity = Convert.ToDecimal(ds.Tables[0].Rows[i]["Stock"].ToString());
                    decimal totalprice = price * quantity;
                    dr["Totalprice"] = totalprice;
                    dt.Rows.Add(dr);
                    i = i + 1;
                }
            }
            else
            {
                Session["buyitems"] = null;
            }
            Session["buyitems"] = dt;
        }
    }
}
