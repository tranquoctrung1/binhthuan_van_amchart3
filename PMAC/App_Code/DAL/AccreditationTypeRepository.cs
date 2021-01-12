using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for AccreditationRepository
    /// </summary>
    public class AccreditationTypeRepository : IDisposable, IAccreditationTypeRepository
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

        public List<t_Accreditation_Types> GetAllAccreditationTypes()
        {
            return context.t_Accreditation_Types.OrderBy(at => at.Type).ToList();
        }
    }
}