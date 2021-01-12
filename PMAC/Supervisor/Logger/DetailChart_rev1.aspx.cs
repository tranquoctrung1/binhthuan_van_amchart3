using PMAC.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Supervisor_Logger_DetailChart_rev1 : System.Web.UI.Page
{
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        // Pi-solution developer - multi languages
        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Logger/DetailChart_rev1.aspx")).ToList();

            //Parse content to form
            var var1 = list.Where(x => x.ControlId.Contains("lbFrom")).FirstOrDefault();
            lbFrom.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("lbTo")).FirstOrDefault();
            lbTo.Text = (var2 == null) ? "" : var2.Contents;

            var var3 = list.Where(x => x.ControlId.Contains("btnUpdateChart")).FirstOrDefault();
            btnUpdateChart.Value = (var3 == null) ? "" : var3.Contents;
            var var4 = list.Where(x => x.ControlId.Contains("btnClearChart")).FirstOrDefault();
            btnClearChart.Value = (var4 == null) ? "" : var4.Contents;
            
        }
    }
}