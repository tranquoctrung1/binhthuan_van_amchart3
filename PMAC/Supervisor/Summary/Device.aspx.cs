using PMAC.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Supervisor_Summary_Device : System.Web.UI.Page
{
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Summary/Device.aspx")).ToList();

            var var01 = list.Where(x => x.ControlId.Contains("lbTitle")).FirstOrDefault();
            lbTitle.Text = (var01 == null) ? "" : var01.Contents;

            RadTab tab1 = RadTabStrip1.Tabs.FindTabByValue("tab1");
            var var02 = list.Where(x => x.ControlId.Contains("tab1_title")).FirstOrDefault();
            tab1.Text = (var02 == null) ? "" : var02.Contents;

            RadTab tab2 = RadTabStrip1.Tabs.FindTabByValue("tab2");
            var var03 = list.Where(x => x.ControlId.Contains("tab2_title")).FirstOrDefault();
            tab2.Text = (var03 == null) ? "" : var03.Contents;

            RadTab tab3 = RadTabStrip1.Tabs.FindTabByValue("tab3");
            var var04 = list.Where(x => x.ControlId.Contains("tab3_title")).FirstOrDefault();
            tab3.Text = (var04 == null) ? "" : var04.Contents;

            
        }
    }
}