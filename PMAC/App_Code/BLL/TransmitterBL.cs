using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.BLL
{
    /// <summary>
    /// Summary description for TransmitterBL
    /// </summary>
    /// 
    [DataObject]
    public class TransmitterBL : IDisposable
    {
        private ITransmitterRepository transmitterRepository;
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    transmitterRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public TransmitterBL()
        {
            this.transmitterRepository = new TransmitterRepository();
        }

        public t_Transmitters GetTransmitter(string serial)
        {
            return transmitterRepository.GetTransmitter(serial);
        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public List<t_Transmitters> GetAllTransmitters()
        {
            return transmitterRepository.GetAllTransmitters();
        }

        public List<DeviceViewModel> GetTransmitterByConds(List<string> listProviders, List<string> listMarks, List<short> listSizes, List<string> listModels, List<string> listStatus, List<bool> listInstalleds)
        {
            return transmitterRepository.GetTransmitterByConds(listProviders, listMarks, listSizes, listModels, listStatus, listInstalleds);
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<string> GetAllTransmitterProviders()
        {
            return transmitterRepository.GetAllTransmitterProviders();
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<string> GetAllTransmitterMarks()
        {
            return transmitterRepository.GetAllTransmitterMarks();
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<short?> GetAllTransmitterSizes()
        {
            return transmitterRepository.GetAllTransmitterSizes();
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<string> GetAllTransmitterModels()
        {
            return transmitterRepository.GetAllTransmitterModels();
        }

        public void InsertTransmitter(t_Transmitters Transmitter)
        {
            try
            {
                transmitterRepository.InsertTransmitter(Transmitter);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateTransmitter(t_Transmitters Transmitter, t_Transmitters origTransmitter)
        {
            try
            {
                transmitterRepository.UpdateTransmitter(Transmitter, origTransmitter);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteTransmitter(t_Transmitters Transmitter)
        {
            try
            {
                transmitterRepository.DeleteTransmitter(Transmitter);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }
    }
}