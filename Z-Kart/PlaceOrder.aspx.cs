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
    public partial class PlaceOrder : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Z_KartDBConnectionString"].ConnectionString);
        SqlCommand cmd, cmd1;
        SqlDataAdapter sda;
        DataTable dt, dt1;
        bool isTrue = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

       
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Session["buyitems"] != null && Session["Orderid"] != null)
            {
                dt = (DataTable)Session["buyitems"];
                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    string pId = dt.Rows[i]["pid"].ToString();
                    int pQuantity = Convert.ToInt16(dt.Rows[i]["Stock"]);

                    cmd = new SqlCommand("Product_SP", con);
                    cmd.Parameters.AddWithValue("@Action", "GETBYID");
                    cmd.Parameters.AddWithValue("@ProductId", pId);
                    cmd.CommandType = CommandType.StoredProcedure;
                    sda = new SqlDataAdapter(cmd);
                    dt1 = new DataTable();
                    sda.Fill(dt1);
                    int quantity = Convert.ToInt16(dt1.Rows[0]["Stock"]);
                    if (quantity > 0)
                    {
                      
                        con.Open();
                        
                        cmd1 = new SqlCommand("Order_SP", con);
                        cmd1.Parameters.AddWithValue("@Action", "INSERT");
                        cmd1.Parameters.AddWithValue("@orderid", Session["Orderid"]);
                        cmd1.Parameters.AddWithValue("@sno", dt.Rows[i]["sno"]);
                        cmd1.Parameters.AddWithValue("@productid", dt.Rows[i]["pid"]);
                        cmd1.Parameters.AddWithValue("@Brand", dt.Rows[i]["Brand"]);
                        cmd1.Parameters.AddWithValue("@price", dt.Rows[i]["Price"]);
                        cmd1.Parameters.AddWithValue("@quantity", dt.Rows[i]["Stock"]);
                        cmd1.Parameters.AddWithValue("@orderdate", DateTime.Now.ToString("dd-MM-yyyy"));
                        cmd1.Parameters.AddWithValue("@status", "Pending");
                        cmd1.Parameters.AddWithValue("@email", Session["username"]);
                        cmd1.CommandType = CommandType.StoredProcedure;
                        cmd1.ExecuteNonQuery();
                        con.Close();
                    }
                }
                decreaseQuantity();
                Payment();
                clearCart();
                Session["buyitems"] = null;
                Response.Redirect("Invoice.aspx");
            }
            else
            {
                Response.Redirect("AddToCart.aspx");
            }
        }
        public void Payment()
        {
            if (isTrue == true)
            {
                con.Open();
                
                cmd = new SqlCommand("Card_SP", con);
               
                cmd.Parameters.AddWithValue("@Name", TextBox2.Text);
                cmd.Parameters.AddWithValue("@CardNo", TextBox3.Text);
                cmd.Parameters.AddWithValue("@ExpiryDate", TextBox4.Text);
                cmd.Parameters.AddWithValue("@CVV", TextBox5.Text);
                cmd.Parameters.AddWithValue("@BillingAddr", TextBox6.Text);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();
                con.Close();
            }
            Session["address"] = TextBox6.Text;
        }

     
        public void decreaseQuantity()
        {
            DataTable dt = (DataTable)Session["buyitems"];
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                int pId = Convert.ToInt16(dt.Rows[i]["pid"]);
                int pQuantity = Convert.ToInt16(dt.Rows[i]["Stock"]);
                
                cmd = new SqlCommand("Product_SP", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@ProductId", pId);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt1 = new DataTable();
                sda.Fill(dt1);
                int quantity = Convert.ToInt16(dt1.Rows[0]["Stock"]);
                if (quantity > 0)
                {
                    int reducedQuamtity = quantity - pQuantity;
                    con.Open();
                    
                    cmd1 = new SqlCommand("Product_SP", con);
                    cmd1.Parameters.AddWithValue("@Action", "UPDATEQTY");
                    cmd1.Parameters.AddWithValue("@Stock", reducedQuamtity);
                    cmd1.Parameters.AddWithValue("@ProductId", pId);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.ExecuteNonQuery();
                    con.Close();
                    isTrue = true;
                }
                else
                {
                    isTrue = false;
                }
            }
        }

  
        public void clearCart()
        {
            if (Session["username"] != null)
            {
                DataTable dt = (DataTable)Session["buyitems"];
                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    int pId = Convert.ToInt16(dt.Rows[i]["pid"]);
                    con.Open();
                    cmd = new SqlCommand("Cart_SP", con);
                    cmd.Parameters.AddWithValue("@Action", "DELETE");
                    cmd.Parameters.AddWithValue("@ProductId", pId);
                    cmd.Parameters.AddWithValue("@Email", Session["username"]);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}