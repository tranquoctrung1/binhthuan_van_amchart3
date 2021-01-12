using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.BLL
{
/// <summary>
/// Summary description for LoggerBL
/// </summary>
/// 
    [DataObject]
    public class LoggerBL : IDisposable
    {
        private ILoggerRepository loggerRepository;
        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    loggerRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public LoggerBL()
        {
            this.loggerRepository = new LoggerRepository();
        }

        public t_Loggers GetLogger(string serial)
        {
            return loggerRepository.GetLogger(serial);
        }

        [DataObjectMethod(DataObjectMethodType.Select, true)]
        public List<t_Loggers> GetAllLoggers()
        {
            return loggerRepository.GetAllLoggers();
        }

        public List<DeviceViewModel> GetLoggerByConds(List<string> listProviders, List<string> listMarks, List<string> listModels, List<string> listStatus, List<bool> listInstalleds)
        {
            return loggerRepository.GetLoggerByConds(listProviders, listMarks, listModels, listStatus, listInstalleds);
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<string> GetAllLoggerProviders()
        {
            return loggerRepository.GetAllLoggerProviders();
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<string> GetAllLoggerMarks()
        {
            return loggerRepository.GetAllLoggerMarks();
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<string> GetAllLoggerModels()
        {
            return loggerRepository.GetAllLoggerModels();
        }

        public void InsertLogger(t_Loggers logger)
        {
            try
            {
                loggerRepository.InsertLogger(logger);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateLogger(t_Loggers logger, t_Loggers origLogger)
        {
            try
            {
                loggerRepository.UpdateLogger(logger, origLogger);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteLogger(t_Loggers logger)
        {
            try
            {
                loggerRepository.DeleteLogger(logger);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }
    }
}