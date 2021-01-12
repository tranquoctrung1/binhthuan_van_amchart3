using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;
using PMAC.ULT;

public partial class Controls_System_ucRole_Add : System.Web.UI.UserControl
{
    RoleBL roleBL = new RoleBL();
    StringUT _stringUT = new StringUT();
    SysParamBL sysParamBL = new SysParamBL();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        // Pi-solution
        language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/System/Roles/Add.aspx")).ToList();

        if (!IsPostBack)
        {
            // Language - Pi-solution

            var var1 = list.Where(x => x.ControlId.Contains("btnSaveChanges")).FirstOrDefault();
            btnSaveChanges.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("btnCancelSave")).FirstOrDefault();
            btnCancelSave.Text = (var2 == null) ? "" : var2.Contents;
        }
    }
    

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            
            t_Roles role = new t_Roles
            {
                Role = string.Format("role-{0}", DateTime.Now.ToString("yyyyMMddHHmmss")),
                Description = txtDescription.Text
            };
            roleBL.AddRole(role);

            string urlRedirect = string.Format("/Supervisor/System/Roles.aspx");
            Response.Redirect(urlRedirect);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        string urlRedirect = string.Format("/Supervisor/System/Roles.aspx");
        Response.Redirect(urlRedirect);
    }
}