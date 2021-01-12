using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;

public partial class Supervisor_Logger_Local : System.Web.UI.Page
{
    SiteBL _siteBL = new SiteBL();
    UserBL _userBL = new UserBL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
        }
    }
   
}