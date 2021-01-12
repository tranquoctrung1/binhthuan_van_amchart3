using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;
using System.Data.Objects;

namespace PMAC.DAL
{
    public class RawIndexRepository : IDisposable, IRawIndexRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

        public t_Data_Raw_Indexes GetRawIndex(string siteID, DateTime timeStamp)
        {
            var date = timeStamp.Date;
            return context.t_Data_Raw_Indexes.SingleOrDefault(d => d.SiteId == siteID 
            && EntityFunctions.TruncateTime(d.TimeStamp) == date);
        }

        public List<t_Data_Raw_Indexes> GetRawIndexes(string siteID, DateTime startDate, DateTime endDate)
        {
            return context.t_Data_Raw_Indexes.Where(d => d.SiteId == siteID && d.TimeStamp >= startDate && d.TimeStamp <= endDate).OrderBy(d => d.TimeStamp).ToList();
        }

        public t_Data_Raw_Indexes GetLastRawIndex(string siteID)
        {
            var rawIndexes = context.t_Data_Raw_Indexes.Where(d => d.SiteId == siteID).ToList();
            if (rawIndexes == null || rawIndexes.Count == 0)
            {
                return null;
            }
            else
            {
                var lastDate = rawIndexes.Select(d => d.TimeStamp).Max();
                return rawIndexes.SingleOrDefault(d => d.TimeStamp == lastDate);
            }
        }

        public void InsertRawIndex(t_Data_Raw_Indexes rawIndex)
        {
            try
            {
                context.t_Data_Raw_Indexes.Add(rawIndex);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateRawIndex(t_Data_Raw_Indexes rawIndex, t_Data_Raw_Indexes origRawIndex)
        {
            try
            {
                context.t_Data_Raw_Indexes.Attach(origRawIndex);
                origRawIndex.Index = rawIndex.Index;
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteRawIndex(t_Data_Raw_Indexes rawIndex)
        {
            try
            {
                context.t_Data_Raw_Indexes.Attach(rawIndex);
                context.t_Data_Raw_Indexes.Remove(rawIndex);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteRawIndexes(string siteID, DateTime startDate, DateTime endDate)
        {
            try
            {
                var list = context.t_Data_Raw_Indexes.Where(d => d.SiteId == siteID && d.TimeStamp >= startDate && d.TimeStamp <= endDate).ToList();
                //.ForEach(context.t_Data_Raw_Indexes.Remove);
                foreach (var item in list)
                {
                    context.t_Data_Raw_Indexes.Remove(item);
                }
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

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
    }
}