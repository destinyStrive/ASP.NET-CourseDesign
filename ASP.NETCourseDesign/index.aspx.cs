using ASP.NETCourseDesign.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASP.NETCourseDesign
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 动态写入分类
            Ul.InnerHtml = "";
            Ul.InnerHtml += "<li><a href=" + "\"" + "index.aspx" + "\"" + ">全部</a></li>";

            MyDb dbHelper = new MyDb();
            string sql = "SELECT DISTINCT type FROM ImgInfo";
            DataTable dt = dbHelper.GetRecords(sql);
            foreach (DataRow dr in dt.Rows)
            {
                string category = ((string)dr[0]).Trim();
                add(category);
            }
            // 根据分类显示图片
            if (Request.QueryString["category"] == null || Request.QueryString["category"] == "")
            {
                GridView1.Style["Display"] = "normal";
                GridView2.Style["Display"] = "none";
            }
            else
            {
                GridView1.Style["Display"] = "none";
                GridView2.Style["Display"] = "normal";
            }

            // 登陆相关信息
            string cur_user = (string)Session["username"];
            if (cur_user == null || cur_user == "")
            {
                LinkTo.Text = "请登录";
                LinkTo.NavigateUrl = "/Pages/login.aspx";
                WelcomeInfo.Text = "";
                LinkUserHome.Visible = false;
            }
            else
            {
                LinkTo.Text = "退出登陆";
                LinkTo.NavigateUrl = "/Controllers/logout.aspx";
                WelcomeInfo.Text = "欢迎您，" + cur_user + "用户";
                LinkUserHome.Visible = true;
            }
        }
        // 在导航中加入一个分类
        protected void add(string category)
        {
            string href = "href=" + "\"" + "index.aspx?category=" + category + "\"";

            Ul.InnerHtml += "<li><a ";
            Ul.InnerHtml += href + ">" + category;
            Ul.InnerHtml += "</a></li>";
        }
    }
}