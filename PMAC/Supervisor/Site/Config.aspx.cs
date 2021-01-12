using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using PMAC.BLL;
using System.Data;

public partial class Supervisor_Site_Config : System.Web.UI.Page
{
    SiteBL _siteBL = new SiteBL();
    MeterHistoryBL _meterHistoryBL = new MeterHistoryBL();
    TransmitterHistoryBL _transmitterHistoryBL = new TransmitterHistoryBL();
    LoggerHistoryBL _loggerHistoryBL = new LoggerHistoryBL();

    LoggerConfigurationBL _loggerConfigurationBL = new LoggerConfigurationBL();
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            for (int i = 1; i <= 31; i++)
            {
                cboStartDays.Items.Add(new Telerik.Web.UI.RadComboBoxItem(i.ToString()));
            }
            for (int i = 0; i < 24; i++)
            {
                cboStartHours.Items.Add(new Telerik.Web.UI.RadComboBoxItem(i.ToString()));
            }
            for (int i = 1; i < 20; i++)
            {
                cboZoomLevels.Items.Add(new Telerik.Web.UI.RadComboBoxItem(i.ToString()));
            }
            cboZoomLevels.SelectedIndex = 15;

            // Pi-solution
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();

            var var1 = list.Where(x => x.ControlId.Contains("lbTitle")).FirstOrDefault();
            lbTitle.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("lbTagName")).FirstOrDefault();
            lbTagName.Text = (var2 == null) ? "" : var2.Contents;
            var var3 = list.Where(x => x.ControlId.Contains("lbAliasName")).FirstOrDefault();
            lbAliasName.Text = (var3 == null) ? "" : var3.Contents;
            var var4 = list.Where(x => x.ControlId.Contains("lbLocation")).FirstOrDefault();
            lbLocation.Text = (var4 == null) ? "" : var4.Contents;
            var var5 = list.Where(x => x.ControlId.Contains("lbLatitude")).FirstOrDefault();
            lbLatitude.Text = (var5 == null) ? "" : var5.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("lbLongitude")).FirstOrDefault();
            lbLongitude.Text = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("lbDelayTime")).FirstOrDefault();
            lbDelayTime.Text = (var7 == null) ? "" : var7.Contents;
            var var8 = list.Where(x => x.ControlId.Contains("lbZoom")).FirstOrDefault();
            lbZoom.Text = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("lbGroupDisplay")).FirstOrDefault();
            lbGroupDisplay.Text = (var9 == null) ? "" : var9.Contents;
            var var10 = list.Where(x => x.ControlId.Contains("lbGaugeSeri")).FirstOrDefault();
            lbGaugeSeri.Text = (var10 == null) ? "" : var10.Contents;
            var var11 = list.Where(x => x.ControlId.Contains("lbTransmitterSeri")).FirstOrDefault();
            lbTransmitterSeri.Text = (var11 == null) ? "" : var11.Contents;
            var var12 = list.Where(x => x.ControlId.Contains("lbLoggerSeri")).FirstOrDefault();
            lbLoggerSeri.Text = (var12 == null) ? "" : var12.Contents;
            var var13 = list.Where(x => x.ControlId.Contains("lbStatus")).FirstOrDefault();
            lbStatus.Text = (var13 == null) ? "" : var13.Contents;
            var var14 = list.Where(x => x.ControlId.Contains("lbStaffId")).FirstOrDefault();
            lbStaffId.Text = (var14 == null) ? "" : var14.Contents;
            var var15 = list.Where(x => x.ControlId.Contains("lbCustomerId")).FirstOrDefault();
            lbCustomerId.Text = (var15 == null) ? "" : var15.Contents;
            var var16 = list.Where(x => x.ControlId.Contains("lbTubingSize")).FirstOrDefault();
            lbTubingSize.Text = (var16 == null) ? "" : var16.Contents;
            var var17 = list.Where(x => x.ControlId.Contains("lbLoggerId")).FirstOrDefault();
            lbLoggerId.Text = (var17 == null) ? "" : var17.Contents;
            var var18 = list.Where(x => x.ControlId.Contains("lbLastDate")).FirstOrDefault();
            lbLastDate.Text = (var18 == null) ? "" : var18.Contents;
            var var19 = list.Where(x => x.ControlId.Contains("lbTimeVerified")).FirstOrDefault();
            lbTimeVerified.Text = (var19 == null) ? "" : var19.Contents;
            var var20 = list.Where(x => x.ControlId.Contains("lbDiffValue")).FirstOrDefault();
            lbDiffValue.Text = (var20 == null) ? "" : var20.Contents;
            var var21 = list.Where(x => x.ControlId.Contains("lbLoggerMobileNumber")).FirstOrDefault();
            lbLoggerMobileNumber.Text = (var21 == null) ? "" : var21.Contents;
            var var22 = list.Where(x => x.ControlId.Contains("lbNote")).FirstOrDefault();
            lbNote.Text = (var22 == null) ? "" : var22.Contents;
            var var23 = list.Where(x => x.ControlId.Contains("lbChangeGaugeDate")).FirstOrDefault();
            lbChangeGaugeDate.Text = (var23 == null) ? "" : var23.Contents;
            var var24 = list.Where(x => x.ControlId.Contains("lbChangeTransmitterDate")).FirstOrDefault();
            lbChangeTransmitterDate.Text = (var24 == null) ? "" : var24.Contents;
            var var25 = list.Where(x => x.ControlId.Contains("lbChangeLoggerDate")).FirstOrDefault();
            lbChangeLoggerDate.Text = (var25 == null) ? "" : var25.Contents;
            var var26 = list.Where(x => x.ControlId.Contains("lbCondition")).FirstOrDefault();
            lbCondition.Text = (var26 == null) ? "" : var26.Contents;
            var var27 = list.Where(x => x.ControlId.Contains("lbBaseline")).FirstOrDefault();
            lbBaseline.Text = (var27 == null) ? "" : var27.Contents;


            var var28 = list.Where(x => x.ControlId.Contains("btnAdd")).FirstOrDefault();
            btnAdd.Text = (var28 == null) ? "" : var28.Contents;
            var var29 = list.Where(x => x.ControlId.Contains("btnDelete")).FirstOrDefault();
            btnDelete.Text = (var29 == null) ? "" : var29.Contents;
            var var30 = list.Where(x => x.ControlId.Contains("btnStatistics")).FirstOrDefault();
            RadButton1.Text = (var30 == null) ? "" : var30.Contents;
            var var31 = list.Where(x => x.ControlId.Contains("btnReplacement")).FirstOrDefault();
            RadButton2.Text = (var31 == null) ? "" : var31.Contents;


            // Pop-up (Display groups)
            var var32 = list.Where(x => x.ControlId.Contains("winAddDisplayGroup")).FirstOrDefault();
            winAddDisplayGroup.Title = (var32 == null) ? "" : var32.Contents; 

            // Pop-up (Customer Id)
            var var33 = list.Where(x => x.ControlId.Contains("winAddConsumer")).FirstOrDefault();
            winAddConsumer.Title = (var33 == null) ? "" : var33.Contents;

            // Pop-up (Channel)
            var var34 = list.Where(x => x.ControlId.Contains("winAddChannel")).FirstOrDefault();
            winAddChannel.Title = (var34 == null) ? "" : var34.Contents;

            // Delete popup
            var var35 = list.Where(x => x.ControlId.Contains("lbConfirmDelete")).FirstOrDefault();
            lbConfirmDelete.Text = (var35 == null) ? "" : var35.Contents;
            var var36 = list.Where(x => x.ControlId.Contains("btnOk")).FirstOrDefault();
            btnOK.Text = (var36 == null) ? "" : var36.Contents;
            var var37 = list.Where(x => x.ControlId.Contains("btnCancel")).FirstOrDefault();
            btnCancel.Text = (var37 == null) ? "" : var37.Contents;
            var var38 = list.Where(x => x.ControlId.Contains("winConfirmDelete")).FirstOrDefault();
            winConfirmDelete.Title = (var38 == null) ? "" : var38.Contents;


            // Change of header of RadComboBox
            Label label1 = cboMeterSerials.Header.FindControl("seri_header") as Label;
            Label label2 = cboTransmitterSerials.Header.FindControl("seri_header") as Label;
            Label label3 = cboLoggerSerials.Header.FindControl("seri_header") as Label;
            var var39 = list.Where(x => x.ControlId.Contains("radComboBox_seri_header")).FirstOrDefault();
            label1.Text = (var39 == null) ? "" : var39.Contents;
            label2.Text = (var39 == null) ? "" : var39.Contents;
            label3.Text = (var39 == null) ? "" : var39.Contents;

            label1 = cboMeterSerials.Header.FindControl("manufacturer_header") as Label;
            label2 = cboTransmitterSerials.Header.FindControl("manufacturer_header") as Label;
            label3 = cboLoggerSerials.Header.FindControl("manufacturer_header") as Label;
            var var40 = list.Where(x => x.ControlId.Contains("radComboBox_manufacturer_header")).FirstOrDefault();
            label1.Text = (var40 == null) ? "" : var40.Contents;
            label2.Text = (var40 == null) ? "" : var40.Contents;
            label3.Text = (var40 == null) ? "" : var40.Contents;

            label1 = cboMeterSerials.Header.FindControl("brandname_header") as Label;
            label2 = cboTransmitterSerials.Header.FindControl("brandname_header") as Label;
            label3 = cboLoggerSerials.Header.FindControl("brandname_header") as Label;
            var var41 = list.Where(x => x.ControlId.Contains("radComboBox_brandname_header")).FirstOrDefault();
            label1.Text = (var41 == null) ? "" : var41.Contents;
            label2.Text = (var41 == null) ? "" : var41.Contents;
            label3.Text = (var41 == null) ? "" : var41.Contents;

            label1 = cboMeterSerials.Header.FindControl("size_header") as Label;
            label2 = cboTransmitterSerials.Header.FindControl("size_header") as Label;
            label3 = cboLoggerSerials.Header.FindControl("size_header") as Label;
            var var42 = list.Where(x => x.ControlId.Contains("radComboBox_size_header")).FirstOrDefault();
            label1.Text = (var42 == null) ? "" : var42.Contents;
            label2.Text = (var42 == null) ? "" : var42.Contents;
            label3.Text = (var42 == null) ? "" : var42.Contents;

            // Change header of another radcombobox
            Label label4 = cboStatus.Header.FindControl("status_header") as Label;
            var var43 = list.Where(x => x.ControlId.Contains("radComboBox_status_header")).FirstOrDefault();
            label4.Text = (var43 == null) ? "" : var43.Contents;

            label4 = cboStatus.Header.FindControl("description_header") as Label;
            var var44 = list.Where(x => x.ControlId.Contains("radComboBox_description_header")).FirstOrDefault();
            label4.Text = (var44 == null) ? "" : var44.Contents;

            Label label5 = cboAvailabilities.Header.FindControl("condition_status") as Label;
            var var45 = list.Where(x => x.ControlId.Contains("radComboBox_condition_header")).FirstOrDefault();
            label5.Text = (var45 == null) ? "" : var45.Contents;

            label5 = cboAvailabilities.Header.FindControl("description2_status") as Label;
            var var46 = list.Where(x => x.ControlId.Contains("radComboBox_description_header")).FirstOrDefault();
            label5.Text = (var46 == null) ? "" : var46.Contents;


            // Change header of combobox
            Label label11 = cboSites.Header.FindControl("aliasname_header") as Label;
            var var47 = list.Where(x => x.ControlId.Contains("radComboBox_aliasname_header")).FirstOrDefault();
            label11.Text = (var47 == null) ? "" : var47.Contents;

            label11 = cboSites.Header.FindControl("location_header") as Label;
            var var48 = list.Where(x => x.ControlId.Contains("radComboBox_location_header")).FirstOrDefault();
            label11.Text = (var48 == null) ? "" : var48.Contents;

            label11 = cboSites.Header.FindControl("locationId_header") as Label;
            var var49 = list.Where(x => x.ControlId.Contains("radComboBox_locationId_header")).FirstOrDefault();
            label11.Text = (var49 == null) ? "" : var49.Contents;

            // Change header of combobox
            Label label22 = cboDisplayGroups.Header.FindControl("group_header") as Label;
            var var50 = list.Where(x => x.ControlId.Contains("radComboBox_group_header")).FirstOrDefault();
            label22.Text = (var50 == null) ? "" : var50.Contents;

            label22 = cboDisplayGroups.Header.FindControl("description_header") as Label;
            var var51 = list.Where(x => x.ControlId.Contains("radComboBox_description_header")).FirstOrDefault();
            label22.Text = (var51 == null) ? "" : var51.Contents;

            // Change header of combobox
            label22 = cboConsumers.Header.FindControl("customerId_header") as Label;
            var50 = list.Where(x => x.ControlId.Contains("winAddConsumer_customerId")).FirstOrDefault();
            label22.Text = (var50 == null) ? "" : var50.Contents;

            label22 = cboConsumers.Header.FindControl("customerName_header") as Label;
            var51 = list.Where(x => x.ControlId.Contains("winAddConsumer_customerName")).FirstOrDefault();
            label22.Text = (var51 == null) ? "" : var51.Contents;

        }
        RadAjaxManager manage = RadAjaxManager.GetCurrent(Page);
        manage.AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(manage_AjaxRequest);
        manage.AjaxSettings.AddAjaxSetting(manage, cboConsumers);
        manage.AjaxSettings.AddAjaxSetting(manage, ConsumersDataSource);
        manage.AjaxSettings.AddAjaxSetting(manage, cboDisplayGroups);
        manage.AjaxSettings.AddAjaxSetting(manage, DisplayGroupsDataSource);
        ntf.VisibleOnPageLoad = false;
    }

    void manage_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        switch (e.Argument)
        {
            case "winAddConsumer_Close":
                ConsumersDataSource.DataBind();
                cboConsumers.DataBind();
                break;
            case "winAddDisplayGroup_Close":
                DisplayGroupsDataSource.DataBind();
                cboDisplayGroups.DataBind();
                break;
            default:
                break;
        }
    }
    

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();
        var lb_installation_point_update_confirm = list.Where(x => x.ControlId.Contains("lb_installation_point_update_confirm")).FirstOrDefault();

        ntf.VisibleOnPageLoad = true;
        bool invalid = IsInvalidInput();
        if (invalid)
        {
            return;
        }
        var dbSite = _siteBL.GetSite(cboSites.Text);
        var site = GetSite();
        var loggerConfiguration = GetLoggerConfiguration();
        var dbLoggerConfiguration = _loggerConfigurationBL.GetLoggerConfiguration(txtLoggerID.Text);
        if (dbSite == null)
        {
            if (dbLoggerConfiguration == null)
            {
                _loggerConfigurationBL.InsertLoggerConfiguration(loggerConfiguration);
                //site.t_Logger_Configurations = loggerConfiguration;
            }
            else
            {
                loggerConfiguration.ForwardFlow = dbLoggerConfiguration.ForwardFlow;
                loggerConfiguration.Pressure1 = dbLoggerConfiguration.Pressure1;
                loggerConfiguration.Pressure2 = dbLoggerConfiguration.Pressure2;
                loggerConfiguration.ReverseFlow = dbLoggerConfiguration.ReverseFlow;
                _loggerConfigurationBL.UpdateLoggerConfiguration(loggerConfiguration, dbLoggerConfiguration);
            }
            _siteBL.InsertSite(site);
            ReBind();

            //ntf.Text = "Đã thêm mới điểm lắp đặt.";
            ntf.Text = lb_installation_point_update_confirm.Contents;

        }
        else
        {

            if (dbLoggerConfiguration == null)
            {
                _loggerConfigurationBL.InsertLoggerConfiguration(loggerConfiguration);
            }
            else
            {
                loggerConfiguration.ForwardFlow = dbLoggerConfiguration.ForwardFlow;
                loggerConfiguration.Pressure1 = dbLoggerConfiguration.Pressure1;
                loggerConfiguration.Pressure2 = dbLoggerConfiguration.Pressure2;
                loggerConfiguration.ReverseFlow = dbLoggerConfiguration.ReverseFlow;
                _loggerConfigurationBL.UpdateLoggerConfiguration(loggerConfiguration, dbLoggerConfiguration);
            }
            _siteBL.UpdateSite(site, dbSite);
            ntf.Text = "Data saved.";
        }
    }

    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();
        var lb_installation_point_delete_confirm = list.Where(x => x.ControlId.Contains("lb_installation_point_delete_confirm")).FirstOrDefault();

        var site = _siteBL.GetSite(cboSites.Text);
        if (site != null)
        {
            _siteBL.DeleteSite(site);
            ReBind();
            ntf.VisibleOnPageLoad = true;
            //ntf.Text = "Đã xóa điểm lắp đặt.";
            ntf.Text = lb_installation_point_delete_confirm.Contents;
            SetEmpty();
            cboSites.Focus();
        }
    }

    private void ReBind()
    {
        SitesDataSource.DataBind();
        cboSites.DataBind();
    }

    private t_Sites GetSite()
    {
        t_Sites site = new t_Sites();
        site.SiteAliasName = txtAliasName.Text;
        site.ConsumerId = cboConsumers.Text;
        site.Description = txtDescription.Text;
        site.DisplayGroup = cboDisplayGroups.Text;
        site.Latitude = nmrLatitude.Value;
        site.Location = txtLocation.Text;
        site.LoggerId = txtLoggerID.Text;
        if (string.IsNullOrEmpty(site.LoggerId))
        {
            site.LoggerId = null;
        }
        site.Longitude = nmrLongitude.Value;
        site.SiteId = cboSites.Text;
        site.StartDay = byte.Parse(cboStartDays.Text);
        site.Zoom = byte.Parse(cboZoomLevels.Text);
        site.MeterSerial = string.IsNullOrEmpty(cboMeterSerials.Text) ? null : cboMeterSerials.Text;
        site.TransmitterSerial = string.IsNullOrEmpty(cboTransmitterSerials.Text) ? null : cboTransmitterSerials.Text;
        site.LoggerSerial = string.IsNullOrEmpty(cboLoggerSerials.Text) ? null : cboLoggerSerials.Text;
        site.Status = string.IsNullOrEmpty(cboStatus.SelectedValue) ? null : cboStatus.SelectedValue;
        site.Availability = string.IsNullOrEmpty(cboAvailabilities.SelectedValue) ? null : cboAvailabilities.SelectedValue;
        site.MeterDateChanged = dtmMeterChanged.SelectedDate;
        site.TransmitterDateChanged = dtmTransmitterChanged.SelectedDate;
        site.LoggerDateChanged = dtmLoggerChanged.SelectedDate;
        site.Staffs = txtStaffs.Text;
        site.PipeSize = txtPipeSize.Text;
        if (nmrSetDelayTime.Value != null)
            site.SetDelayTime = (int)nmrSetDelayTime.Value;
        if (nmrSetDiffValue.Value != null)
            site.SetDiffValue = (double)nmrSetDiffValue.Value / 100;
        site.Baseline = (txtBaseline.Value!= null)?(double)txtBaseline.Value:0;
        return site;
    }

    private t_Logger_Configurations GetLoggerConfiguration()
    {
        t_Logger_Configurations loggerConfiguration = new t_Logger_Configurations();
        loggerConfiguration.LoggerId = txtLoggerID.Text;
        loggerConfiguration.SiteId = cboSites.Text;
        loggerConfiguration.StartHour = byte.Parse(cboStartHours.Text);
        loggerConfiguration.TelephoneNumber = txtLoggerPhoneNumber.Text;
        return loggerConfiguration;
    }

    private void SetEmpty()
    {
        txtAliasName.Text = string.Empty;
        cboConsumers.Text = string.Empty;
        txtDescription.Text = string.Empty;
        cboDisplayGroups.SelectedIndex = 0;
        nmrLatitude.Value = null;
        txtLocation.Text = string.Empty;
        txtLoggerID.Text = string.Empty;
        nmrLongitude.Value = null;
        cboSites.Text = string.Empty;
        cboStartDays.SelectedIndex = 0;
        cboZoomLevels.SelectedIndex = 0;
        cboStartHours.SelectedIndex = 0;
        cboAvailabilities.SelectedValue = null;
        cboStatus.SelectedValue = null;
        cboMeterSerials.Text = string.Empty;
        cboTransmitterSerials.Text = string.Empty;
        cboLoggerSerials.Text = string.Empty;
        dtmMeterChanged.SelectedDate = null;
        dtmTransmitterChanged.SelectedDate = null;
        dtmLoggerChanged.SelectedDate = null;
        txtStaffs.Text = string.Empty;
        txtPipeSize.Text = string.Empty;
        nmrSetDelayTime.Value = null;
        nmrSetDiffValue.Value = null;
        txtBaseline.Value = null;
    }

    private void SetValues(t_Sites site)
    {
        txtAliasName.Text = site.SiteAliasName;
        cboConsumers.SelectedValue = site.ConsumerId;
        txtDescription.Text = site.Description;
        cboDisplayGroups.SelectedValue = site.DisplayGroup;
        nmrLatitude.Value = site.Latitude;
        txtLocation.Text = site.Location;
        txtLoggerID.Text = site.LoggerId;
        nmrLongitude.Value = site.Longitude;
        cboSites.Text = site.SiteId;
        if (site.StartDay != null)
            cboStartDays.SelectedIndex = (int)site.StartDay - 1;
        if (site.Zoom != null)
            cboZoomLevels.SelectedIndex = (byte)site.Zoom - 1;
        if (site.t_Logger_Configurations != null)
        {
            cboStartHours.SelectedIndex = (byte)site.t_Logger_Configurations.StartHour;
            txtLoggerPhoneNumber.Text = site.t_Logger_Configurations.TelephoneNumber;
            
        }
        else
        {
            cboStartHours.SelectedIndex = 0;
            txtLoggerPhoneNumber.Text = string.Empty;
        }
        cboMeterSerials.Text = site.MeterSerial;
        cboTransmitterSerials.Text = site.TransmitterSerial;
        cboLoggerSerials.Text = site.LoggerSerial;
        cboStatus.SelectedValue = site.Status;
        cboAvailabilities.SelectedValue = site.Availability;
        txtStaffs.Text = site.Staffs;
        txtPipeSize.Text = site.PipeSize;
        nmrSetDiffValue.Value = site.SetDiffValue;
        if (site.SetDiffValue != null)
        {
            nmrSetDiffValue.Value = (double)site.SetDiffValue * 100;
        }
        nmrSetDelayTime.Value = site.SetDelayTime;
        txtBaseline.Value = site.Baseline;
        SetDateChanged();
    }

    private void SetDateChanged()
    {
        var meterHistory = _meterHistoryBL.GetLastMeterHistory(cboSites.Text);
        var transmitterHistory = _transmitterHistoryBL.GetLastTransmitterHistory(cboSites.Text);
        var loggerHistory = _loggerHistoryBL.GetLastLoggerHistory(cboSites.Text);
        if (meterHistory != null)
        {
            dtmMeterChanged.SelectedDate = meterHistory.DateChanged;
        }
        if (transmitterHistory != null)
        {
            dtmTransmitterChanged.SelectedDate = transmitterHistory.DateChanged;
        }
        if (loggerHistory != null)
        {
            dtmLoggerChanged.SelectedDate = loggerHistory.DateChanged;
        }
    }

    private bool IsInvalidInput()
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();
        var empty_locationId = list.Where(x => x.ControlId.Contains("empty_locationId")).FirstOrDefault();
        var empty_aliasName = list.Where(x => x.ControlId.Contains("empty_aliasName")).FirstOrDefault();
        var empty_groupDisplay = list.Where(x => x.ControlId.Contains("empty_groupDisplay")).FirstOrDefault();

        if (string.IsNullOrEmpty(cboSites.Text))
        {
            ntf.Text = empty_locationId.Contents;
            return true;
        }
        else if (string.IsNullOrEmpty(txtAliasName.Text))
        {
            ntf.Text = empty_aliasName.Contents;
            txtAliasName.Focus();
            return true;
        }
        else if (string.IsNullOrEmpty(cboDisplayGroups.Text))
        {
            ntf.Text = empty_groupDisplay.Contents;
            cboDisplayGroups.Focus();
            return true;
        }
        return false;
    }

    protected void cboSites_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        string siteID = cboSites.Text;
        var site = _siteBL.GetSite(siteID);
        if (site != null)
        {
            SetValues(site);
        }
        else
        {
            txtLocation.Focus();
        }
    }
}