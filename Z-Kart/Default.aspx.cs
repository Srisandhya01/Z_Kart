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
    public partial class Default1 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Z_KartDBConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["addproduct"] = "false";

            if (Session["username"] != null)
            {
                Label4.Text = "Logged in as " + Session["username"].ToString();
                HyperLink1.Visible = false;
                Button1.Visible = true;
            }
            else
            {
                Label4.Text = "Hello you can Login here";
                HyperLink1.Visible = true;
                Button1.Visible = false;
            }

            if (!IsPostBack)
            {
                Drp_ProductCategory();
            }
        }



        protected void Button1_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Default.aspx");
            Label4.Text = "You have Logged out successfully";
        }

    
        protected void btnSubmit_Click(object sender,EventArgs e)
        {
            
            SqlCommand cmd = new SqlCommand("Product_SP", con);
            cmd.Parameters.AddWithValue("@Action", "GETBYNAMEORCATEGORY");
            cmd.Parameters.AddWithValue("@Brand", TextBox1.Text.Trim());
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            DataList1.DataSourceID = null;
            DataList1.DataSource = dt;
            DataList1.DataBind();
        }


        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            Session["addproduct"] = "true";
            if (e.CommandName == "AddToCart")
            {
                DropDownList list = (DropDownList)(e.Item.FindControl("DropDownList1"));
                Response.Redirect("AddToCart.aspx?id=" + e.CommandArgument.ToString() + "&quantity=" + list.SelectedItem.ToString());
            }
        }


        protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            Label productID = e.Item.FindControl("Label6") as Label;
            Label stock = e.Item.FindControl("Label5") as Label;
            Button btn = e.Item.FindControl("btnSubmit") as Button;

            SqlCommand cmd = new SqlCommand("Product_SP", con);
            cmd.Parameters.AddWithValue("@Action", "GETBYID");
            cmd.Parameters.AddWithValue("@ProductId", productID.Text);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            String stockdata = "";

            if (dt.Rows.Count > 0)
            {
                stockdata = dt.Rows[0]["Stock"].ToString();

            }
            con.Close();

            if (stockdata == "0")
            {
                stock.Text = "Out of Stock";
                btn.Enabled = false;
                

            }
            else
            {
                stock.Text = stockdata;
            }
        }

       
        public void Drp_ProductCategory()
        {
            SqlCommand cmd = new SqlCommand("Category_SP", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ProductCategories.DataSource = dt;
            ProductCategories.DataTextField = "CategoryName";
            ProductCategories.DataValueField = "CategoryID";
            ProductCategories.DataBind();
            ProductCategories.Items.Insert(0, "Product Category");
        }

       
        protected void ProductCategories_SelectedIndexChanged(object sender, EventArgs e)
        {
            int cID = Convert.ToInt32(ProductCategories.SelectedValue);
            SqlCommand cmd = new SqlCommand("Product_SP", con);
            if (cID == 0)
            {
                cmd.Parameters.AddWithValue("@Action", "SELECT");
            }
            else
            {
                cmd.Parameters.AddWithValue("@Action", "GETBYCATEGORY");
                cmd.Parameters.AddWithValue("@CategoryId", cID);
            }
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
        
            if (cID != Convert.ToInt32(dt.Rows[0]["CategoryId"]))
            {
                Response.Write("<script>alert('No product found')</script>");
            }
            DataList1.DataSourceID = null;
            DataList1.DataSource = dt;
            DataList1.DataBind();
        }
    }
}