<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/userInfo.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="ASP.NETCourseDesign.Pages.userInfo.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database1.mdf;Integrated Security=True" 
        ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [UserInfo] WHERE ([username] = @username)">
        <SelectParameters>
            <asp:SessionParameter Name="username" SessionField="username" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="username" DataSourceID="SqlDataSource1"
        >
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <table style="width: 600px; height: 650px;  padding: 10px 25%;
                            
                    ">
                        <tr>
                            <td>邮箱：<%# Eval("email") %></td>
                        </tr>
                        <tr>
                            <td>年齡：<%# Eval("age") %></td>
                        </tr>
                        <tr>
                            <td>性別：<%# Eval("sex") %></td>
                        </tr>
                        <tr>
                            <td>愛好：<%# Eval("hobbies") %></td>
                        </tr>
                        <tr>
                            <td>备注：<%# Eval("remark") %></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
</asp:GridView>
</asp:Content>
