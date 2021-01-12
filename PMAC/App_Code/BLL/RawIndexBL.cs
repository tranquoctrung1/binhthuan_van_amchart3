using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;


namespace PMAC.BLL
{
    [DataObject]
    public class RawIndexBL : IDisposable
    {
        private bool disposedValue = false;
        private IRawIndexRepository rawIndexRepository;

        public RawIndexBL()
        {
            this.rawIndexRepository = new RawIndexRepository();
        }

        public RawIndexBL(IRawIndexRepository rawIndexRepository)
        {
            this.rawIndexRepository = rawIndexRepository;
        }

        public t_Data_Raw_Indexes GetRawIndex(string siteID, DateTime timeStamp)
        {
            return rawIndexRepository.GetRawIndex(siteID, timeStamp);
        }

        public t_Data_Raw_Indexes GetLastRawIndex(string siteID)
        {
            return rawIndexRepository.GetLastRawIndex(siteID);

        }
        public List<t_Data_Raw_Indexes> GetRawIndexes(string siteID, DateTime startDate, DateTime endDate)
        {
            return rawIndexRepository.GetRawIndexes(siteID, startDate, endDate);
        }

        public void InsertRawIndex(t_Data_Raw_Indexes rawIndex)
        {
            try
            {
                rawIndexRepository.InsertRawIndex(rawIndex);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateRawIndex(t_Data_Raw_Indexes rawIndex, t_Data_Raw_Indexes origRawIndex)
        {
            try
            {
                rawIndexRepository.UpdateRawIndex(rawIndex, origRawIndex);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteRawIndex(t_Data_Raw_Indexes rawIndex)
        {
            try
            {
                rawIndexRepository.DeleteRawIndex(rawIndex);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteRawIndexes(string siteID, DateTime startDate, DateTime endDate)
        {
            try
            {
                rawIndexRepository.DeleteRawIndexes(siteID, startDate, endDate);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        protected void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    rawIndexRepository.Dispose();
                }
            }
            disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}
