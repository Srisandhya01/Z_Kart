<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="UpdateStatus.aspx.cs" Inherits="Z_Kart.UpdateStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div align="center" class="navbar" style="height: auto">
   
        <div align="right">
            <asp:LinkButton ID="AllOrder" runat="server" OnClick="AllOrder_Click">Show All Order List</asp:LinkButton>
            &nbsp;
        </div>

        <b>Select Date:</b>
        <asp:TextBox ID="TextBox2" runat="server" TextMode="Date" Height="29px" Width="168px"></asp:TextBox>
        &nbsp;

    
    <asp:Button ID="Button1" runat="server" Text="Click" OnClick="Button1_Click"
        CssClass="button" Font-Bold="True" Height="39px" Width="72px" />
        <br />
        <br />

        <asp:GridView ID="GridView1" runat="server" BackColor="White"
            BorderColor="#666666" BorderStyle="None" BorderWidth="12px" CellPadding="3"
            GridLines="Vertical" OnRowDataBound="GridView1_RowDataBound">
            <AlternatingRowStyle BackColor="#DCDCDC" />
            <Columns>
                <asp:TemplateField HeaderText="Product Status">
                    <ItemTemplate>
                        <asp:RadioButton ID="RadioButton1" runat="server" Checked="True"
                            GrouBrand="Status" Text="Pending" />
                        &nbsp;<asp:RadioButton ID="RadioButton2" runat="server" GrouBrand="Status"
                            Text="Complete" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
            <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
            <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#0000A9" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#000065" />
        </asp:GridView>
        <br />

        <asp:Button ID="Button2" runat="server" Text="Update Status"
            OnClick="Button2_Click" CssClass="button" Font-Bold="True" Height="37px"
            Width="136px" />
        <br />
        <br />
    </div>

</asp:Content>
