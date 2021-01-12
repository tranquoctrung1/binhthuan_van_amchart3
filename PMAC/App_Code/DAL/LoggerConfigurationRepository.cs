using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;


namespace PMAC.DAL
{
    public class LoggerConfigurationRepository:IDisposable, ILoggerConfigurationRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

       

        public IEnumerable<t_Logger_Configurations> GetLoggerConfigurations()
        {
            return context.t_Logger_Configurations.OrderBy(c => c.LoggerId).ToList();
        }

        public t_Logger_Configurations GetLoggerConfiguration(string loggerConfigurationID)
        {
            return context.t_Logger_Configurations.SingleOrDefault(c => c.LoggerId == loggerConfigurationID);
        }

        public void InsertLoggerConfiguration(t_Logger_Configurations loggerConfiguraton)
        {
            try
            {
                context.t_Logger_Configurations.Add(loggerConfiguraton);
                context.SaveChanges();
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
                context.t_Logger_Configurations.Attach(origLoggerConfiguration);
                origLoggerConfiguration.ForwardFlow = loggerConfiguration.ForwardFlow;
                origLoggerConfiguration.LoggerId = loggerConfiguration.LoggerId;
                origLoggerConfiguration.Pressure1 = loggerConfiguration.Pressure1;
                origLoggerConfiguration.Pressure2 = loggerConfiguration.Pressure2;
                origLoggerConfiguration.ReverseFlow = loggerConfiguration.ReverseFlow;
                origLoggerConfiguration.SiteId = loggerConfiguration.SiteId;
                origLoggerConfiguration.StartHour = loggerConfiguration.StartHour;
                origLoggerConfiguration.TelephoneNumber = loggerConfiguration.TelephoneNumber;
                context.SaveChanges();
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
                context.t_Logger_Configurations.Attach(loggerConfiguration);
                if (loggerConfiguration.ForwardFlow == channel)
                {
                    loggerConfiguration.ForwardFlow = null;
                }
                if (loggerConfiguration.Pressure1 == channel)
                {
                    loggerConfiguration.Pressure1 = null;
                }
                if (loggerConfiguration.Pressure2 == channel)
                {
                    loggerConfiguration.Pressure2 = null;
                }
                if (loggerConfiguration.ReverseFlow == channel)
                {
                    loggerConfiguration.ReverseFlow = null;
                }
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteLoggerConfiguration(t_Logger_Configurations loggerConfig)
        {
            try
            {
                context.t_Logger_Configurations.Attach(loggerConfig);
                context.t_Logger_Configurations.Remove(loggerConfig);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        protected void Dispose(bool isDisposing)
        {
            if (!this.disposedValue)
            {
                if (isDisposing)
                {
                    context.Dispose();
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