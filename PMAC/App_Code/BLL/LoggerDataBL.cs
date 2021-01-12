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
    public class LoggerDataBL : IDisposable
    {
        private bool disposedValue = false;
        private ILoggerDataRepository loggerDataRepository;

        public LoggerDataBL()
        {
            this.loggerDataRepository = new LoggerDataRepository();
        }

        public LoggerDataBL(ILoggerDataRepository loggerDataRepository)
        {
            this.loggerDataRepository = loggerDataRepository;
        }

        public List<t_Logger_Data> GetLoggerData(string channelID, DateTime startDate, DateTime endDate)
        {
            return loggerDataRepository.GetLoggerData(channelID, startDate, endDate);
        }

        public List<t_Logger_Data> GetLoggerIndexes(string channelID, DateTime startDate, DateTime endDate)
        {
            return loggerDataRepository.GetLoggerIndexes(channelID, startDate, endDate);
        }

        public t_Logger_Data GetLoggerIndex(string channelID, DateTime timeStamp)
        {
            return loggerDataRepository.GetLoggerIndex(channelID, timeStamp);
        }

        protected void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    loggerDataRepository.Dispose();
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
