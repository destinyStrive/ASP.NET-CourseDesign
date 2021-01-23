<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="ASP.NETCourseDesign.Pages.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <link href="/CSS/base.css" rel="stylesheet" type="text/css" />
    <link href="/CSS/register.css" rel="stylesheet" type="text/css" />
    <style>
        body {
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Table ID="Table1" runat="server" CssClass="info_table" BorderWidth="2px">
            <asp:TableHeaderRow>
                <asp:TableCell  ColumnSpan="3" HorizontalAlign="center">
                    <h2 style="font-family: 楷体; margin-bottom: 20px; color: aqua; pointer-events: none">请填写个人信息</h2>
                </asp:TableCell>
                <asp:TableCell></asp:TableCell>
            </asp:TableHeaderRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Right" >用户名：</asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="Username" runat="server" CssClass="input"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*必填" ForeColor="Red" ControlToValidate="Username"></asp:RequiredFieldValidator>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow><asp:TableCell><br /></asp:TableCell></asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Right" >密码：</asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="Psd1" runat="server" TextMode="Password" CssClass="input"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*必填" ForeColor="Red" ControlToValidate="Psd1"></asp:RequiredFieldValidator>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow><asp:TableCell><br /></asp:TableCell></asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Right" >确认密码：</asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="Psd2" runat="server" TextMode="Password" CssClass="input"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:CompareValidator runat="server" ErrorMessage="两次密码不一致" ForeColor="Red" ControlToCompare="Psd1" ControlToValidate="Psd2"></asp:CompareValidator>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow><asp:TableCell><br /></asp:TableCell></asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Right" >邮箱：</asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="Email" runat="server" CssClass="input"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow><asp:TableCell><br /></asp:TableCell></asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Right" >年龄：</asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="Age" runat="server" CssClass="input"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow><asp:TableCell><br /></asp:TableCell></asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Right">性别：</asp:TableCell>
                <asp:TableCell>
                    <asp:RadioButtonList ID="SexRadioBtn" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem>男</asp:ListItem>
                        <asp:ListItem>女</asp:ListItem>
                    </asp:RadioButtonList>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow><asp:TableCell><br /></asp:TableCell></asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Right">爱好：</asp:TableCell>
                <asp:TableCell>
                    <asp:CheckBoxList ID="HobbyCheckBox" runat="server" RepeatDirection="Horizontal" RepeatColumns="3">
                        <asp:ListItem>篮球</asp:ListItem>
                        <asp:ListItem>足球</asp:ListItem>
                        <asp:ListItem>乒乓球</asp:ListItem>
                        <asp:ListItem>跑步</asp:ListItem>
                        <asp:ListItem>玩游戏</asp:ListItem>
                        <asp:ListItem>唱歌</asp:ListItem>
                    </asp:CheckBoxList>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow><asp:TableCell><br /></asp:TableCell></asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Right">头像：</asp:TableCell>
                <asp:TableCell>
                    <asp:FileUpload ID="ImageUpload" runat="server" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow><asp:TableCell><br /></asp:TableCell></asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Right">备注：</asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="Remark" runat="server" TextMode="MultiLine" CssClass="input" Height="100px"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow><asp:TableCell><br /></asp:TableCell></asp:TableRow>
            <asp:TableFooterRow>
                <asp:TableCell></asp:TableCell>
                <asp:TableCell>
                    <asp:Button ID="RegisterBtn" CssClass="bottom_btn" runat="server" Text="注册" OnClick="RegisterBtn_Click" />
                    <asp:HyperLink ID="HyperLink1" CssClass="bottom_btn" runat="server" NavigateUrl="login.aspx">返回登录</asp:HyperLink>
                </asp:TableCell>
            </asp:TableFooterRow>
        </asp:Table>
    </form>
</body>
</html>
