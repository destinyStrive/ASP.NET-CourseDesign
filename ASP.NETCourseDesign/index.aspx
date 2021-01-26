<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="ASP.NETCourseDesign.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <link href="/CSS/index.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <%-- 页面基本布局 --%>
        <h2>在线相册系统</h2>
        <asp:DropDownList ID="TypeList" runat="server">
            <asp:ListItem>全部</asp:ListItem>
        </asp:DropDownList>

        <div class="container">
            <asp:Label ID="WelcomeInfo" runat="server"></asp:Label>
            <asp:HyperLink ID="LinkUserHome" runat="server" NavigateUrl="/Pages/userInfo/album.aspx">个人主页</asp:HyperLink>
            <asp:HyperLink ID="LinkTo" runat="server"></asp:HyperLink>
        </div>
        <div class="circle1"></div>
        <div class="circle2"></div>


        <%-- SqlDataSource --%>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database1.mdf;Integrated Security=True" ProviderName="System.Data.SqlClient" 
            SelectCommand="SELECT * FROM [ImgInfo]"></asp:SqlDataSource>
        <%-- GridView --%>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical"
        AllowSorting="True" AllowPaging="True" style="margin-bottom: 15px;" PageSize="6" DataKeyNames="Id">
        <AlternatingRowStyle BackColor="#CCCCCC" />
        <Columns>
            <asp:ImageField DataImageUrlField="imgpath" HeaderText="图片" SortExpression="imgpath">
                <ControlStyle Height="150px" Width="200px" />
            </asp:ImageField>
            <asp:BoundField DataField="name" HeaderText="图片名字" SortExpression="name" ItemStyle-HorizontalAlign="center" >
            </asp:BoundField>
            <asp:BoundField DataField="type" HeaderText="图片类型" SortExpression="type" ItemStyle-HorizontalAlign="center" />
            <asp:BoundField DataField="username" HeaderText="上传用户" SortExpression="username" ItemStyle-HorizontalAlign="center" />
            <asp:BoundField DataField="uploadtime" HeaderText="上传时间" SortExpression="uploadtime" ItemStyle-HorizontalAlign="center" >
            </asp:BoundField>
            <asp:BoundField DataField="downtimes" HeaderText="下载次数" SortExpression="downtimes" ItemStyle-HorizontalAlign="center" />
        </Columns>
        <FooterStyle BackColor="#CCCCCC" />
        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#808080" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />
        <%-- 自定义分页 --%>
         <PagerTemplate>
            当前第:
                <%--//((GridView)Container.NamingContainer)就是为了得到当前的控件--%>
            <asp:Label ID="LabelCurrentPage" runat="server" Text="<%# ((GridView)Container.NamingContainer).PageIndex + 1 %>"></asp:Label>
            页/共:
            <%--//得到分页页面的总数--%>
            <asp:Label ID="LabelPageCount" runat="server" Text="<%# ((GridView)Container.NamingContainer).PageCount %>"></asp:Label>
            页
            <%--//如果该分页是首分页，那么该连接就不会显示了.同时对应了自带识别的命令参数CommandArgument--%>
            <asp:LinkButton ID="LinkButtonFirstPage" runat="server" CommandArgument="First" CommandName="Page"
                Visible='<%#((GridView)Container.NamingContainer).PageIndex != 0 %>'>首页</asp:LinkButton>
            <asp:LinkButton ID="LinkButtonPreviousPage" runat="server" CommandArgument="Prev"
                CommandName="Page" Visible='<%# ((GridView)Container.NamingContainer).PageIndex != 0 %>'>上一页</asp:LinkButton>
            <%--//如果该分页是尾页，那么该连接就不会显示了--%>
            <asp:LinkButton ID="LinkButtonNextPage" runat="server" CommandArgument="Next" CommandName="Page"
                Visible='<%# ((GridView)Container.NamingContainer).PageIndex != ((GridView)Container.NamingContainer).PageCount - 1 %>'>下一页</asp:LinkButton>
            <asp:LinkButton ID="LinkButtonLastPage" runat="server" CommandArgument="Last" CommandName="Page"
                Visible='<%# ((GridView)Container.NamingContainer).PageIndex != ((GridView)Container.NamingContainer).PageCount - 1 %>'>尾页</asp:LinkButton>
            转到第
            <asp:TextBox ID="txtNewPageIndex" runat="server" Width="20px" Text='<%# ((GridView)Container.Parent.Parent).PageIndex + 1 %>' />页
            <%--//这里将CommandArgument即使点击该按钮e.newIndex 值为3 --%>
            <asp:LinkButton ID="btnGo" runat="server" CausesValidation="False" CommandArgument="-2"
                CommandName="Page" Text="GO" />
        </PagerTemplate>
    </asp:GridView>
    </form>
</body>
</html>
