using Newtonsoft.Json;
using PMAC.BLL;
using PMAC.ULT;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.Services;

/// <summary>
/// Summary description for Pi1
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Pi1 : System.Web.Services.WebService
{

    UserBL _userBL = new UserBL();
    StringUT _stringUT = new StringUT();
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    public Pi1()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]    
    public string Login_pi(string username, string password)
    {
        t_Users dbUser = _userBL.GetUser(username);
        if (dbUser == null)
        {
            //ntf.VisibleOnPageLoad = true;
            //ntf.Text = "Sai ký danh hoặc mật khẩu.";
            //txtUsername.Focus();
            object result = new
            {
                resultId = 0,
                message = "Wrong username. Please try again"
            };
            return JsonConvert.SerializeObject(result);
        }
        //string hashedPassword = _stringUT.HashMD5(_stringUT.HashMD5(txtPassword.Text) + dbUser.Salt);
        string hashedPassword = _stringUT.HashMD5(_stringUT.HashMD5(password) + dbUser.Salt);
        if (string.Equals(hashedPassword, dbUser.Password))
        {
            HttpCookie cookie;
            
            System.Web.Security.FormsAuthenticationTicket ticket = new System.Web.Security.FormsAuthenticationTicket(1, dbUser.Username, DateTime.Now,
                        DateTime.Now.AddMinutes(120),
                        true, dbUser.Role + "|" + dbUser.ConsumerId, System.Web.Security.FormsAuthentication.FormsCookiePath);
            string hashCookie = System.Web.Security.FormsAuthentication.Encrypt(ticket);
            cookie = new HttpCookie(System.Web.Security.FormsAuthentication.FormsCookieName, hashCookie);
            Context.Response.Cookies.Add(cookie);
            t_Users user = new t_Users();
            user = dbUser;
            user.LoginTime = user.LoginTime == null ? 0 : user.LoginTime + 1;
            _userBL.UpdateUser(user, dbUser);

            string message = "";
            if (dbUser.Role == "consumer" || dbUser.Role == "staff" )
            {
                message = string.Format("Consumer/Logger/MapJS_rev1.aspx?uid={0}", user.Username);
            }
            else if(dbUser.Role == "vanviewer")
            {
                message = string.Format("VanViewer/BomControl/BomControl.aspx");
            }
            else
            {                
               message = string.Format("Supervisor/Logger/MapJS_rev1.aspx?uid={0}", user.Username);
            }
            object result = new
            {
                resultId = 1,
                message = message
            };
            return JsonConvert.SerializeObject(result); 
        }
        else
        {
            object result = new
            {
                resultId = 0,
                message = "Wrong password. Please try again"
            };
            return JsonConvert.SerializeObject(result);
        }
    }

    [WebMethod]
    public string Logout_pi()
    {
        Context.Response.Cookies.Remove(FormsAuthentication.FormsCookieName);
        Context.Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
        HttpCookie cookie = Context.Request.Cookies[FormsAuthentication.FormsCookieName];
        if (cookie != null)
        {
            cookie.Expires = DateTime.Now.AddDays(-1);
            Context.Response.Cookies.Add(cookie);
        }
        return "/Login.aspx";
    }


    [WebMethod(EnableSession = true)]
    public string LoggerId_check()
    {
        // Pi-solution
        language = (HttpContext.Current.Session["myapplication.language"] == null) ? "vi" : HttpContext.Current.Session["myapplication.language"].ToString();

        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();

        var var1 = list.Where(x => x.ControlId.Contains("logger_Id_check")).FirstOrDefault();

        return var1.Contents;
    }
}
