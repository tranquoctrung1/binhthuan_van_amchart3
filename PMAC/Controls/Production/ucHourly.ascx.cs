using PMAC.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_Production_ucHourly : System.Web.UI.UserControl
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
        grv1.DataSource = null;
        grv1.DataBind();
    }

    protected void mnuDisplayGroup_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        SetEmpty();
    }

    protected void cboSites_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        var site = _siteBL.GetSite(e.Value);
        cboConsumers1.SelectedValue = site.ConsumerId;
        SetEmpty();
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Warning")).ToList();

        var empty_start_date = list.Where(x => x.ControlId.Contains("empty_start_date")).FirstOrDefault();
        var empty_end_date = list.Where(x => x.ControlId.Contains("empty_end_date")).FirstOrDefault();

        if (myStart1.SelectedDate == null)
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = empty_start_date.Contents;
            myStart1.Focus();
            return;
        }
        if (myEnd1.SelectedDate == null)
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = empty_end_date.Contents;
            myEnd1.Focus();
            return;
        }
        DateTime startDate = (DateTime)myStart1.SelectedDate;
        DateTime endDate = (DateTime)myEnd1.SelectedDate;

        var site = _siteBL.GetSite(cboSites1.SelectedValue);
        List<ProductionReport> listReportDataViewModel = _prodBL.GetHourlyProductionReport(site.SiteId, startDate, endDate);
        grv1.DataSource = listReportDataViewModel;
        grv1.DataBind();
        grv1.ExportSettings.FileName = site.SiteAliasName + "_" + startDate.ToString("dd-MM-yyyy HH:mm") + "--" + endDate.ToString("dd-MM-yyyy HH:mm");
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        try
        {
            //List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Report/Montly.aspx")).ToList();

            //var lbMonthlyFrom = list.Where(x => x.ControlId.Contains("lbMonthlyFrom")).FirstOrDefault();
            //var lbMonthlyTo = list.Where(x => x.ControlId.Contains("lbMonthlyTo")).FirstOrDefault();

            string dateTimeFormat = "dd-MM-yyyy HH:mm";
            var site = _siteBL.GetSite(cboSites1.SelectedValue);
            this.grv1.MasterTableView.Caption = site.SiteAliasName
                + " bắt đầu " + ((DateTime)myStart1.SelectedDate).ToString(dateTimeFormat)
                + " - kết thúc " + ((DateTime)myEnd1.SelectedDate).ToString(dateTimeFormat);

            this.grv1.MasterTableView.BorderStyle = BorderStyle.Solid;
            this.grv1.GridLines = GridLines.Both;
            grv1.MasterTableView.ExportToExcel();
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
            cboSites1.SelectedIndex = 0;
        }
    }
}