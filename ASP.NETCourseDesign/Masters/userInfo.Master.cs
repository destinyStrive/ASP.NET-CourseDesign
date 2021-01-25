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

namespace ASP.NETCourseDesign.Masters
{
    public partial class userInfo : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null) return;

            string username = (string)Session["username"];
            string img_path = getImgPath(username);

            UserUname.InnerText = username;
            UserImg.Style["background-image"] = "url(" + img_path + ")";
            UserImg.Style["background-size"] = "200px 200px";
        }
        
        // 获取username用户的头像
        protected string getImgPath(string username)
        {
            MyDb dbHelper = new MyDb();
            string sql = "select * from UserInfo where username=@username";
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@username", username);
            DataTable dt = dbHelper.GetRecords(sql, param);
            return (string)dt.Rows[0]["image"];
        }
    }
}