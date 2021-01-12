using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.BLL
{
/// <summary>
/// Summary description for LoggerHistoryBL
/// </summary>
    public class LoggerHistoryBL : IDisposable
    {
        private ILoggerHistoryRepository loggerHistoryRepository;
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    loggerHistoryRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public LoggerHistoryBL()
        {
            loggerHistoryRepository = new LoggerHistoryRepository();
        }

        public t_Logger_Histories GetLoggerHistory(string siteID, DateTime dateChanged)
        {
            return loggerHistoryRepository.GetLoggerHistory(siteID, dateChanged);
        }

        public t_Logger_Histories GetLastLoggerHistory(string siteID)
        {
            return loggerHistoryRepository.GetLastLoggerHistory(siteID);
        }

        public void InsertLoggerHistory(t_Logger_Histories loggerHistory)
        {
            try
            {
                loggerHistoryRepository.InsertLoggerHistory(loggerHistory);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateLoggerHistory(t_Logger_Histories loggerHistory, t_Logger_Histories orgiLoggerHistory)
        {
            try
            {
                loggerHistoryRepository.UpdateLoggerHistory(loggerHistory, orgiLoggerHistory);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteLoggerHistory(t_Logger_Histories history)
        {
            try
            {
                loggerHistoryRepository.DeleteLoggerHistory(history);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }
    }
}