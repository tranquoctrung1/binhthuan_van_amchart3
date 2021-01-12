using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using PMAC.BLL;

public partial class Controls_ucLogger : System.Web.UI.UserControl
{
    LoggerBL _loggerBL = new LoggerBL();

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
            var var6 = list.Where(x => x.ControlId.Contains("lbModel")).FirstOrDefault();
            lbModel.Text = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("lbStatus")).FirstOrDefault();
            lbStatus.Text = (var7 == null) ? "" : var7.Contents;
            var var8 = list.Where(x => x.ControlId.Contains("lbIsInstallation")).FirstOrDefault();
            lbIsInstallation.Text = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("lbNote")).FirstOrDefault();
            lbNote.Text = (var9 == null) ? "" : var9.Contents;

            var var15 = list.Where(x => x.ControlId.Contains("lbUpload")).FirstOrDefault();
            lbUpload.Text = (var15 == null) ? "" : var15.Contents;

            var var16 = list.Where(x => x.ControlId.Contains("btnAdd")).FirstOrDefault();
            btnAdd.Text = (var16 == null) ? "" : var16.Contents;
            var var17 = list.Where(x => x.ControlId.Contains("btnDelete")).FirstOrDefault();
            btnDelete.Text = (var17 == null) ? "" : var17.Contents;
            var var18 = list.Where(x => x.ControlId.Contains("btnStatistics")).FirstOrDefault();
            RadButton1.Text = (var18 == null) ? "" : var18.Contents;


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

            var var45 = list.Where(x => x.ControlId.Contains("lb_logger_delete_confirm")).FirstOrDefault();
            lb_delete_confirm.Text = (var45 == null) ? "" : var45.Contents;
        }

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Device/All.aspx")).ToList();
        var empty_seri_logger = list.Where(x => x.ControlId.Contains("empty_seri_logger")).FirstOrDefault();
        var logger_update_confirm = list.Where(x => x.ControlId.Contains("logger_update_confirm")).FirstOrDefault();

        ntf.VisibleOnPageLoad = true;
        if (string.IsNullOrEmpty(cboSerials.Text))
        {
            ntf.Text = empty_seri_logger.Contents;
            cboSerials.Focus();
            return;
        }
        var logger = GetControlValues();
        var dbLogger = _loggerBL.GetLogger(cboSerials.Text);
        if (dbLogger == null)
        {
            try
            {
                _loggerBL.InsertLogger(logger);
                ntf.Text = "logger added.";
                Serial_DataSource.DataBind();
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
                _loggerBL.UpdateLogger(logger, dbLogger);
                //ntf.Text = "Đã cập nhật logger.";
                ntf.Text = logger_update_confirm.Contents;
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
        var empty_seri_logger = list.Where(x => x.ControlId.Contains("empty_seri_logger")).FirstOrDefault();

        ntf.VisibleOnPageLoad = true;
        if (string.IsNullOrEmpty(cboSerials.Text))
        {
            ntf.Text = empty_seri_logger.Contents;
            cboSerials.Focus();
            return;
        }
        var logger = _loggerBL.GetLogger(cboSerials.Text);
        if (logger != null)
        {
            try
            {
                _loggerBL.DeleteLogger(logger);
                ntf.Text = "logger deleted.";
                SetControlDefault();
                Serial_DataSource.DataBind();
                cboSerials.DataBind();
            }
            catch (Exception ex)
            {
                ntf.Text = "Lỗi: " + ex.Message;
                throw;
            }
        }
        else
        {
            ntf.Text = "seri logger not exist.";
        }
        cboSerials.Focus();
    }

    private void SetControlDefault()
    {
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
        cboStatus.SelectedIndex = -1;
        cboStatus.Text = string.Empty;
    }

    private t_Loggers GetControlValues()
    {
        t_Loggers logger = new t_Loggers();
        logger.Description = txtDescription.Text;
        logger.Installed = chkInstalled.Checked;
        logger.Marks = cboMarks.Text;
        logger.Model = cboModels.Text;
        logger.Provider = cboProviders.Text;
        logger.ReceiptDate = dtmReceipt.SelectedDate;
        logger.Serial = cboSerials.Text;
        logger.Status = cboStatus.Text;
        return logger;
    }

    private void SetControlValues(t_Loggers logger)
    {
        txtDescription.Text = logger.Description;
        chkInstalled.Checked = logger.Installed ?? false;
        cboMarks.Text = logger.Marks;
        cboModels.Text = logger.Model;
        cboProviders.Text = logger.Provider;
        dtmReceipt.SelectedDate = logger.ReceiptDate;
        cboSerials.Text = logger.Serial;
        cboStatus.Text = logger.Status;
    }

    protected void cboSerials_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        var logger = _loggerBL.GetLogger(cboSerials.Text);
        if (logger != null)
        {
            SetControlValues(logger);
        }
    }
}