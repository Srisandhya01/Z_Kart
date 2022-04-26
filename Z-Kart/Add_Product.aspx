<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Add_Product.aspx.cs" Inherits="Z_Kart.Add_Product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="navbar" style="border-width: 3px; border-color: #333333; height: auto">
        <table style="width: 700px; height: 390px; background-color: #5f98f3;" align="center">
            <tr>
                <td align="center" width="50%" colspan="2">
                    <h1>
                        Adding Product</h1>
                    <hr />
                </td>
                
            </tr>
            <tr>
                <td align="center" width="50%">
                    <h3>
                        Category:</h3>
                </td>
                <td width="50%">
                    <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" 
                        DataSourceID="SqlDataSource1" DataTextField="CategoryName" 
                        DataValueField="CategoryId" Height="33px" Width="165px">
                        <asp:ListItem>Select</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="DropDownList1" Display="Dynamic" 
                        ErrorMessage="Category is Mandatory" ForeColor="Red" InitialValue="Select">*</asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td align="center" width="50%">
                    <h3>
                        Brand:</h3>
                </td>
                <td width="50%">
                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="txtName" Display="Dynamic" 
                        ErrorMessage="Brand is Mandatory" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td align="center" width="50%">
                <h3>Model:</h3>
                </td>
                <td width="50%">
                <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="txtDesc" Display="Dynamic" 
                        ErrorMessage="Model is Mandatory" ForeColor="Red">*</asp:RequiredFieldValidator>
                </td>
            </tr>


            <tr>
                <td align="center" width="50%">
                <h3>
                        Product Price(₹):</h3>
                </td>
                <td width="50%">
                <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ControlToValidate="txtPrice" Display="Dynamic" 
                        ErrorMessage="Price is Mandatory" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="txtPrice" Display="Dynamic" ErrorMessage="Price is Invalid" 
                        ForeColor="Red" ValidationExpression="[0-9]*">*</asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td align="center" width="50%">
                <h3>
                        Product Quantity:</h3>
                </td>
                <td width="50%">
                <asp:TextBox ID="txtQuantity" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="txtQuantity" Display="Dynamic" 
                        ErrorMessage="Quantity is Mandatory" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                        ControlToValidate="txtQuantity" Display="Dynamic" 
                        ErrorMessage="Quantity is Invalid" ForeColor="Red" 
                        ValidationExpression="[0-9]*">*</asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td align="center" width="50%" colspan="2">
                    <asp:Button ID="btnSubmit" runat="server" Text="Add" Font-Bold="True" 
                        ForeColor="Black" Height="36px" Width="88px" onclick="btnSubmit_Click" />
                </td>
                
            </tr>
            <tr>
                <td align="center" width="50%" colspan="2">
                    &nbsp;</td>
                
            </tr>

        </table>
        <br />
    </div>

    <div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:Z_KartDBConnectionString %>" 
            SelectCommand="SELECT * FROM [Category]"></asp:SqlDataSource>
    </div>

</asp:Content>
