using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for ILoggerRepository
    /// </summary>
    public interface ILoggerRepository : IDisposable
    {
        t_Loggers GetLogger(string serial);

        List<DeviceViewModel> GetLoggerByConds(List<string> listProviders, List<string> listMarks, List<string> listModels, List<string> listStatus, List<bool> listInstalleds);

        List<t_Loggers> GetAllLoggers();

        List<string> GetAllLoggerProviders();

        List<string> GetAllLoggerMarks();

        List<string> GetAllLoggerModels();

        void InsertLogger(t_Loggers Logger);

        void UpdateLogger(t_Loggers Logger, t_Loggers origLogger);

        void DeleteLogger(t_Loggers Logger);
    }
}