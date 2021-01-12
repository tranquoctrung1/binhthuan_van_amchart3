using PMAC.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_ucHourlyReport : System.Web.UI.UserControl
{
    SiteBL _siteBL = new SiteBL();
    ComplexDataBL _complexDataHelper = new ComplexDataBL();

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void cboSites_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        var site = _siteBL.GetSite(cboSites.SelectedValue);
        cboConsumers.Text = site.ConsumerId;
    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        var isValid = CheckValidInput();
        if (!isValid)
        {
            rNotification1.Show(Msg);
            return;
        }
        DateTime startDate = (DateTime)dtStart.SelectedDate;
        DateTime endDate = (DateTime)dtEnd.SelectedDate;
        var _site = _siteBL.GetSite(cboSites.SelectedValue);
        var hourlyData = _complexDataHelper.GetHourlyData(_site.SiteId, startDate, endDate);
        grv.DataSource = hourlyData;
        grv.DataBind();
        grv.ExportSettings.FileName = _site.SiteAliasName + "_" + startDate.ToString("yyyy_MM_dd_HH_mm") + "_" + endDate.ToString("yyyy_MM_dd_HH_mm");
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        var isValid = CheckValidInput();
        if (!isValid)
        {
            rNotification1.Show(Msg);
            return;
        }
        DateTime startDate = (DateTime)dtStart.SelectedDate;
        DateTime endDate = (DateTime)dtEnd.SelectedDate;
        var _site = _siteBL.GetSite(cboSites.SelectedValue);

        string dateTimeFormat = "dd/MM/yyyy HH:mm";
        string caption = "";
        if (startDate != null && endDate != null)
        {
            string strStartDate = ((DateTime)startDate).ToString(dateTimeFormat);
            string strEndDate = ((DateTime)endDate).ToString(dateTimeFormat);
            caption = _site.SiteAliasName
            + " Từ ngày " + strStartDate
            + " đến ngày " + strEndDate;
        }
        else
        {
            caption = _site.SiteAliasName;
        }

        this.grv.MasterTableView.Caption = caption;
        this.grv.GridLines = GridLines.Both;
        this.grv.BorderStyle = BorderStyle.Solid;
        //this.grv.MasterTableView.GetColumn("lnkColumn").Display = false;
        try
        {
            grv.MasterTableView.ExportToExcel();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    private string _msg;
    public string Msg
    {
        get { return _msg; }
        set { _msg = value; }
    }
    public bool CheckValidInput()
    {
        bool isValid = true;
        if (string.IsNullOrEmpty(cboSites.Text))
        {
            isValid = false;
            Msg = "Chưa nhập vị trí!";
        }
        else if (dtStart.SelectedDate == null)
        {
            Msg = "Chưa nhập ngày bắt đầu!";
            isValid = false;
        }
        else if (dtEnd.SelectedDate == null)
        {
            isValid = false;
            Msg = "Chưa nhập ngày kết thúc!";
        }

        return isValid;
    }
}