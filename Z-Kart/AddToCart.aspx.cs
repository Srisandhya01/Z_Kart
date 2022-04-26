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
    public partial class AddToCart : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Z_KartDBConnectionString"].ConnectionString);
        SqlCommand cmd, cmd1;
        SqlDataAdapter sda;
        DataTable dt, dt1;
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                dt = new DataTable();
                DataRow dr;
                dt.Columns.Add("sno");
                dt.Columns.Add("pid");
                dt.Columns.Add("Brand");
                dt.Columns.Add("Model");
                dt.Columns.Add("Price");
                dt.Columns.Add("Stock");
                dt.Columns.Add("Totalprice");
                if (Request.QueryString["id"] != null)
                {
                    if (Session["buyitems"] == null)
                    {
                        dr = dt.NewRow();
                        cmd = new SqlCommand("Product_SP", con);
                        cmd.Parameters.AddWithValue("@Action", "GETBYID");
                        cmd.Parameters.AddWithValue("@ProductId", Request.QueryString["id"]);
                        cmd.CommandType = CommandType.StoredProcedure;
                        sda = new SqlDataAdapter(cmd);
                        ds = new DataSet();
                        sda.Fill(ds);
                        dr["sno"] = 1;
                        dr["pid"] = ds.Tables[0].Rows[0]["ProductId"].ToString();
                        dr["Brand"] = ds.Tables[0].Rows[0]["Brand"].ToString();
                        dr["Model"] = ds.Tables[0].Rows[0]["Model"].ToString();
                        dr["Price"] = ds.Tables[0].Rows[0]["Price"].ToString();
                        dr["Stock"] = Request.QueryString["Stock"];
                        decimal price = Convert.ToDecimal(ds.Tables[0].Rows[0]["Price"].ToString());
                        decimal Quantity = Convert.ToDecimal(Request.QueryString["Stock"].ToString());
                        decimal TotalPrice = price * Quantity;
                        dr["Totalprice"] = TotalPrice;
                        dt.Rows.Add(dr);
                        con.Open();
                        cmd1 = new SqlCommand("Cart_SP", con);
                        cmd1.Parameters.AddWithValue("@Action", "INSERT");
                        cmd1.Parameters.AddWithValue("@sno", dr["sno"]);
                        cmd1.Parameters.AddWithValue("@ProductId", dr["pid"]);
                        cmd1.Parameters.AddWithValue("@Brand", dr["Brand"]);
                        cmd1.Parameters.AddWithValue("@Model", dr["Model"]);
                        cmd1.Parameters.AddWithValue("@Price", dr["Price"]);
                        cmd1.Parameters.AddWithValue("@Stock", dr["Stock"]);
                        cmd1.Parameters.AddWithValue("@Email", Session["username"]);
                        cmd1.CommandType = CommandType.StoredProcedure;
                        cmd1.ExecuteNonQuery();
                        con.Close();
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                        Session["buyitems"] = dt;
                        Button1.Enabled = true;
                        GridView1.FooterRow.Cells[6].Text = "Total Amount";
                        GridView1.FooterRow.Cells[7].Text = grandtotal().ToString();
                        Response.Redirect("AddToCart.aspx");
                    }
                    else
                    {
                        dt = (DataTable)Session["buyitems"];
                        int sr;
                        sr = dt.Rows.Count;
                        dr = dt.NewRow();
                        cmd = new SqlCommand("Product_SP", con);
                        cmd.Parameters.AddWithValue("@Action", "GETBYID");
                        cmd.Parameters.AddWithValue("@ProductId", Request.QueryString["id"]);
                        cmd.CommandType = CommandType.StoredProcedure;
                        sda = new SqlDataAdapter(cmd);
                        ds = new DataSet();
                        sda.Fill(ds);
                        dr["sno"] = sr + 1;
                        dr["pid"] = ds.Tables[0].Rows[0]["ProductId"].ToString();
                        dr["Brand"] = ds.Tables[0].Rows[0]["Brand"].ToString();
                        dr["Model"] = ds.Tables[0].Rows[0]["Model"].ToString();
                        dr["Price"] = ds.Tables[0].Rows[0]["Price"].ToString();
                        dr["Stock"] = Request.QueryString["quantity"];
                        decimal price = Convert.ToDecimal(ds.Tables[0].Rows[0]["Price"].ToString());
                        decimal Quantity = Convert.ToDecimal(Request.QueryString["quantity"].ToString());
                        decimal TotalPrice = price * Quantity;
                        dr["Totalprice"] = TotalPrice;
                        dt.Rows.Add(dr);
                        con.Open();
                        cmd1 = new SqlCommand("Cart_SP", con);
                        cmd1.Parameters.AddWithValue("@Action", "INSERT");
                        cmd1.Parameters.AddWithValue("@sno", dr["sno"]);
                        cmd1.Parameters.AddWithValue("@ProductId", dr["pid"]);
                        cmd1.Parameters.AddWithValue("@Brand", dr["Brand"]);
                        cmd1.Parameters.AddWithValue("@Model", dr["Model"]);
                        cmd1.Parameters.AddWithValue("@Price", dr["Price"]);
                        cmd1.Parameters.AddWithValue("@Stock", dr["Stock"]);
                        cmd1.Parameters.AddWithValue("@Email", Session["username"]);
                        cmd1.CommandType = CommandType.StoredProcedure;
                        cmd1.ExecuteNonQuery();
                        con.Close();
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                        Session["buyitems"] = dt;
                        Button1.Enabled = true;
                        GridView1.FooterRow.Cells[6].Text = "Total Amount";
                        GridView1.FooterRow.Cells[7].Text = grandtotal().ToString();
                        Response.Redirect("AddToCart.aspx");
                    }
                }
                else
                {
                    dt = (DataTable)Session["buyitems"];
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    if (GridView1.Rows.Count > 0)
                    {
                        GridView1.FooterRow.Cells[6].Text = "Total Amount";
                        GridView1.FooterRow.Cells[7].Text = grandtotal().ToString();
                    }
                }
            }

            if (GridView1.Rows.Count.ToString() == "0")
            {
                LinkButton1.Enabled = false;
                LinkButton1.ForeColor = System.Drawing.Color.White;
                Button1.Enabled = false;
                Button1.Text = "No orders";
            }
            else
            {
                LinkButton1.Enabled = true;
                Button1.Enabled = true;
            }
            orderid();
        }

        public decimal grandtotal()
        {
            dt = new DataTable();
            dt = (DataTable)Session["buyitems"];
            int nrow = dt.Rows.Count;
            int i = 0;
            decimal totalprice = 0;
            while (i < nrow)
            {
                totalprice = totalprice + Convert.ToDecimal(dt.Rows[i]["Totalprice"].ToString());
                i = i + 1;
            }
            return totalprice;
        }
        public void orderid()
        {
            String alpha = "abCdefghIjklmNopqrStuvwXyz123456789";
            Random r = new Random();
            char[] myArray = new char[5];
            for (int i = 0; i < 5; i++)
            {
                myArray[i] = alpha[(int)(35 * r.NextDouble())];
            }
            String orderid;
            orderid = "Order_Id: " + DateTime.Now.Hour.ToString() + DateTime.Now.Second.ToString() + DateTime.Now.Day.ToString()
                + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() + new string(myArray) + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString();
            Session["Orderid"] = orderid;
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            dt = new DataTable();
            dt = (DataTable)Session["buyitems"];
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                int sr;
                int sr1;
                string qdata;
                string dtdata;
                sr = Convert.ToInt32(dt.Rows[i]["sno"].ToString());
                TableCell cell = GridView1.Rows[e.RowIndex].Cells[0];
                qdata = cell.Text;
                dtdata = sr.ToString();
                sr1 = Convert.ToInt32(qdata);
                TableCell prID = GridView1.Rows[e.RowIndex].Cells[1];
                if (sr == sr1)
                {
                    dt.Rows[i].Delete();
                    dt.AcceptChanges();
                    con.Open();
                    cmd = new SqlCommand("Cart_SP", con);
                    cmd.Parameters.AddWithValue("@Action", "DELETE");
                    cmd.Parameters.AddWithValue("@ProductId", prID.Text);
                    cmd.Parameters.AddWithValue("@Email", Session["username"]);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                    con.Close();
                    break;
                }
            }
            for (int i = 1; i <= dt.Rows.Count; i++)
            {
                dt.Rows[i - 1]["sno"] = i;
                dt.AcceptChanges();
            }
            Session["buyitems"] = dt;
            Response.Redirect("AddToCart.aspx");
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            bool isTrue = false;
            dt = (DataTable)Session["buyitems"];
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
                if (quantity == 0)
                {
                    string Brand = dt1.Rows[0]["Brand"].ToString();
                    string msg = "" + Brand + " is not in Stock";
                    Response.Write("<script>alert('" + msg + "');</script>");
                    isTrue = false;
                }
                else
                {
                    isTrue = true;
                }
            }

            if (GridView1.Rows.Count.ToString() == "0")
            {
                Response.Write("<script>alert('Your Cart is Empty. You cannot place an Order');</script>");
            }
            else
            {
                if (isTrue == true)
                {
                    Response.Redirect("PlaceOrder.aspx");
                }
            }
        }

        public void clearCart()
        {
            con.Open();
            cmd = new SqlCommand("Cart_SP", con);
            cmd.Parameters.AddWithValue("@Action", "DELETEBYUSER");
            cmd.Parameters.AddWithValue("@Email", Session["username"]);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("AddToCart.aspx");
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session["buyitems"] = null;
            clearCart();
        }
    }
}