using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for ISiteAvailabilityRepository
    /// </summary>
    public interface ISiteAvailabilityRepository : IDisposable
    {
        IEnumerable<t_Site_Availabilities> GetAllSiteAvailabilities();
        IEnumerable<t_Site_Availabilities> GetAllSiteAvailabilitiesForApp();
    }
}