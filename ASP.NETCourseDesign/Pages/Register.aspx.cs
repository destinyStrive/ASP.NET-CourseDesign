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
            if (Page.IsValid)
            {
                // 1. 验证通过，获取用户的输入
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
                string image_path = UploadPic();
                string remark = Remark.Text;

                // 2. 将数据插入数据库
                string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection conn = new SqlConnection(connStr);
                try
                {
                    conn.Open();
                    SqlCommand cmd1 = new SqlCommand("insert into UserInfo values(@username, @password, @email, @age, @sex, @hobbies, @image, @remark)", conn);
                    cmd1.Parameters.Add("@username", SqlDbType.VarChar);
                    cmd1.Parameters.Add("@password", SqlDbType.VarChar);
                    cmd1.Parameters.Add("@email", SqlDbType.VarChar);
                    cmd1.Parameters.Add("@age", SqlDbType.Int);
                    cmd1.Parameters.Add("@sex", SqlDbType.NChar);
                    cmd1.Parameters.Add("@hobbies", SqlDbType.NVarChar);
                    cmd1.Parameters.Add("@image", SqlDbType.NVarChar);
                    cmd1.Parameters.Add("@remark", SqlDbType.NVarChar);
                    cmd1.Parameters[0].Value = username;
                    cmd1.Parameters[1].Value = psd1;
                    cmd1.Parameters[2].Value = email;
                    cmd1.Parameters[3].Value = age;
                    cmd1.Parameters[4].Value = sex;
                    cmd1.Parameters[5].Value = hobbies;
                    cmd1.Parameters[6].Value = image_path;
                    cmd1.Parameters[7].Value = remark;
                    int cnt1 = (int)cmd1.ExecuteNonQuery();
                    if (cnt1 == 0)
                    {
                        Response.Write("<script>alert('注册失败！');</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('注册成功！');</script>");
                    }
                    conn.Close();
                }
                catch (Exception ee)
                {
                    Response.Write(ee.Message);
                }
            }
            else
            {
                // 验证不通过...
            }
        }
        protected string UploadPic()
        {
            string saveDir = @"\Images\"; // 指定文件夹
            string appPath = Request.PhysicalApplicationPath;
            if (ImageUpload.HasFile) // 判断是否选择了图片
            {
                // 选择了，就利用FileUpload.FileName取出选择的图片名称
                string savePath = appPath + saveDir + ImageUpload.FileName;
                ImageUpload.SaveAs(savePath);
                return @"/Images/" + ImageUpload.FileName; // HiddenField存储图片路径
            }
            return null;
        }
    }
}