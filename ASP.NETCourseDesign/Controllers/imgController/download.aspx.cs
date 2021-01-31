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
    public partial class download : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. 判断用户是否登录
            if(Session["username"] == null || (string)Session["username"] == "")
            {
                Response.Write("<script>alert('请先登录！'); location.replace('/index.aspx'); </script>");
            }
            else
            {
                string upuser = Request.QueryString["upuser"];
                int imgid = int.Parse(Request.QueryString["imgid"]);
                string imgname = Request.QueryString["imgname"];
                // 2. 下载文件到客户端
                string saveDir = @"\Images\uploadedImgs\user_" + upuser + "\\";
                string appPath = Request.PhysicalApplicationPath;
                if (!Directory.Exists(appPath + saveDir))
                    Directory.CreateDirectory(appPath + saveDir);
                string savePath = appPath + saveDir + imgname;

                FileInfo fileInfo = new FileInfo(savePath);
                Response.Clear();
                Response.AddHeader("Content-Disposition", "attachment:filename=" + HttpUtility.UrlEncode(imgname, System.Text.Encoding.UTF8));
                Response.AddHeader("Content-Length", fileInfo.Length.ToString());
                Response.ContentType = "application/actet-stream";
                Response.WriteFile(fileInfo.FullName);
                Response.Flush();
                // 3. 该图片下载次数加+1
                MyDb dbHelper = new MyDb();
                string sql = "UPDATE ImgInfo SET downtimes = downtimes + 1 WHERE Id = " + imgid;
                dbHelper.cud(sql);

                Response.End();
            }
        }
    }
}