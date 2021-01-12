using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;

using Telerik.Web.UI;
public partial class Consumer_Logger_Monthly : System.Web.UI.Page
{
    SiteBL _siteBL = new SiteBL();
    ComplexDataHelper _complexDataHelper = new ComplexDataHelper();
    UserBL _userBL = new UserBL();

    protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;
        if (!IsPostBack)
        {
            var user = _userBL.GetUser(HttpContext.Current.User.Identity.Name);
            IEnumerable<t_Sites> sites;
            if (user.Role == "consumer")
            {
                sites = _siteBL.GetSitesByConsumerID(user.ConsumerId);
            }
            else if (user.Role == "staff")
            {
                sites = _siteBL.GetSitesByStaffId(user.StaffId);
            }
            else
            {
                sites = null;
            }
            cboSites.DataSource = sites;
            var current = sites.FirstOrDefault();
            if (current != null)
            {
                txtLocation.Text = current.Location;
            }
            cboSites.DataBind();
        }
    }
    protected void grv_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        CultureInfo culture = new CultureInfo("en-GB");
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = (GridDataItem)e.Item;
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
        txtLocation.Text = site.Location;
        SetEmpty();
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        if (myStart.SelectedDate == null)
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = "Chưa nhập ngày bắt đầu.";
            myStart.Focus();
            return;
        }
        if (myEnd.SelectedDate == null)
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = "Chưa nhập ngày kết thúc.";
            myEnd.Focus();
            return;
        }
        DateTime startDate = (DateTime)myStart.SelectedDate;
        DateTime endDate = (DateTime)myEnd.SelectedDate;
        var site = _siteBL.GetSite(cboSites.SelectedValue);
        var listMonthlyComplexData = _complexDataHelper.GetMonthlyComplexData(site.LoggerId, startDate, endDate);
        grv.DataSource = listMonthlyComplexData;
        grv.DataBind();
        grv.ExportSettings.FileName = site.SiteAliasName + "_" + startDate.ToString("yyyy_MM");
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        try
        {
            string dateTimeFormat = "MM/yyyy";
            this.grv.MasterTableView.Caption = cboSites.SelectedValue
                + " Từ tháng " + ((DateTime)myStart.SelectedDate).ToString(dateTimeFormat)
                + " đến tháng " + ((DateTime)myEnd.SelectedDate).ToString(dateTimeFormat);

            this.grv.MasterTableView.GetColumn("lnkColumn").Display = false;
            this.grv.GridLines = GridLines.Both;
            this.grv.BorderStyle = BorderStyle.Solid;
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