using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for MeterHistoryRepository
    /// </summary>
    public class MeterHistoryRepository : IDisposable, IMeterHistoryRepository
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

        public t_Meter_Histories GetMeterHistory(string siteID, DateTime dateChanged)
        {
            return context.t_Meter_Histories.SingleOrDefault(h => h.SiteID == siteID && h.DateChanged == dateChanged);
        }

        public t_Meter_Histories GetLastMeterHistory(string siteID)
        {
            DateTime? lastDateChanged;
            var dates = context.t_Meter_Histories.Select(h => h.DateChanged).ToList();
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
                return context.t_Meter_Histories.SingleOrDefault(h => h.SiteID == siteID && h.DateChanged == lastDateChanged);
            }
            else
            {
                return null;
            }
        }

        public void InsertMeterHistory(t_Meter_Histories meterHistory)
        {
            try
            {
                context.t_Meter_Histories.Add(meterHistory);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateMeterHistory(t_Meter_Histories meterHistory, t_Meter_Histories orgiMeterHistory)
        {
            try
            {
                context.t_Meter_Histories.Attach(orgiMeterHistory);
                orgiMeterHistory.DateChanged = meterHistory.DateChanged;
                orgiMeterHistory.Description = meterHistory.Description;
                orgiMeterHistory.NewAccreditation = meterHistory.NewAccreditation;
                orgiMeterHistory.NewIndex = meterHistory.NewIndex;
                orgiMeterHistory.NewMeterSerial = meterHistory.NewMeterSerial;
                orgiMeterHistory.OldAccreditation = meterHistory.OldAccreditation;
                orgiMeterHistory.OldIndex = meterHistory.OldIndex;
                orgiMeterHistory.OldMeterSerial = meterHistory.OldMeterSerial;
                orgiMeterHistory.SiteID = meterHistory.SiteID;
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteMeterHistory(t_Meter_Histories history)
        {
            try
            {
                var dbHistory = context.t_Meter_Histories.FirstOrDefault(h => h.SiteID == history.SiteID && h.DateChanged == history.DateChanged);
                //context.t_Meter_Histories.Attach(history);
                //context.t_Meter_Histories.Remove(history);
                if (dbHistory != null)
                {
                    context.t_Meter_Histories.Remove(dbHistory);
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