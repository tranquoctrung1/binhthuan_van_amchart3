using PMAC.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Consumer_Logger_MapJS : System.Web.UI.Page
{
    UserBL _userBL = new UserBL();
    SiteBL _siteBL = new SiteBL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            t_Users user = new t_Users();
            string username = HttpContext.Current.User.Identity.Name;
            t_Users dbUser = _userBL.GetUser(username);
            user = dbUser;
            user.Active = true;
            string hostName = Dns.GetHostName();
            user.Ip = Dns.GetHostAddresses(hostName).GetValue(0).ToString();
            user.TimeStamp = DateTime.Now;
            _userBL.UpdateUser(user, dbUser);
        }
    }
}