using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
/// <summary>
/// Summary description for IAccreditationRepository
/// </summary>
    public interface IAccreditationTypeRepository : IDisposable
    {
        List<t_Accreditation_Types> GetAllAccreditationTypes();
    }
}