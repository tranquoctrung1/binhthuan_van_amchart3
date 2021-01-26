using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for TakeSampleHistoryRepository
/// </summary>
public class TakeSampleHistoryRepository: IDisposable, ITakeSampleHistoryRepository
{
    private bool disposedValue = false;
    private DBEntities context = new DBEntities();

    public List<t_TakeSampleHistory> GetAll()
    {
        return context.t_TakeSampleHistory.OrderByDescending(x => x.TimeStamp).ToList();
    }

    public List<t_TakeSampleHistory> GetByCondition(List<string> siteIDs, List<string> Types, List<bool> Status, DateTime? start, DateTime? end)
    {
        return context.t_TakeSampleHistory.Where(x => 
        siteIDs.Contains(x.SiteID) &&
        Types.Contains(x.Type) &&
        Status.Contains(x.Status) &&
        x.TimeStamp >= (start ?? new DateTime(1753,1,1)) && x.TimeStamp <= (end ?? new DateTime(3000, 1, 1)))
        .OrderByDescending(x => x.TimeStamp).ToList();
    }

    public int AddTakeSampleHistory(t_TakeSampleHistory history)
    {
        try
        {
            history.IsNotified = false;
            context.t_TakeSampleHistory.Add(history);
            context.SaveChanges();
            return 1;
        }
        catch (Exception ex)
        {
            return -1;
        }
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