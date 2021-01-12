using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for LoggerRepository
    /// </summary>
    public class LoggerRepository : IDisposable, ILoggerRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

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

        public t_Loggers GetLogger(string serial)
        {
            return context.t_Loggers.SingleOrDefault(l => l.Serial == serial);
        }

        public List<t_Loggers> GetAllLoggers()
        {
            return context.t_Loggers.OrderBy(l => l.Serial).ToList();
        }

        public List<DeviceViewModel> GetLoggerByConds(List<string> listProviders, List<string> listMarks, List<string> listModels, List<string> listStatus, List<bool> listInstalleds)
        {
            return (from t in context.t_Loggers
                    join s in context.t_Sites on t.Serial equals s.LoggerSerial into ts
                    where listProviders.Contains(t.Provider ?? string.Empty)
                    && listMarks.Contains(t.Marks ?? string.Empty)
                    && listModels.Contains(t.Model ?? string.Empty)
                    && listStatus.Contains(t.Status ?? string.Empty)
                    && listInstalleds.Contains(t.Installed ?? false)
                    orderby t.Serial
                    from s in ts.DefaultIfEmpty()
                    where t.Serial != string.Empty
                    select new DeviceViewModel
                    {
                        Serial = t.Serial,
                        Provider = t.Provider,
                        Marks = t.Marks,
                        Model = t.Model,
                        Status = t.Status,
                        Installed = t.Installed ?? false,
                        ReceiptDate = t.ReceiptDate,
                        Description = t.Description,
                        SiteID = s.SiteId,
                        SitaAliasName = s.SiteAliasName,
                        Location = s.Location
                    }).ToList();
        }

        public List<string> GetAllLoggerProviders()
        {
            return context.t_Loggers.OrderBy(l => l.Provider).Select(l => l.Provider).Distinct().ToList();
        }

        public List<string> GetAllLoggerMarks()
        {
            return context.t_Loggers.OrderBy(l => l.Marks).Select(l => l.Marks).Distinct().ToList();
        }

        public List<string> GetAllLoggerModels()
        {
            return context.t_Loggers.OrderBy(l => l.Model).Select(l => l.Model).Distinct().ToList();
        }

        public void InsertLogger(t_Loggers Logger)
        {
            try
            {
                context.t_Loggers.Add(Logger);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateLogger(t_Loggers Logger, t_Loggers origLogger)
        {
            try
            {
                context.t_Loggers.Attach(origLogger);
                origLogger.Description = Logger.Description;
                origLogger.Installed = Logger.Installed;
                origLogger.Marks = Logger.Marks;
                origLogger.Model = Logger.Model;
                origLogger.Provider = Logger.Provider;
                origLogger.ReceiptDate = Logger.ReceiptDate;
                origLogger.Serial = Logger.Serial;
                origLogger.Status = Logger.Status;
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteLogger(t_Loggers Logger)
        {
            try
            {
                context.t_Loggers.Attach(Logger);
                context.t_Loggers.Remove(Logger);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }
    }
}