using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using System.Linq.Expressions;

namespace PMAC.DAL
{
    public interface IComplexDataRepository : IDisposable
    {
        int GetCountBaselien(string loggerId,double? baseLine, DateTime startDate, DateTime endDate);

        double GetMNF(string loggerId, DateTime startDate, DateTime endDate);

        IEnumerable<t_Data_Complexes> GetComplexData(string loggerID, DateTime startDate, DateTime endDate);

        IEnumerable<ComplexData> GetCustomComplexData();

        IEnumerable<ComplexData> GetCustomComplexDataRange(Expression<Func<ComplexData, bool>> predicate);

        IEnumerable<ComplexData> GetCustomComplexDataForStaff(string staffId);

        IEnumerable<ComplexData> GetCustomComplexDataForConsumer(string consumerId);

        IEnumerable<HourlyData> GetHourlyData(string siteId, DateTime startDate, DateTime endDate);


    }
}