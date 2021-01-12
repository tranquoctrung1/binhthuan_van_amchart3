using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;

using Telerik.Web.UI;
using Telerik.Web.UI.GridExcelBuilder;

public partial class Controls_ucDailyReport_rev1 : System.Web.UI.UserControl
{
    SiteBL _siteBL = new SiteBL();
    ComplexDataHelper _complexDataHelper = new ComplexDataHelper();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;

        // Pi-solution developer - multi languages
        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Logger/Daily_Monthly.aspx")).ToList();

            //Parse content to form
            var var1 = list.Where(x => x.ControlId.Contains("lbFrom")).FirstOrDefault();
            lbFrom.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("lbTo")).FirstOrDefault();
            lbTo.Text = (var2 == null) ? "" : var2.Contents;
            var var3 = list.Where(x => x.ControlId.Contains("btnView")).FirstOrDefault();
            btnView.Text = (var3 == null) ? "" : var3.Contents;
            var var4 = list.Where(x => x.ControlId.Contains("btnExport")).FirstOrDefault();
            btnExport.Text = (var4 == null) ? "" : var4.Contents;


            // Change header of rad grid
            var var5 = list.Where(x => x.ControlId.Contains("grv_TimeStamp")).FirstOrDefault();
            grv.MasterTableView.GetColumn("Time").HeaderText = (var5 == null) ? "" : var5.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("grv_SiteAliasName")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column13").HeaderText = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("grv_MaxFlowRate")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column14").HeaderText = (var7 == null) ? "" : var7.Contents;
            var var8 = list.Where(x => x.ControlId.Contains("grv_MinFlowRate")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column17").HeaderText = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("grv_Output")).FirstOrDefault();
            grv.MasterTableView.GetColumn("Output").HeaderText = (var9 == null) ? "" : var9.Contents;

            var var10 = list.Where(x => x.ControlId.Contains("grv_MaxPressure")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column15").HeaderText = (var10 == null) ? "" : var10.Contents;

            var var13 = list.Where(x => x.ControlId.Contains("grv_Output_footer")).FirstOrDefault();
            GridBoundColumn outputColumn = grv.MasterTableView.GetColumn("Output") as GridBoundColumn;
            outputColumn.FooterAggregateFormatString = (var13 == null) ? "" : var13.Contents;

            var var11 = list.Where(x => x.ControlId.Contains("grv_MinPressure")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column16").HeaderText = (var11 == null) ? "" : var11.Contents;
            var var12 = list.Where(x => x.ControlId.Contains("grv_Trending")).FirstOrDefault();
            grv.MasterTableView.GetColumn("lnkColumn").HeaderText = (var12 == null) ? "" : var12.Contents;


            // Popup
            var var14 = list.Where(x => x.ControlId.Contains("grv_Trending_winTable")).FirstOrDefault();
            winTable.Title = (var14 == null) ? "" : var14.Contents;
            var var15 = list.Where(x => x.ControlId.Contains("grv_Trending_winChart")).FirstOrDefault();
            winChart.Title = (var15 == null) ? "" : var15.Contents;
        }

    }
    protected void grv_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Logger/Daily_Monthly.aspx")).ToList();
        var var1 = list.Where(x => x.ControlId.Contains("grv_Trending_lnkChart")).FirstOrDefault();
        var var2 = list.Where(x => x.ControlId.Contains("grv_Trending_lnkTable")).FirstOrDefault();
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            HyperLink lnkChart = (HyperLink)item.FindControl("lnkChart");
            lnkChart.Text = (var1 == null) ? "" : var1.Contents;
            HyperLink lnkTable = (HyperLink)item.FindControl("lnkTable");
            lnkTable.Text = (var2 == null) ? "" : var2.Contents;
        }

        CultureInfo culture = new CultureInfo("en-GB");
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = (GridDataItem)e.Item;
            HyperLink lnkTable = (HyperLink)e.Item.FindControl("lnkTable");
            lnkTable.Attributes["href"] = "#";
            lnkTable.Attributes["onclick"] = String.Format("return ShowTableForm('{0}','{1}','{2}');",
                e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["SiteId"],
                DateTime.Parse(dataItem["Time"].Text, culture).ToOADate().ToString().Replace('.', '-'), e.Item.ItemIndex);
            HyperLink lnkChart = (HyperLink)e.Item.FindControl("lnkChart");
            lnkChart.Attributes["href"] = "#";
            lnkChart.Attributes["onclick"] = String.Format("return ShowChartFormDaily('{0}','{1}','{2}','{3}');",
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

    public IList<ComplexDataViewModel> GetData()
    {
        if (dtmStart.SelectedDate != null && dtmEnd.SelectedDate != null)
        {
            DateTime startDate = (DateTime)dtmStart.SelectedDate;
            DateTime endDate = (DateTime)dtmEnd.SelectedDate;
            List<string> loggerIds = new List<string>();
            foreach (RadListBoxItem item in listBoxSelectedSites.Items)
            {
                loggerIds.Add(_siteBL.GetSite(item.Value).LoggerId);
            }
            var listDailyComplexData = _complexDataHelper.GetDailyComplexData_Multiple(loggerIds, startDate, endDate);

            //var tempMaxFlow = listDailyComplexData.Max(d => d.MaxFlowRate);
            //var maxFlow = listDailyComplexData.Where(d => d.MaxFlowRate == tempMaxFlow).ToList();

            //var tempMinFlow = listDailyComplexData.Min(d => d.MinFlowRate);
            //var minFlow = listDailyComplexData.Where(d => d.MinFlowRate == tempMinFlow).ToList();

            //var tempMaxPress = listDailyComplexData.Max(d => d.MaxPressure);
            //var maxPress = listDailyComplexData.Where(d => d.MaxPressure == tempMaxPress).ToList();

            //var tempMinPress = listDailyComplexData.Min(d => d.MinPressure);
            //var minPress = listDailyComplexData.Where(d => d.MinPressure == tempMinPress).ToList();

            return listDailyComplexData;
        }
        else return null;
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Warning")).ToList();
        var empty_start_date = list.Where(x => x.ControlId.Contains("empty_start_date")).FirstOrDefault();
        var empty_end_date = list.Where(x => x.ControlId.Contains("empty_end_date")).FirstOrDefault();

        if (dtmStart.SelectedDate == null)
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = empty_start_date.Contents;
            dtmStart.Focus();
            return;
        }
        if (dtmEnd.SelectedDate == null)
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = empty_end_date.Contents;
            dtmEnd.Focus();
            return;
        }
        DateTime startDate = (DateTime)dtmStart.SelectedDate;
        DateTime endDate = (DateTime)dtmEnd.SelectedDate;

        grv.DataSource = GetData();
        grv.DataBind();
        grv.ExportSettings.FileName = "Daily_" + startDate.ToString("yyyy_MM_dd") + "_" + endDate.ToString("yyyy_MM_dd");
    }



    protected void btnExport_Click(object sender, EventArgs e)
    {

        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Logger/Daily_Monthly.aspx")).ToList();

        //Parse content to form
        var lbFrom = list.Where(x => x.ControlId.Contains("lbFrom")).FirstOrDefault();
        var lbTo = list.Where(x => x.ControlId.Contains("lbTo")).FirstOrDefault();

        string dateTimeFormat = "dd/MM/yyyy";
        //var site = _siteBL.GetSite(cboSites.SelectedValue);
        

        DateTime? startDate = dtmStart.SelectedDate;
        DateTime? endDate = dtmEnd.SelectedDate;

        string caption = "";

        if (startDate != null && endDate != null)
        {
            string strStartDate = ((DateTime)dtmStart.SelectedDate).ToString(dateTimeFormat);
            string strEndDate = ((DateTime)dtmEnd.SelectedDate).ToString(dateTimeFormat);
            //caption = site.SiteAliasName
            caption = "Daily_ "
            + lbFrom.Contents + " " + strStartDate + " "
            + lbTo.Contents + " " + strEndDate;
        }
        else
        {
            caption = "Daily_";
        }

        this.grv.MasterTableView.Caption = caption;

        this.grv.GridLines = GridLines.Both;
        this.grv.BorderStyle = BorderStyle.Solid;
        this.grv.MasterTableView.GetColumn("lnkColumn").Display = false;
        try
        {
            grv.MasterTableView.ExportToExcel();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void listBoxSelectedSites_Dropped(object sender, RadListBoxDroppedEventArgs e)
    {
        if (e.HtmlElementID == listBoxSites.ClientID)
        {

            if (listBoxSites.SelectedItem != null)
            {

                foreach (RadListBoxItem item in e.SourceDragItems)
                {

                    bool flag = true;

                    RadListBoxItem dItem = new RadListBoxItem(item.Text, item.Value);

                    foreach (RadListBoxItem selectedItem in listBoxSelectedSites.Items)
                    {
                        if (selectedItem.Value == dItem.Value)
                        {
                            flag = false;
                        }
                    }

                    if (flag)
                    {
                        listBoxSelectedSites.Items.Add(dItem);
                    }
                }
            }
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