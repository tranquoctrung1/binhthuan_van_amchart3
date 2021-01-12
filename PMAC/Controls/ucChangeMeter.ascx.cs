using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using PMAC.BLL;

public partial class Controls_ucChangeMeter : System.Web.UI.UserControl
{
    MeterHistoryBL _meterHistoryBL = new MeterHistoryBL();
    MeterBL _meterBL = new MeterBL();
    SiteBL _siteBL = new SiteBL();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;

        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/ChangeDevice.aspx")).ToList();

            var var01 = list.Where(x => x.ControlId.Contains("lbAliasName")).FirstOrDefault();
            lbAliasName.Text = (var01 == null) ? "" : var01.Contents;
            var var02 = list.Where(x => x.ControlId.Contains("lbDateReplacement")).FirstOrDefault();
            lbDateReplacement.Text = (var02 == null) ? "" : var02.Contents;
            var var03 = list.Where(x => x.ControlId.Contains("lbOldSeriId")).FirstOrDefault();
            lbOldSeriId.Text = (var03 == null) ? "" : var03.Contents;
            var var04 = list.Where(x => x.ControlId.Contains("lbNewSeriId")).FirstOrDefault();
            lbNewSeriId.Text = (var04 == null) ? "" : var04.Contents;


            // Change header of rad grid
            var var5 = list.Where(x => x.ControlId.Contains("lbOldValue")).FirstOrDefault();
            lbOldValue.Text = (var5 == null) ? "" : var5.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("lbNewValue")).FirstOrDefault();
            lbNewValue.Text = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("lbNote")).FirstOrDefault();
            lbNote.Text = (var7 == null) ? "" : var7.Contents;

            var var8 = list.Where(x => x.ControlId.Contains("btnView")).FirstOrDefault();
            btnView.Text = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("btnAdd")).FirstOrDefault();
            btnAdd.Text = (var9 == null) ? "" : var9.Contents;
            var var10 = list.Where(x => x.ControlId.Contains("btnDelete")).FirstOrDefault();
            btnDelete.Text = (var10 == null) ? "" : var10.Contents;

            // Delete users
            var var11 = list.Where(x => x.ControlId.Contains("confirm_delete_user")).FirstOrDefault();
            lbconfirm_delete_user.Text = (var11 == null) ? "" : var11.Contents;


            list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();

            // Change of header of RadComboBox
            Label label1 = cboOldSerials.Header.FindControl("seri_header") as Label;
            Label label2 = cboNewSerials.Header.FindControl("seri_header") as Label;
            var var39 = list.Where(x => x.ControlId.Contains("radComboBox_seri_header")).FirstOrDefault();
            label1.Text = (var39 == null) ? "" : var39.Contents;
            label2.Text = (var39 == null) ? "" : var39.Contents;

            label1 = cboOldSerials.Header.FindControl("manufacturer_header") as Label;
            label2 = cboNewSerials.Header.FindControl("manufacturer_header") as Label;
            var var40 = list.Where(x => x.ControlId.Contains("radComboBox_manufacturer_header")).FirstOrDefault();
            label1.Text = (var40 == null) ? "" : var40.Contents;
            label2.Text = (var40 == null) ? "" : var40.Contents;

            label1 = cboOldSerials.Header.FindControl("brandname_header") as Label;
            label2 = cboNewSerials.Header.FindControl("brandname_header") as Label;
            var var41 = list.Where(x => x.ControlId.Contains("radComboBox_brandname_header")).FirstOrDefault();
            label1.Text = (var41 == null) ? "" : var41.Contents;
            label2.Text = (var41 == null) ? "" : var41.Contents;

            label1 = cboOldSerials.Header.FindControl("size_header") as Label;
            label2 = cboNewSerials.Header.FindControl("size_header") as Label;
            var var42 = list.Where(x => x.ControlId.Contains("radComboBox_size_header")).FirstOrDefault();
            label1.Text = (var42 == null) ? "" : var42.Contents;
            label2.Text = (var42 == null) ? "" : var42.Contents;


        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/ChangeDevice.aspx")).ToList();
        var empty_datechange_meter = list.Where(x => x.ControlId.Contains("empty_datechange_meter")).FirstOrDefault();
        var empty_alias_name = list.Where(x => x.ControlId.Contains("empty_alias_name")).FirstOrDefault();
        var meter_add_confirm = list.Where(x => x.ControlId.Contains("meter_add_confirm")).FirstOrDefault();
        var meter_update_confirm = list.Where(x => x.ControlId.Contains("meter_update_confirm")).FirstOrDefault();


        ntf.VisibleOnPageLoad = true;
        if (string.IsNullOrEmpty(cboSiteID.SelectedValue))
        {
            ntf.Text = empty_alias_name.Contents;
            cboSiteID.Focus();
            return;
        }
        if (dtmChange.SelectedDate == null)
        {
            ntf.Text = empty_datechange_meter.Contents;
            dtmChange.Focus();
            return;
        }
        var history = GetControlValues();
        var dbHistory = _meterHistoryBL.GetMeterHistory(history.SiteID, history.DateChanged);
        if (dbHistory == null)
        {
            try
            {
                _meterHistoryBL.InsertMeterHistory(history);
                //ntf.Text = "Đã thêm lịch sử đồng hồ.";
                ntf.Text = meter_add_confirm.Contents;
            }
            catch (Exception ex)
            {
                ntf.Text = "Lỗi: " + ex.Message;
                //throw;
            }
        }
        else
        {
            try
            {
                _meterHistoryBL.UpdateMeterHistory(history, dbHistory);
                //ntf.Text = "Đã cập nhật lịch sử đồng hồ.";
                ntf.Text = meter_update_confirm.Contents;

            }
            catch (Exception ex)
            {
                ntf.Text = "Lỗi: " + ex.Message;
                //throw;
            }
        }

    }

    protected void btnOK_Clicked(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/ChangeDevice.aspx")).ToList();
        var empty_datechange_meter = list.Where(x => x.ControlId.Contains("empty_datechange_meter")).FirstOrDefault();
        var empty_alias_name = list.Where(x => x.ControlId.Contains("empty_alias_name")).FirstOrDefault();
        var meter_delete_confirm = list.Where(x => x.ControlId.Contains("meter_delete_confirm")).FirstOrDefault();
        var meter_empty_history = list.Where(x => x.ControlId.Contains("meter_empty_history")).FirstOrDefault();

        ntf.VisibleOnPageLoad = true;
        if (string.IsNullOrEmpty(cboSiteID.SelectedValue))
        {
            ntf.Text = empty_alias_name.Contents;
            cboSiteID.Focus();
            return;
        }
        if (dtmChange.SelectedDate == null)
        {
            ntf.Text = empty_datechange_meter.Contents;
            dtmChange.Focus();
            return;
        }
        var history = GetControlValues();
        var dbHistory = _meterHistoryBL.GetMeterHistory(history.SiteID, history.DateChanged);
        if (dbHistory == null)
        {
            //ntf.Text = "Không tồn tại lịch sử.";
            ntf.Text = meter_empty_history.Contents;

            return;
        }
        else
        {
            try
            {
                _meterHistoryBL.DeleteMeterHistory(history);
                //ntf.Text = "Đã xóa lịch sử đồng hồ.";
                ntf.Text = meter_delete_confirm.Contents;
                SetDefaultValues();
            }
            catch (Exception ex)
            {
                ntf.Text = "Lỗi: " + ex.Message;
            }
        }
    }

    private t_Meter_Histories GetControlValues()
    {
        t_Meter_Histories meterHistory = new t_Meter_Histories();
        meterHistory.DateChanged = (DateTime)dtmChange.SelectedDate;
        meterHistory.Description = txtDescription.Text;
        meterHistory.NewMeterSerial = cboNewSerials.SelectedValue;
        meterHistory.OldMeterSerial = cboOldSerials.SelectedValue;
        meterHistory.NewIndex = nmrNewIndex.Value;
        meterHistory.OldIndex = nmrOldIndex.Value;
        meterHistory.SiteID = cboSiteID.SelectedValue;
        var oldMeter=_meterBL.GetMeter(meterHistory.OldMeterSerial);
        var newMeter=_meterBL.GetMeter(meterHistory.NewMeterSerial);
        meterHistory.OldAccreditation = (oldMeter == null ? null : oldMeter.AccreditationDocument);
        meterHistory.NewAccreditation = (newMeter == null ? null : newMeter.AccreditationDocument);
        return meterHistory;
    }

    private void SetControlValues(t_Meter_Histories meterHistory)
    {
        var site = _siteBL.GetSite(meterHistory.SiteID);
        cboSiteID.Text = site.SiteAliasName;

        dtmChange.SelectedDate = meterHistory.DateChanged;
        cboOldSerials.SelectedValue = meterHistory.OldMeterSerial;
        cboNewSerials.SelectedValue = meterHistory.NewMeterSerial;
        nmrOldIndex.Value = meterHistory.OldIndex;
        nmrNewIndex.Value = meterHistory.NewIndex;
        txtDescription.Text = meterHistory.Description;
    }

    private void SetDefaultValues()
    {
        cboSiteID.SelectedIndex = 0;
        cboSiteID.Text = string.Empty;
        dtmChange.SelectedDate = null;
        cboOldSerials.SelectedIndex = -1;
        cboOldSerials.Text = string.Empty;
        cboNewSerials.SelectedIndex = -1;
        cboNewSerials.Text = string.Empty;
        nmrOldIndex.Value = null;
        nmrNewIndex.Value = null;
        txtDescription.Text = string.Empty;
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/ChangeDevice.aspx")).ToList();
        var empty_datechange_meter = list.Where(x => x.ControlId.Contains("empty_datechange_meter")).FirstOrDefault();
        var empty_alias_name = list.Where(x => x.ControlId.Contains("empty_alias_name")).FirstOrDefault();
        var meter_empty_history = list.Where(x => x.ControlId.Contains("meter_empty_history")).FirstOrDefault();

        if (string.IsNullOrEmpty(cboSiteID.SelectedValue))
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = empty_alias_name.Contents;
            cboSiteID.Focus();
            return;
        }
        if (dtmChange.SelectedDate == null)
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = empty_datechange_meter.Contents;
            dtmChange.Focus();
            return;
        }
        var history = _meterHistoryBL.GetMeterHistory(cboSiteID.SelectedValue, (DateTime)dtmChange.SelectedDate);
        if (history == null)
        {
            ntf.Text = "Không tồn tại lịch sử.";
            ntf.Text = meter_empty_history.Contents;
        }
        else
        {
            SetControlValues(history);
        }        
    }
    protected void cboSiteID_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cboSiteID.SelectedIndex = 0;
        }
    }
}