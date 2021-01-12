using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.BLL
{
    /// <summary>
    /// Summary description for MeterBL
    /// </summary>
    /// 
    [DataObject]
    public class MeterBL : IDisposable
    {
        private IMeterRepository meterRepository;
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    meterRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public MeterBL()
        {
            this.meterRepository = new MeterRepository();
        }

        public t_Meters GetMeter(string serial)
        {
            return meterRepository.GetMeter(serial);
        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public List<t_Meters> GetAllMeters()
        {
            return meterRepository.GetAllMeters();
        }

        public List<DeviceViewModel> GetMeterByConds(List<string> listProviders, List<string> listMarks, List<short> listSizes, List<string> listModels, List<string> listStatus, List<bool> listInstalleds)
        {
            return meterRepository.GetMeterByConds(listProviders, listMarks, listSizes, listModels, listStatus, listInstalleds);
        }

        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<string> GetAllMeterProviders()
        {
            return meterRepository.GetAllMeterProviders();
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<string> GetAllMeterMarks()
        {
            return meterRepository.GetAllMeterMarks();
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<short?> GetAllMeterSizes()
        {
            return meterRepository.GetAllMeterSizes();
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<string> GetAllMeterModels()
        {
            return meterRepository.GetAllMeterModels();
        }

        public void InsertMeter(t_Meters meter)
        {
            try
            {
                meterRepository.InsertMeter(meter);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateMeter(t_Meters meter, t_Meters origMeter)
        {
            try
            {
                meterRepository.UpdateMeter(meter, origMeter);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteMeter(t_Meters meter)
        {
            try
            {
                meterRepository.DeleteMeter(meter);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }
    }
}