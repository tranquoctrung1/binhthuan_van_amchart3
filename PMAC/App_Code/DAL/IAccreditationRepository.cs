using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
/// <summary>
/// Summary description for IAccreditationRepository
/// </summary>
    public interface IAccreditationRepository : IDisposable
    {
        t_Accreditations GetAccreditation(string accreditationDocument);

        List<t_Accreditations> GetAllAccreditations();

        void InsertAccreditation(t_Accreditations accreditation);

        void UpdateAccreditation(t_Accreditations accreditation, t_Accreditations orgiAccreditation);

        void DeleteAccreditation(t_Accreditations accreditation);
    }
}