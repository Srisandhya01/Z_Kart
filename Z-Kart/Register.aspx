<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Z_Kart.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style=" height: 830px;">
        <table style="width: 700px; height: 702px; background-color:#5f98f3"  align="center">
            <tr>
                <td align="center" style="width:50%">
                    <b>Name:</b>
                </td>
                <td style="vertical-align:top">
                    <asp:TextBox ID="TextBox1" runat="server" BackColor="Transparent" Height="29px" 
                        Width="166px" Font-Bold="True"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="TextBox1" ErrorMessage="Name is empty" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                        ControlToValidate="TextBox1" ErrorMessage="Name should be in Characters" 
                        ForeColor="Red" ValidationExpression="^[A-Za-z]*$">*</asp:RegularExpressionValidator>
                </td>              
            </tr>
            
            <tr>
                <td align="center" style="width:50%">
                    <b>Email_ID:</b>
                </td>
                <td style="vertical-align:top">
                    <asp:TextBox ID="TextBox3" runat="server" BackColor="Transparent" Height="29px" 
                         Width="166px" TextMode="Email" Font-Bold="True" TabIndex="2"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                        ControlToValidate="TextBox3" ErrorMessage="Email_ID is empty" 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>                
            </tr>
            <tr>
                <td align="center" style="width:50%">
                    <b>Gender:</b>
                </td>
                <td style="vertical-align:top">
                    <asp:DropDownList ID="DropDownList1" runat="server" BackColor="Transparent" 
                        Height="31px"  Width="167px" Font-Bold="true" TabIndex="3">
                        <asp:ListItem Value="Select Gender">Select Gender</asp:ListItem>
                        <asp:ListItem>Male</asp:ListItem>
                        <asp:ListItem>Female</asp:ListItem>
                        <asp:ListItem>Other</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="DropDownList1" ErrorMessage="Select Gender" 
                        ForeColor="Red" InitialValue="Select Gender">*</asp:RequiredFieldValidator>
                </td>               
            </tr>

            <tr>
                <td align="center" style="width:50%">
                    <b>Address:</b>
                </td>
                <td style="vertical-align:top">
                    <asp:TextBox ID="TextBox5" runat="server" BackColor="Transparent" Height="32px" 
                         Width="166px" TextMode="MultiLine" Font-Bold="True" TabIndex="4"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="TextBox5" ErrorMessage="Address is empty" 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>               
            </tr>
            <tr>
                <td align="center" style="width:50%">
                    <b>Phone_No:</b>
                </td>
                <td style="vertical-align:top">
                    <asp:TextBox ID="TextBox6" runat="server" BackColor="Transparent" Height="29px" 
                         Width="166px" TextMode="Number" Font-Bold="True" TabIndex="5"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ControlToValidate="TextBox6" ErrorMessage="Phone Number is empty" 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="TextBox6" ErrorMessage="Invalid Phone Number" 
                        ForeColor="Red" ValidationExpression="[0-9]{10}">*</asp:RegularExpressionValidator>
                </td>               
            </tr>

            <tr>
                <td align="center" style="width:50%">
                    <b>Password:</b>
                </td>
                <td style="vertical-align:top">
                    <asp:TextBox ID="TextBox7" runat="server" BackColor="Transparent" Height="29px" 
                         Width="166px" TextMode="Password" Font-Bold="True" TabIndex="6"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="TextBox7" ErrorMessage="Password is empty" 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>                
            </tr>
            <tr>
                <td align="center" style="width:50%">
                    <b>Confirm Password:</b>
                </td>
                <td style="vertical-align:top">
                    <asp:TextBox ID="TextBox8" runat="server" BackColor="Transparent" Height="29px" 
                         Width="166px" TextMode="Password" Font-Bold="True" TabIndex="7"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                        ControlToValidate="TextBox8" ErrorMessage="Confirm Password is empty" 
                        ForeColor="Red">*</asp:RequiredFieldValidator>
                    
                    <asp:CompareValidator ID="CompareValidator1" runat="server" 
                        ControlToCompare="TextBox7" ControlToValidate="TextBox8" 
                        ErrorMessage="Password Not Matched" ForeColor="Red">*</asp:CompareValidator>
                </td>                
            </tr>

            <tr>
                <td colspan="2" align="center">
         
                <asp:Button ID="Button1" runat="server" Text="Register" Height="44px" Width="120px" 
                    Font-Bold="True" Font-Size="Medium" BackColor="Aqua" BorderColor="#333333" 
                    BorderWidth="2px" onclick="Button1_Click" />
            </td>

            </tr>
            <tr>
                <td  colspan="3">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" 
                        HeaderText="Fix the following errors" Font-Bold="True" />
                </td>
            </tr>


            <tr>
                <td >
                    <asp:Label ID="Label1" runat="server" ForeColor="#66FF66" Font-Bold="true"></asp:Label>
                </td>
                <td align="right">
                    <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" 
                        Font-Italic="True" NavigateUrl="~/Default.aspx">Already Registered. Click Here</asp:HyperLink>
                </td>
            </tr>

        </table>
    </div>
    </form>
</body>
</html>
