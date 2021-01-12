using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using PMAC.BLL;
using PMAC.ULT;

public partial class Controls_ucLogin : System.Web.UI.UserControl
{
    UserBL _userBL = new UserBL();
    StringUT _stringUT = new StringUT();
    SysParamBL sysParamBL = new SysParamBL();

    protected void Page_Load(object sender, EventArgs e)
    {
        //ntf.VisibleOnPageLoad = false;
        if (!IsPostBack)
        {
            // Pi-solution developer            
            t_SysParam logo = sysParamBL.FindSingle(s => s.Name == "img_logo");
            imgLogo.Src = (logo == null)? "" : logo.Val;

            t_SysParam companyName = sysParamBL.FindSingle(s => s.Name == "company_name");
            lbCompany.Text = (companyName == null) ? "" : companyName.Val;


            TextBox TextBoxUserName = Login1.FindControl("UserName") as TextBox;
            TextBoxUserName.Focus();

        }
    }
    //protected void btnOk_Click(object sender, EventArgs e)
    //{
    //    Login();
    //}

    //protected void txtPassword_TextChanged(object sender, EventArgs e)
    //{
    //    Login();
    //}

    private void Login()
    {
        //t_Users dbUser = _userBL.GetUser(txtUsername.Text);
        t_Users dbUser = _userBL.GetUser(Login1.UserName);
        if (dbUser == null)
        {
            //ntf.VisibleOnPageLoad = true;
            //ntf.Text = "Sai ký danh hoặc mật khẩu.";
            //txtUsername.Focus();
            return;
        }
        //string hashedPassword = _stringUT.HashMD5(_stringUT.HashMD5(txtPassword.Text) + dbUser.Salt);
        string hashedPassword = _stringUT.HashMD5(_stringUT.HashMD5(Login1.Password) + dbUser.Salt);
        if (string.Equals(hashedPassword, dbUser.Password))
        {
            HttpCookie cookie;
            System.Web.Security.FormsAuthenticationTicket ticket = new System.Web.Security.FormsAuthenticationTicket(1, dbUser.Username, DateTime.Now,
                        DateTime.Now.AddMinutes(HttpContext.Current.Session.Timeout),
                        true, dbUser.Role + "|" + dbUser.ConsumerId, System.Web.Security.FormsAuthentication.FormsCookiePath);
            string hashCookie = System.Web.Security.FormsAuthentication.Encrypt(ticket);
            cookie = new HttpCookie(System.Web.Security.FormsAuthentication.FormsCookieName, hashCookie);
            Response.Cookies.Add(cookie);
            t_Users user = new t_Users();
            user = dbUser;
            user.LoginTime = user.LoginTime == null ? 0 : user.LoginTime + 1;
            _userBL.UpdateUser(user, dbUser);
            if (dbUser.Role != "consumer" && dbUser.Role != "staff")
            {
                Response.Redirect("~/Supervisor/Logger/MapJS_rev1.aspx?uid=" + user.Username);
            }
            else
            {
                Response.Redirect("~/Consumer/Logger/MapJS_rev1.aspx?uid=" + user.Username);
            }
        }
        else
        {
            //ntf.VisibleOnPageLoad = true;
            //ntf.Text = "Sai ký danh hoặc mật khẩu.";
            //txtUsername.Focus();

            TextBox TextBoxUserName = Login1.FindControl("UserName") as TextBox;
            TextBoxUserName.Focus();

        }
    }
    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        Login();
    }
}