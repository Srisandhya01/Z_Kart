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
    public partial class Add_Category : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Z_KartDBConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["admin"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                ShowGrid();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("Category_SP", con);
            cmd.Parameters.AddWithValue("@Action", "GETBYNAME");
            cmd.Parameters.AddWithValue("@CategoryName",TextBox1.Text.Trim());
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count == 1)
            {
                Response.Write("<script>alert('This Category is Already Present');</script>");
            }
            else
            {
                con.Open();
                SqlCommand cmd1 = new SqlCommand("Category_SP", con);
                cmd1.Parameters.AddWithValue("@Action", "INSERT");
                cmd1.Parameters.AddWithValue("@CategoryName", TextBox1.Text.Trim());
                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.ExecuteNonQuery();
                con.Close();
                Response.Write("<script>alert('One Record added');</script>");
                TextBox1.Text = "";
                ShowGrid();
            }
        }
        public void ShowGrid()
        {
            SqlCommand cmd = new SqlCommand("Category_SP", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
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
            ShowGrid();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int CId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            con.Open();
            SqlCommand cmd = new SqlCommand("Category_SP", con);
            cmd.Parameters.AddWithValue("@Action", "DELETE");
            cmd.Parameters.AddWithValue("@CategoryId", CId);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Write("<script>alert('Category Deleted Successful');</script>");
            ShowGrid();
        }


        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            ShowGrid();
        }
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView1.Rows[e.RowIndex];
            int cId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string CategoryName = (row.FindControl("TextBox2") as TextBox).Text;
            con.Open();
            SqlCommand cmd = new SqlCommand("Category_SP", con);
            cmd.Parameters.AddWithValue("@Action", "UPDATE");
            cmd.Parameters.AddWithValue("@CategoryId", cId);
            cmd.Parameters.AddWithValue("@CategoryName", CategoryName.Trim());
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.ExecuteNonQuery();
            con.Close();
            GridView1.EditIndex = -1;
            Response.Write("<script>alert('Category Updated Successful');</script>");
        }

        // Calls when GridVeiw page changes
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            ShowGrid();
        }
    }
}