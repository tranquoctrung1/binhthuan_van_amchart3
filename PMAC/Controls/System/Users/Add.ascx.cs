using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;
using PMAC.ULT;

public partial class Controls_System_ucUser_Add : System.Web.UI.UserControl
{
    UserBL _userBL = new UserBL();
    StringUT _stringUT = new StringUT();
    SysParamBL sysParamBL = new SysParamBL();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        // Pi-solution
        language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/System/Users/Add.aspx")).ToList();

        if (!IsPostBack)
        {
            // Language - Pi-solution

            var var1 = list.Where(x => x.ControlId.Contains("lbUserName")).FirstOrDefault();
            lbUserName.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("lbPassword")).FirstOrDefault();
            lbPassword.Text = (var2 == null) ? "" : var2.Contents;
            var var3 = list.Where(x => x.ControlId.Contains("lbStaffId")).FirstOrDefault();
            lbStaffId.Text = (var3 == null) ? "" : var3.Contents;
            var var4 = list.Where(x => x.ControlId.Contains("lbConsumerId")).FirstOrDefault();
            lbConsumerId.Text = (var4 == null) ? "" : var4.Contents;
            var var5 = list.Where(x => x.ControlId.Contains("lbEmail")).FirstOrDefault();
            lbEmail.Text = (var5 == null) ? "" : var5.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("lbRole")).FirstOrDefault();
            lbRole.Text = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("lbActive")).FirstOrDefault();
            lbActive.Text = (var7 == null) ? "" : var7.Contents;
        }
    }
    

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            bool active = (ddlActive.SelectedValue == "True") ? true : false;
            string salt = _stringUT.CreateSalt(8);
            string hashedPassword = _stringUT.HashMD5(_stringUT.HashMD5(txtPassword.Text) + salt);

            t_Users user = new t_Users {
                Username = txtUserName.Text,
                ConsumerId = txtConsumerId.Text,
                StaffId = txtStaffId.Text,
                Email = txtEmail.Text,
                Role = ddlRole.SelectedValue,
                Active = active,
                Password = hashedPassword,
                Salt = salt,
            };
            _userBL.InsertUser(user);

            string urlRedirect = string.Format("/Supervisor/System/Users.aspx");
            Response.Redirect(urlRedirect);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        string urlRedirect = string.Format("/Supervisor/System/Users.aspx");
        Response.Redirect(urlRedirect);
    }
}