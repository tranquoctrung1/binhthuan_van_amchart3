using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;

using Telerik.Web.UI;

public partial class Controls_ucDailyReportConsumer : System.Web.UI.UserControl
{
    SiteBL _siteBL = new SiteBL();
    UserBL _userBL = new UserBL();
    ComplexDataHelper _complexDataHelper = new ComplexDataHelper();

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

    protected void cboSites_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        var site = _siteBL.GetSite(cboSites.SelectedValue);
        txtLocation.Text = site.Location;
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
        string dateTimeFormat = "dd/MM/yyyy";
        var site = _siteBL.GetSite(cboSites.SelectedValue);

        DateTime? startDate = dtmStart.SelectedDate;
        DateTime? endDate = dtmEnd.SelectedDate;
        string caption = "";

        if (startDate!=null&&endDate!=null)
        {
            string strStartDate = ((DateTime)startDate).ToString(dateTimeFormat);
            string strEndDate = ((DateTime)endDate).ToString(dateTimeFormat);
            caption = site.SiteAliasName
            + " Từ ngày " + startDate
            + " đến ngày " + endDate;
        }
        else
        {
            caption = site.SiteAliasName;
        }

        this.grv.MasterTableView.Caption = caption;

        //this.grv.MasterTableView.GetColumn("lnkColumns").Display = false;
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
    protected void cboSites_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cboSites.SelectedIndex = 0;
        }
    }
}