using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.BLL
{
/// <summary>
/// Summary description for TransmitterFileBL
/// </summary>
    public class TransmitterFileBL
    {
        private ITransmitterFileRepository transmitterFileRepository;
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    transmitterFileRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public TransmitterFileBL()
        {
            transmitterFileRepository = new TransmitterFileRepository();
        }

        public IEnumerable<t_Transmitter_Files> GetTransmitterFilesByTransmitterSerial(string transmitterSerial)
        {
            return transmitterFileRepository.GetTransmitterFilesByTransmitterSerial(transmitterSerial);
        }

        public t_Transmitter_Files GetTransmitterFile(string fileName)
        {
            return transmitterFileRepository.GetTransmitterFile(fileName);
        }

        public void InsertTransmitterFile(t_Transmitter_Files transmitterFile)
        {
            try
            {
                transmitterFileRepository.InsertTransmitterFile(transmitterFile);
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
                transmitterFileRepository.UpdateTransmitterFile(transmitterFile, orgiTransmitterFile);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteTransmitterFile(t_Transmitter_Files transmitterFile)
        {
            try
            {
                transmitterFileRepository.DeleteTransmitterFile(transmitterFile);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }
    }
}