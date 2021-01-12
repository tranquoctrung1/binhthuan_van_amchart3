using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;


namespace PMAC.BLL
{
    [DataObject]
    public class SiteBL : IDisposable
    {
        private bool disposedValue = false;
        private ISiteRepository siteRepository;

        public SiteBL()
        {
            this.siteRepository = new SiteRepository();
        }

        public SiteBL(ISiteRepository siteRepository)
        {
            this.siteRepository = siteRepository;
        }
    
        public t_Sites GetSite(string siteID)
        {
            return siteRepository.GetSite(siteID);
        }

        public List<SiteViewModel> GetSiteByConds(List<string> listConsumers, List<string> listStatus, List<string> listAvailabilities, List<string> listLoggerModels)
        {
            return siteRepository.GetSiteByConds(listConsumers, listStatus, listAvailabilities, listLoggerModels);
        }

        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public IEnumerable<t_Sites> GetSites()
        {
            return siteRepository.GetSites();
        }
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public IEnumerable<t_Sites> GetSitesDMA()
        {
            return siteRepository.GetSitesDMA();
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public IEnumerable<t_Sites> GetSitesByDisplayGroup(string displayGroup)
        {
            if (string.IsNullOrWhiteSpace(displayGroup))
            {
                return siteRepository.GetSites();
            }
            else
            {
                return siteRepository.GetSitesByDisplayGroup(displayGroup);
            }
        }

        public IEnumerable<t_Sites> GetSitesByConsumerID(string consumerID)
        {
            return siteRepository.GetSitesByConsumerId(consumerID);
        }

        public IEnumerable<t_Sites> GetSitesByStaffId(string staffId)
        {
            return siteRepository.GetSitesByStaffId(staffId);
        }

        public IEnumerable<t_Sites> GetSitesForMap()
        {
            return siteRepository.GetSitesForMap();
        }

        public IEnumerable<t_Sites> GetSitesForMapByConsumerID(string consumerID)
        {
            return siteRepository.GetSitesForMapByConsumerId(consumerID);
        }

        public IEnumerable<t_Sites> GetSitesForMapByStaffId(string staffId)
        {
            return siteRepository.GetSitesForMapByStaffId(staffId);
        }

        public void InsertSite(t_Sites site)
        {
            try
            {
                siteRepository.InsertSite(site);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateSite(t_Sites site, t_Sites origSite)
        {
            try
            {
                siteRepository.UpdateSite(site, origSite);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteSite(t_Sites site)
        {
            try
            {
                siteRepository.DeleteSite(site);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        protected void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    siteRepository.Dispose();
                }
            }
            disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}
