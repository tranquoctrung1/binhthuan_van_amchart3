using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ProductionReportRepository
/// </summary>
public class ProductionReportRepository : IDisposable, IProductionReportRepository
{
    private bool disposedValue = false;
    private DBEntities context = new DBEntities();

    public List<ProductionReport> GetHourlyProductionReport(string siteId, DateTime start, DateTime end)
    {
        return context.Database.SqlQuery<ProductionReport>("exec p_Calculate_One_Site_Hourly_Output @SiteId, @Start, @End", new SqlParameter("SiteId", siteId), new SqlParameter("Start", start), new SqlParameter("End", end)).ToList();
    }

    public List<ProductionReport> GetDailyProductionReport(string siteId, DateTime start, DateTime end)
    {
        return context.Database.SqlQuery<ProductionReport>("exec p_Calculate_One_Site_Daily_Output @SiteId, @Start, @End", new SqlParameter("SiteId", siteId), new SqlParameter("Start", start), new SqlParameter("End", end)).ToList();
    }

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
}

public class ProductionReport
{
    public System.DateTime TimeStamp { get; set; }
    public System.DateTime EndTime { get; set; }
    public Nullable<double> StartIndex { get; set; }
    public Nullable<double> EndIndex { get; set; }
    public Nullable<double> Value { get; set; }
}