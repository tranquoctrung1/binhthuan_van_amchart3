using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using PMAC.BLL;

public partial class Controls_ucTransmitter : System.Web.UI.UserControl
{
    TransmitterBL _transmitterBL = new TransmitterBL();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;

        // Pi-solution
        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Device/All.aspx")).ToList();

            var var1 = list.Where(x => x.ControlId.Contains("lbSeri")).FirstOrDefault();
            lbSeri.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("lbStockImportDay")).FirstOrDefault();
            lbStockImportDay.Text = (var2 == null) ? "" : var2.Contents;
            var var3 = list.Where(x => x.ControlId.Contains("lbManufacturer")).FirstOrDefault();
            lbManufacturer.Text = (var3 == null) ? "" : var3.Contents;
            var var4 = list.Where(x => x.ControlId.Contains("lbBrand")).FirstOrDefault();
            lbBrand.Text = (var4 == null) ? "" : var4.Contents;
            var var5 = list.Where(x => x.ControlId.Contains("lbSize")).FirstOrDefault();
            lbSize.Text = (var5 == null) ? "" : var5.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("lbModel")).FirstOrDefault();
            lbModel.Text = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("lbStatus")).FirstOrDefault();
            lbStatus.Text = (var7 == null) ? "" : var7.Contents;
            var var8 = list.Where(x => x.ControlId.Contains("lbIsInstallation")).FirstOrDefault();
            lbIsInstallation.Text = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("lbNote")).FirstOrDefault();
            lbNote.Text = (var9 == null) ? "" : var9.Contents;
            var var10 = list.Where(x => x.ControlId.Contains("lbLegalDocument")).FirstOrDefault();
            lbLegalDocument.Text = (var10 == null) ? "" : var10.Contents;
            var var12 = list.Where(x => x.ControlId.Contains("lbConfirm")).FirstOrDefault();
            lbConfirm.Text = (var12 == null) ? "" : var12.Contents;
            var var13 = list.Where(x => x.ControlId.Contains("lbConfirmDate")).FirstOrDefault();
            lbConfirmDate.Text = (var13 == null) ? "" : var13.Contents;
            var var14 = list.Where(x => x.ControlId.Contains("lbIsConfirmed")).FirstOrDefault();
            lbIsConfirmed.Text = (var14 == null) ? "" : var14.Contents;
            var var15 = list.Where(x => x.ControlId.Contains("lbUpload")).FirstOrDefault();
            lbUpload.Text = (var15 == null) ? "" : var15.Contents;

            var var16 = list.Where(x => x.ControlId.Contains("btnAdd")).FirstOrDefault();
            btnAdd.Text = (var16 == null) ? "" : var16.Contents;
            var var17 = list.Where(x => x.ControlId.Contains("btnDelete")).FirstOrDefault();
            btnDelete.Text = (var17 == null) ? "" : var17.Contents;
            var var18 = list.Where(x => x.ControlId.Contains("btnStatistics")).FirstOrDefault();
            RadButton1.Text = (var18 == null) ? "" : var18.Contents;

            // Pop-up (Verification Document)
            var var32 = list.Where(x => x.ControlId.Contains("winAccreditationMeter")).FirstOrDefault();
            winAccreditationTransmitter.Title = (var32 == null) ? "" : var32.Contents;


            // Change of header of RadComboBox
            List<t_LanguageTranslate> list_add = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();
            Label label1 = cboSerials.Header.FindControl("seri_header") as Label;
            var var39 = list_add.Where(x => x.ControlId.Contains("radComboBox_seri_header")).FirstOrDefault();
            label1.Text = (var39 == null) ? "" : var39.Contents;

            label1 = cboSerials.Header.FindControl("manufacturer_header") as Label;
            var var40 = list_add.Where(x => x.ControlId.Contains("radComboBox_manufacturer_header")).FirstOrDefault();
            label1.Text = (var40 == null) ? "" : var40.Contents;

            label1 = cboSerials.Header.FindControl("brandname_header") as Label;
            var var41 = list_add.Where(x => x.ControlId.Contains("radComboBox_brandname_header")).FirstOrDefault();
            label1.Text = (var41 == null) ? "" : var41.Contents;

            label1 = cboSerials.Header.FindControl("size_header") as Label;
            var var42 = list_add.Where(x => x.ControlId.Contains("radComboBox_size_header")).FirstOrDefault();
            label1.Text = (var42 == null) ? "" : var42.Contents;

            Label label3 = cboStatus.Header.FindControl("status_header") as Label;
            var var43 = list_add.Where(x => x.ControlId.Contains("radComboBox_status_header")).FirstOrDefault();
            label3.Text = (var43 == null) ? "" : var43.Contents;

            label3 = cboStatus.Header.FindControl("description_header") as Label;
            var var44 = list_add.Where(x => x.ControlId.Contains("radComboBox_description_header")).FirstOrDefault();
            label3.Text = (var44 == null) ? "" : var44.Contents;

            var var45 = list.Where(x => x.ControlId.Contains("lb_delete_confirm")).FirstOrDefault();
            lb_delete_confirm.Text = (var45 == null) ? "" : var45.Contents;
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Device/All.aspx")).ToList();
        var empty_seri_transmitter = list.Where(x => x.ControlId.Contains("empty_seri_transmitter")).FirstOrDefault();
        var transmitter_update_confirm = list.Where(x => x.ControlId.Contains("transmitter_update_confirm")).FirstOrDefault();


        ntf.VisibleOnPageLoad = true;
        if (string.IsNullOrEmpty(cboSerials.Text))
        {
            ntf.Text = empty_seri_transmitter.Contents;
            cboSerials.Focus();
            return;
        }
        var transmitter = GetControlValues();
        var dbTransmitter=_transmitterBL.GetTransmitter(cboSerials.Text);
        if (dbTransmitter == null)
        {
            try
            {
                _transmitterBL.InsertTransmitter(transmitter);
                ntf.Text = "Đã thêm mới bộ hiển thị.";
                SerialDataSource.DataBind();
                cboSerials.DataBind();
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
                _transmitterBL.UpdateTransmitter(transmitter, dbTransmitter);
                //ntf.Text = "Đã cập nhật bộ hiển thị.";
                ntf.Text = transmitter_update_confirm.Contents;

            }
            catch (Exception ex)
            {
                ntf.Text = "Lỗi: " + ex.Message;
                //throw;
            }
        }
    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Device/All.aspx")).ToList();
        var empty_seri_transmitter = list.Where(x => x.ControlId.Contains("empty_seri_transmitter")).FirstOrDefault();
        var transmitter_delete_confirm = list.Where(x => x.ControlId.Contains("transmitter_delete_confirm")).FirstOrDefault();

        ntf.VisibleOnPageLoad = true;
        if (string.IsNullOrEmpty(cboSerials.Text))
        {
            ntf.Text = empty_seri_transmitter.Contents;
            cboSerials.Focus();
            return;
        }
        var transmitter = _transmitterBL.GetTransmitter(cboSerials.Text);
        if (transmitter != null)
        {
            try
            {
                _transmitterBL.DeleteTransmitter(transmitter);
                //ntf.Text = "Đã xóa bộ hiển thị.";
                ntf.Text = transmitter_delete_confirm.Contents;
                SerialDataSource.DataBind();
                cboSerials.DataBind();
                SetControlDefault();
            }
            catch (Exception ex)
            {
                ntf.Text = "Lỗi: " + ex.Message;
                //throw;
            }
        }
        else
        {
            ntf.Text = "Không tồn tại bộ hiển thị.";
            SetControlDefault();
        }
        cboSerials.Focus();
    }

    private void SetControlDefault()
    {
        txtAccreditation.Text = string.Empty;
        txtApprovalDecision.Text = string.Empty; ;
        chkApproved.Checked = false;
        dtmApproved.SelectedDate = null;
        txtDescription.Text = string.Empty;
        chkInstalled.Checked = false;
        cboMarks.SelectedIndex = -1;
        cboMarks.Text = string.Empty;
        cboModels.SelectedIndex = -1;
        cboModels.Text = string.Empty;
        cboProviders.SelectedIndex = -1;
        cboProviders.Text = string.Empty;
        dtmReceipt.SelectedDate = null;
        cboSerials.SelectedIndex = -1;
        cboSerials.Text = string.Empty;
        cboSize.SelectedIndex = -1;
        cboSize.Text = string.Empty;
        cboStatus.SelectedIndex = -1;
        cboStatus.Text = string.Empty;
    }

    private t_Transmitters GetControlValues()
    {
        t_Transmitters transmitter = new t_Transmitters();
        transmitter.AccreditationDocument = txtAccreditation.Text;
        transmitter.ApprovalDecision = txtApprovalDecision.Text;
        transmitter.Approved = chkApproved.Checked;
        transmitter.ApprovedDate = dtmApproved.SelectedDate;
        transmitter.Description = txtDescription.Text;
        transmitter.Installed = chkInstalled.Checked;
        transmitter.Marks = cboMarks.Text;
        transmitter.Model = cboModels.Text;
        transmitter.Provider = cboProviders.Text;
        transmitter.ReceiptDate = dtmReceipt.SelectedDate;
        transmitter.Serial = cboSerials.Text;
        short size = 0;
        bool parseSuccess;
        parseSuccess = short.TryParse(cboSize.Text, out size);
        transmitter.Size = size;
        transmitter.Status = cboStatus.Text;
        return transmitter;
    }

    private void SetControlValues(t_Transmitters transmitter)
    {
        txtAccreditation.Text = transmitter.AccreditationDocument;
        txtApprovalDecision.Text = transmitter.ApprovalDecision;
        chkApproved.Checked = transmitter.Approved ?? false;
        dtmApproved.SelectedDate = transmitter.ApprovedDate;
        txtDescription.Text = transmitter.Description;
        chkInstalled.Checked = transmitter.Installed ?? false;
        cboMarks.Text = transmitter.Marks;
        cboModels.Text = transmitter.Model;
        cboProviders.Text = transmitter.Provider;
        dtmReceipt.SelectedDate = transmitter.ReceiptDate;
        cboSerials.Text = transmitter.Serial;
        cboSize.Text = transmitter.Size.ToString();
        cboStatus.Text = transmitter.Status;
    }

    protected void cboSerials_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        var transmitter = _transmitterBL.GetTransmitter(cboSerials.Text);
        if (transmitter != null)
        {
            SetControlValues(transmitter);
        }
    }
}