using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;


namespace PMAC.DAL{
/// <summary>
/// Summary description for DeviceStatusBL
/// </summary>
/// 
    [DataObject]
    public class DeviceStatusBL : IDisposable
    {
        private IDeviceStatusRepository deviceStatusRepository;
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    deviceStatusRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public DeviceStatusBL()
        {
            deviceStatusRepository = new DeviceStatusRepository();
        }

        [DataObjectMethod(DataObjectMethodType.Select,true)]
        public List<t_Device_Status> GetAllDeviceStatus()
        {
            return deviceStatusRepository.GetAllDeviceStatus();
        }
    }
}