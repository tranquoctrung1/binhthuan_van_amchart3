using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for ILoggerFileRepository
    /// </summary>
    public interface ILoggerFileRepository : IDisposable
    {
        IEnumerable<t_Logger_Files> GetLoggerFilesByLoggerSerial(string LoggerSerial);

        t_Logger_Files GetLoggerFile(string fileName);

        void InsertLoggerFile(t_Logger_Files LoggerFile);

        void UpdateLoggerFile(t_Logger_Files LoggerFile, t_Logger_Files orgiLoggerFile);

        void DeleteLoggerFile(t_Logger_Files LoggerFile);
    }
}