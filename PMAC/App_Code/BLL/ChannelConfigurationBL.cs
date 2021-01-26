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
    public class ChannelConfigurationBL : IDisposable
    {
        private bool disposedValue = false;
        private IChannelConfigurationRepository channelConfigurationRepository;

        public ChannelConfigurationBL()
        {
            this.channelConfigurationRepository = new ChannelConfigurationRepository();
        }

        public ChannelConfigurationBL(IChannelConfigurationRepository channelConfigurationRepository)
        {
            this.channelConfigurationRepository = channelConfigurationRepository;
        }
    
        public t_Channel_Configurations GetChannelConfiguration(string channelConfigurationID)
        {
            return channelConfigurationRepository.GetChannelConfiguration(channelConfigurationID);
        }

        public t_Channel_Configurations GetChannelConfigurationByType(string loggerId, string type)
        {
            return channelConfigurationRepository.GetChannelConfigurationByType(loggerId, type);
        }
        public int GetChannelConfigurationsZero(string loggerId)
        {
            return channelConfigurationRepository.GetChannelConfigurationsZero(loggerId);
        }
        public int GetChannelConfigurationsErr(string loggerId, int? diffTime)
        {
            return channelConfigurationRepository.GetChannelConfigurationsErr(loggerId, diffTime);
        }
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public IEnumerable<t_Channel_Configurations> GetChannelConfigurations()
        {
            return channelConfigurationRepository.GetChannelConfigurations();
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public IEnumerable<t_Channel_Configurations> GetChannelConfigurationsByLoggerID(string loggerID)
        {
            return channelConfigurationRepository.GetChannelConfigurationsByLoggerID(loggerID);
        }

        public void InsertChannelConfiguration(t_Channel_Configurations channelConfiguration)
        {
            try
            {
                channelConfigurationRepository.InsertChannelConfiguration(channelConfiguration);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateChannelConfiguration(t_Channel_Configurations channelConfiguration, t_Channel_Configurations origChannelConfiguration)
        {
            try
            {
                channelConfigurationRepository.UpdateChannelConfiguration(channelConfiguration, origChannelConfiguration);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteChannelConfiguration(t_Channel_Configurations channelConfiguration)
        {
            try
            {
                channelConfigurationRepository.DeleteChannelConfiguration(channelConfiguration);
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
                    channelConfigurationRepository.Dispose();
                }
            }
            disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public IEnumerable<t_Channel_Configurations> GetAlarmChannelByLoggerID(string loggerID)
        {
            return channelConfigurationRepository.GetAlarmChannelByLoggerID(loggerID);
        }

        public bool ConfirmAlarmByLoggerID(string loggerID)
        {
            return channelConfigurationRepository.ConfirmAlarmByLoggerID(loggerID);
        }
    }
}
