<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="ASP.NETCourseDesign.Pages.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <link href="/CSS/base.css" rel="stylesheet" type="text/css" />
    <link href="/CSS/login.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="login">
            <h2>用户登录</h2>
            <div class="login_box">
                <asp:TextBox ID="Username" class="input" runat="server" required="required"></asp:TextBox>
                <asp:Label ID="Label1" class="label" runat="server" Text="用户名"></asp:Label>
                <span class="underline"></span>
            </div>
            <div class="login_box">
                <asp:TextBox ID="Password" class="input" runat="server" required="required" TextMode="Password"></asp:TextBox>
                <asp:Label ID="Label2" class="label" runat="server" Text="密码"></asp:Label>
                <span class="underline"></span>
            </div>
            <div class="btn_container">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
                <asp:Button ID="LoginBtn" CssClass="login_btn" runat="server" Text="登录" OnClick="LoginBtn_Click" />
            </div>
            <asp:LinkButton ID="LinkButton1" CssClass="register_link" runat="server" PostBackUrl="register.aspx">还没账号？</asp:LinkButton>
        </div>
    </form>
</body>
</html>
