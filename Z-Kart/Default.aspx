<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Z_Kart.Default1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            margin-right: 472px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


<table style=" width:1150px; height:30px">
        <tr style=" background-color:#5f98f3">
            <td colspan="2" style=" text-align: right">
                <asp:Label ID="Label4" runat="server" style=" text-align:left" Font-Bold="True" 
                    Font-Italic="True" Font-Names="Bahnschrift SemiBold"></asp:Label>
                <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" 
                    Font-Names="Arial Rounded MT Bold" NavigateUrl="~/Login.aspx">Click To Login</asp:HyperLink>
                <asp:Button ID="Button1" runat="server" Text="Log Out" BackColor="#FF5050" 
                    BorderColor="White" Font-Bold="True" Font-Names="Comic Sans MS" 
                    ForeColor="Aqua" Height="27px" Width="105px" onclick="Button1_Click" />
            </td>
           
            <td style=" text-align:right">
                <asp:DropDownList ID="ProductCategories" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ProductCategories_SelectedIndexChanged" 
                    BackColor="#5F98F3" Font-Bold="True" Font-Size="Medium" ForeColor="White">                 
                </asp:DropDownList>&nbsp;
                <asp:TextBox ID="TextBox1" runat="server" Height="21px" Width="174px"></asp:TextBox>
                <asp:Button ID="btnSubmit" runat="server" Text="Search" Font-Bold="True" 
                   ForeColor="Black" Height="36px" Width="88px" onclick="btnSubmit_Click" />
            </td>
        </tr>
    </table>


    <asp:DataList ID="DataList1" runat="server" DataKeyField="ProductId" 
        DataSourceID="SqlDataSource1" Height="293px" Width="373px" 
        RepeatColumns="4" RepeatDirection="Horizontal" 
        onitemcommand="DataList1_ItemCommand" 
        onitemdatabound="DataList1_ItemDataBound" CssClass="auto-style1" >
    <ItemTemplate>
            <table>
                <tr>
                    <td style="text-align: center; background-color: #5f98f3">
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Brand") %>' Font-Bold="True"
                            Font-Names="Open Sans Extrabold" ForeColor="White"></asp:Label>
                    </td>
                </tr>

                   <tr>
                    <td style="text-align: right; background-color: #5f98f3">
                        <asp:Label ID="Label2" runat="server" Text="Price: ₹" Font-Bold="True" Font-Names="Arial"
                            ForeColor="White" Style="text-align: center"></asp:Label>
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("Price") %>' Font-Bold="True"
                            Font-Names="Arial" ForeColor="White" Style="text-align: center"></asp:Label>
                         
                    </td>
                </tr>
                
                <tr>
                    <td style="text-align: right">
                        <div class="all">
                            Stock:
                            <asp:Label CssClass="txtStock" ID="Label5" runat="server" Text='<%# Eval("Stock") %>'
                                BackColor='<%# (int)Eval("Stock") <= 10 ? System.Drawing.Color.Red : System.Drawing.Color.Green %>' >
                            </asp:Label>
                        </div>
                        <asp:Label ID="Label6" runat="server" Text='<%# Eval("ProductId") %>' 
                            Visible="False"></asp:Label>
                    </td>
                </tr>
             

                <tr>
                    <td align="center">
                        Quantity
                        <asp:DropDownList ID="DropDownList1" runat="server">
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem>4</asp:ListItem>
                            <asp:ListItem>5</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>

                   <tr>
                    <td style="text-align: center">
                        <asp:ImageButton ID="ImageButton1" runat="server" Height="40px" ImageUrl="~/Images/AddCart.jpg"
                            Width="160px" CommandArgument='<%# Eval("ProductId") %>' CommandName="AddToCart" />
                    </td>
                </tr>
            </table>
        <br />
        <br />
    </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Z_KartDBConnectionString %>" 
        
        SelectCommand="SELECT [ProductId], [Brand],[Price],[Stock] FROM [Product]">

    </asp:SqlDataSource>



</asp:Content>
