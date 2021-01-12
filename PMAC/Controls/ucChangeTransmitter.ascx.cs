using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;


public partial class Controls_ucChangeTransmitter : System.Web.UI.UserControl
{
    TransmitterHistoryBL _transmitterHistoryBL = new TransmitterHistoryBL();
    TransmitterBL _transmitterBL = new TransmitterBL();
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
            var var5 = list.Where(x => x.ControlId.Contains("lbValueAsChanged")).FirstOrDefault();
            lbValueAsChanged.Text = (var5 == null) ? "" : var5.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("lbNote")).FirstOrDefault();
            lbNote.Text = (var7 == null) ? "" : var7.Contents;

            var var8 = list.Where(x => x.ControlId.Contains("btnView")).FirstOrDefault();
            btnView.Text = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("btnAdd")).FirstOrDefault();
            btnConfirm.Text = (var9 == null) ? "" : var9.Contents;
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
        var transmitter_empty_datechanged = list.Where(x => x.ControlId.Contains("transmitter_empty_datechanged")).FirstOrDefault();


        ntf.VisibleOnPageLoad = true;
        if (string.IsNullOrEmpty(cboSiteID.SelectedValue))
        {
            ntf.Text = "Chưa nhập Mã vị trí (Alias name).";
            cboSiteID.Focus();
            return;
        }
        if (dtmChange.SelectedDate == null)
        {
            //ntf.Text = "Chưa nhập ngày thay bộ hiển thị.";
            ntf.Text = transmitter_empty_datechanged.Contents;
            dtmChange.Focus();
            return;
        }
        var history = GetControlValues();
        var dbHistory = _transmitterHistoryBL.GetTransmitterHistory(history.SiteID, history.DateChanged);
        if (dbHistory == null)
        {
            try
            {
                _transmitterHistoryBL.InsertTransmitterHistory(history);
                ntf.Text = "Đã thêm lịch sử bộ hiển thị.";
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
                _transmitterHistoryBL.UpdateTransmitterHistory(history, dbHistory);
                ntf.Text = "Đã cập nhật lịch sử bộ hiển thị.";
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
        var transmitter_empty_datechanged = list.Where(x => x.ControlId.Contains("transmitter_empty_datechanged")).FirstOrDefault();

        ntf.VisibleOnPageLoad = true;
        if (string.IsNullOrEmpty(cboSiteID.SelectedValue))
        {
            ntf.Text = "Chưa nhập Mã vị trí (Alias name).";
            cboSiteID.Focus();
            return;
        }
        if (dtmChange.SelectedDate == null)
        {
            //ntf.Text = "Chưa nhập ngày thay bộ hiển thị.";
            ntf.Text = transmitter_empty_datechanged.Contents;

            dtmChange.Focus();
            return;
        }
        var history = GetControlValues();
        var dbHistory = _transmitterHistoryBL.GetTransmitterHistory(history.SiteID, history.DateChanged);
        if (dbHistory == null)
        {
            ntf.Text = "Không tồn tại lịch sử.";
            return;
        }
        else
        {
            try
            {
                _transmitterHistoryBL.DeleteTransmitterHistory(history);
                ntf.Text = "Đã xóa lịch sử bộ hiển thị.";
                SetDefaultValues();
            }
            catch (Exception ex)
            {
                ntf.Text = "Lỗi: " + ex.Message;
            }
        }
    }

    private t_Transmitter_Histories GetControlValues()
    {
        t_Transmitter_Histories transmitterHistory = new t_Transmitter_Histories();
        transmitterHistory.DateChanged = (DateTime)dtmChange.SelectedDate;
        transmitterHistory.Description = txtDescription.Text;
        transmitterHistory.NewTransmitterSerial = cboNewSerials.SelectedValue;
        transmitterHistory.OldTransmitterSerial = cboOldSerials.SelectedValue;
        transmitterHistory.Index = nmrOldIndex.Value;
        transmitterHistory.SiteID = cboSiteID.SelectedValue;
        var oldTransmitter = _transmitterBL.GetTransmitter(transmitterHistory.OldTransmitterSerial);
        var newTransmitter = _transmitterBL.GetTransmitter(transmitterHistory.NewTransmitterSerial);
        transmitterHistory.OldAccreditation = (oldTransmitter == null ? null : oldTransmitter.AccreditationDocument);
        transmitterHistory.NewAccreditation = (newTransmitter == null ? null : newTransmitter.AccreditationDocument);
        return transmitterHistory;
    }

    private void SetControlValues(t_Transmitter_Histories transmitterHistory)
    {
        var site =  _siteBL.GetSite(transmitterHistory.SiteID);
        cboSiteID.Text = site.SiteAliasName ;

        dtmChange.SelectedDate = transmitterHistory.DateChanged;
        cboOldSerials.SelectedValue = transmitterHistory.OldTransmitterSerial;
        cboNewSerials.SelectedValue = transmitterHistory.NewTransmitterSerial;
        nmrOldIndex.Value = transmitterHistory.Index;
        txtDescription.Text = transmitterHistory.Description;
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
        txtDescription.Text = string.Empty;
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/ChangeDevice.aspx")).ToList();
        var transmitter_empty_datechanged = list.Where(x => x.ControlId.Contains("transmitter_empty_datechanged")).FirstOrDefault();


        if (string.IsNullOrEmpty(cboSiteID.SelectedValue))
        {
            ntf.VisibleOnPageLoad = true;
            ntf.Text = "Chưa nhập Mã vị trí (tag name).";
            cboSiteID.Focus();
            return;
        }
        if (dtmChange.SelectedDate == null)
        {
            ntf.VisibleOnPageLoad = true;
            //ntf.Text = "Chưa nhập ngày thay bộ hiển thị.";
            ntf.Text = transmitter_empty_datechanged.Contents;

            dtmChange.Focus();
            return;
        }
        var history = _transmitterHistoryBL.GetTransmitterHistory(cboSiteID.SelectedValue, (DateTime)dtmChange.SelectedDate);
        if (history == null)
        {
            ntf.Text = "Không tồn tại lịch sử.";
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