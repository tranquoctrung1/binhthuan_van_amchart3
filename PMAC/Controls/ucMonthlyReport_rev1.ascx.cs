using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;

using Telerik.Web.UI;
public partial class Controls_ucMonthlyReport_rev1 : System.Web.UI.UserControl
{
    SiteBL _siteBL = new SiteBL();
    ComplexDataHelper _complexDataHelper = new ComplexDataHelper();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;

        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Logger/Daily_Monthly.aspx")).ToList();

            var var01 = list.Where(x => x.ControlId.Contains("lbMonthlyFrom")).FirstOrDefault();
            lbMonthlyFrom.Text = (var01 == null) ? "" : var01.Contents;
            var var02 = list.Where(x => x.ControlId.Contains("lbMonthlyTo")).FirstOrDefault();
            lbMonthlyTo.Text = (var02 == null) ? "" : var02.Contents;
            var var03 = list.Where(x => x.ControlId.Contains("btnView_tab2")).FirstOrDefault();
            btnView.Text = (var03 == null) ? "" : var03.Contents;
            var var04 = list.Where(x => x.ControlId.Contains("btnExport_tab2")).FirstOrDefault();
            btnExport.Text = (var04 == null) ? "" : var04.Contents;


            // Change header of rad grid
            var var5 = list.Where(x => x.ControlId.Contains("grv_TimeStamp")).FirstOrDefault();
            grv.MasterTableView.GetColumn("Time").HeaderText = (var5 == null) ? "" : var5.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("grv_SiteAliasName")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column13").HeaderText = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("grv_MaxFlowRate")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column14").HeaderText = (var7 == null) ? "" : var7.Contents;
            var var8 = list.Where(x => x.ControlId.Contains("grv_MinFlowRate")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column15").HeaderText = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("grv_Output")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column2").HeaderText = (var9 == null) ? "" : var9.Contents;

            var var10 = list.Where(x => x.ControlId.Contains("grv_MaxPressure")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column16").HeaderText = (var10 == null) ? "" : var10.Contents;

            var var11 = list.Where(x => x.ControlId.Contains("grv_MinPressure")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column17").HeaderText = (var11 == null) ? "" : var11.Contents;
            var var12 = list.Where(x => x.ControlId.Contains("grv_Trending")).FirstOrDefault();
            grv.MasterTableView.GetColumn("lnkColumns").HeaderText = (var12 == null) ? "" : var12.Contents;

        }
    }
    protected void grv_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Logger/Daily_Monthly.aspx")).ToList();
        var var1 = list.Where(x => x.ControlId.Contains("grv_Trending_lnkChart")).FirstOrDefault();
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            HyperLink lnkChart = (HyperLink)item.FindControl("lnkChart");
            lnkChart.Text = (var1 == null) ? "" : var1.Contents;
        }

        CultureInfo culture = new CultureInfo("en-GB");
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = (GridDataItem)e.Item;
            HyperLink lnkChart = (HyperLink)e.Item.FindControl("lnkChart");
            lnkChart.Attributes["href"] = "#";
            lnkChart.Attributes["onclick"] = String.Format("return ShowChartFormMonthy('{0}','{1}','{2}','{3}');",
                e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["SiteId"],
                DateTime.Parse(dataItem["Time"].Text, culture).ToOADate().ToString().Replace('.', '-'), HttpContext.Current.User.Identity.Name, e.Item.ItemIndex);
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

        grv.DataSource = GetData();
        grv.DataBind();
        grv.ExportSettings.FileName = "Monthly_" + startDate.ToString("yyyy_MM");
    }

    public IList<ComplexDataViewModel> GetData()
    {
        if (myStart.SelectedDate != null && myEnd.SelectedDate != null)
        {
            DateTime startDate = (DateTime)myStart.SelectedDate;
            DateTime endDate = (DateTime)myEnd.SelectedDate;
            startDate = DateTime.Parse(startDate.ToString("yyyy-MM"));
            endDate = DateTime.Parse(endDate.ToString("yyyy-MM"));

            List<string> loggerIds = new List<string>();
            foreach (RadListBoxItem item in listBoxSelectedSites.Items)
            {
                loggerIds.Add(_siteBL.GetSite(item.Value).LoggerId);
            }
            var listMonthlyComplexData = _complexDataHelper.GetMonthlyComplexData_Multiple(loggerIds, startDate, endDate);
            return listMonthlyComplexData;
        }
        else return null;
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Logger/Daily_Monthly.aspx")).ToList();

        //Parse content to form
        var lbMonthlyFrom = list.Where(x => x.ControlId.Contains("lbMonthlyFrom")).FirstOrDefault();
        var lbMonthlyTo = list.Where(x => x.ControlId.Contains("lbMonthlyTo")).FirstOrDefault();

        string dateTimeFormat = "MM/yyyy";
        //var site = _siteBL.GetSite(cboSites.SelectedValue);

        DateTime? startDate = myStart.SelectedDate;
        DateTime? endDate = myEnd.SelectedDate;
        string caption = "";
        if (startDate != null && endDate != null)
        {
            string strStartDate = ((DateTime)startDate).ToString(dateTimeFormat);
            string strEndDate = ((DateTime)endDate).ToString(dateTimeFormat);

            caption = "Monthly_ "
            + lbMonthlyFrom.Contents + " " + strStartDate + " "
            + lbMonthlyTo.Contents + " " + strEndDate;
        }
        else
        {
            caption = "Monthly_";
        }

        this.grv.MasterTableView.Caption = caption;

        this.grv.MasterTableView.GetColumn("lnkColumns").Display = false;
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

    protected void grv_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        grv.DataSource = GetData();
    }

    protected void grv_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        grv.DataSource = GetData();
    }
}