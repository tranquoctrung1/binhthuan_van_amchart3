using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;


namespace PMAC.BLL
{
    [DataObject]
    public class LoggerConfigurationBL : IDisposable
    {
        private bool disposedValue = false;
        private ILoggerConfigurationRepository loggerConfigurationRepository;

        public LoggerConfigurationBL()
        {
            this.loggerConfigurationRepository = new LoggerConfigurationRepository();
        }

        public LoggerConfigurationBL(ILoggerConfigurationRepository loggerConfigurationRepository)
        {
            this.loggerConfigurationRepository = loggerConfigurationRepository;
        }
    
        public t_Logger_Configurations GetLoggerConfiguration(string loggerID)
        {
            return loggerConfigurationRepository.GetLoggerConfiguration(loggerID);
        }

        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public IEnumerable<t_Logger_Configurations> GetLoggerConfigurations()
        {
            return loggerConfigurationRepository.GetLoggerConfigurations();
        }

        public void InsertLoggerConfiguration(t_Logger_Configurations loggerConfiguration)
        {
            try
            {
                loggerConfigurationRepository.InsertLoggerConfiguration(loggerConfiguration);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateLoggerConfiguration(t_Logger_Configurations loggerConfiguration, t_Logger_Configurations origLoggerConfiguration)
        {
            try
            {
                loggerConfigurationRepository.UpdateLoggerConfiguration(loggerConfiguration, origLoggerConfiguration);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void RollbackChannelSetting(t_Logger_Configurations loggerConfiguration, byte channel)
        {
            try
            {
                loggerConfigurationRepository.RollbackChannelSetting(loggerConfiguration, channel);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteLoggerConfiguration(t_Logger_Configurations loggerConfiguration)
        {
            try
            {
                loggerConfigurationRepository.DeleteLoggerConfiguration(loggerConfiguration);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        protected void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    loggerConfigurationRepository.Dispose();
                }
            }
            disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}
