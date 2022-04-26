using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Z_Kart
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCategory_Click(object sender, EventArgs e)
        {
            btnCategory.CssClass = "buttonColor";
            btnCategory.Style.Add(HtmlTextWriterStyle.Color, "green");
            Response.Redirect("Add_Category.aspx");
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            btnCategory.CssClass = "buttonColor";
            btnCategory.Style.Add(HtmlTextWriterStyle.Color, "green");
            Response.Redirect("Add_Product.aspx");
        }

        protected void btnUpdateProduct_Click(object sender, EventArgs e)
        {
            Response.Redirect("UpdateProducts.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            Response.Redirect("UpdateStatus.aspx");
        }
    }
}