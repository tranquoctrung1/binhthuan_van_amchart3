using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.BLL
{
    /// <summary>
    /// Summary description for TransmitterHistoryBL
    /// </summary>
    public class TransmitterHistoryBL : IDisposable
    {
        private ITransmitterHistoryRepository transmitterHistoryRepository;
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    transmitterHistoryRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public TransmitterHistoryBL()
        {
            transmitterHistoryRepository = new TransmitterHistoryRepository();
        }

        public t_Transmitter_Histories GetTransmitterHistory(string siteID, DateTime dateChanged)
        {
            return transmitterHistoryRepository.GetTransmitterHistory(siteID, dateChanged);
        }

        public t_Transmitter_Histories GetLastTransmitterHistory(string siteID)
        {
            return transmitterHistoryRepository.GetLastTransmitterHistory(siteID);
        }

        public void InsertTransmitterHistory(t_Transmitter_Histories transmitterHistory)
        {
            try
            {
                transmitterHistoryRepository.InsertTransmitterHistory(transmitterHistory);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateTransmitterHistory(t_Transmitter_Histories transmitterHistory, t_Transmitter_Histories orgiTransmitterHistory)
        {
            try
            {
                transmitterHistoryRepository.UpdateTransmitterHistory(transmitterHistory, orgiTransmitterHistory);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteTransmitterHistory(t_Transmitter_Histories history)
        {
            try
            {
                transmitterHistoryRepository.DeleteTransmitterHistory(history);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }
    }
}