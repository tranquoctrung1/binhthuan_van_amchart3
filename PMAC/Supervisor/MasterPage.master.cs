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


public partial class supervisor_MasterPage : System.Web.UI.MasterPage
{
    // Pi-solution
    UserBL _userBL = new UserBL();
    RoleFunctionBL _roleFunctionBL = new RoleFunctionBL();
    FunctionBL languageobj = new FunctionBL();
    LanguageBL languageBL = new LanguageBL();
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
            title.Text = sysParamBL.FindSingle(x => x.Name == "title").Val;
        }

        string IP = GetLanIPAddress();
        if (string.IsNullOrEmpty(IP)||IP.Contains('%'))
        {
            IP=GetVisitorIpAddress();
        }
        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            t_Users user = new t_Users();
            string username = HttpContext.Current.User.Identity.Name;
            // Update name - Pi-solution developer
            lbUserName.Text = username;
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
            t_RoleFunction _functions  = new t_RoleFunction();
            List<int> dbfunction = (from a in _roleFunctionBL.FindAll(s => s.Role == role && s.Active == true ).ToList() select a.FunctionId).ToList();
            //URL by Role
            List<string> fun = (from q in languageobj.FindAll(s => dbfunction.Contains(s.FunctionId) && s.Language=="vi").ToList() select q.URL).ToList();
            hidListMenu.Value = "@";
            foreach (var _f in fun) {
                hidListMenu.Value = hidListMenu.Value + _f + "@";
            }


        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }

        // Update logo
        var sysParamList = sysParamBL.FindAll().ToList();
        var var0 = sysParamList.Where(x => x.ID == 2).FirstOrDefault();
        imgLogo.Src = (var0 == null) ? "" : var0.Val;
        // Update Company name
        var var01 = sysParamList.Where(x => x.Name == "company_name").FirstOrDefault();
        lbCompany.Text = (var01 == null) ? "" : var01.Val;

        
        // Programming language - Pi solution
        if (Session["myapplication.language"] != null)
        {
            language = (Session["myapplication.language"]).ToString();
            if (!IsPostBack)
            {
                // Set drop down current language
                DropDownList_Language.ClearSelection();
                DropDownList_Language.Items.FindByValue(Session["myapplication.language"].ToString()).Selected = true;
            }
            
            // Load Language from SQL database
            var functionList = languageobj.FindAll(x => x.Language == language).ToList();

            // Update home page + language
            List<t_LanguageTranslate> contentList = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("title_homepage")).ToList();
            var var001 = contentList.Where(x => x.ControlId.Contains("title_homepage")).FirstOrDefault(); ;
            lbPageTitle.Text = (var001 == null) ? "" : var001.Contents;

            Page.Title = lbPageTitle.Text;

            var var1 = functionList.Where(x => x.URL.Contains("MapJS_rev1.aspx")).FirstOrDefault();
            lbGeneralMap.Text = (var1 == null) ? "" : var1.FunctionName;
            var var2 = functionList.Where(x => x.URL.Contains("MapJS_rev1_DMA.aspx")).FirstOrDefault();
            lbDMAMap.Text = (var2 == null) ? "" : var2.FunctionName;
            var var3 = functionList.Where(x => x.ParentId == 3).FirstOrDefault();
            lbData.Text = (var3 == null) ? "" : var3.FunctionName;

            t_Function var4 = functionList.Where(x => x.URL.Contains("Complex_TA.aspx")).FirstOrDefault();
            lbDataTable.Text = (var4 == null) ? "" : var4.FunctionName;
            var var5 = functionList.Where(x => x.URL.Contains("Daily_Monthly.aspx")).FirstOrDefault();
            lbLoggerData.Text = (var5 == null) ? "" : var5.FunctionName;
            var var6 = functionList.Where(x => x.URL.Contains("Add_Change.aspx")).FirstOrDefault();
            lbManualData.Text = (var6 == null) ? "" : var6.FunctionName;
            var var7 = functionList.Where(x => x.URL.Contains("MinMaxVal.aspx")).FirstOrDefault();
            lbMinMaxValues.Text = (var7 == null) ? "" : var7.FunctionName;
            var var8 = functionList.Where(x => x.ParentId == 4).FirstOrDefault();
            lbReport.Text = (var8 == null) ? "" : var8.FunctionName;
            var var9 = functionList.Where(x => x.URL.Contains("Press.aspx")).FirstOrDefault();
            lbPressure.Text = (var9 == null) ? "" : var9.FunctionName;
            var var10 = functionList.Where(x => x.URL.Contains("Montly.aspx")).FirstOrDefault();
            lbVolume.Text = (var10 == null) ? "" : var10.FunctionName;
            var var11 = functionList.Where(x => x.ParentId == 5).FirstOrDefault();
            blEAndsL.Text = (var11 == null) ? "" : var11.FunctionName;
            var var12 = functionList.Where(x => x.URL.Contains("All.aspx")).FirstOrDefault();
            lbEquipments.Text = (var12 == null) ? "" : var12.FunctionName;
            var var13 = functionList.Where(x => x.URL.Contains("Config.aspx")).FirstOrDefault();
            lbInstallationPoints.Text = (var1 == null) ? "" : var13.FunctionName;
            var var14 = functionList.Where(x => x.ParentId ==6).FirstOrDefault();
            lbAdminPanel.Text = (var14 == null) ? "" : var14.FunctionName;
            var var15 = functionList.Where(x => x.URL.Contains("ViewUsers.aspx")).FirstOrDefault();
            lbViewUserDetails.Text = (var15 == null) ? "" : var15.FunctionName;
            var var16 = functionList.Where(x => x.URL.Contains("CreateUser.aspx")).FirstOrDefault();
            lbCreateUsers.Text = (var16 == null) ? "" : var16.FunctionName;
            var var17 = functionList.Where(x => x.URL.Contains("SettingSMS.aspx")).FirstOrDefault();
            lbMessageSettings.Text = (var17 == null) ? "" : var17.FunctionName;
            var var18 = functionList.Where(x => x.URL.Contains("ChangePassword.aspx")).FirstOrDefault();
            lbChangePassword.Text = (var18 == null) ? "" : var18.FunctionName;
            var var19 = functionList.Where(x => x.ParentId == 8).FirstOrDefault();
            lbLanguageManagement.Text = (var19 == null) ? "" : var19.FunctionName;
            var var20 = functionList.Where(x => x.URL.Contains("ChangeFunction.aspx")).FirstOrDefault();
            lbFunctions.Text = (var20 == null) ? "" : var20.FunctionName;
            var var21 = functionList.Where(x => x.URL.Contains("ChangeContent.aspx")).FirstOrDefault();
            lbContents.Text = (var21 == null) ? "" : var21.FunctionName;

            var var22 = functionList.Where(x => x.ParentId == 9).FirstOrDefault();
            lbConfigSystem.Text = (var22 == null) ? "" : var22.FunctionName;
            var var23 = functionList.Where(x => x.URL.Contains("System/General.aspx")).FirstOrDefault();
            lbGeneralSystem.Text = (var23 == null) ? "" : var23.FunctionName;
            var var24 = functionList.Where(x => x.URL.Contains("System/Users.aspx")).FirstOrDefault();
            lbUserManagement.Text = (var24 == null) ? "" : var24.FunctionName;
            var var25 = functionList.Where(x => x.URL.Contains("System/Roles.aspx")).FirstOrDefault();
            lbRoleManagement.Text = (var25 == null) ? "" : var25.FunctionName;
            var var26 = functionList.Where(x => x.URL.Contains("System/RoleFunction.aspx")).FirstOrDefault();
            lbRoleFunctionManagement.Text = (var26 == null) ? "" : var26.FunctionName;
        }
        
    }

    protected void DropDownList_Language_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Set the session variable with the selected language
        switch (DropDownList_Language.SelectedValue)
        {
            case "en":
                this.SetMyNewCulture("en");
                break;
            case "vi":
                this.SetMyNewCulture("vi");
                break;
            case "other":
                this.SetMyNewCulture("other");
                break;
            default:
                break;
        }
    }

    private void SetMyNewCulture(string culture)
    {
        Session["myapplication.language"] = culture;
        Page.Response.Redirect(Request.RawUrl);
    }
}
