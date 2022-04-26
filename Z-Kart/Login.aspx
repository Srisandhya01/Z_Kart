<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Z_Kart.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style=" height: 450px;">
        <table style="width: 565px; height: 421px; background-color:#5f98f3; margin:0 auto">
            <tr>
                <td align="center" style="width:50%">
                    <b>Login</b>
                </td>
                
            </tr>

            <tr>
                <td align="center" style="width:50%">
                    <b>Email Id:</b>
                </td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server" BackColor="Transparent" Height="29px" 
                        Width="166px" Font-Bold="True"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="TextBox1" ErrorMessage="Enter Email-ID" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="center" style="width:50%">
                    <b>Password:</b>
                </td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server" BackColor="Transparent" Height="29px" 
                        Width="166px" TextMode="Password" Font-Bold="True"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="TextBox2" ErrorMessage="Enter Password" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
             <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSubmit" runat="server" Text="Login" Font-Bold="True" 
                        ForeColor="Black" Height="36px" Width="88px" onclick="btnSubmit_Click" /><hr />
                </td>
                
            </tr>

            <tr>


                <td>
                    <asp:Label ID="Label1" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
                </td>
                <td>
                    &nbsp;</td>
                <td align="right">
                    <asp:LinkButton ID="LinkButton1" 
                        runat="server"  Font-Bold="True" Font-Italic="True" ForeColor="Red" 
                        onclick="LinkButton1_Click" CausesValidation="False">Register Here</asp:LinkButton>
                </td>
            </tr>

        </table>
    </div>
    </form>
</body>
</html>
