using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;
using System.Data.SqlClient;

namespace PMAC.DAL
{
    public class LoggerDataRepository:IDisposable, ILoggerDataRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

        public List<t_Logger_Data> GetLoggerData(string channelID, DateTime startDate, DateTime endDate)
        {
            //Sql2005
            return context.Database.SqlQuery<t_Logger_Data>("exec p_Data_Logger_Get @ChannelID, @StartDate, @EndDate", new SqlParameter("StartDate", startDate), new SqlParameter("EndDate", endDate), new SqlParameter("ChannelID", channelID)).ToList();

            //return context.Database.SqlQuery<t_Logger_Data>("p_Data_Logger_Get @ChannelID, @StartDate, @EndDate", new SqlParameter("StartDate", startDate), new SqlParameter("EndDate", endDate), new SqlParameter("ChannelID", channelID)).ToList();
        }

        
        public List<t_Logger_Data> GetLoggerIndexes(string channelID, DateTime startDate, DateTime endDate)
        {
            return context.Database.SqlQuery<t_Logger_Data>("exec p_Index_Logger_Get @ChannelID, @StartDate, @EndDate", new SqlParameter("StartDate", startDate), new SqlParameter("EndDate", endDate), new SqlParameter("ChannelID", channelID)).ToList();
        }

        public t_Logger_Data GetLoggerIndex(string channelID, DateTime timeStamp)
        {
            return context.Database.SqlQuery<t_Logger_Data>(" exec p_Index_Logger_Get @ChannelID, @StartDate, @EndDate", new SqlParameter("StartDate", timeStamp), new SqlParameter("EndDate", timeStamp), new SqlParameter("ChannelID", channelID)).FirstOrDefault();
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