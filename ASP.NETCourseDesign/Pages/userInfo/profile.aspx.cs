using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASP.NETCourseDesign.Pages.userInfo
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink profile = (HyperLink)Master.FindControl("HyperLink3");
            profile.Style["Style"] = "box-shadow: 0 0 10px rgba(0, 0, 0, 0.1), inset 0 0 1px rgba(255, 255, 255, 0.6);background: rgba(65, 142, 245, 0.60);color: white; ";

            // 第一次进入页面时，用于修改的GridView是隐藏的。只有用户点击了修改按钮才显示
            if (!IsPostBack)
            {
                GridView2.Style["Display"] = "none";
            }
            else
            {
                GridView2.Style["Display"] = "normal";
            }
        }

        protected void ModifyBtn_ServerClick(object sender, EventArgs e)
        {
            // 点击修改，显示修改的GridView
            GridView2.Style["Display"] = "normal";
        }

        protected void FinishBtn_ServerClick(object sender, EventArgs e)
        {
            // 点击完成之后，重定向到当前页面，以便信息可以刷新
            
            Response.Redirect("profile.aspx");
        }
    }
}