using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;


public partial class Supervisor_Device_Accreditation : System.Web.UI.Page
{
    AccreditationBL _accreditationBL = new AccreditationBL();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMessage.Visible = false;
        if (!IsPostBack)
        {
            string accreditation = Request.QueryString["acc"];
            cboAccreditationDocuments.Text = accreditation;
            BindData();
        }

        if (!IsPostBack)
        {
            // Pi-solution
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Device/All.aspx")).ToList();

            var var1 = list.Where(x => x.ControlId.Contains("winAccreditationMeter_verificationDocument")).FirstOrDefault();
            winAccreditationMeter_verificationDocument.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("winAccreditationMeter_MeterSeri")).FirstOrDefault();
            winAccreditationMeter_MeterSeri.Text = (var2 == null) ? "" : var2.Contents;
            var var3 = list.Where(x => x.ControlId.Contains("winAccreditationMeter_DisplaySeri")).FirstOrDefault();
            winAccreditationMeter_DisplaySeri.Text = (var3 == null) ? "" : var3.Contents;
            var var4 = list.Where(x => x.ControlId.Contains("winAccreditationMeter_verificationType")).FirstOrDefault();
            winAccreditationMeter_verificationType.Text = (var4 == null) ? "" : var4.Contents;
            var var5 = list.Where(x => x.ControlId.Contains("winAccreditationMeter_date")).FirstOrDefault();
            winAccreditationMeter_date.Text = (var5 == null) ? "" : var5.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("winAccreditationMeter_dueDate")).FirstOrDefault();
            winAccreditationMeter_dueDate.Text = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("winAccreditationMeter_note")).FirstOrDefault();
            winAccreditationMeter_note.Text = (var7 == null) ? "" : var7.Contents;


            var var28 = list.Where(x => x.ControlId.Contains("winAccreditationMeter_btnEdit")).FirstOrDefault();
            btnAdd.Text = (var28 == null) ? "" : var28.Contents;
            var var29 = list.Where(x => x.ControlId.Contains("winAccreditationMeter_delete")).FirstOrDefault();
            btnDelete.Text = (var29 == null) ? "" : var29.Contents;
        }
    }

    private void BindData()
    {
        var accreditation = _accreditationBL.GetAccreditation(cboAccreditationDocuments.Text);
        if (accreditation != null)
        {
            SetControlValues(accreditation);
        }
    }

    protected void cboAccreditationDocuments_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        BindData();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Device/All.aspx")).ToList();
        var empty_verification_document = list.Where(x => x.ControlId.Contains("empty_verification_document")).FirstOrDefault();
        var empty_date_verification = list.Where(x => x.ControlId.Contains("empty_date_verification")).FirstOrDefault();
        var empty_seri_meter = list.Where(x => x.ControlId.Contains("empty_seri_meter")).FirstOrDefault();
        var verification_add_confirm = list.Where(x => x.ControlId.Contains("verification_add_confirm")).FirstOrDefault();
        var verification_update_confirm = list.Where(x => x.ControlId.Contains("verification_update_confirm")).FirstOrDefault();


        lblMessage.Visible = true;
        if (string.IsNullOrEmpty(cboAccreditationDocuments.Text))
        {
            lblMessage.Text = empty_verification_document.Contents;
            cboAccreditationDocuments.Focus();
            return;
        }
        if (dtmAccredited.SelectedDate == null)
        {
            lblMessage.Text = empty_date_verification.Contents;
            dtmAccredited.Focus();
            return;
        }
        if (string.IsNullOrEmpty(cboMeter.Text))
        {
            lblMessage.Text = empty_seri_meter.Contents;
            cboMeter.Focus();
            return;
        }
        var accreditation = GetControlValues();
        var dbAccreditation = _accreditationBL.GetAccreditation(cboAccreditationDocuments.Text);
        if (dbAccreditation == null)
        {
            try
            {
                _accreditationBL.InsertAccreditation(accreditation);
                //lblMessage.Text = "Đã thêm mới giấy kiểm định.";
                lblMessage.Text = verification_add_confirm.Contents;

            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi: " + ex.Message;
                //throw;
            }
        }
        else
        {
            try
            {
                _accreditationBL.UpdateAccreditation(accreditation, dbAccreditation);
                //lblMessage.Text = "Đã sửa thông tin kiểm định.";
                lblMessage.Text = verification_update_confirm.Contents;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi: " + ex.Message;
                //throw;
            }
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Device/All.aspx")).ToList();
        var empty_verification_document = list.Where(x => x.ControlId.Contains("empty_verification_document")).FirstOrDefault();
        var verification_delete_confirm = list.Where(x => x.ControlId.Contains("verification_delete_confirm")).FirstOrDefault();
        


        lblMessage.Visible = true;
        if (string.IsNullOrEmpty(cboAccreditationDocuments.Text))
        {
            lblMessage.Text = empty_verification_document.Contents;
            cboAccreditationDocuments.Focus();
            return;
        }
        var accreditation = GetControlValues();
        var dbAccreditation = _accreditationBL.GetAccreditation(cboAccreditationDocuments.Text);
        if (dbAccreditation != null)
        {
            try
            {
                _accreditationBL.DeleteAccreditation(accreditation);
                SetControlDefault();
                BindData();
                //lblMessage.Text = "Đã xóa thông tin kiểm định.";
                lblMessage.Text = verification_delete_confirm.Contents;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi: " + ex.Message;
                //throw;
            }
        }
    }

    private void SetControlDefault()
    {
        cboAccreditationDocuments.SelectedIndex = -1;
        cboAccreditationDocuments.Text = string.Empty;
        cboMeter.SelectedValue = string.Empty;
        cboTransmitter.SelectedValue = string.Empty;
        cboAccreditationTypes.SelectedIndex = -1;
        dtmAccredited.SelectedDate = null;
        dtmExpiry.SelectedDate = null;
    }

    private void SetControlValues(t_Accreditations accreditation)
    {
        cboAccreditationDocuments.Text = accreditation.AccreditationDocument;
        cboAccreditationTypes.SelectedValue = accreditation.AccreditationType;
        cboMeter.SelectedValue = accreditation.MeterSerial;
        cboTransmitter.SelectedValue = accreditation.TransmitterSerial;
        dtmAccredited.SelectedDate = accreditation.AccreditationDate;
        dtmExpiry.SelectedDate = accreditation.ExpiryDate;
    }

    private t_Accreditations GetControlValues()
    {
        t_Accreditations accreditation = new t_Accreditations();
        accreditation.AccreditationDate = (DateTime)dtmAccredited.SelectedDate;
        accreditation.AccreditationDocument = cboAccreditationDocuments.Text;
        accreditation.AccreditationType = cboAccreditationTypes.SelectedValue;
        accreditation.Description = txtDescription.Text;
        accreditation.ExpiryDate = dtmExpiry.SelectedDate;
        accreditation.MeterSerial = string.IsNullOrEmpty(cboMeter.Text) ? null : cboMeter.Text;
        accreditation.TransmitterSerial = string.IsNullOrEmpty(cboTransmitter.Text) ? null : cboTransmitter.Text;
        return accreditation;
    }
}