using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.BLL
{
    /// <summary>
    /// Summary description for MeterHistoryBL
    /// </summary>
    public class MeterHistoryBL : IDisposable
    {
        private IMeterHistoryRepository meterHistoryRepository;
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    meterHistoryRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public MeterHistoryBL()
        {
            meterHistoryRepository = new MeterHistoryRepository();
        }

        public t_Meter_Histories GetMeterHistory(string siteID, DateTime dateChanged)
        {
            return meterHistoryRepository.GetMeterHistory(siteID, dateChanged);
        }

        public t_Meter_Histories GetLastMeterHistory(string siteID)
        {
            return meterHistoryRepository.GetLastMeterHistory(siteID);
        }

        public void InsertMeterHistory(t_Meter_Histories meterHistory)
        {
            try
            {
                meterHistoryRepository.InsertMeterHistory(meterHistory);
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
                meterHistoryRepository.UpdateMeterHistory(meterHistory, orgiMeterHistory);
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
                meterHistoryRepository.DeleteMeterHistory(history);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }
    }
}