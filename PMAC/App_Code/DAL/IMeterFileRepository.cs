using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for IMeterFileRepository
    /// </summary>
    public interface IMeterFileRepository : IDisposable
    {
        IEnumerable<t_Meter_Files> GetMeterFilesByMeterSerial(string meterSerial);

        t_Meter_Files GetMeterFile(string fileName);

        void InsertMeterFile(t_Meter_Files meterFile);

        void UpdateMeterFile(t_Meter_Files meterFile, t_Meter_Files orgiMeterFile);

        void DeleteMeterFile(t_Meter_Files meterFile);
    }
}