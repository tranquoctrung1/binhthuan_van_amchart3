using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for TransmitterHistoryRepository
    /// </summary>
    public class TransmitterHistoryRepository : IDisposable, ITransmitterHistoryRepository
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

        public t_Transmitter_Histories GetTransmitterHistory(string siteID, DateTime dateChanged)
        {
            return context.t_Transmitter_Histories.SingleOrDefault(h => h.SiteID == siteID && h.DateChanged == dateChanged);
        }

        public t_Transmitter_Histories GetLastTransmitterHistory(string siteID)
        {
            DateTime? lastDateChanged;
            var dates = context.t_Transmitter_Histories.Select(h => h.DateChanged).ToList();
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
                return context.t_Transmitter_Histories.SingleOrDefault(h => h.SiteID == siteID && h.DateChanged == lastDateChanged);
            }
            else
            {
                return null;
            }
        }

        public void InsertTransmitterHistory(t_Transmitter_Histories TransmitterHistory)
        {
            try
            {
                context.t_Transmitter_Histories.Add(TransmitterHistory);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateTransmitterHistory(t_Transmitter_Histories TransmitterHistory, t_Transmitter_Histories orgiTransmitterHistory)
        {
            try
            {
                context.t_Transmitter_Histories.Attach(orgiTransmitterHistory);
                orgiTransmitterHistory.DateChanged = TransmitterHistory.DateChanged;
                orgiTransmitterHistory.Description = TransmitterHistory.Description;
                orgiTransmitterHistory.NewAccreditation = TransmitterHistory.NewAccreditation;
                orgiTransmitterHistory.Index = TransmitterHistory.Index;
                orgiTransmitterHistory.NewTransmitterSerial = TransmitterHistory.NewTransmitterSerial;
                orgiTransmitterHistory.OldAccreditation = TransmitterHistory.OldAccreditation;
                orgiTransmitterHistory.OldTransmitterSerial = TransmitterHistory.OldTransmitterSerial;
                orgiTransmitterHistory.SiteID = TransmitterHistory.SiteID;
                context.SaveChanges();
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
                //context.t_Transmitter_Histories.Attach(history);
                //context.t_Transmitter_Histories.Remove(history);
                var dbHistory = context.t_Transmitter_Histories.FirstOrDefault(h => h.SiteID == history.SiteID && h.DateChanged == history.DateChanged);
                if (dbHistory != null)
                {
                    context.t_Transmitter_Histories.Remove(dbHistory);
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