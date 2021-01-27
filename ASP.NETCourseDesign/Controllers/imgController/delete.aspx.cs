using ASP.NETCourseDesign.App_Code;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASP.NETCourseDesign.Pages.imgOperation
{
    public partial class delete : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 从数据库中删除
            int delete_id = int.Parse(Request.QueryString["Id"]);
            string delete_filename = Request.QueryString["Filename"];
            MyDb dbHelper = new MyDb();
            string sql = "DELETE FROM ImgInfo WHERE Id = " + delete_id;
            dbHelper.cud(sql);

            // 从服务器目录中删除
            string saveDir = @"\Images\uploadedImgs\user_" + Session["username"] + "\\";
            string file = System.Web.HttpContext.Current.Server.MapPath(saveDir + delete_filename);
            if (System.IO.File.Exists(file))
            {
                System.IO.File.Delete(file);
            }
            Response.Redirect("/Pages/userInfo/album.aspx");
        }
    }
}