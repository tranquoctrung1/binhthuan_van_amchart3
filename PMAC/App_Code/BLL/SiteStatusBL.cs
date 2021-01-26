using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for SiteStatusBL
    /// </summary>
    /// 
    [DataObject]
    public class SiteStatusBL : IDisposable
    {
        private ISiteStatusRepository siteStatusRepository;
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    siteStatusRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public SiteStatusBL()
        {
            siteStatusRepository = new SiteStatusRepository();
        }

        [DataObjectMethod(DataObjectMethodType.Select,true)]
        public IEnumerable<t_Site_Status> GetAllSiteStatus()
        {
            return siteStatusRepository.GetAllSiteStatus();
        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public IEnumerable<t_Site_Status> GetAllSiteStatusForApp()
        {
            return siteStatusRepository.GetAllSiteStatusForApp();
        }
    }
}