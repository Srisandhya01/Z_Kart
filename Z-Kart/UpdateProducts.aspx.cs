using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Z_Kart
{
    public partial class UpdateProducts : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Z_KartDBConnectionString"].ConnectionString);
        int Productid;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
           
                if (Session["admin"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                ShowProduct();
            }
        }

     
        public void ShowProduct()
        {
            SqlCommand cmd = new SqlCommand("Product_SP", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            int index = e.NewEditIndex;
            GridViewRow row = (GridViewRow)GridView1.Rows[index];
            Label productID = (Label)row.FindControl("Label1");
            Productid = int.Parse(productID.Text.ToString());
            SqlCommand cmd = new SqlCommand("Product_SP", con);
            cmd.Parameters.AddWithValue("@Action", "GETBYID");
            cmd.Parameters.AddWithValue("@ProductId", Productid);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            DropDownList2.SelectedValue = "Select Category";
            ShowProduct();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            ShowProduct();
        }


        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int index = Productid;
            GridViewRow row = (GridViewRow)GridView1.Rows[index];

            
            
                Label productID = (Label)row.FindControl("Label1");
                TextBox Brand = (TextBox)row.FindControl("TextBox1");
                TextBox Model = (TextBox)row.FindControl("TextBox2");
                TextBox Price = (TextBox)row.FindControl("TextBox3");
                TextBox Stock = (TextBox)row.FindControl("TextBox4");
                string pCategory = ((DropDownList)GridView1.Rows[e.RowIndex].Cells[6].FindControl("DropDownList1")).SelectedValue;


                con.Open();
                
                SqlCommand cmd = new SqlCommand("Product_SP", con);
                cmd.Parameters.AddWithValue("@Action", "UPDATE");
                cmd.Parameters.AddWithValue("@Brand", Brand.Text.Trim());
                cmd.Parameters.AddWithValue("@Model", Model.Text.Trim());
                cmd.Parameters.AddWithValue("@Price", Price.Text.Trim());
                cmd.Parameters.AddWithValue("@Stock", Stock.Text.Trim());
                cmd.Parameters.AddWithValue("@CategoryId", pCategory);
                cmd.Parameters.AddWithValue("@ProductId", productID.Text);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();
                con.Close();
                GridView1.EditIndex = -1;
                Response.Write("<script>alert('Product Updated Successfully');</script>");
                ShowProduct();
                DropDownList2.SelectedValue = "Select Category";
          
            
        }
        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            int cID = Convert.ToInt32(DropDownList2.SelectedValue);
            if (cID == 0)
            {
                ShowProduct();
            }
            else
            {
                SqlCommand cmd = new SqlCommand("Product_SP", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYCATEGORY");
                cmd.Parameters.AddWithValue("@CategoryId", cID);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }
    }
}