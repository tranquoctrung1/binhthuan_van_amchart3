using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for DeviceStatusRepository
    /// </summary>
    public class DeviceStatusRepository : IDisposable, IDeviceStatusRepository
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

        public List<t_Device_Status> GetAllDeviceStatus()
        {
            // Pi-solution
            string language = (HttpContext.Current.Session["myapplication.language"] == null) ? "vi" : HttpContext.Current.Session["myapplication.language"].ToString();
            var listDB = context.t_Device_Status.Where(s=> s.Language == language).OrderBy(s => s.Status).ToList();
            return listDB;

            //return context.t_Device_Status.OrderBy(s => s.Status).ToList();
        }
    }
}