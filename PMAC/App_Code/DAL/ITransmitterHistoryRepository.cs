using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for ITransmitterHistoryRepository
    /// </summary>
    public interface ITransmitterHistoryRepository : IDisposable
    {
        t_Transmitter_Histories GetTransmitterHistory(string siteID, DateTime dateChanged);

        t_Transmitter_Histories GetLastTransmitterHistory(string siteID);

        void InsertTransmitterHistory(t_Transmitter_Histories TransmitterHistory);

        void UpdateTransmitterHistory(t_Transmitter_Histories TransmitterHistory, t_Transmitter_Histories orgiTransmitterHistory);

        void DeleteTransmitterHistory(t_Transmitter_Histories history);
    }
}