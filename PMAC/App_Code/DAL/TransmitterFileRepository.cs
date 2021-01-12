using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for TransmitterFileRepository
    /// </summary>
    public class TransmitterFileRepository : IDisposable, ITransmitterFileRepository
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

        public IEnumerable<t_Transmitter_Files> GetTransmitterFilesByTransmitterSerial(string transmitterSerial)
        {
            return context.t_Transmitter_Files.Where(f => f.TransmitterSerial == transmitterSerial).OrderByDescending(f => f.UploadDate).ToList();
        }

        public t_Transmitter_Files GetTransmitterFile(string fileName)
        {
            return context.t_Transmitter_Files.SingleOrDefault(f => f.FileName == fileName);
        }

        public void InsertTransmitterFile(t_Transmitter_Files transmitterFile)
        {
            try
            {
                context.t_Transmitter_Files.Add(transmitterFile);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateTransmitterFile(t_Transmitter_Files transmitterFile, t_Transmitter_Files orgiTransmitterFile)
        {
            try
            {
                context.t_Transmitter_Files.Attach(orgiTransmitterFile);
                orgiTransmitterFile.FileName = transmitterFile.FileName;
                orgiTransmitterFile.TransmitterSerial = transmitterFile.TransmitterSerial;
                orgiTransmitterFile.MIMEType = transmitterFile.MIMEType;
                orgiTransmitterFile.Path = transmitterFile.Path;
                orgiTransmitterFile.Size = transmitterFile.Size;
                orgiTransmitterFile.UploadDate = transmitterFile.UploadDate;
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteTransmitterFile(t_Transmitter_Files tramsmitterFile)
        {
            try
            {
                context.t_Transmitter_Files.Attach(tramsmitterFile);
                context.t_Transmitter_Files.Remove(tramsmitterFile);
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