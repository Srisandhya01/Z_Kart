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
    public partial class Add_Product : System.Web.UI.Page
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
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("Product_SP", con);
                cmd.Parameters.AddWithValue("@Action", "INSERT");
                cmd.Parameters.AddWithValue("@Brand", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Model", txtDesc.Text.Trim());
                cmd.Parameters.AddWithValue("@Price", txtPrice.Text.Trim());
                cmd.Parameters.AddWithValue("@Stock", txtQuantity.Text.Trim());
                cmd.Parameters.AddWithValue("@CategoryId", DropDownList1.SelectedValue);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Redirect("UpdateProducts.aspx");
            
        }
    }
}