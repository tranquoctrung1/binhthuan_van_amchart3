using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using PMAC.BLL;

public partial class Controls_ucChannel : System.Web.UI.UserControl
{
    ChannelConfigurationBL _channelConfigurationBL = new ChannelConfigurationBL();
    LoggerConfigurationBL _loggerConfigurationBL = new LoggerConfigurationBL();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        txtLoggerID.Text = Request.QueryString["loggerID"];
        txtSiteID.Text = Request.QueryString["siteID"];
        msg.Text = string.Empty;


        if (!IsPostBack)
        {
            // Pi-solution
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();

            var var1 = list.Where(x => x.ControlId.Contains("winAddChannel_channelId")).FirstOrDefault();
            winAddChannel_channelId.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("winAddChannel_locationId")).FirstOrDefault();
            winAddChannel_locationId.Text = (var2 == null) ? "" : var2.Contents;
            var var3 = list.Where(x => x.ControlId.Contains("winAddChannel_loggerId")).FirstOrDefault();
            winAddChannel_loggerId.Text = (var3 == null) ? "" : var3.Contents;
            var var4 = list.Where(x => x.ControlId.Contains("winAddChannel_channelFront")).FirstOrDefault();
            winAddChannel_channelFront.Text = (var4 == null) ? "" : var4.Contents;
            var var5 = list.Where(x => x.ControlId.Contains("winAddChannel_channelBack")).FirstOrDefault();
            winAddChannel_channelBack.Text = (var5 == null) ? "" : var5.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("winAddChannel_channelForward")).FirstOrDefault();
            winAddChannel_channelForward.Text = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("winAddChannel_channelBackward")).FirstOrDefault();
            winAddChannel_channelBackward.Text = (var7 == null) ? "" : var7.Contents;
            var var8 = list.Where(x => x.ControlId.Contains("winAddChannel_Note")).FirstOrDefault();
            winAddChannel_Note.Text = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("winAddChannel_channelName")).FirstOrDefault();
            winAddChannel_channelName.Text = (var9 == null) ? "" : var9.Contents;
            var var10 = list.Where(x => x.ControlId.Contains("winAddChannel_channelUnit")).FirstOrDefault();
            winAddChannel_channelUnit.Text = (var10 == null) ? "" : var10.Contents;


            var var28 = list.Where(x => x.ControlId.Contains("winAddChannel_btnEdit")).FirstOrDefault();
            btnAdd.Text = (var28 == null) ? "" : var28.Contents;
            var var29 = list.Where(x => x.ControlId.Contains("winAddChannel_delete")).FirstOrDefault();
            btnDelete.Text = (var29 == null) ? "" : var29.Contents;
        }
    }

    protected void cboChannels_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        string channelID=cboChannels.Text;
        var channelConfiguration = _channelConfigurationBL.GetChannelConfiguration(channelID);
        if (channelConfiguration != null)
        {
            SetValues(channelConfiguration);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();
        var lb_channel_update_confirm = list.Where(x => x.ControlId.Contains("lb_channel_update_confirm")).FirstOrDefault();

        var dbChannelConfiguration = _channelConfigurationBL.GetChannelConfiguration(cboChannels.Text);
        var channelConfiguration = GetChannelConfiguration();
        if (dbChannelConfiguration == null)
        {
            _channelConfigurationBL.InsertChannelConfiguration(channelConfiguration);
            msg.Text = "Channel added";
            ReBind();
        }
        else
        {
            _channelConfigurationBL.UpdateChannelConfiguration(channelConfiguration, dbChannelConfiguration);
            //msg.Text = "Đã cập nhật kênh đo.";
            msg.Text = lb_channel_update_confirm.Contents;
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();
        var lb_channel_delete_confirm = list.Where(x => x.ControlId.Contains("lb_channel_delete_confirm")).FirstOrDefault();

        var channelConfiguration = _channelConfigurationBL.GetChannelConfiguration(cboChannels.Text);
        if (channelConfiguration != null)
        {
            _channelConfigurationBL.DeleteChannelConfiguration(channelConfiguration);
            SetEmpty();
            ReBind();
            //msg.Text = "Đã xóa kênh đo.";
            msg.Text = lb_channel_delete_confirm.Contents;
        }
    }

    private void ReBind()
    {
        ChannelsDataSource.DataBind();
        cboChannels.DataBind();
    }

    private t_Channel_Configurations GetChannelConfiguration()
    {
        t_Channel_Configurations channelConfiguration = new t_Channel_Configurations();
        channelConfiguration.ChannelId = cboChannels.Text;
        channelConfiguration.ChannelName = txtName.Text;
        channelConfiguration.Description = txtDescription.Text;
        channelConfiguration.ForwardFlow = rdoForward.Checked;
        channelConfiguration.LoggerId = txtLoggerID.Text;
        channelConfiguration.Pressure1 = rdoPressure1.Checked;
        channelConfiguration.Pressure2 = rdoPressure2.Checked;
        channelConfiguration.ReverseFlow = rdoReverse.Checked;
        channelConfiguration.Unit = cboUnits.Text;
        channelConfiguration.ChannelOther = rdoChannelOther.Checked;
        if(rdoIsShowLable.Checked == true)
        {
            channelConfiguration.DisplayOnLabel = true;
        }
        if(rdonotShowLable.Checked == true)
        {
            channelConfiguration.DisplayOnLabel = false;
        }
        channelConfiguration.t_Logger_Configurations = GetLoggerConfiguration();
        return channelConfiguration;
    }

    private t_Logger_Configurations GetLoggerConfiguration()
    {
        t_Logger_Configurations loggerConfiguration = new t_Logger_Configurations();
        loggerConfiguration.LoggerId = txtLoggerID.Text;
        loggerConfiguration.SiteId = txtSiteID.Text;
        loggerConfiguration.StartHour = byte.Parse(Request.QueryString["startHour"]);
        loggerConfiguration.TelephoneNumber = Request.QueryString["telNumer"];
        
        
        //byte channel = byte.Parse(cboChannels.Text.Split('_')[1]);
        //if (rdoForward.Checked)
        //{
        //    loggerConfiguration.ForwardFlow = channel;
        //}
        //if (rdoPressure1.Checked)
        //{
        //    loggerConfiguration.Pressure1 = channel;
        //}
        //if (rdoPressure2.Checked)
        //{
        //    loggerConfiguration.Pressure2 = channel;
        //}
        //if (rdoReverse.Checked)
        //{
        //    loggerConfiguration.ReverseFlow = channel;
        //}

        if (rdoForward.Checked)
        {
            loggerConfiguration.ForwardFlow = 3;
        }
        if (rdoPressure1.Checked)
        {
            loggerConfiguration.Pressure1 = 1;
        }
        if (rdoPressure2.Checked)
        {
            loggerConfiguration.Pressure2 = 2;
        }
        if (rdoReverse.Checked)
        {
            loggerConfiguration.ReverseFlow = 4;
        }

        return loggerConfiguration;
    }

    private void SetValues(t_Channel_Configurations channelConfiguration)
    {
        cboChannels.Text = channelConfiguration.ChannelId;
        txtName.Text = channelConfiguration.ChannelName;
        cboUnits.SelectedValue = channelConfiguration.Unit;
        txtDescription.Text = channelConfiguration.Description;
        rdoForward.Checked = channelConfiguration.ForwardFlow ?? false;
        rdoPressure1.Checked = channelConfiguration.Pressure1 ?? false;
        rdoPressure2.Checked = channelConfiguration.Pressure2 ?? false;
        rdoReverse.Checked = channelConfiguration.ReverseFlow ?? false;
        rdoChannelOther.Checked = channelConfiguration.ChannelOther ?? false;
        if(channelConfiguration.DisplayOnLabel == true)
        {
            rdoIsShowLable.Checked = true;
        }
        else
        {
            rdonotShowLable.Checked = true;
        }
    }

    private void SetEmpty()
    {
        cboChannels.Text = string.Empty;
        txtName.Text = string.Empty;
        cboUnits.SelectedIndex = 0;
        txtDescription.Text = string.Empty;
        rdoForward.Checked = false;
        rdoPressure1.Checked = false;
        rdoPressure2.Checked = false;
        rdoReverse.Checked = false;
        rdoIsShowLable.Checked = false;
        rdonotShowLable.Checked = false;
        rdoChannelOther.Checked = false;
    }
}