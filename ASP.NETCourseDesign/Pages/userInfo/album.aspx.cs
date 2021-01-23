using System;
using System.Collections.Generic;
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
    }
}