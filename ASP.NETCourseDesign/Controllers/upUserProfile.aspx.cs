using ASP.NETCourseDesign.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASP.NETCourseDesign.Controllers
{
    public partial class upUserProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null || (string)Session["username"] == "")
            {
                Response.Write("<script>alert('请先登录！'); location.replace('/index.aspx'); </script>");
            }

            HyperLink2.Style["Style"] = "box-shadow: 0 0 10px rgba(0, 0, 0, 0.1), inset 0 0 1px rgba(255, 255, 255, 0.6);background: rgba(65, 142, 245, 0.60);color: white; ";

            string upuser = (string)Request.QueryString["upuser"];
            string img_path = getImgPath(upuser);

            string session_user = (string)Session["username"];
            if (upuser.CompareTo(session_user) == 0)
                Response.Redirect("/Pages/userInfo/profile.aspx");

            UserUname.InnerText = upuser;
            UserImg.Style["background-image"] = "url(" + img_path + ")";
            UserImg.Style["background-size"] = "200px 200px";
        }
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