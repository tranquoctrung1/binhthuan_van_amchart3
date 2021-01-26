using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for TakeSampleHistoryBl
/// </summary>
public class TakeSampleHistoryBL : IDisposable
{
    private bool disposedValue = false;
    private ITakeSampleHistoryRepository TakeSampleHistoryRepository;

    public TakeSampleHistoryBL()
    {
        this.TakeSampleHistoryRepository = new TakeSampleHistoryRepository();
    }

    public TakeSampleHistoryBL(ITakeSampleHistoryRepository TakeSampleHistoryRepository)
    {
        this.TakeSampleHistoryRepository = TakeSampleHistoryRepository;
    }

    public List<t_TakeSampleHistory> GetAll()
    {
        return TakeSampleHistoryRepository.GetAll();
    }

    public List<t_TakeSampleHistory> GetByCondition(List<string> siteIDs, List<string> Types, List<bool> Status, DateTime? start, DateTime? end)
    {
        return TakeSampleHistoryRepository.GetByCondition(siteIDs, Types, Status, start, end);
    }

    public int AddTakeSampleHistory(t_TakeSampleHistory history)
    {
        return TakeSampleHistoryRepository.AddTakeSampleHistory(history);
    }

    protected void Dispose(bool disposing)
    {
        if (!disposedValue)
        {
            if (disposing)
            {
                TakeSampleHistoryRepository.Dispose();
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