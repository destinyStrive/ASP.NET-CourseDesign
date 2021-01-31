<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="upUserProfile.aspx.cs" Inherits="ASP.NETCourseDesign.Controllers.upUserProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <link href="/CSS/userInfoCss/masterCss.css" rel="stylesheet" />
    <link href="/CSS/userInfoCss/profile.css" rel="stylesheet" type="text/css"  />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <nav>
                <ul>
                    <li>
                        <asp:HyperLink ID="HyperLink2" CssClass="a"  runat="server" NavigateUrl="/Pages/userInfo/profile.aspx">用户信息</asp:HyperLink>
                    </li>
                    <li>
                        <asp:HyperLink ID="HyperLink3" CssClass="a"  runat="server" NavigateUrl="/index.aspx">返回首页</asp:HyperLink>
                    </li>
                </ul>
            </nav> 

            <div class="content">
                <div class="top">
                    <div class="user_wrapper">
                        <div class="user_img" id="UserImg" runat="server"></div>
                        <div class="user_uname" id="UserUname" runat="server"></div>
                    </div>
                </div>
                <div class="bottom">
                    <%-- 用户资料 --%>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database1.mdf;Integrated Security=True" ProviderName="System.Data.SqlClient" 
                        SelectCommand="SELECT * FROM [UserInfo] WHERE ([username] = @username)" >
                        <SelectParameters>
                            <asp:QueryStringParameter Name="username" QueryStringField="upuser" Type="String" />
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
                </div>
            </div>
        </div>
        <div class="circle1"></div>
        <div class="circle2"></div>
    </form>
</body>
</html>
