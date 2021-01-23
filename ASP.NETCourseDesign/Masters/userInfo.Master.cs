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
            string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(connStr);
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("select * from UserInfo where username=@username", conn);
                cmd.Parameters.Add("@username", SqlDbType.VarChar);
                cmd.Parameters[0].Value = username;
                SqlDataReader dr = cmd.ExecuteReader();
                if(dr.Read())
                {
                    return dr["image"].ToString();
                }
                return null;
            }
            catch (Exception ee)
            {
                Response.Write(ee.Message);
                return null;
            }
        }
    }
}