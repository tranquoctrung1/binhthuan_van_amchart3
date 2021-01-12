using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.BLL
{
    /// <summary>
    /// Summary description for MeterFileBL
    /// </summary>
    public class MeterFileBL : IDisposable
    {
        private IMeterFileRepository meterFileRepository;
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    meterFileRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public MeterFileBL()
        {
            meterFileRepository = new MeterFileRepository();
        }

        public IEnumerable<t_Meter_Files> GetMeterFilesByMeterSerial(string meterSerial)
        {
            return meterFileRepository.GetMeterFilesByMeterSerial(meterSerial);
        }

        public t_Meter_Files GetMeterFile(string fileName)
        {
            return meterFileRepository.GetMeterFile(fileName);
        }

        public void InsertMeterFile(t_Meter_Files meterFile)
        {
            try
            {
                meterFileRepository.InsertMeterFile(meterFile);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateMeterFile(t_Meter_Files meterFile, t_Meter_Files orgiMeterFile)
        {
            try
            {
                meterFileRepository.UpdateMeterFile(meterFile, orgiMeterFile);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteMeterFile(t_Meter_Files meterFile)
        {
            try
            {
                meterFileRepository.DeleteMeterFile(meterFile);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }
    }
}