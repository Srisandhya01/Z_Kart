<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Add_Category.aspx.cs" Inherits="Z_Kart.Add_Category" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <center>
    <div class="navbar" style="border-width: 3px; border-color: #333333; height:460px">
        <table align="center" style="width: 386px; height:410px; border: 1px solid blue;">

        <tr>
            <td colspan="2" align="center">
                <h2>
                    Add Category</h2>
                <br />
            </td>            
        </tr>
        <tr>
            <td>
                <b style="font-size: 21px; font-weight: bold">Category: &nbsp;&nbsp;&nbsp;</b>
            </td>
            <td>
                <asp:TextBox ID="TextBox1" runat="server" Height="44px" Width="230px" 
                    CausesValidation="True" placeholder="Category Name" BorderColor="#333333" 
                    BorderWidth="2px" Font-Bold="True" Font-Size="Medium" ForeColor="Black" 
                    BackColor="Transparent"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="TextBox1" 
                    ForeColor="Red" ErrorMessage="Enter Category Name"></asp:RequiredFieldValidator>
            </td>           
        </tr>

        <tr>
            <td colspan="2" align="center">
                <asp:Button ID="Button1" runat="server" Text="Add" Height="44px" Width="80px" 
                    Font-Bold="True" Font-Size="Medium" BackColor="Aqua" BorderColor="#333333" 
                    BorderWidth="2px" onclick="Button1_Click" />
            </td>
        </tr>

        <tr>
            <td colspan="2"><br /></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <asp:GridView CssClass="button" ID="GridView1" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" PageSize="4" Width="257px" 
            DataKeyNames="CategoryId"  
            onpageindexchanging="GridView1_PageIndexChanging" 
            onrowcancelingedit="GridView1_RowCancelingEdit" 
            onrowdeleting="GridView1_RowDeleting" onrowediting="GridView1_RowEditing" 
            onrowupdating="GridView1_RowUpdating" EmptyDataText="No record to display" 
                    BorderColor="#333333" BorderWidth="2px" Font-Bold="True">
            <Columns>
                <asp:TemplateField HeaderText="Category">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("CategoryName") %>' Font-Bold="True"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("CategoryName") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:CommandField CausesValidation="False" HeaderText="Operation" 
                    ShowDeleteButton="True" ShowEditButton="True" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:CommandField>
            </Columns>
                    <HeaderStyle BorderColor="#333333" BorderWidth="3px" Font-Size="Large" />
        </asp:GridView>
       </td>
     </tr>
        
    </table> 
    <br /><br />
    </div>
</center>

</asp:Content>
