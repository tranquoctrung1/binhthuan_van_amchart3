using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ITakeSampleHistoryRepository
/// </summary>
public interface ITakeSampleHistoryRepository: IDisposable
{
    List<t_TakeSampleHistory> GetAll();

    List<t_TakeSampleHistory> GetByCondition(List<string> siteIDs, List<string> Types, List<bool> Status, DateTime? start, DateTime? end);

    int AddTakeSampleHistory(t_TakeSampleHistory history);
}