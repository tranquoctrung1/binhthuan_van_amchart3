using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.BLL
{
    /// <summary>
    /// Summary description for SiteFileBL
    /// </summary>
    public class SiteFileBL : IDisposable
    {
        private ISiteFileRepository siteFileRepository;
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    siteFileRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public SiteFileBL()
        {
            //
            // TODO: Add constructor logic here
            //
        }
    }
}