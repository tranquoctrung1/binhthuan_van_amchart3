using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for IProductionReportRepository
/// </summary>
public interface IProductionReportRepository:IDisposable
{
    List<ProductionReport> GetHourlyProductionReport(string siteId, DateTime start, DateTime end);

    List<ProductionReport> GetDailyProductionReport(string siteId, DateTime start, DateTime end);
}