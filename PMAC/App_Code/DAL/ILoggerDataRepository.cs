using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;


namespace PMAC.DAL
{
    public interface ILoggerDataRepository : IDisposable
    {
        List<t_Logger_Data> GetLoggerData(string channelID, DateTime startDate, DateTime endDate);

        List<t_Logger_Data> GetLoggerIndexes(string channelID, DateTime startDate, DateTime endDate);

        t_Logger_Data GetLoggerIndex(string channelID, DateTime timeStamp);
    }
}