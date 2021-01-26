using ASP.NETCourseDesign.App_Code;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASP.NETCourseDesign.Pages
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            string username = Username.Text;
            string password = Password.Text;

            MyDb dbHelper = new MyDb();
            string sql1 = "select count(*) from UserInfo where username=@username";
            SqlParameter[] params1 = new SqlParameter[1];
            params1[0] = new SqlParameter("@username", username);
            DataTable dt1 = dbHelper.GetRecords(sql1, params1);
            int cnt1 = (int)dt1.Rows[0][0];

            string sql2 = "select count(*) from UserInfo where username=@username and password=@password";
            SqlParameter[] params2 = new SqlParameter[2];
            params2[0] = new SqlParameter("@username", username);
            params2[1] = new SqlParameter("@password", password);
            DataTable dt2 = dbHelper.GetRecords(sql2, params2);
            int cnt2 = (int)dt2.Rows[0][0];

            if (cnt1 == 0)
            {
                Response.Write("<script>alert('用户名不存在！');</script>");
            }
            else
            {  
                if (cnt2 == 0)
                {
                    Response.Write("<script>alert('密码错误！');</script>");
                }
                else
                {
                    // 登陆成功...
                    Session["username"] = username;
                    Response.Redirect("/index.aspx"); // 跳转到当前用户的相册页面
                }
            }
        }
    }
}