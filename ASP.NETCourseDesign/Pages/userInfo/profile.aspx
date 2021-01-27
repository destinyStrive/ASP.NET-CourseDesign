<%@ Page Title="" Language="C#" MasterPageFile="userInfo.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="ASP.NETCourseDesign.Pages.userInfo.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/CSS/userInfoCss/profile.css" rel="stylesheet" type="text/css"  />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database1.mdf;Integrated Security=True" ProviderName="System.Data.SqlClient" 
        SelectCommand="SELECT * FROM [UserInfo] WHERE ([username] = @username)" >
        <SelectParameters>
            <asp:SessionParameter Name="username" SessionField="username" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="username" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:TemplateField HeaderText="个人信息">
                <ItemTemplate>
                    <table style="width: 600px; height:500px;  padding: 10px 25%;">
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
                            <td>爱好：<%# Eval("hobbies") %></td>
                        </tr>   
                        <tr>
                            <td>备注：<%# Eval("remark") %></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
</asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database1.mdf;Integrated Security=True" ProviderName="System.Data.SqlClient" 
        SelectCommand="SELECT [username], [age], [sex], [hobbies], [image], [remark] FROM [UserInfo] WHERE ([username] = @username)"
        UpdateCommand="UPDATE [UserInfo] SET age = @age, sex = @sex, hobbies = @hobbies, remark=@remark WHERE (username = @username)">
        <SelectParameters>
            <asp:SessionParameter Name="username" SessionField="username" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">  <%-- 异步刷新 --%>
        <ContentTemplate>
            <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSource2" AutoGenerateColumns="False" DataKeyNames="username" 
                Width="800px" style="margin-top: 40px;">
                <Columns>
                    <asp:CommandField ShowEditButton="True" />
                    <asp:BoundField DataField="username" HeaderText="username" ReadOnly="True" SortExpression="username" />
                    <asp:BoundField DataField="age" HeaderText="age" SortExpression="age" />
                    <asp:TemplateField HeaderText="sex" SortExpression="sex">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("sex") %>'>
                                <asp:ListItem Value="男">男</asp:ListItem>
                                <asp:ListItem Value="女">女</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("sex") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="hobbies" HeaderText="hobbies" SortExpression="hobbies" />
                    <asp:ImageField DataImageUrlField="image" HeaderText="image" SortExpression="image" ReadOnly="True">
                        <ControlStyle Height="50px" Width="50px" />
                    </asp:ImageField>
                    <asp:BoundField DataField="remark" HeaderText="remark" SortExpression="remark" />
                </Columns>
            </asp:GridView>
            <div class="control_btns">
                <asp:Button ID="Button1" runat="server" CssClass="modify_btn" OnClick="ModifyBtn_ServerClick"/>
                <asp:Button ID="Button2" runat="server" CssClass="finish_btn" OnClick="FinishBtn_ServerClick"/>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>     
</asp:Content>
