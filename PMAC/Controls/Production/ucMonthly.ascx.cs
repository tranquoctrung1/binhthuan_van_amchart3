using PMAC.BLL;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Controls_Production_ucMonthly : System.Web.UI.UserControl
{
    SiteBL _siteBL = new SiteBL();
    ReportHelper _reportHelper = new ReportHelper();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;

        if (!IsPostBack)
        {
            // Pi-solution
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Report/Montly.aspx")).ToList();

            var var01 = list.Where(x => x.ControlId.Contains("lbMonthlyFrom")).FirstOrDefault();
            lbMonthlyFrom.Text = (var01 == null) ? "" : var01.Contents;
            var var02 = list.Where(x => x.ControlId.Contains("lbMonthlyTo")).FirstOrDefault();
            lbMonthlyTo.Text = (var02 == null) ? "" : var02.Contents;
            var var03 = list.Where(x => x.ControlId.Contains("btnView")).FirstOrDefault();
            btnView.Text = (var03 == null) ? "" : var03.Contents;
            var var04 = list.Where(x => x.ControlId.Contains("btnExport")).FirstOrDefault();
            btnExport.Text = (var04 == null) ? "" : var04.Contents;
            var var05 = list.Where(x => x.ControlId.Contains("btnMail")).FirstOrDefault();
            btnMail.Text = (var05 == null) ? "" : var05.Contents;
            var var06 = list.Where(x => x.ControlId.Contains("lbAliasName")).FirstOrDefault();
            lbAliasName.Text = (var06 == null) ? "" : var06.Contents;
            var var07 = list.Where(x => x.ControlId.Contains("lbStaffId")).FirstOrDefault();
            lbStaffId.Text = (var07 == null) ? "" : var07.Contents;


            // Change header of rad grid
            var var5 = list.Where(x => x.ControlId.Contains("grv_Time")).FirstOrDefault();
            grv.MasterTableView.GetColumn("Time").HeaderText = (var5 == null) ? "" : var5.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("grv_SiteAliasName")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column13").HeaderText = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("grv_TemplateColumn")).FirstOrDefault();
            grv.MasterTableView.GetColumn("TemplateColumn").HeaderText = (var7 == null) ? "" : var7.Contents;
            var var8 = list.Where(x => x.ControlId.Contains("grv_TemplateColumn1")).FirstOrDefault();
            grv.MasterTableView.GetColumn("TemplateColumn1").HeaderText = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("grv_Output")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column").HeaderText = (var9 == null) ? "" : var9.Contents;


            // Change header of combobox
            Label label1 = cboSites.Header.FindControl("aliasname_header") as Label;
            var var39 = list.Where(x => x.ControlId.Contains("radComboBox_aliasname_header")).FirstOrDefault();
            label1.Text = (var39 == null) ? "" : var39.Contents;

            label1 = cboSites.Header.FindControl("location_header") as Label;
            var var40 = list.Where(x => x.ControlId.Contains("radComboBox_location_header")).FirstOrDefault();
            label1.Text = (var40 == null) ? "" : var40.Contents;

            // Change header of combobox
            Label label2 = cboConsumers.Header.FindControl("customerId_header") as Label;
            var var41 = list.Where(x => x.ControlId.Contains("radComboBox_customerId_header")).FirstOrDefault();
            label2.Text = (var41 == null) ? "" : var41.Contents;

            label2 = cboConsumers.Header.FindControl("customer_header") as Label;
            var var42 = list.Where(x => x.ControlId.Contains("radComboBox_customer_header")).FirstOrDefault();
            label2.Text = (var42 == null) ? "" : var42.Contents;

        }
    }

    private void SetEmpty()
    {
        grv.DataSource = null;
        grv.DataBind();
    }

    protected void mnuDisplayGroup_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        SetEmpty();
    }

    protected void cboSites_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        var site = _siteBL.GetSite(cboSites.SelectedValue);
        cboConsumers.SelectedValue = site.ConsumerId;
        SetEmpty();
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Warning")).ToList();

        var empty_start_date = list.Where(x => x.ControlId.Contains("empty_start_date")).FirstOrDefault();
        var empty_end_date = list.Where(x => x.ControlId.Contains("empty_end_date")).FirstOrDefault();

        if (myStart.SelectedDate == null)
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = empty_start_date.Contents;
            myStart.Focus();
            return;
        }
        if (myEnd.SelectedDate == null)
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = empty_end_date.Contents;
            myEnd.Focus();
            return;
        }
        DateTime startDate = (DateTime)myStart.SelectedDate;
        DateTime endDate = (DateTime)myEnd.SelectedDate;
        startDate = DateTime.Parse(startDate.ToString("yyyy-MM"));
        endDate = DateTime.Parse(endDate.ToString("yyyy-MM"));
        var site = _siteBL.GetSite(cboSites.SelectedValue);
        List<ReportDataViewModel> listReportDataViewModel = _reportHelper.GetMonthyReportData(site.SiteId, startDate, endDate);
        grv.DataSource = listReportDataViewModel;
        grv.DataBind();
        grv.ExportSettings.FileName = site.SiteAliasName + "_" + startDate.ToString("yyyy_MM");
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        try
        {
            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Report/Montly.aspx")).ToList();

            var lbMonthlyFrom = list.Where(x => x.ControlId.Contains("lbMonthlyFrom")).FirstOrDefault();
            var lbMonthlyTo = list.Where(x => x.ControlId.Contains("lbMonthlyTo")).FirstOrDefault();

            string dateTimeFormat = "MM/yyyy";
            var site = _siteBL.GetSite(cboSites.SelectedValue);
            this.grv.MasterTableView.Caption = site.SiteAliasName + " "
                + lbMonthlyFrom.Contents + " " + ((DateTime)myStart.SelectedDate).ToString(dateTimeFormat) + " "
                + lbMonthlyTo.Contents + " " + ((DateTime)myEnd.SelectedDate).ToString(dateTimeFormat);

            this.grv.MasterTableView.BorderStyle = BorderStyle.Solid;
            this.grv.GridLines = GridLines.Both;
            grv.MasterTableView.ExportToExcel();
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
            cboSites.SelectedIndex = 0;
        }
    }
}