using PMAC.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Consumer_Logger_Daily_Monthy : System.Web.UI.Page
{
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        // Pi-solution
        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Logger/Daily_Monthly.aspx")).ToList();

            // Language - Pi-solution
            var var1 = list.Where(x => x.ControlId.Contains("Tab1")).FirstOrDefault();
            RadTabStrip1.Tabs[0].Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("Tab2")).FirstOrDefault();
            RadTabStrip1.Tabs[1].Text = (var2 == null) ? "" : var2.Contents;

            var var01 = list.Where(x => x.ControlId.Contains("lbTitle")).FirstOrDefault();
            lbTitle.Text = (var01 == null) ? "" : var01.Contents;
        }
    }
}