using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for AvailabilityBL
    /// </summary>
    /// 

    [DataObject]
    public class SiteAvailabilityBL : IDisposable
    {
        private bool disposedValue = false;
        private ISiteAvailabilityRepository siteAvailabilityRepository;

        public SiteAvailabilityBL()
        {
            siteAvailabilityRepository = new SiteAvailabilityRepository();
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    siteAvailabilityRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        [DataObjectMethod(DataObjectMethodType.Select,true)]
        public IEnumerable<t_Site_Availabilities> GetAllSiteAvailabilities()
        {
            return siteAvailabilityRepository.GetAllSiteAvailabilities();
        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public IEnumerable<t_Site_Availabilities> GetAllSiteAvailabilitiesForApp()
        {
            return siteAvailabilityRepository.GetAllSiteAvailabilitiesForApp();
        }
    }
}