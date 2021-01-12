using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;
using System.Data.SqlClient;
using System.Linq.Expressions;

namespace PMAC.DAL
{
    public class ComplexDataRepository:IDisposable, IComplexDataRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

        public double GetMNF(string loggerId, DateTime startDate, DateTime endDate)
        {
            return context.t_Data_Complexes.Where(d => d.LoggerId == loggerId && d.TimeStamp >= startDate && d.TimeStamp <= endDate).Min(d=>d.MinForwardFlow ?? d.MinReverseFlow).GetValueOrDefault();

        }
        public int GetCountBaselien(string loggerId, double? baseLine, DateTime startDate, DateTime endDate)
        {
            return context.t_Data_Complexes.Where(d => d.LoggerId == loggerId && (d.MinForwardFlow ?? d.MinReverseFlow) > baseLine && d.TimeStamp >= startDate && d.TimeStamp <= endDate).Count();
        }
        public IEnumerable<t_Data_Complexes> GetComplexData(string loggerID, DateTime startDate, DateTime endDate)
        {
            return context.t_Data_Complexes.Where(d => d.LoggerId == loggerID && d.TimeStamp >= startDate && d.TimeStamp <= endDate);
        }

        public IEnumerable<ComplexData> GetCustomComplexData()
        {
            return context.Database.SqlQuery<ComplexData>("exec p_ComplexData_Select_Faster").ToList();
        }

        public IEnumerable<ComplexData> GetCustomComplexDataRange(Expression<Func<ComplexData, bool>> predicate)
        {
            return context.Database.SqlQuery<ComplexData>("exec p_ComplexData_Select_Faster").AsQueryable().Where(predicate);
        }

        public IEnumerable<ComplexData> GetCustomComplexDataForStaff(string staffId)
        {
            return context.Database.SqlQuery<ComplexData>("exec p_ComplexData_Select_For_Staff @StaffId", new SqlParameter("StaffId", staffId)).ToList();
        }

        public IEnumerable<ComplexData> GetCustomComplexDataForConsumer(string consumerId)
        {
            return context.Database.SqlQuery<ComplexData>("exec p_ComplexData_Select_For_Consumer @ConsumerId", new SqlParameter("ConsumerId", consumerId)).ToList();
        }

        public IEnumerable<HourlyData> GetHourlyData(string siteId, DateTime startDate, DateTime endDate)
        {
            return context.Database.SqlQuery<HourlyData>("exec p_HourlyData_Select @SiteId,@StartDate,@EndDate", new SqlParameter("SiteId", siteId), new SqlParameter("StartDate", startDate), new SqlParameter("EndDate", endDate)).ToList();
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

    public class HourlyData
    {
        public string SiteId { get; set; }
        public string SiteAliasName { get; set; }
        public string Location { get; set; }
        public string LoggerId { get; set; }
        public System.DateTime TimeStamp { get; set; }
        public Nullable<double> ForwardFlow { get; set; }
        public Nullable<double> ReverseFlow { get; set; }
        public Nullable<double> ForwardIndex { get; set; }
        public Nullable<double> ReverseIndex { get; set; }
        public Nullable<double> Pressure1 { get; set; }
        public Nullable<double> Pressure2 { get; set; }
        public Nullable<double> MinForwardFlow { get; set; }
        public Nullable<double> MaxForwardFlow { get; set; }
        public Nullable<double> MinReverseFlow { get; set; }
        public Nullable<double> MaxReverseFlow { get; set; }
        public Nullable<double> MinPressure1 { get; set; }
        public Nullable<double> MaxPressure1 { get; set; }
        public Nullable<double> MinPressure2 { get; set; }
        public Nullable<double> MaxPressure2 { get; set; }
    }
}