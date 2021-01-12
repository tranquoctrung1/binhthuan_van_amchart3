using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;

using Telerik.Web.UI;

public partial class Controls_ucMonthlyReport : System.Web.UI.UserControl
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

    protected void cboSites_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        var site = _siteBL.GetSite(cboSites.SelectedValue);
        cboConsumers.SelectedValue = site.ConsumerId;
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
        startDate = DateTime.Parse(startDate.ToString("yyyy-MM"));
        endDate = DateTime.Parse(endDate.ToString("yyyy-MM"));
        var site = _siteBL.GetSite(cboSites.SelectedValue);
        var listMonthlyComplexData = _complexDataHelper.GetMonthlyComplexData(site.LoggerId, startDate, endDate);
        grv.DataSource = listMonthlyComplexData;
        grv.DataBind();
        grv.ExportSettings.FileName = site.SiteAliasName + "_" + startDate.ToString("yyyy_MM");
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {

        string dateTimeFormat = "MM/yyyy";
        var site = _siteBL.GetSite(cboSites.SelectedValue);

        DateTime? startDate = myStart.SelectedDate;
        DateTime? endDate = myEnd.SelectedDate;
        string caption = "";
        if (startDate != null && endDate != null)
        {
            string strStartDate = ((DateTime)startDate).ToString(dateTimeFormat);
            string strEndDate = ((DateTime)endDate).ToString(dateTimeFormat);

            caption = site.SiteAliasName
            + " Từ tháng " + strStartDate
            + " đến tháng " + strEndDate;
        }
        else
        {
            caption = site.SiteAliasName;
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


    protected void cboSites_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cboSites.SelectedIndex = 0;
        }
    }
}