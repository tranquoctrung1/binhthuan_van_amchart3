using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;

using Telerik.Web.UI;

public partial class Controls_ucMontlyReportConsumer : System.Web.UI.UserControl
{
    SiteBL _siteBL = new SiteBL();
    ComplexDataHelper _complexDataHelper = new ComplexDataHelper();
    UserBL _userBL = new UserBL();
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";
    protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;
        if (!IsPostBack)
        {
            var user = _userBL.GetUser(HttpContext.Current.User.Identity.Name);
            IEnumerable<t_Sites> sites;
            if (user.Role == "consumer")
            {
                sites = _siteBL.GetSitesByConsumerID(user.ConsumerId).OrderBy(s => s.SiteAliasName);
            }
            else if (user.Role == "staff")
            {
                sites = _siteBL.GetSitesByStaffId(user.StaffId).OrderBy(s => s.SiteAliasName);
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

            // News comparing to supervisor
            List<t_LanguageTranslate> list2 = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();
            var var11 = list2.Where(x => x.ControlId.Contains("lbTagName")).FirstOrDefault();
            lbTagName.Text = (var11 == null) ? "" : var11.Contents;
            var var22 = list2.Where(x => x.ControlId.Contains("lbLocation")).FirstOrDefault();
            lbLocation.Text = (var22 == null) ? "" : var22.Contents;
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
            lnkChart.Attributes["onclick"] = String.Format("return ShowChartFormMonthly('{0}','{1}','{2}','{3}');",
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
        
            string dateTimeFormat = "MM/yyyy";
            DateTime? startDate = myStart.SelectedDate;
            DateTime? endDate = myEnd.SelectedDate;
            string caption = "";
            if (startDate!=null&&endDate!=null)
            {
                string strStartDate = ((DateTime)startDate).ToString(dateTimeFormat);
                string strEndDate = ((DateTime)endDate).ToString(dateTimeFormat);
                caption = cboSites.SelectedValue
                + " Từ tháng " + strStartDate
                + " đến tháng " + strEndDate;
            }
            else
            {
                caption = cboSites.SelectedValue;
            }
            this.grv.MasterTableView.Caption = caption;

            this.grv.MasterTableView.GetColumn("lnkColumn").Display = false;
            this.grv.GridLines = GridLines.Both;
            this.grv.BorderStyle = BorderStyle.Solid;
            try
            {
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