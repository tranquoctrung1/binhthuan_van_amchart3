using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Security;
using PMAC.BLL;
using PMAC.ULT;


public partial class Empty : System.Web.UI.MasterPage
{
    UserBL _userBL = new UserBL();

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
