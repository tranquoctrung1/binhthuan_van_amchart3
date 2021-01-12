using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.BLL;

namespace PMAC.BLL
{
    /// <summary>
    public class ComplexDataHelper
    {
        ComplexDataBL _complexDataBL = new ComplexDataBL();
        LoggerConfigurationBL _loggerConfigurationBL = new LoggerConfigurationBL();
        SiteBL _siteBL = new SiteBL();
        ChannelConfigurationBL _channelBL = new ChannelConfigurationBL();


        public List<BlinkMNFViewModel> BlinkMNF()
        {
            List<BlinkMNFViewModel> listMNF = new List<BlinkMNFViewModel>();

            var listSite = _siteBL.GetSitesDMA();
            var hour = DateTime.Now.Hour - 2;
            var minute = DateTime.Now.Minute;
            //edit adddays(-10)->now
            DateTime start = DateTime.Now.AddHours(-hour).AddMinutes(-minute);//02:00
            DateTime end = start.AddHours(2);
            DateTime starHis = start.AddDays(-1);
            DateTime endHis = starHis.AddHours(2);
            int countMNFhigh = 0;
            int countMNF = 0;
            int numLoggerZero = 0;
            int numLoggerErr = 0;
            int? SetDelayTime = 60;
            foreach (var site in listSite)
            {               
                double? baseline = site.Baseline;
                string loggerId = site.LoggerId;
                if(site.SetDelayTime > 0)
                {
                    SetDelayTime = site.SetDelayTime;
                }
                 
                //get logger error
                int numErr = _channelBL.GetChannelConfigurationsErr(loggerId, SetDelayTime);
                if(numErr>0)
                {
                    numLoggerErr += 1;
                }
                //get logger Zero
                int numZero = _channelBL.GetChannelConfigurationsZero(loggerId);
                if(numZero > 0)
                {
                    numLoggerZero += 1;
                }
                //get MNF low baseline
                int temp = _complexDataBL.GetCountBaselien(loggerId, baseline, start, end);
                if(temp > 0)
                {
                    countMNF += 1;
                }
                //get MNF high NMF history
                double MNFToday =_complexDataBL.GetMNF(loggerId, start, end);
                double MNFHistory= _complexDataBL.GetMNF(loggerId, starHis, endHis) ;
                if (MNFToday > MNFHistory)
                {
                    countMNFhigh += 1;
                }

            }

            //var numLogger = _loggerConfigurationBL.GetLoggerConfigurations().Count();
            var numLogger = _siteBL.GetSitesDMA().Count();
           // var numLoggerZero = _channelBL.GetChannelConfigurationsZero().Count();

            BlinkMNFViewModel BlinkModel = new BlinkMNFViewModel();
                 BlinkModel.TotalLogger = numLogger;
                 BlinkModel.LoggerZero = numLoggerZero;
                 BlinkModel.LoggerError = numLoggerErr;
                 BlinkModel.MNFLowBaseline = countMNF;
                 BlinkModel.MNFHighFirst = countMNFhigh;
                 listMNF.Add(BlinkModel);
            return listMNF.ToList();
        }

        public IList<ComplexDataViewModel> GetDailyComplexData_Multiple(List<string> loggerIds, DateTime startDate, DateTime endDate)
        {
            List<ComplexDataViewModel> listDailyComplexDataViewModel_Multiple = new List<ComplexDataViewModel>();

            foreach (var loggerId in loggerIds)
            {
                var data = GetDailyComplexData(loggerId, startDate, endDate);

                foreach (var d in data)
                {
                    listDailyComplexDataViewModel_Multiple.Add(d);
                }
            }

            return listDailyComplexDataViewModel_Multiple.OrderBy(i => i.TimeStamp).ToList();
        }

