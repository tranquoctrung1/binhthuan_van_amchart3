using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ProductionReportBL
/// </summary>
public class ProductionReportBL : IDisposable
{
    private bool disposedValue = false;
    private IProductionReportRepository productionReportRepository;

    public ProductionReportBL()
    {
        this.productionReportRepository = new ProductionReportRepository();
    }

    public ProductionReportBL(IProductionReportRepository productionReportRepository)
    {
        this.productionReportRepository = productionReportRepository;
    }

    public List<ProductionReport> GetHourlyProductionReport(string siteId, DateTime start, DateTime end)
    {
        return productionReportRepository.GetHourlyProductionReport(siteId, start, end);
    }

    public List<ProductionReport> GetDailyProductionReport(string siteId, DateTime start, DateTime end)
    {
        return productionReportRepository.GetDailyProductionReport(siteId, start, end);
    }

    protected void Dispose(bool disposing)
    {
        if (!disposedValue)
        {
            if (disposing)
            {
                productionReportRepository.Dispose();
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