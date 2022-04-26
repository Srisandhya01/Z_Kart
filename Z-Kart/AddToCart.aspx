<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddToCart.aspx.cs" Inherits="Z_Kart.AddToCart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        #Button1
        {
            border-radius:25px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center" style=" margin: 0 auto;">

        <h2 style=" text-decoration: underline overline blink; color:#5f98f3">You Have Following Product In Your Cart</h2>
        <br />

        <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" 
            Font-Names="Colonna MT" Font-Size="X-Large" NavigateUrl="~/Default.aspx">Continue Shopping</asp:HyperLink>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">Clear Cart</asp:LinkButton>
            <br /><br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            BackColor="#FF6699" BorderColor="#333333" BorderWidth="5px" 
            EmptyDataText="No Product Available in Shopping Cart" Font-Bold="True" 
            Height="257px" ShowFooter="True" Width="1100px" 
            onrowdeleting="GridView1_RowDeleting">
            <Columns>
                <asp:BoundField DataField="sno" HeaderText="SNo">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="pid" HeaderText="Product ID">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Brand" HeaderText="Brand">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Model" HeaderText="Model">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Price" HeaderText="Price">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Stock" HeaderText="Quantity">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Totalprice" HeaderText="Total Price">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:CommandField DeleteText="Remove" ShowDeleteButton="True" />
            </Columns>
            <FooterStyle BackColor="#6666FF" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="DarkOrchid" ForeColor="White" />
        </asp:GridView>

        <br />

        <asp:Button CssClass="btnPlaceOrder" ID="Button1" runat="server" Text="Place Order" BackColor="#FF6699" 
            BorderColor="#0A2C2A" BorderStyle="Ridge" Font-Bold="True" Font-Size="Large" 
            Height="46px" Width="190px" onclick="Button1_Click" />
    </div>
    </form>
</body>
</html>
