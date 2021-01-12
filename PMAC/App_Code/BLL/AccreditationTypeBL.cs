using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

using PMAC.DAL;

namespace PMAC.BLL{
/// <summary>
/// Summary description for AccreditationBL
/// </summary>
/// 
    [DataObject]
    public class AccreditationTypeBL : IDisposable
    {
        private IAccreditationTypeRepository accreditationTypeRepository;
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    accreditationTypeRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public AccreditationTypeBL()
        {
            accreditationTypeRepository = new AccreditationTypeRepository();
        }

        [DataObjectMethod(DataObjectMethodType.Select,true)]
        public List<t_Accreditation_Types> GetAllAccreditationTypes()
        {
            return accreditationTypeRepository.GetAllAccreditationTypes();
        }
    }
}