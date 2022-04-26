using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Z_Kart
{
    public partial class UpdateStatus : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Z_KartDBConnectionString"].ConnectionString);
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Session["admin"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                Button2.Visible = false;
            }
        }

       
        protected void Button1_Click(object sender, EventArgs e)
        {
            string date = TextBox2.Text;

            if (date == "")
            {
                Response.Write("<script>alert('Please select Date')</script>");
            }
            else
            {
           
                IFormatProvider culture = new CultureInfo("en-US", true);
                DateTime dateTime = DateTime.ParseExact(date, "yyyy-MM-dd", culture);
                string selectedDate = dateTime.ToString("dd-MM-yyyy");
                con.Open();
              
                cmd = new SqlCommand("Order_SP", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYDATE");
                cmd.Parameters.AddWithValue("@orderdate", selectedDate);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                
                if (dt.Rows.Count == 0)
                {
                    Response.Write("<script>alert('No record to display')</script>");
                }
                else
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    GridView1.Columns[0].Visible = true;
                    Button2.Visible = true;
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                string orderId = row.Cells[1].Text;
                RadioButton rb1 = (row.Cells[0].FindControl("RadioButton1") as RadioButton);
                RadioButton rb2 = (row.Cells[0].FindControl("RadioButton2") as RadioButton);
                string status;
                if (rb1.Checked)
                {
                    status = rb1.Text;
                }
                else
                {
                    status = rb2.Text;
                }

                con.Open();
               
                cmd = new SqlCommand("Order_SP", con);
                cmd.Parameters.AddWithValue("@Action", "UPDATE");
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@orderid", orderId);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();
                con.Close();
            }
            Response.Write("<script>alert('Status updated successfully.')</script>");
        }

       
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Center;
            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
        }

        protected void AllOrder_Click(object sender, EventArgs e)
        {
            con.Open();
            
            cmd = new SqlCommand("Order_SP", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            ds = new DataSet();
            sda.Fill(ds, "OrderDetails");
            GridView1.DataSource = ds;
            GridView1.DataBind();
            GridView1.Columns[0].Visible = false;
            Button2.Visible = false;
        }
    }
}