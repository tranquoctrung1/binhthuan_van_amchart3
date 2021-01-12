using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for LoggerFileRepository
    /// </summary>
    public class LoggerFileRepository : IDisposable, ILoggerFileRepository
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

        public IEnumerable<t_Logger_Files> GetLoggerFilesByLoggerSerial(string LoggerSerial)
        {
            return context.t_Logger_Files.Where(f => f.LoggerSerial == LoggerSerial).OrderByDescending(f => f.UploadDate).ToList();
        }

        public t_Logger_Files GetLoggerFile(string fileName)
        {
            return context.t_Logger_Files.SingleOrDefault(f => f.FileName == fileName);
        }

        public void InsertLoggerFile(t_Logger_Files LoggerFile)
        {
            try
            {
                context.t_Logger_Files.Add(LoggerFile);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateLoggerFile(t_Logger_Files LoggerFile, t_Logger_Files orgiLoggerFile)
        {
            try
            {
                context.t_Logger_Files.Attach(orgiLoggerFile);
                orgiLoggerFile.FileName = LoggerFile.FileName;
                orgiLoggerFile.LoggerSerial = LoggerFile.LoggerSerial; ;
                orgiLoggerFile.MIMEType = LoggerFile.MIMEType;
                orgiLoggerFile.Path = LoggerFile.Path;
                orgiLoggerFile.Size = LoggerFile.Size;
                orgiLoggerFile.UploadDate = LoggerFile.UploadDate;
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteLoggerFile(t_Logger_Files LoggerFile)
        {
            try
            {
                context.t_Logger_Files.Attach(LoggerFile);
                context.t_Logger_Files.Remove(LoggerFile);
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