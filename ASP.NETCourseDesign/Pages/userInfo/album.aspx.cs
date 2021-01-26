using ASP.NETCourseDesign.App_Code;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASP.NETCourseDesign.Pages.userInfo
{
    public partial class album : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink profile = (HyperLink)Master.FindControl("HyperLink1");
            profile.Style["Style"] = "box-shadow: 0 0 10px rgba(0, 0, 0, 0.1), inset 0 0 1px rgba(255, 255, 255, 0.6);background: rgba(65, 142, 245, 0.60);color: white; ";
        }

        protected void UpLoading_Click(object sender, EventArgs e)
        {
            if(!FileUpload1.HasFile || TypeList.SelectedIndex == 0)
            {
                Response.Write("<script>alert('没有上传图片或者没有选择图片类型！')</script>");
            }
            else
            {
                /* 1. 上传图片到服务器Images文件夹下 */
                string savedir = @"\Images\uploadedImgs\user_" + Session["username"] + "\\"; // 指定文件夹
                string appPath = Request.PhysicalApplicationPath;
                // 没有目录就创建目录（为每个用户的上传图片创建他们各自的目录）
                if (!Directory.Exists(appPath + savedir))
                    Directory.CreateDirectory(appPath + savedir);
                // 利用FileUpload.FileName取出选择的图片名称，并上传
                string savePath = appPath + savedir + FileUpload1.FileName;
                FileUpload1.SaveAs(savePath);

                /* 2. 将图片信息插入数据库 */
                string name = FileUpload1.FileName;
                string username = (string)Session["username"]; // 上传的用户就是当前参与会话的用户
                DateTime uploadtime = DateTime.Now;
                string type = TypeList.SelectedValue;
                int downtimes = 0;
                string imgpath = savedir + FileUpload1.FileName;

                MyDb dbHelper = new MyDb();
                string sql = "insert into ImgInfo (name, username, uploadtime, type, downtimes, imgpath) values " +
                    "(@name, @username, @uploadtime, @type, @downtimes, @imgpath)";
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@name", name);
                param[1] = new SqlParameter("@username", username);
                param[2] = new SqlParameter("@uploadtime", uploadtime);
                param[3] = new SqlParameter("@type", type);
                param[4] = new SqlParameter("@downtimes", downtimes);
                param[5] = new SqlParameter("@imgpath", imgpath);
                try
                {
                    dbHelper.cud(sql, param);
                    Response.Redirect("album.aspx");
                    //Response.Write("<script>alert('上传成功！')</script>");
                }
                catch(Exception ee)
                {
                    Response.Write(ee.Message);
                }
            }
        }

        protected void UploadBtn_Click(object sender, EventArgs e)
        { 
            if(NewImg.HasFile)
            {
                /* 1. 准备变量 */
                string new_filename = NewImg.FileName;
                string username = (string)Session["username"];
                DateTime uploadtime = DateTime.Now;
                int downtimes = 0;
                string new_type = NewType.SelectedValue;

                MyDb dbHelper = new MyDb();
                int id = int.Parse(OldId.Value);
                string old_filename = OldFilename.Value;
                string saveDir = @"\Images\uploadedImgs\user_" + Session["username"] + "\\";
                string appPath = Request.PhysicalApplicationPath;

                /* 2. 删除数据库、服务器中原图片 */
                string sql = "DELETE FROM ImgInfo WHERE Id = " + id;
                dbHelper.cud(sql);
                string old_file = System.Web.HttpContext.Current.Server.MapPath(saveDir + old_filename);
                if (System.IO.File.Exists(old_file))
                {
                    System.IO.File.Delete(old_file);
                }

                /* 3. 上传新图片到服务器 */
                string savePath = appPath + saveDir + new_filename;
                NewImg.SaveAs(savePath);

                /* 4. 新图片插入数据库 */
                sql = "INSERT INTO ImgInfo (name, username, uploadtime, type, downtimes, imgpath) values " +
                    "(@name, @username, @uploadtime, @type, @downtimes, @imgpath)";
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@name", new_filename);
                param[1] = new SqlParameter("@username", username);
                param[2] = new SqlParameter("@uploadtime", uploadtime);
                param[3] = new SqlParameter("@type", new_type);
                param[4] = new SqlParameter("@downtimes", downtimes);
                param[5] = new SqlParameter("@imgpath", saveDir + new_filename);
                dbHelper.cud(sql, param);

                Response.Redirect("album.aspx");
            }
            else
            {
                Response.Write("<script>alert('上传失败！')</script>");
            }
        }
    }
}