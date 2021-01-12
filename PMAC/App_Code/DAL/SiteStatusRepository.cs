using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
/// <summary>
/// Summary description for SiteStatusRepository
/// </summary>
    public class SiteStatusRepository : IDisposable, ISiteStatusRepository
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

        public IEnumerable<t_Site_Status> GetAllSiteStatus()
        {
            // Pi-solution
            string language = (HttpContext.Current.Session["myapplication.language"] == null) ? "vi" : HttpContext.Current.Session["myapplication.language"].ToString();
            var listDB = context.t_Site_Status.Where(x=> x.Language == language).OrderBy(s => s.Status).ToList();
            return listDB;

            //return context.t_Site_Status.OrderBy(s => s.Status).ToList();
        }
    }
}