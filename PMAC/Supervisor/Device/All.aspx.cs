using PMAC.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Supervisor_Device_All : System.Web.UI.Page
{
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        // Pi-solution
        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Device/All.aspx")).ToList();

            var var1 = list.Where(x => x.ControlId.Contains("Tab1")).FirstOrDefault();
            RadTabStrip1.Tabs[0].Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("Tab2")).FirstOrDefault();
            RadTabStrip1.Tabs[1].Text = (var2 == null) ? "" : var2.Contents;
            var var3 = list.Where(x => x.ControlId.Contains("Tab3")).FirstOrDefault();
            RadTabStrip1.Tabs[2].Text = (var3 == null) ? "" : var3.Contents;

            var var4 = list.Where(x => x.ControlId.Contains("lbTitle")).FirstOrDefault();
            lbTitle.Text = (var4 == null) ? "" : var4.Contents;
        }
    }
}