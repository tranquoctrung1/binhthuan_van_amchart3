using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;
using System.Data.Objects.SqlClient;

namespace PMAC.DAL
{
    public class ChannelConfigurationRepository : IDisposable, IChannelConfigurationRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

        public int GetChannelConfigurationsZero(string loggerId)
        {
            return context.t_Channel_Configurations.Where(c =>c.LoggerId==loggerId && c.Pressure2 == true && c.LastValue <= 0 ).Count();
        }
        public int GetChannelConfigurationsErr(string loggerId, int? diffTime)
        {
            var ts = DateTime.Now.AddMinutes(-(int)diffTime);

            return context.t_Channel_Configurations.Where(c => c.LoggerId == loggerId && ts>(DateTime)c.TimeStamp).Count();
        }
        public IEnumerable<t_Channel_Configurations> GetChannelConfigurations()
        {
            return context.t_Channel_Configurations.OrderBy(c => c.ChannelId).ToList();
        }

        public IEnumerable<t_Channel_Configurations> GetChannelConfigurationsByLoggerID(string loggerID)
        {
            return context.t_Channel_Configurations.OrderBy(c => c.ChannelId).Where(c => c.LoggerId == loggerID).ToList();
        }

        public t_Channel_Configurations GetChannelConfiguration(string channelConfigurationID)
        {
            return context.t_Channel_Configurations.SingleOrDefault(c => c.ChannelId == channelConfigurationID);
        }

        public t_Channel_Configurations GetChannelConfigurationByType(string loggerId, string type)
        {
            t_Channel_Configurations config = new t_Channel_Configurations();

            switch (type)
            {
                case "f":
                    config = context.t_Channel_Configurations.Where(c => c.ForwardFlow != null && c.ForwardFlow == true && c.LoggerId == loggerId).FirstOrDefault();
                    break;
                case "r":
                    config = context.t_Channel_Configurations.Where(c => c.ReverseFlow != null && c.ReverseFlow == true && c.LoggerId == loggerId).FirstOrDefault();
                    break;
                case "p1":
                    config = context.t_Channel_Configurations.Where(c => c.Pressure1 != null && c.Pressure1 == true && c.LoggerId == loggerId).FirstOrDefault();
                    break;
                case "p2":
                    config = context.t_Channel_Configurations.Where(c => c.Pressure2 != null && c.Pressure2 == true && c.LoggerId == loggerId).FirstOrDefault();
                    break;
                default:
                    break;
            }

            return config;
        }

        public void InsertChannelConfiguration(t_Channel_Configurations channelConfiguration)
        {
            try
            {
                var loggerConfiguration = channelConfiguration.t_Logger_Configurations;
                var dbLoggerConfiguration = context.t_Logger_Configurations.SingleOrDefault(c => c.LoggerId == channelConfiguration.LoggerId);
                if (dbLoggerConfiguration != null)
                {

                    dbLoggerConfiguration.SiteId = loggerConfiguration.SiteId;
                    dbLoggerConfiguration.StartHour = loggerConfiguration.StartHour;
                    dbLoggerConfiguration.TelephoneNumber = loggerConfiguration.TelephoneNumber;

                    if (channelConfiguration.ForwardFlow == true)
                    {
                        dbLoggerConfiguration.ForwardFlow = 3;
                    }
                    if (channelConfiguration.Pressure1 == true)
                    {
                        dbLoggerConfiguration.Pressure1 = 1;
                    }
                    if (channelConfiguration.Pressure2 == true)
                    {
                        dbLoggerConfiguration.Pressure2 = 2;
                    }
                    if (channelConfiguration.ReverseFlow == true)
                    {
                        dbLoggerConfiguration.ReverseFlow = 4;
                    }

                    channelConfiguration.t_Logger_Configurations = null;
                }
                context.t_Channel_Configurations.Add(channelConfiguration);
                context.p_Create_Data_Table(channelConfiguration.ChannelId);
                context.SaveChanges();
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
                context.t_Channel_Configurations.Attach(origChannelConfiguration);

                var dbLoggerConfiguration = origChannelConfiguration.t_Logger_Configurations;
                var loggerConfiguration = channelConfiguration.t_Logger_Configurations;

                if (origChannelConfiguration.Pressure1 == true)
                {
                    dbLoggerConfiguration.Pressure1 = null;
                }
                if (origChannelConfiguration.Pressure2 == true)
                {
                    dbLoggerConfiguration.Pressure2 = null;
                }
                if (origChannelConfiguration.ForwardFlow == true)
                {
                    dbLoggerConfiguration.ForwardFlow = null;
                }
                if (origChannelConfiguration.ReverseFlow == true)
                {
                    dbLoggerConfiguration.ReverseFlow = null;
                }

                origChannelConfiguration.ChannelId = channelConfiguration.ChannelId;
                origChannelConfiguration.ChannelName = channelConfiguration.ChannelName;
                origChannelConfiguration.Description = channelConfiguration.Description;
                origChannelConfiguration.ForwardFlow = channelConfiguration.ForwardFlow;
                origChannelConfiguration.LoggerId = channelConfiguration.LoggerId;
                origChannelConfiguration.Pressure1 = channelConfiguration.Pressure1;
                origChannelConfiguration.Pressure2 = channelConfiguration.Pressure2;
                origChannelConfiguration.ReverseFlow = channelConfiguration.ReverseFlow;
                origChannelConfiguration.Unit = channelConfiguration.Unit;


                dbLoggerConfiguration.SiteId = loggerConfiguration.SiteId;
                dbLoggerConfiguration.StartHour = loggerConfiguration.StartHour;
                dbLoggerConfiguration.TelephoneNumber = loggerConfiguration.TelephoneNumber;



                //Add
                if (channelConfiguration.ForwardFlow == true)
                {
                    dbLoggerConfiguration.ForwardFlow = 3;
                }
                if (channelConfiguration.Pressure1 == true)
                {
                    dbLoggerConfiguration.Pressure1 = 1;
                }
                if (channelConfiguration.Pressure2 == true)
                {
                    dbLoggerConfiguration.Pressure2 = 2;
                }
                if (channelConfiguration.ReverseFlow == true)
                {
                    dbLoggerConfiguration.ReverseFlow = 4;
                }
                context.SaveChanges();
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
                var loggerConfiguration = context.t_Logger_Configurations.SingleOrDefault(c => c.LoggerId == channelConfiguration.LoggerId);


                //Clear
                if (channelConfiguration.ForwardFlow == true)
                {
                    loggerConfiguration.ForwardFlow = null;
                }
                if (channelConfiguration.ReverseFlow == true)
                {
                    loggerConfiguration.ReverseFlow = null;
                }
                if (channelConfiguration.Pressure1 == true)
                {
                    loggerConfiguration.Pressure1 = null;
                }
                if (channelConfiguration.Pressure2 == true)
                {
                    loggerConfiguration.Pressure2 = null;
                }

                context.t_Channel_Configurations.Attach(channelConfiguration);
                context.t_Channel_Configurations.Remove(channelConfiguration);
                context.p_Drop_Data_Table(channelConfiguration.ChannelId);
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