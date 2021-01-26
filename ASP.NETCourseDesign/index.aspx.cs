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
            // 登陆相关信息
            string cur_user = (string)Session["username"];
            if(cur_user == null || cur_user == "")
            {
                LinkTo.Text = "请登录";
                LinkTo.NavigateUrl = "/Pages/login.aspx";
                WelcomeInfo.Text = "";
                LinkUserHome.Visible = false;
            }
            else
            {
                LinkTo.Text = "退出登陆";
                LinkTo.NavigateUrl = "/Pages/logout.aspx";
                WelcomeInfo.Text = "欢迎您，" + cur_user + "用户";
                LinkUserHome.Visible = true;
            }

            // 动态将所有分类写入DropDownList
            MyDb dbHelpr = new MyDb();
            string sql = "SELECT DISTINCT type FROM ImgInfo";
            DataTable dt = dbHelpr.GetRecords(sql);
            foreach(DataRow dr in dt.Rows)
            {
                string cur_type = (string)dr[0];
                TypeList.Items.Add(new ListItem(cur_type, cur_type));
            }   
        }

        //protected void GenerateGridView()
        //{
        //    string select_cmd = "SELECT * FROM [ImgInfo]";
        //    string cur_type = TypeList.SelectedValue;
        //    if (cur_type.CompareTo("全部") != 0)
        //    {
        //        select_cmd += "WHERE type = " + cur_type;
        //    }
        //}
    }
}