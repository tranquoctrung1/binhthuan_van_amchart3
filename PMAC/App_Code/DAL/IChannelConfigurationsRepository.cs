using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;


namespace PMAC.DAL
{
    public interface IChannelConfigurationRepository : IDisposable
    {
        t_Channel_Configurations GetChannelConfigurationByType(string loggerId, string type);

        void DeleteChannelConfiguration(t_Channel_Configurations channelConfiguration);

        t_Channel_Configurations GetChannelConfiguration(string channelConfigurationID);

        int GetChannelConfigurationsZero(string loggerId);

        int GetChannelConfigurationsErr(string loggerId, int? diffTime);

        IEnumerable<t_Channel_Configurations> GetChannelConfigurations();

        IEnumerable<t_Channel_Configurations> GetChannelConfigurationsByLoggerID(string loggerID);

        void InsertChannelConfiguration(t_Channel_Configurations channelConfiguration);

        void UpdateChannelConfiguration(t_Channel_Configurations channelConfiguration, t_Channel_Configurations origChannelConfiguration);

        IEnumerable<t_Channel_Configurations> GetAlarmChannelByLoggerID(string loggerID);

        bool ConfirmAlarmByLoggerID(string loggerID);
    }
}