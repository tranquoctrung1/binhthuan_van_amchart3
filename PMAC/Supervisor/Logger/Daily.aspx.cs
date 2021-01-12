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

public partial class Supervisor_Logger_Daily : System.Web.UI.Page
{
    SiteBL _siteBL = new SiteBL();
    ComplexDataHelper _complexDataHelper = new ComplexDataHelper();

    protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;
    }
    protected void grv_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
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
            lnkChart.Attributes["onclick"] = String.Format("return ShowChartForm('{0}','{1}','{2}');", 
                e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["SiteId"], 
                DateTime.Parse(dataItem["Time"].Text, culture).ToOADate().ToString().Replace('.', '-'), e.Item.ItemIndex);
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
        //cboConsumers.SelectedValue = site.ConsumerId;
        SetEmpty();
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        if (dtmStart.SelectedDate == null)
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = "Chưa nhập ngày bắt đầu.";
            dtmStart.Focus();
            return;
        }
        if (dtmEnd.SelectedDate == null)
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = "Chưa nhập ngày kết thúc.";
            dtmEnd.Focus();
            return;
        }
        DateTime startDate = (DateTime)dtmStart.SelectedDate;
        DateTime endDate = (DateTime)dtmEnd.SelectedDate;
        var site = _siteBL.GetSite(cboSites.SelectedValue);
        var listDailyComplexData = _complexDataHelper.GetDailyComplexData(site.LoggerId, startDate, endDate);
        grv.DataSource = listDailyComplexData;
        grv.DataBind();
        grv.ExportSettings.FileName = site.SiteAliasName + "_" + startDate.ToString("yyyy_MM_dd") + "_" + endDate.ToString("yyyy_MM_dd");
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        try
        {
            string dateTimeFormat = "dd/MM/yyyy";
            var site = _siteBL.GetSite(cboSites.SelectedValue);
            this.grv.MasterTableView.Caption = site.SiteAliasName
                + " Từ ngày " + ((DateTime)dtmStart.SelectedDate).ToString(dateTimeFormat)
                + " đến ngày " + ((DateTime)dtmEnd.SelectedDate).ToString(dateTimeFormat);

            this.grv.GridLines = GridLines.Both;
            this.grv.BorderStyle = BorderStyle.Solid;
            this.grv.MasterTableView.GetColumn("lnkColumn").Display = false;
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