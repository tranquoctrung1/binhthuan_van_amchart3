using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.BLL
{
    /// <summary>
    /// Summary description for LoggerFileBL
    /// </summary>
    public class LoggerFileBL
    {
        private ILoggerFileRepository loggerFileRepository;
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    loggerFileRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public LoggerFileBL()
        {
            loggerFileRepository = new LoggerFileRepository();
        }

        public IEnumerable<t_Logger_Files> GetLoggerFilesByLoggerSerial(string loggerSerial)
        {
            return loggerFileRepository.GetLoggerFilesByLoggerSerial(loggerSerial);
        }

        public t_Logger_Files GetLoggerFile(string fileName)
        {
            return loggerFileRepository.GetLoggerFile(fileName);
        }

        public void InsertLoggerFile(t_Logger_Files loggerFile)
        {
            try
            {
                loggerFileRepository.InsertLoggerFile(loggerFile);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateLoggerFile(t_Logger_Files loggerFile, t_Logger_Files orgiLoggerFile)
        {
            try
            {
                loggerFileRepository.UpdateLoggerFile(loggerFile, orgiLoggerFile);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteLoggerFile(t_Logger_Files loggerFile)
        {
            try
            {
                loggerFileRepository.DeleteLoggerFile(loggerFile);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }
    }
}