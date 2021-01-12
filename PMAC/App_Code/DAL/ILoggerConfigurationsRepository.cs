using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;


namespace PMAC.DAL
{
    public interface ILoggerConfigurationRepository : IDisposable
    {

        void DeleteLoggerConfiguration(t_Logger_Configurations loggerConfiguration);

       

        t_Logger_Configurations GetLoggerConfiguration(string loggerConfigurationID);

        IEnumerable<t_Logger_Configurations> GetLoggerConfigurations();

        void InsertLoggerConfiguration(t_Logger_Configurations loggerConfiguration);

        void UpdateLoggerConfiguration(t_Logger_Configurations loggerConfiguration, t_Logger_Configurations origLoggerConfiguration);

        void RollbackChannelSetting(t_Logger_Configurations loggerConfiguration, byte channel);
    }
}