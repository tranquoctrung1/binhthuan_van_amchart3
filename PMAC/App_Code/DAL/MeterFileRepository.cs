using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for MeterFileRepository
    /// </summary>
    public class MeterFileRepository : IDisposable, IMeterFileRepository
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

        public IEnumerable<t_Meter_Files> GetMeterFilesByMeterSerial(string meterSerial)
        {
            return context.t_Meter_Files.Where(f => f.MeterSerial == meterSerial).OrderByDescending(f => f.UploadDate).ToList();
        }

        public t_Meter_Files GetMeterFile(string fileName)
        {
            return context.t_Meter_Files.SingleOrDefault(f => f.FileName == fileName);
        }

        public void InsertMeterFile(t_Meter_Files meterFile)
        {
            try
            {
                context.t_Meter_Files.Add(meterFile);
                context.SaveChanges();
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
                context.t_Meter_Files.Attach(orgiMeterFile);
                orgiMeterFile.FileName = meterFile.FileName;
                orgiMeterFile.MeterSerial = meterFile.MeterSerial; ;
                orgiMeterFile.MIMEType = meterFile.MIMEType;
                orgiMeterFile.Path = meterFile.Path;
                orgiMeterFile.Size = meterFile.Size;
                orgiMeterFile.UploadDate = meterFile.UploadDate;
                context.SaveChanges();
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
                context.t_Meter_Files.Attach(meterFile);
                context.t_Meter_Files.Remove(meterFile);
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