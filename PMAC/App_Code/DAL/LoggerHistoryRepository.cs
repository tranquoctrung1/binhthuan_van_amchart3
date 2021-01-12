using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for LoggerHistoryRepository
    /// </summary>
    public class LoggerHistoryRepository : ILoggerHistoryRepository, IDisposable
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

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

        public t_Logger_Histories GetLoggerHistory(string siteID, DateTime dateChanged)
        {
            return context.t_Logger_Histories.SingleOrDefault(h => h.SiteID == siteID && h.DateChanged == dateChanged);
        }

        public t_Logger_Histories GetLastLoggerHistory(string siteID)
        {
            DateTime? lastDateChanged;
            var dates = context.t_Logger_Histories.Select(h => h.DateChanged).ToList();
            if (dates.Count != 0)
            {
                lastDateChanged = dates.Max();
            }
            else
            {
                lastDateChanged = null;
            }
            if (lastDateChanged != null)
            {
                return context.t_Logger_Histories.SingleOrDefault(h => h.SiteID == siteID && h.DateChanged == lastDateChanged);
            }
            else
            {
                return null;
            }
        }

        public void InsertLoggerHistory(t_Logger_Histories LoggerHistory)
        {
            try
            {
                context.t_Logger_Histories.Add(LoggerHistory);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateLoggerHistory(t_Logger_Histories LoggerHistory, t_Logger_Histories orgiLoggerHistory)
        {
            try
            {
                context.t_Logger_Histories.Attach(orgiLoggerHistory);
                orgiLoggerHistory.DateChanged = LoggerHistory.DateChanged;
                orgiLoggerHistory.Description = LoggerHistory.Description;
                orgiLoggerHistory.Index = LoggerHistory.Index;
                orgiLoggerHistory.NewLoggerSerial = LoggerHistory.NewLoggerSerial;
                orgiLoggerHistory.OldLoggerSerial = LoggerHistory.OldLoggerSerial;
                orgiLoggerHistory.SiteID = LoggerHistory.SiteID;
                context.SaveChanges();
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
                //context.t_Logger_Histories.Attach(history);
                //context.t_Logger_Histories.Remove(history);
                var dbHistory = context.t_Logger_Histories.FirstOrDefault(lh => history.SiteID == history.SiteID && history.DateChanged == history.DateChanged);
                if (dbHistory!=null)
                {
                    context.t_Logger_Histories.Remove(dbHistory);
                }
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }
    }
}