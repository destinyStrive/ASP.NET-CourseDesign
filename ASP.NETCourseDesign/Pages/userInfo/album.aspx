<%@ Page Title="" Language="C#" MasterPageFile="userInfo.Master" 
    AutoEventWireup="true" 
    CodeBehind="album.aspx.cs" 
    Inherits="ASP.NETCourseDesign.Pages.userInfo.album" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <link href="/CSS/userInfoCss/album.css" rel="stylesheet" />
    <script>
        function click_fileupload1() {
            var fileupload1 = document.getElementById("ContentPlaceHolder1_FileUpload1");
            if (fileupload1) {
                fileupload1.click();
            }
        }
        // 通过js把要编辑的图片id和文件名写入HiddenField
        function passIdFilename(id, name) {
            var old_id = document.getElementById("ContentPlaceHolder2_OldId");
            old_id.value = id;

            var old_filename = document.getElementById("ContentPlaceHolder2_OldFilename");
            old_filename.value = name;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database1.mdf;Integrated Security=True" ProviderName="System.Data.SqlClient" 
        SelectCommand="SELECT [Id], [imgpath], [name], [type], [uploadtime], [downtimes] FROM [ImgInfo] WHERE ([username] = @username)">
        <SelectParameters>
            <asp:SessionParameter Name="username" SessionField="username" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical"
        AllowSorting="True" AllowPaging="True" style="margin-bottom: 15px;" PageSize="5" DataKeyNames="Id">
        <AlternatingRowStyle BackColor="#CCCCCC" />
        <Columns>
            <asp:ImageField DataImageUrlField="imgpath" HeaderText="图片" SortExpression="imgpath">
                <ControlStyle Height="150px" Width="200px" />
            </asp:ImageField>
   
            <asp:BoundField DataField="name" HeaderText="图片名字" SortExpression="name" />
            <asp:BoundField DataField="type" HeaderText="图片类型" SortExpression="type" ItemStyle-HorizontalAlign="center" >
                <ItemStyle HorizontalAlign="Center"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="uploadtime" HeaderText="上传时间" SortExpression="uploadtime" />
            <asp:BoundField DataField="downtimes" HeaderText="下载次数" SortExpression="downtimes" ItemStyle-HorizontalAlign="center" >
                <ItemStyle HorizontalAlign="Center"></ItemStyle>
            </asp:BoundField>
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <a href="#popup1" class="editBtn" onclick="passIdFilename(  <%# Eval("Id") %>  , '<%# Eval("name") %>')"></a>
                    <a href="/Controllers/imgController/delete.aspx?Id=<%# Eval("Id") %>&Filename=<%# Eval("name") %>" onclick="return confirm('确认删除吗？');" class="deleteBtn"></a>
                </ItemTemplate>
            </asp:TemplateField>
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
    <div class="control_btns">
        <input id="FakeUpload" type="button" value="选择图片" class="fake_upload" onclick="click_fileupload1()" />
        <asp:FileUpload ID="FileUpload1" CssClass="file_upload" runat="server" />
        <asp:DropDownList ID="TypeList" CssClass="type_list" runat="server">
            <asp:ListItem>--图片类型--</asp:ListItem>
            <asp:ListItem>人物</asp:ListItem>
            <asp:ListItem>动物</asp:ListItem>
            <asp:ListItem>风景</asp:ListItem>
            <asp:ListItem>建筑</asp:ListItem>
            <asp:ListItem>意境</asp:ListItem>
            <asp:ListItem>交通</asp:ListItem>
            <asp:ListItem>城市</asp:ListItem>
            <asp:ListItem>其他</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="UpLoading" CssClass="uploading" runat="server" Text="上传" OnClick="UpLoading_Click" />
    </div>
</asp:Content>
<%-- 用于用户修改图片的模态框 --%>
<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="popup1" class="overlay">
	    <div class="popup">
            <div class="modal_header">
                <span class="title">修改图片</span>
		        <button class="close">&times;</button>
            </div>
            <hr/>
            <div class="modal_content">
                <asp:HiddenField ID="OldId" runat="server" />
                <asp:HiddenField ID="OldFilename" runat="server" />
                <asp:FileUpload ID="NewImg" runat="server" style="width: 170px; margin-top: 20px;"/><br />
                <asp:DropDownList ID="NewType" runat="server" style="margin-top: 30px;">
                    <asp:ListItem>--图片类型--</asp:ListItem>
                    <asp:ListItem>人物</asp:ListItem>
                    <asp:ListItem>动物</asp:ListItem>
                    <asp:ListItem>风景</asp:ListItem>
                    <asp:ListItem>建筑</asp:ListItem>
                    <asp:ListItem>意境</asp:ListItem>
                    <asp:ListItem>交通</asp:ListItem>
                    <asp:ListItem>城市</asp:ListItem>
                    <asp:ListItem>其他</asp:ListItem>
                </asp:DropDownList>
            </div> 
            <hr style="position: absolute; bottom: 40px; left: 10px; right: 10px;" />
            <div class="modal_btns">
                <asp:Button id="UploadBtn" class="confirm_btn" runat="server" Text="确认" OnClick="UploadBtn_Click" />
            </div>
        </div>
    </div>
</asp:Content>
