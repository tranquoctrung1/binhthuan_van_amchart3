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
    public class AccreditationBL : IDisposable
    {
        private IAccreditationRepository accreditationRepository;
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    accreditationRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public AccreditationBL()
        {
            accreditationRepository = new AccreditationRepository();
        }

        public t_Accreditations GetAccreditation(string accreditationDocument)
        {
            return accreditationRepository.GetAccreditation(accreditationDocument);
        }

        [DataObjectMethod(DataObjectMethodType.Select,true)]
        public List<t_Accreditations> GetAllAccreditations()
        {
            return accreditationRepository.GetAllAccreditations();
        }

        public void InsertAccreditation(t_Accreditations accreditation)
        {
            try
            {
                accreditationRepository.InsertAccreditation(accreditation);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateAccreditation(t_Accreditations accreditation, t_Accreditations orgiAccreditation)
        {
            try
            {
                accreditationRepository.UpdateAccreditation(accreditation, orgiAccreditation);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteAccreditation(t_Accreditations accreditation)
        {
            try
            {
                accreditationRepository.DeleteAccreditation(accreditation);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }
    }
}