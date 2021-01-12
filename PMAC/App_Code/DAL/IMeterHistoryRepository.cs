using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for IMeterHistoryRepository
    /// </summary>
    public interface IMeterHistoryRepository : IDisposable
    {
        t_Meter_Histories GetMeterHistory(string siteID, DateTime dateChanged);

        t_Meter_Histories GetLastMeterHistory(string siteID);

        void InsertMeterHistory(t_Meter_Histories meterHistory);

        void UpdateMeterHistory(t_Meter_Histories meterHistory, t_Meter_Histories orgiMeterHistory);

        void DeleteMeterHistory(t_Meter_Histories history);
    }
}