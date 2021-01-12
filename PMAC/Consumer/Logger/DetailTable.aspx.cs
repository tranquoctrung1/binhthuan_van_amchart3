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

    protected void Page_Load(object sender, EventArgs e)
    {
        CultureInfo culture = new CultureInfo("en-GB");
        string siteID = Request.QueryString["si"];
        double oADate = double.Parse(Request.QueryString["dt"]);
        DateTime date = DateTime.FromOADate(oADate);
        t_Sites site = _siteBL.GetSite(siteID);
        var list = _loggerDataHelper.GetComplexLoggerData(site.SiteId, date, date);
        lblTitle.Text = "Chi tiết dữ liệu logger điểm " + site.SiteAliasName + " (" + site.Location + ") " + date.ToString("dd-MM-yyyy");
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
        if (dtmStart.SelectedDate == null)
        {
            ntf.Text = "Chưa nhập ngày bắt đầu.";
            ntf.VisibleOnPageLoad = true;
            dtmStart.Focus();
            return;
        }
        if (dtmEnd.SelectedDate == null)
        {
            ntf.Text = "Chưa nhập ngày kết thúc.";
            ntf.VisibleOnPageLoad = true;
            dtmEnd.Focus();
            return;
        }
        DateTime startDate = (DateTime)dtmStart.SelectedDate;
        DateTime endDate = (DateTime)dtmEnd.SelectedDate;
        string siteID = Request.QueryString["si"];
        t_Sites site = _siteBL.GetSite(siteID);
        var list = _loggerDataHelper.GetComplexLoggerData(site.SiteId, startDate, endDate);
        lblTitle.Text = "Chi tiết dữ liệu logger điểm " + site.Location + " (" + site.SiteAliasName + ") " + startDate.ToString("dd-MM-yyyy") + " đến " + endDate.ToString("dd-MM-yyyy");
        grv.DataSource = list;
        grv.DataBind();
        grv.ExportSettings.FileName = site.SiteAliasName + "_" + startDate.ToString("yyyy_MM_dd") + "_to_" + endDate.ToString("yyyy_MM_dd");
    }
}