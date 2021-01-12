using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for IMeterRepository
    /// </summary>
    public interface IMeterRepository : IDisposable
    {
        t_Meters GetMeter(string serial);

        List<t_Meters> GetAllMeters();

        List<DeviceViewModel> GetMeterByConds(List<string> listProviders, List<string> listMarks, List<short> listSizes, List<string> listModels, List<string> listStatus, List<bool> listInstalleds);

        List<string> GetAllMeterProviders();

        List<string> GetAllMeterMarks();

        List<short?> GetAllMeterSizes();

        List<string> GetAllMeterModels();

        void InsertMeter(t_Meters meter);

        void UpdateMeter(t_Meters meter, t_Meters origMeter);

        void DeleteMeter(t_Meters meter);
    }
}