        public IList<ComplexDataViewModel> GetDailyComplexData(string loggerID, DateTime startDate, DateTime endDate)
        {
            List<ComplexDataViewModel> listDailyComplexDataViewModel = new List<ComplexDataViewModel>();
            int totalDay = Convert.ToInt32(endDate.Subtract(startDate).TotalDays) + 1;
            var loggerConfiguration = _loggerConfigurationBL.GetLoggerConfiguration(loggerID);
            if (loggerConfiguration != null)
            {
                var site = _siteBL.GetSite(loggerConfiguration.SiteId);
                double startHour = Convert.ToDouble(loggerConfiguration.StartHour);
                if (loggerConfiguration.LoggerId.Contains("__"))//Inventia
                {
                    startDate = startDate.AddSeconds(1).AddHours(startHour + 1);
                    endDate = endDate.AddSeconds(1).AddDays(1).AddHours(startHour);
                }
                else
                {
                    startDate = startDate.AddHours(startHour + 1);
                    endDate = endDate.AddDays(1).AddHours(startHour);
                }
                var listComplexData = _complexDataBL.GetComplexData(loggerID, startDate, endDate);
                DateTime start;
                DateTime end;
                for (int i = 0; i < totalDay; i++)
                {
                    start = startDate.AddDays(i);
                    end = start.AddDays(1).AddHours(-1);
                    var list = listComplexData.Where(d => d.TimeStamp >= start && d.TimeStamp <= end).ToList();
                    if (list != null && list.Count != 0 && site != null)
                    {
                        ComplexDataViewModel dailyComplexDataViewModel = new ComplexDataViewModel();
                        dailyComplexDataViewModel.Location = site.Location;
                        dailyComplexDataViewModel.SiteID = site.SiteId;
                        dailyComplexDataViewModel.SiteAliasName = site.SiteAliasName;
                        dailyComplexDataViewModel.TimeStamp = startDate.AddDays(i);
                        dailyComplexDataViewModel.MinFlowRate = list.Min(d => d.ForwardFlow ?? 0 - d.ReverseFlow ?? 0);
                        dailyComplexDataViewModel.MaxFlowRate = list.Max(d => d.ForwardFlow ?? 0 - d.ReverseFlow ?? 0);
                        dailyComplexDataViewModel.Output = list.Sum(d => d.ForwardFlow ?? 0) - list.Sum(d => d.ReverseFlow ?? 0);
                        dailyComplexDataViewModel.MinPressure = list.Min(d => d.MinPressure2 ?? d.MinPressure1);
                        dailyComplexDataViewModel.MaxPressure = list.Max(d => d.MaxPressure2 ?? d.MaxPressure1);

                        var listMaxFlow = list.Where(d => (d.ForwardFlow ?? 0 - d.ReverseFlow ?? 0) == dailyComplexDataViewModel.MaxFlowRate);
                        var listMinFlow = list.Where(d => (d.ForwardFlow ?? 0 - d.ReverseFlow ?? 0) == dailyComplexDataViewModel.MinFlowRate);
                        var listMinPress = list.Where(d => (d.MinPressure2 ?? d.MinPressure1) == dailyComplexDataViewModel.MinPressure);
                        var listMaxPress = list.Where(d => (d.MaxPressure2 ?? d.MaxPressure1) == dailyComplexDataViewModel.MaxPressure);

                       

                        listDailyComplexDataViewModel.Add(dailyComplexDataViewModel);
                    }
                }
            }
            return listDailyComplexDataViewModel;
        }

        public IList<ComplexDataViewModel> GetMonthlyComplexData_Multiple(List<string> loggerIds, DateTime startDate, DateTime endDate)
        {
            List<ComplexDataViewModel> listMonthlyComplexDataViewModel_Multiple = new List<ComplexDataViewModel>();

            foreach (var loggerId in loggerIds)
            {
                var data = GetMonthlyComplexData(loggerId, startDate, endDate);

                foreach (var d in data)
                {
                    listMonthlyComplexDataViewModel_Multiple.Add(d);
                }
            }

            return listMonthlyComplexDataViewModel_Multiple.OrderBy(i => i.TimeStamp).ToList();
        }

        public IList<ComplexDataViewModel> GetMonthlyComplexData(string loggerID, DateTime startDate, DateTime endDate)
        {
            List<ComplexDataViewModel> listMonthlyComplexDataViewModel = new List<ComplexDataViewModel>();
            int totalMonth = (endDate.Year - startDate.Year) * 12 + (endDate.Month - startDate.Month) + 1;
            var loggerConfiguration = _loggerConfigurationBL.GetLoggerConfiguration(loggerID);
            if (loggerConfiguration != null)
            {
                var site = _siteBL.GetSite(loggerConfiguration.SiteId);
                double startHour = Convert.ToDouble(loggerConfiguration.StartHour);
                double startDay = Convert.ToDouble(site.StartDay);
                endDate = endDate.AddMonths(1).AddDays(startDay).AddHours(startHour);

                if (site.LoggerId.Contains("__"))//Inventia
                {
                    startDate = startDate.AddDays(startDay - 1).AddHours(startHour + 1).AddSeconds(1);
                    endDate = endDate.AddSeconds(1);
                }
                else
                {
                    startDate = startDate.AddDays(startDay - 1).AddHours(startHour + 1);
                }

                var listComplexData = _complexDataBL.GetComplexData(loggerID, startDate, endDate);
                DateTime start;
                DateTime end;
                for (int i = 0; i < totalMonth; i++)
                {
                    start = startDate.AddMonths(i);
                    end = start.AddMonths(1).AddHours(-1);
                    var list = listComplexData.Where(d => d.TimeStamp >= start && d.TimeStamp <= end).ToList();
                    if (list != null && list.Count != 0)
                    {
                        ComplexDataViewModel monthlyComplexDataViewModel = new ComplexDataViewModel();
                        monthlyComplexDataViewModel.Location = site.Location;
                        monthlyComplexDataViewModel.SiteID = site.SiteId;
                        monthlyComplexDataViewModel.SiteAliasName = site.SiteAliasName;
                        monthlyComplexDataViewModel.TimeStamp = startDate.AddMonths(i);
                        monthlyComplexDataViewModel.MinFlowRate = list.Min(d => d.ForwardFlow ?? 0 - d.ReverseFlow ?? 0);
                        monthlyComplexDataViewModel.MaxFlowRate = list.Max(d => d.ForwardFlow ?? 0 - d.ReverseFlow ?? 0);
                        monthlyComplexDataViewModel.Output = list.Sum(d => d.ForwardFlow ?? 0) - list.Sum(d => d.ReverseFlow ?? 0);
                        monthlyComplexDataViewModel.MinPressure = list.Min(d => d.MinPressure2 ?? d.MinPressure1);
                        monthlyComplexDataViewModel.MaxPressure = list.Max(d => d.MinPressure2 ?? d.MinPressure1);
                        listMonthlyComplexDataViewModel.Add(monthlyComplexDataViewModel);
                    }
                }
            }
            return listMonthlyComplexDataViewModel;
        }
    }
}