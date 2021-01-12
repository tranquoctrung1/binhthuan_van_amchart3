using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for AccreditationRepository
    /// </summary>
    public class AccreditationRepository : IDisposable, IAccreditationRepository
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

        public List<t_Accreditations> GetAllAccreditations()
        {
            return context.t_Accreditations.OrderBy(a => a.AccreditationDocument).ToList();
        }

        public t_Accreditations GetAccreditation(string accreditationDocument)
        {
            return context.t_Accreditations.SingleOrDefault(a => a.AccreditationDocument == accreditationDocument);
        }

        public void InsertAccreditation(t_Accreditations accreditation)
        {
            try
            {
                context.t_Accreditations.Add(accreditation);
                context.SaveChanges();
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
                context.t_Accreditations.Attach(orgiAccreditation);
                orgiAccreditation.AccreditationDate = accreditation.AccreditationDate;
                orgiAccreditation.AccreditationDocument = accreditation.AccreditationDocument;
                orgiAccreditation.AccreditationType = accreditation.AccreditationType;
                orgiAccreditation.ExpiryDate = accreditation.ExpiryDate;
                orgiAccreditation.MeterSerial = accreditation.MeterSerial;
                orgiAccreditation.TransmitterSerial = accreditation.TransmitterSerial;
                context.SaveChanges();
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
                var dbAcc = context.t_Accreditations.SingleOrDefault(a => a.AccreditationDocument == accreditation.AccreditationDocument);
                //context.t_Accreditations.Attach(accreditation);
                context.t_Accreditations.Remove(dbAcc);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }
    }
}