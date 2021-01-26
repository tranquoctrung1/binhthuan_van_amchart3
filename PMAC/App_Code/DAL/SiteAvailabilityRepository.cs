using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for AvailabilityRepository
    /// </summary>
    public class SiteAvailabilityRepository : IDisposable, ISiteAvailabilityRepository
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

        public IEnumerable<t_Site_Availabilities> GetAllSiteAvailabilities()
        {
            // Pi-solution
            string language = (HttpContext.Current.Session["myapplication.language"] == null) ? "vi" : HttpContext.Current.Session["myapplication.language"].ToString();
            var listDB = context.t_Site_Availabilities.Where(x=>x.Language == language).OrderBy(a => a.Availability).ToList();
            return listDB;

            //return context.t_Site_Availabilities.OrderBy(a => a.Availability).ToList();
        }
        public IEnumerable<t_Site_Availabilities> GetAllSiteAvailabilitiesForApp()
        {
            var listDB = context.t_Site_Availabilities.Where(x => x.Language == "vi").OrderBy(a => a.Availability).ToList();
            return listDB;
        }

      
    }
}