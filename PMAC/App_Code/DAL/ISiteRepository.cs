using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using PMAC.DAL;

namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for ISiteRepository
    /// </summary>
    public interface ISiteRepository : IDisposable
    {
        void DeleteSite(t_Sites Site);

        t_Sites GetSite(string siteID);

       

        IEnumerable<t_Sites> GetSites();

        IEnumerable<t_Sites> GetSitesDMA();

        List<SiteViewModel> GetSiteByConds(List<string> listConsumers, List<string> listStatus, List<string> listAvailabilities, List<string> listLoggerModels);

        IEnumerable<t_Sites> GetSitesByDisplayGroup(string displayGroup);

        IEnumerable<t_Sites> GetSitesByConsumerId(string consumerId);

        IEnumerable<t_Sites> GetSitesByStaffId(string staffId);

        IEnumerable<t_Sites> GetSitesForMap();

        IEnumerable<t_Sites> GetSitesForMapByConsumerId(string consumerId);

        IEnumerable<t_Sites> GetSitesForMapByStaffId(string staffId);

        void InsertSite(t_Sites Site);

        void UpdateSite(t_Sites Site, t_Sites origSite);

        IEnumerable<t_SiteCustomer> GetSitesForMapCustom();
        IEnumerable<t_SiteCustomer> GetSitesForMapByConsumerIdCustom(string consumerId);
        IEnumerable<t_SiteCustomer> GetSitesForMapByStaffIdCustom(string staffId);
    }
}