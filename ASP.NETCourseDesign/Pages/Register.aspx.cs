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
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RegisterBtn_Click(object sender, EventArgs e)
        {
            // 1. 获取用户的输入
            string username = Username.Text;
            string psd1 = Psd1.Text;
            string psd2 = Psd2.Text;
            string email = Email.Text;
            int age = int.Parse(Age.Text);
            string sex = null;
            foreach (ListItem li in SexRadioBtn.Items)
            {
                if (li.Selected)
                {
                    sex = li.Value;
                    break;
                }
            }
            string hobbies = "";
            foreach (ListItem li in HobbyCheckBox.Items)
            {
                if (li.Selected)
                {
                    hobbies += li.Value + ",";
                }
            }
            if (hobbies == "") hobbies = "无";
            else hobbies = hobbies.Substring(0, hobbies.Length - 1);
            string remark = Remark.Text;

            // 2. 判断用户名是否已存在
            MyDb dbHelper = new MyDb();
            string sql1 = "select count(*) from UserInfo where username=@username";
            SqlParameter[] params1 = new SqlParameter[1];
            params1[0] = new SqlParameter("@username", username);
            DataTable dt1 = dbHelper.GetRecords(sql1, params1);
            int cnt1 = (int)dt1.Rows[0][0];
            CustomValidator1.IsValid = cnt1 == 0; // 不存在 => cnt1为0 => IsValid为true

            // 3. 将数据插入数据库
            if(Page.IsValid)
            {
                string image_path = UploadPic(username);

                string sql2 = "insert into UserInfo values(@username, @password, @email, @age, @sex, @hobbies, @image, @remark)";
                SqlParameter[] params2 = new SqlParameter[8];
                params2[0] = new SqlParameter("@username", username);
                params2[1] = new SqlParameter("@password", psd1);
                params2[2] = new SqlParameter("@email", email);
                params2[3] = new SqlParameter("@age", age);
                params2[4] = new SqlParameter("@sex", sex);
                params2[5] = new SqlParameter("@hobbies", hobbies);
                params2[6] = new SqlParameter("@image", image_path);
                params2[7] = new SqlParameter("@remark", remark);
                int cnt2 = dbHelper.cud(sql2, params2);
                if (cnt2 == 0)
                {
                    Response.Write("<script>alert('注册失败！');</script>");
                }
                else
                {
                    Response.Write("<script>alert('注册成功！'); location.replace('login.aspx'); </script>");
                }
            } 
        }
        protected string UploadPic(string username)
        {
            string saveDir = @"\Images\usersAvator\user" + username + "_"; // 指定文件夹
            string appPath = Request.PhysicalApplicationPath;
            if (ImageUpload.HasFile) // 判断是否选择了图片
            {
                // 选择了，就利用FileUpload.FileName取出选择的图片名称
                string savePath = appPath + saveDir + ImageUpload.FileName;
                ImageUpload.SaveAs(savePath);
                return @"/Images/usersAvator/user" + username + "_" + ImageUpload.FileName; // HiddenField存储图片路径
            }
            return null;
        }
    }
}