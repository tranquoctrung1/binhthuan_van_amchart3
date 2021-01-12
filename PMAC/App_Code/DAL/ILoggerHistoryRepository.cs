using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for ILoggerHistoryRepository
    /// </summary>
    public interface ILoggerHistoryRepository : IDisposable
    {
        t_Logger_Histories GetLoggerHistory(string siteID, DateTime dateChanged);

        t_Logger_Histories GetLastLoggerHistory(string siteID);

        void InsertLoggerHistory(t_Logger_Histories LoggerHistory);

        void UpdateLoggerHistory(t_Logger_Histories LoggerHistory, t_Logger_Histories orgiLoggerHistory);

        void DeleteLoggerHistory(t_Logger_Histories history);
    }
}