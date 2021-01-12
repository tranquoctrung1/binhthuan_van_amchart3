using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;


namespace PMAC.BLL
{
    [DataObject]
    public class ComplexDataBL : IDisposable
    {
        private bool disposedValue = false;
        private IComplexDataRepository complexDataRepository;

        public ComplexDataBL()
        {
            this.complexDataRepository = new ComplexDataRepository();
        }

        public ComplexDataBL(IComplexDataRepository complexDataRepository)
        {
            this.complexDataRepository = complexDataRepository;
        }


        public IEnumerable<t_Data_Complexes> GetComplexData(string loggerID, DateTime startDate, DateTime endDate)
        {
            return complexDataRepository.GetComplexData(loggerID, startDate, endDate);
        }

        public IEnumerable<HourlyData> GetHourlyData(string siteId, DateTime startDate, DateTime endDate)
        {
            return complexDataRepository.GetHourlyData(siteId, startDate, endDate);
        }


        public double GetMNF(string loggerId, DateTime startDate, DateTime endDate)
        {
            return complexDataRepository.GetMNF(loggerId, startDate, endDate);
        }

        public int GetCountBaselien(string loggerId, double? baseLine, DateTime startDate, DateTime endDate)
        {
            return complexDataRepository.GetCountBaselien(loggerId, baseLine, startDate, endDate);
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public IEnumerable<ComplexData> GetCustomComplexData()
        {
            return complexDataRepository.GetCustomComplexData();
        }
        [DataObjectMethod(DataObjectMethodType.Select)]
        public IEnumerable<ComplexData> GetCustomComplexDataForStaff(string staffId)
        {
            return complexDataRepository.GetCustomComplexDataForStaff(staffId);
        }

        [DataObjectMethod(DataObjectMethodType.Select)]
        public IEnumerable<ComplexData> GetCustomComplexDataForConsumer(string consumerId)
        {
            return complexDataRepository.GetCustomComplexDataForConsumer(consumerId);
        }

        protected void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    complexDataRepository.Dispose();
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
