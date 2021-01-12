using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;


namespace PMAC.DAL
{
    public interface IRawIndexRepository : IDisposable
    {
        t_Data_Raw_Indexes GetRawIndex(string siteID, DateTime timeStamp);

        t_Data_Raw_Indexes GetLastRawIndex(string siteID);

        List<t_Data_Raw_Indexes> GetRawIndexes(string siteID, DateTime startDate, DateTime endDate);

        void InsertRawIndex(t_Data_Raw_Indexes rawIndex);

        void UpdateRawIndex(t_Data_Raw_Indexes rawIndex, t_Data_Raw_Indexes origRawIndex);

        void DeleteRawIndex(t_Data_Raw_Indexes rawIndex);

        void DeleteRawIndexes(string siteID, DateTime startDate, DateTime endDate);
    }
}