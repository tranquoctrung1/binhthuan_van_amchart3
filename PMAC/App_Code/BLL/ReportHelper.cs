using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.BLL;


/// <summary>
/// Summary description for ReportHelper
/// </summary>
public class ReportHelper
{
    SiteBL _siteBL = new SiteBL();
    LoggerConfigurationBL _loggerConfigurationBL = new LoggerConfigurationBL();
    ComplexDataHelper _complexDataHelper = new ComplexDataHelper();
    RawIndexBL _rawIndexBL = new RawIndexBL();
    LoggerDataBL _loggerDataBL = new LoggerDataBL();
    ChannelConfigurationBL _channelConfigurationBL = new ChannelConfigurationBL();

    public List<ReportDataViewModel> GetMonthyReportData(string siteID, DateTime startDate, DateTime endDate)
    {
        List<ReportDataViewModel> listReportDataViewModel = new List<ReportDataViewModel>();
        var site = _siteBL.GetSite(siteID);
        var loggerConfiguration = site.t_Logger_Configurations;
        
        DateTime start;
        double startDay = Convert.ToDouble(site.StartDay);
        double startHour = Convert.ToDouble(loggerConfiguration.StartHour);

        string channelForward ="";
        string channelReverse = "";
        if (loggerConfiguration.ForwardFlow != null)
        {
            channelForward = _channelConfigurationBL.GetChannelConfigurationByType(loggerConfiguration.LoggerId, "f").ChannelId;
            //string channelForward = loggerConfiguration.LoggerId + "_" + string.Format("{0:00}", loggerConfiguration.ForwardFlow);
        }
        if (loggerConfiguration.ReverseFlow != null)
        {
            channelReverse = _channelConfigurationBL.GetChannelConfigurationByType(loggerConfiguration.LoggerId, "r").ChannelId;
            //string channelReverse = loggerConfiguration.LoggerId + "_" + string.Format("{0:00}", loggerConfiguration.ReverseFlow);
        }

        var listMonthlyComplexDataViewModel = _complexDataHelper.GetMonthlyComplexData(loggerConfiguration.LoggerId, startDate, endDate);
        
        int interval = 0;//sec
        if (listMonthlyComplexDataViewModel.Count != 0)
        {
            interval = listMonthlyComplexDataViewModel[0].TimeStamp.Second;
        }
        
        startDate = startDate.AddDays(startDay - 1).AddHours(startHour);
        int totalMonth = (endDate.Year - startDate.Year) * 12 + (endDate.Month - startDate.Month) + 1;
        for (int i = 0; i < totalMonth; i++)
        {
            start = startDate.AddMonths(i);
            ReportDataViewModel data = new ReportDataViewModel();
            data.StartDate = start;
            data.EndDate = start.AddMonths(1);
            data.SiteID = site.SiteId;
            data.SiteAliasName = site.SiteAliasName;
            data.Location = site.Location;

            var startRecord = _rawIndexBL.GetRawIndex(site.SiteId, data.StartDate);
            
            if (startRecord != null)
            {
                data.StartIndex = startRecord.Index;
            }

            var endRecord = _rawIndexBL.GetRawIndex(siteID, data.EndDate);
            
            if (endRecord != null)
            {
                data.EndIndex = endRecord.Index;
            }
            if (startRecord != null && endRecord != null)
            {
                data.Output = data.EndIndex - data.StartIndex;
            }
            listReportDataViewModel.Add(data);
        }
        double startForwardIndex = 0;
        double startReveseIndex = 0;
        double endForwardIndex = 0;
        double endReveseIndex = 0;

        t_Logger_Data startLoggerForwardIndex = null;
        t_Logger_Data startLoggerReveseIndex = null;
        t_Logger_Data endLoggerForwardIndex = null;
        t_Logger_Data endLoggerReveseIndex = null;

        for (int i = 0; i < listReportDataViewModel.Count; i++)
        {
            if (listReportDataViewModel[i].Output == null)
            {
                var complexData = listMonthlyComplexDataViewModel.Where(d => d.SiteID == listReportDataViewModel[i].SiteID && d.TimeStamp == listReportDataViewModel[i].StartDate.AddHours(1)).SingleOrDefault();
                if (complexData == null)//Inventia
                {
                    complexData = listMonthlyComplexDataViewModel.Where(d => d.SiteID == listReportDataViewModel[i].SiteID && d.TimeStamp == listReportDataViewModel[i].StartDate.AddHours(1).AddSeconds(1)).SingleOrDefault();
                }
                if (complexData != null)
                {

                    listReportDataViewModel[i].Output = complexData.Output;
                    if (loggerConfiguration.ForwardFlow != null)
                    {
                        startLoggerForwardIndex = _loggerDataBL.GetLoggerIndex(channelForward, listReportDataViewModel[i].StartDate);
                        if (startLoggerForwardIndex == null)
                        {
                            startLoggerForwardIndex = _loggerDataBL.GetLoggerIndex(channelForward, listReportDataViewModel[i].StartDate.AddSeconds(1));
                        }
                        endLoggerForwardIndex = _loggerDataBL.GetLoggerIndex(channelForward, listReportDataViewModel[i].EndDate);
                        if (endLoggerForwardIndex == null)
                        {
                            endLoggerForwardIndex = _loggerDataBL.GetLoggerIndex(channelForward, listReportDataViewModel[i].EndDate.AddSeconds(1));
                        }
                    }
                    if (loggerConfiguration.ReverseFlow != null)
                    {
                        startLoggerReveseIndex = _loggerDataBL.GetLoggerIndex(channelReverse, listReportDataViewModel[i].StartDate);
                        if (startLoggerReveseIndex == null)
                        {
                            startLoggerReveseIndex = _loggerDataBL.GetLoggerIndex(channelReverse, listReportDataViewModel[i].StartDate.AddSeconds(1));
                        }
                        endLoggerReveseIndex = _loggerDataBL.GetLoggerIndex(channelReverse, listReportDataViewModel[i].EndDate);
                        if (endLoggerReveseIndex == null)
                        {
                            endLoggerReveseIndex = _loggerDataBL.GetLoggerIndex(channelReverse, listReportDataViewModel[i].EndDate.AddSeconds(1));
                        }
                    }

                    startForwardIndex = 0;
                    startReveseIndex = 0;
                    endForwardIndex = 0;
                    endReveseIndex = 0;

                    if (startLoggerForwardIndex != null)
                    {
                        startForwardIndex = startLoggerForwardIndex.Value ?? 0;
                    }
                    if (startLoggerReveseIndex != null)
                    {
                        startReveseIndex = startLoggerReveseIndex.Value ?? 0;
                    }
                    if (endLoggerForwardIndex != null)
                    {
                        endForwardIndex = endLoggerForwardIndex.Value ?? 0;
                    }
                    if (endLoggerReveseIndex != null)
                    {
                        endReveseIndex = endLoggerReveseIndex.Value ?? 0;
                    }
                    listReportDataViewModel[i].StartIndex = startForwardIndex - startReveseIndex;
                    listReportDataViewModel[i].EndIndex = endForwardIndex - endReveseIndex;
                }
            }
        }
        return listReportDataViewModel;
    }
}