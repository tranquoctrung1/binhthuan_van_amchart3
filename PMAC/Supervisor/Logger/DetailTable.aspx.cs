using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using PMAC.BLL;

public partial class Supervisor_Logger_DetailTable : System.Web.UI.Page
{
    SiteBL _siteBL = new SiteBL();
    LoggerDataHelper _loggerDataHelper = new LoggerDataHelper();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";
    private static string tileContent = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        // Pi-solution developer - multi languages
        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> listLanguage = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Logger/DetailTable.aspx")).ToList();

            //Parse content to form
            var var1 = listLanguage.Where(x => x.ControlId.Contains("lbFrom")).FirstOrDefault();
            lbFrom.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = listLanguage.Where(x => x.ControlId.Contains("lbTo")).FirstOrDefault();
            lbTo.Text = (var2 == null) ? "" : var2.Contents;

            var var3 = listLanguage.Where(x => x.ControlId.Contains("btnView")).FirstOrDefault();
            btnView.Text = (var3 == null) ? "" : var3.Contents;
            var var4 = listLanguage.Where(x => x.ControlId.Contains("btnExport")).FirstOrDefault();
            btnExport.Text = (var4 == null) ? "" : var4.Contents;

            // Title
            var var5 = listLanguage.Where(x => x.ControlId.Contains("lbTitleContent")).FirstOrDefault();
            tileContent = (var5 == null) ? "" : var5.Contents;

            // Change header of rad grid
            var var15 = listLanguage.Where(x => x.ControlId.Contains("grv_TimeStamp")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column3").HeaderText = (var15 == null) ? "" : var15.Contents;
            var var16 = listLanguage.Where(x => x.ControlId.Contains("grv_FlowRate")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column").HeaderText = (var16 == null) ? "" : var16.Contents;
            var var17 = listLanguage.Where(x => x.ControlId.Contains("grv_ForwardIndex")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column2").HeaderText = (var17 == null) ? "" : var17.Contents;
            var var18 = listLanguage.Where(x => x.ControlId.Contains("grv_ReverseIndex")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column4").HeaderText = (var18 == null) ? "" : var18.Contents;
            var var19 = listLanguage.Where(x => x.ControlId.Contains("grv_NetIndex")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column5").HeaderText = (var19 == null) ? "" : var19.Contents;
            var var20 = listLanguage.Where(x => x.ControlId.Contains("grv_Pressure")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column1").HeaderText = (var20 == null) ? "" : var20.Contents;
        }

        CultureInfo culture = new CultureInfo("en-GB");
        string siteID = Request.QueryString["si"];
        double oADate = double.Parse(Request.QueryString["dt"]);
        DateTime date = DateTime.FromOADate(oADate);
        t_Sites site = _siteBL.GetSite(siteID);
        var list = _loggerDataHelper.GetComplexLoggerData(site.SiteId, date, date);
        lblTitle.Text = tileContent + " " + site.SiteAliasName + " (" + site.Location + ") " + date.ToString("dd-MM-yyyy");
        grv.DataSource = list;
        grv.DataBind();
        grv.ExportSettings.FileName = site.SiteAliasName + "_" + date.ToString("yyyy_MM_dd");
        ntf.VisibleOnPageLoad = false;
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        string dateTimeFormat = "dd/MM/yyyy HH:mm";

        DateTime? startDate = dtmStart.SelectedDate;
        DateTime? endDate = dtmEnd.SelectedDate;
        string caption = "";

        if (startDate != null && endDate != null)
        {
            string strStartDate = "";
            string strEndDate = "";
            
            strStartDate = ((DateTime)startDate).ToString(dateTimeFormat);
            strEndDate = ((DateTime)endDate).ToString(dateTimeFormat);

            caption = Request.QueryString["si"]
            + " Từ ngày " + strStartDate
            + " đến ngày " + strEndDate;
        }
        else
        {
            string strDate = DateTime.FromOADate(double.Parse(Request.QueryString["dt"])).ToString(dateTimeFormat);
            caption = Request.QueryString["si"] + " ngày " + strDate;
        }

        this.grv.MasterTableView.Caption = caption;
        this.grv.GridLines = GridLines.Both;
        this.grv.BorderStyle = BorderStyle.Solid;

        try
        {
            grv.MasterTableView.ExportToExcel();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list1 = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Warning")).ToList();
        var winTable_empty_start_date = list1.Where(x => x.ControlId.Contains("winTable_empty_start_date")).FirstOrDefault();
        var winTable_empty_end_date = list1.Where(x => x.ControlId.Contains("winTable_empty_end_date")).FirstOrDefault();

        if (dtmStart.SelectedDate == null)
        {
            ntf.Text = winTable_empty_start_date.Contents;
            ntf.VisibleOnPageLoad = true;
            dtmStart.Focus();
            return;
        }
        if (dtmEnd.SelectedDate == null)
        {
            ntf.Text = winTable_empty_end_date.Contents;
            ntf.VisibleOnPageLoad = true;
            dtmEnd.Focus();
            return;
        }
        DateTime startDate = (DateTime)dtmStart.SelectedDate;
        DateTime endDate = (DateTime)dtmEnd.SelectedDate;
        string siteID = Request.QueryString["si"];
        t_Sites site = _siteBL.GetSite(siteID);
        var list = _loggerDataHelper.GetComplexLoggerData(site.SiteId, startDate, endDate);
        lblTitle.Text = tileContent + " " + site.Location + " (" + site.SiteAliasName + ") " + startDate.ToString("dd-MM-yyyy") + " đến " + endDate.ToString("dd-MM-yyyy");



        grv.DataSource = list;
        grv.DataBind();
        grv.ExportSettings.FileName = site.SiteAliasName + "_" + startDate.ToString("yyyy_MM_dd") + "_to_" + endDate.ToString("yyyy_MM_dd");
    }
}