
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
using PMAC.BLL;
using PMAC.ULT;


public partial class Consumer_Logger_MapJS_rev1_DMA : System.Web.UI.Page
{
    // Pi-solution
    UserBL _userBL = new UserBL();
    RoleFunctionBL _roleFunctionBL = new RoleFunctionBL();
    FunctionBL languageobj = new FunctionBL();
    SysParamBL sysParamBL = new SysParamBL();
    private static string language = "vi";

    public string GetVisitorIpAddress()
    {
        string stringIpAddress;
        stringIpAddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (stringIpAddress == null) //may be the HTTP_X_FORWARDED_FOR is null
        {
            stringIpAddress = Request.ServerVariables["REMOTE_ADDR"];//we can use REMOTE_ADDR
        }
        return stringIpAddress;
    }

    //Get Lan Connected IP address method
    public string GetLanIPAddress()
    {
        //Get the Host Name
        string stringHostName = Dns.GetHostName();
        //Get The Ip Host Entry
        IPHostEntry ipHostEntries = Dns.GetHostEntry(stringHostName);
        //Get The Ip Address From The Ip Host Entry Address List
        IPAddress[] arrIpAddress = ipHostEntries.AddressList;
        return arrIpAddress[arrIpAddress.Length - 1].ToString();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }

        string IP = GetLanIPAddress();
        if (string.IsNullOrEmpty(IP) || IP.Contains('%'))
        {
            IP = GetVisitorIpAddress();
        }
        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            t_Users user = new t_Users();
            string username = HttpContext.Current.User.Identity.Name;
            // Update name - Pi-solution developer
           // lbUserName.Text = username;
            t_Users dbUser = _userBL.GetUser(username);
            user = dbUser;
            user.Active = true;
            string hostName = Dns.GetHostName();
            user.Ip = Dns.GetHostAddresses(hostName).GetValue(0).ToString();
            user.Ip = IP;
            user.TimeStamp = DateTime.Now;
            _userBL.UpdateUser(user, dbUser);
            string role = user.Role;
            //RoleFunciton
            t_RoleFunction _functions = new t_RoleFunction();
            List<int> dbfunction = (from a in _roleFunctionBL.FindAll(s => s.Role == role && s.Active == true).ToList() select a.FunctionId).ToList();
            //URL by Role
            List<string> fun = (from q in languageobj.FindAll(s => dbfunction.Contains(s.FunctionId)).ToList() select q.URL).ToList();
            //hidListMenu.Value = "@";
            //foreach (var _f in fun)
            //{
            //    hidListMenu.Value = hidListMenu.Value + _f + "@";
            //}


        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }

        // Update logo
        var sysParamList = sysParamBL.FindAll().ToList();
        var var0 = sysParamList.Where(x => x.ID == 2).FirstOrDefault();
      //  imgLogo.Src = (var0 == null) ? "" : var0.Val;
        // Update Company name
        var var01 = sysParamList.Where(x => x.Name == "company_name").FirstOrDefault();
     //   lbCompany.Text = (var01 == null) ? "" : var01.Val;
        // Update home page
        var var001 = sysParamList.Where(x => x.Name == "home_page").FirstOrDefault();
      //  lbPageTitle.Text = (var001 == null) ? "" : var001.Val;

        // Programming language - Pi solution
        if (Session["myapplication.language"] != null)
        {
            language = (Session["myapplication.language"]).ToString();
            if (!IsPostBack)
            {
                // Set drop down current language
                //DropDownList_Language.ClearSelection();
                //DropDownList_Language.Items.FindByValue(Session["myapplication.language"].ToString()).Selected = true;
            }

            //// Load Language from SQL database
            //var functionList = languageobj.FindAll(x => x.Language == language).ToList();

            //var var1 = functionList.Where(x => x.URL.Contains("MapJS_rev1.aspx")).FirstOrDefault();
            //lbGeneralMap.Text = (var1 == null) ? "" : var1.FunctionName;
            //var var2 = functionList.Where(x => x.URL.Contains("MapJS_rev1_DMA.aspx")).FirstOrDefault();


            //t_Function var4 = functionList.Where(x => x.URL.Contains("Complex_TA.aspx")).FirstOrDefault();
            //lbDataTable.Text = (var4 == null) ? "" : var4.FunctionName;
            //var var5 = functionList.Where(x => x.URL.Contains("Daily_Monthly.aspx")).FirstOrDefault();
            //lbLoggerData.Text = (var5 == null) ? "" : var5.FunctionName;

        }

    }


    //protected void DropDownList_Language_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //Set the session variable with the selected language
    //    switch (DropDownList_Language.SelectedValue)
    //    {
    //        case "en":
    //            this.SetMyNewCulture("en");
    //            break;
    //        case "vi":
    //            this.SetMyNewCulture("vi");
    //            break;
    //        case "other":
    //            this.SetMyNewCulture("other");
    //            break;
    //        default:
    //            break;
    //    }
    //}

    private void SetMyNewCulture(string culture)
    {
        Session["myapplication.language"] = culture;
        Page.Response.Redirect(Request.RawUrl);
    }
}
