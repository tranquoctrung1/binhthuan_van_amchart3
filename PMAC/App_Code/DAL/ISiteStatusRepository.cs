using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
/// <summary>
/// Summary description for ISiteStatusRepository
/// </summary>
    public interface ISiteStatusRepository : IDisposable
    {
        IEnumerable<t_Site_Status> GetAllSiteStatus();
        IEnumerable<t_Site_Status> GetAllSiteStatusForApp();
    }
}