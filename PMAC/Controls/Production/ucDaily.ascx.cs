using PMAC.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_Production_ucDaily : System.Web.UI.UserControl
{
    SiteBL _siteBL = new SiteBL();
    ProductionReportBL _prodBL = new ProductionReportBL();

    LanguageBL languageBL = new LanguageBL();
    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;

        if (!IsPostBack)
        {


        }
    }

    private void SetEmpty()
    {
        grv2.DataSource = null;
        grv2.DataBind();
    }

    protected void mnuDisplayGroup_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        SetEmpty();
    }

    protected void cboSites_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        var site = _siteBL.GetSite(e.Value);
        cboConsumers2.SelectedValue = site.ConsumerId;
        SetEmpty();
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Warning")).ToList();

        var empty_start_date = list.Where(x => x.ControlId.Contains("empty_start_date")).FirstOrDefault();
        var empty_end_date = list.Where(x => x.ControlId.Contains("empty_end_date")).FirstOrDefault();

        if (myStart2.SelectedDate == null)
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = empty_start_date.Contents;
            myStart2.Focus();
            return;
        }
        if (myEnd2.SelectedDate == null)
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = empty_end_date.Contents;
            myEnd2.Focus();
            return;
        }
        DateTime startDate = (DateTime)myStart2.SelectedDate;
        DateTime endDate = (DateTime)myEnd2.SelectedDate;

        var site = _siteBL.GetSite(cboSites2.SelectedValue);
        List<ProductionReport> listReportDataViewModel = _prodBL.GetDailyProductionReport(site.SiteId, startDate, endDate);
        grv2.DataSource = listReportDataViewModel;
        grv2.DataBind();
        grv2.ExportSettings.FileName = site.SiteAliasName + "_" + startDate.ToString("dd-MM-yyyy HH:mm") + "--" + endDate.ToString("dd-MM-yyyy HH:mm");
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        try
        {
            //List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Report/Montly.aspx")).ToList();

            //var lbMonthlyFrom = list.Where(x => x.ControlId.Contains("lbMonthlyFrom")).FirstOrDefault();
            //var lbMonthlyTo = list.Where(x => x.ControlId.Contains("lbMonthlyTo")).FirstOrDefault();

            string dateTimeFormat = "dd-MM-yyyy HH:mm";
            var site = _siteBL.GetSite(cboSites2.SelectedValue);
            this.grv2.MasterTableView.Caption = site.SiteAliasName
                + " bắt đầu " + ((DateTime)myStart2.SelectedDate).ToString(dateTimeFormat)
                + " - kết thúc" + ((DateTime)myEnd2.SelectedDate).ToString(dateTimeFormat);

            this.grv2.MasterTableView.BorderStyle = BorderStyle.Solid;
            this.grv2.GridLines = GridLines.Both;
            grv2.MasterTableView.ExportToExcel();
        }
        catch (Exception ex)
        {

            //throw;
        }
    }
    protected void cboSites_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cboSites2.SelectedIndex = 0;
        }
    }
}