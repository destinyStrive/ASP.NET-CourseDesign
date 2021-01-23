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

            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);
            try
            {
                conn.Open();
                SqlCommand cmd1 = new SqlCommand("select count(*) from UserInfo where username=@username", conn);
                cmd1.Parameters.Add("@username", SqlDbType.VarChar);
                cmd1.Parameters[0].Value = username;
                int cnt1 = (int)cmd1.ExecuteScalar();
                if (cnt1 == 0)
                {
                    Response.Write("<script>alert('用户名不存在！');</script>");
                }
                else
                {
                    SqlCommand cmd2 = new SqlCommand("select count(*) from UserInfo where username=@username and password=@password", conn);
                    cmd2.Parameters.Add("@username", SqlDbType.VarChar);
                    cmd2.Parameters.Add("@password", SqlDbType.VarChar);
                    cmd2.Parameters[0].Value = username;
                    cmd2.Parameters[1].Value = password;
                    int cnt2 = (int)cmd2.ExecuteScalar();
                    if (cnt2 == 0)
                    {
                        Response.Write("<script>alert('密码错误！');</script>");
                    }
                    else
                    {
                        // 登陆成功...
                        Session["username"] = username;
                        Response.Redirect("userInfo/album.aspx"); // 跳转到当前用户的相册页面
                    }
                }
                conn.Close();
            }
            catch(Exception ee)
            {
                Response.Write(ee.Message);
            }
        }
    }
}