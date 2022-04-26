<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlaceOrder.aspx.cs" Inherits="Z_Kart.PlaceOrder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .table
        {
            border-radius:5%;
        }
        #Button1
        {
            border-radius:11% 11% 11% 11% / 61% 64% 64% 66%; 
        }
        .auto-style1 {
            width: 239px;
        }
        .auto-style2 {
            margin-left: 0px;
        }
        .auto-style3 {
            width: 239px;
            font-weight: bold;
            font-size: large;
            color: #FFFFFF;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table class="table" align="center" style=" margin-top:50px; width:531px; height: 563px;" bgcolor="DarkCyan">

            <tr>
                <td colspan="2" align="center" style=" vertical-align:top">
                    <asp:Label ID="Label1" runat="server" Text="Card Details" Font-Bold="True" 
                        Font-Size="XX-Large" ForeColor="White"></asp:Label>
                </td>
            </tr>

            <tr>
                 <td align="center" style=" vertical-align:top" class="auto-style3">
                    Name</td>
                <td align="center" style=" vertical-align:top">
                    <asp:TextBox ID="TextBox2" runat="server" BorderColor="Black" BorderWidth="2px" 
                        Font-Bold="True" Font-Size="Medium" Height="44px" Width="188px" placeholder="Name" CssClass="auto-style2"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ErrorMessage="Name is Empty" ControlToValidate="TextBox2" 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                        ErrorMessage="Name must be in characters" ControlToValidate="TextBox2" 
                        ForeColor="Red" ValidationExpression="^[A-Za-z]*$">*</asp:RegularExpressionValidator>
                </td>
            </tr>

           
     
            <tr>
                <td colspan="2" align="center">
                    <asp:Label ID="Label2" runat="server" Text="Card Number" Font-Bold="True" 
                        Font-Size="Large" ForeColor="White"></asp:Label>
                </td>
            </tr>
          
            <tr>
                <td colspan="2" align="center" style=" vertical-align:top">
                    <asp:TextBox ID="TextBox3" runat="server" BorderColor="Black" BorderWidth="2px" 
                        Font-Bold="True" Font-Size="Medium" Height="44px" Width="442px" placeholder="16 Digits"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ErrorMessage="Card Number is Empty" ControlToValidate="TextBox3" 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                        ErrorMessage="Card Number must be of 16 digits" ControlToValidate="TextBox3" 
                        ForeColor="Red" ValidationExpression="[0-9]{16}">*</asp:RegularExpressionValidator>
                </td>
            </tr>


            <tr>
    
                <td align="center" class="auto-style1">
                    <asp:Label ID="Label3" runat="server" Text="Expiry Date" Font-Bold="True" 
                        Font-Size="Large" ForeColor="White"></asp:Label>
                </td>

       
                <td align="center">
                    <asp:Label ID="Label4" runat="server" Text="CVV" Font-Bold="True" 
                        Font-Size="Large" ForeColor="White"></asp:Label>
                </td>
            </tr>

            <tr>
                <td align="center" style=" vertical-align:top" class="auto-style1">
                    <asp:TextBox ID="TextBox4" runat="server" BorderColor="Black" BorderWidth="2px" 
                        Font-Bold="True" Font-Size="Medium" Height="44px" Width="188px" placeholder="MM/YY(Eg:061996)"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ErrorMessage="Expiry Date is Empty" ControlToValidate="TextBox4" 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>

                <td align="center" style=" vertical-align:top">
                    <asp:TextBox ID="TextBox5" runat="server" BorderColor="Black" BorderWidth="2px" 
                        Font-Bold="True" Font-Size="Medium" Height="44px" Width="188px" placeholder="3 Digits"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ErrorMessage="CVV is Empty" ControlToValidate="TextBox5" 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                        ErrorMessage="CVV Number must be of 3 digits" ControlToValidate="TextBox5" 
                        ForeColor="Red" ValidationExpression="[0-9]{3}">*</asp:RegularExpressionValidator>
                </td>
            </tr>

           
            <tr>
                <td colspan="2" align="center" style=" vertical-align:top">
                    <asp:TextBox ID="TextBox6" runat="server" BorderColor="Black" BorderWidth="2px" 
                        Font-Bold="True" Font-Size="X-Large" Height="50px" Width="442px" placeholder="Billing Address" TextMode="MultiLine"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ErrorMessage="Address is Empty" ControlToValidate="TextBox6" 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                    
                </td>
            </tr>

           
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="Button1" runat="server" Text="Submit" BackColor="Black" 
                        BorderColor="White" BorderWidth="2px" Font-Bold="True" Font-Size="Large" 
                        ForeColor="White" Height="44px" Width="188px" onclick="Button1_Click" />
                </td>
            </tr>

           
            <tr>
                <td colspan="2">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" Font-Bold="True" 
                        ForeColor="Red" HeaderText="Fix the following errors" />
                </td>
            </tr>

            <tr>
               
                <td colspan="2">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" 
                        NavigateUrl="~/AddToCart.aspx">Previous Page</asp:HyperLink>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:HyperLink ID="HyperLink2" runat="server" Font-Bold="True" 
                        NavigateUrl="~/Default.aspx">Home Page</asp:HyperLink>
                </td>
            </tr>

        </table>
    </div>
    </form>
</body>
</html>

