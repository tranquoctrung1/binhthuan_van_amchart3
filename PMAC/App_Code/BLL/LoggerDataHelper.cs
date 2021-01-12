using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using PMAC.DAL;
using PMAC.BLL;

namespace PMAC.BLL
{
    /// <summary>
    /// Summary description for LoggerDataHelper
    /// </summary>
    /// 
    public class LoggerDataHelper
    {
        SiteBL _siteBL = new SiteBL();
        LoggerDataBL _loggerDataBL = new LoggerDataBL();
        ChannelConfigurationBL _channelConfigurationBL = new ChannelConfigurationBL();

        public IList<LoggerDataViewModel> GetComplexLoggerData(string siteID, DateTime startDate, DateTime endDate)
        {
            List<LoggerDataViewModel> listLoggerDataViewModel = new List<LoggerDataViewModel>();
            var site = _siteBL.GetSite(siteID);
            var loggerConfiguration = site.t_Logger_Configurations;
            double startHour = Convert.ToDouble(loggerConfiguration.StartHour);
            if (site.LoggerId.Contains("__"))//inventia
            {
                startDate = startDate.AddHours(startHour).AddSeconds(1).AddSeconds(1);
                endDate = endDate.AddDays(1).AddHours(startHour).AddSeconds(1);
            }
            else
            {
                startDate = startDate.AddHours(startHour).AddSeconds(1);
                endDate = endDate.AddDays(1).AddHours(startHour);
            }
            List<t_Logger_Data> listForward = new List<t_Logger_Data>();
            List<t_Logger_Data> listReverse = new List<t_Logger_Data>();
            List<t_Logger_Data> listPressure1 = new List<t_Logger_Data>();
            List<t_Logger_Data> listPressure2 = new List<t_Logger_Data>();
            List<t_Logger_Data> listForwardIndex = new List<t_Logger_Data>();
            List<t_Logger_Data> listReverseIndex = new List<t_Logger_Data>();
            try
            {
                if (loggerConfiguration.ForwardFlow != null)
                {
                    string channelForward = "";
                    //string channelForward = loggerConfiguration.LoggerId + "_" + string.Format("{0:00}", loggerConfiguration.ForwardFlow);
                    channelForward = _channelConfigurationBL.GetChannelConfigurationByType(loggerConfiguration.LoggerId, "f").ChannelId;

                    listForward = _loggerDataBL.GetLoggerData(channelForward, startDate, endDate);
                    listForwardIndex = _loggerDataBL.GetLoggerIndexes(channelForward, startDate, endDate);
                }
            }
            catch (Exception ex)
            {
                //throw ex;
            }

            try
            {
                if (loggerConfiguration.ReverseFlow != null)
                {
                    string channelReverse = "";

                    //string channelReverse = loggerConfiguration.LoggerId + "_" + string.Format("{0:00}", loggerConfiguration.ReverseFlow);
                    channelReverse = _channelConfigurationBL.GetChannelConfigurationByType(loggerConfiguration.LoggerId, "r").ChannelId;

                    listReverse = _loggerDataBL.GetLoggerData(channelReverse, startDate, endDate);
                    listReverseIndex = _loggerDataBL.GetLoggerIndexes(channelReverse, startDate, endDate);
                }
            }
            catch (Exception ex)
            {
                //throw ex;
            }

            try
            {
                if (loggerConfiguration.Pressure1 != null)
                {
                    string channelPressure1 = "";
                    //string channelPressure1 = loggerConfiguration.LoggerId + "_" + string.Format("{0:00}", loggerConfiguration.Pressure1);
                    channelPressure1 = _channelConfigurationBL.GetChannelConfigurationByType(loggerConfiguration.LoggerId, "p1").ChannelId;

                    listPressure1 = _loggerDataBL.GetLoggerData(channelPressure1, startDate, endDate);
                }
            }
            catch (Exception ex)
            {
                //throw ex;
            }

            try
            {
                if (loggerConfiguration.Pressure2 != null)
                {
                    string channelPressure2 = "";
                    //string channelPressure2 = loggerConfiguration.LoggerId + "_" + string.Format("{0:00}", loggerConfiguration.Pressure2);
                    channelPressure2 = _channelConfigurationBL.GetChannelConfigurationByType(loggerConfiguration.LoggerId, "p2").ChannelId;

                    listPressure2 = _loggerDataBL.GetLoggerData(channelPressure2, startDate, endDate);
                }
            }
            catch (Exception ex)
            {
                //throw ex;
            }

            List<t_Logger_Data> temp = new List<t_Logger_Data>();
            if (listForward.Count != 0)
            {
                temp = listForward;
                goto t;
            }
            if (listReverse.Count != 0)
            {
                temp = listReverse;
                goto t;
            }
            if (listPressure1.Count != 0)
            {
                temp = listPressure1;
                goto t;
            }
            if (listPressure2.Count != 0)
            {
                temp = listPressure2;
            }
        t:
            if (listForward.Count == 0)
            {
                foreach (var item in temp)
                {
                    t_Logger_Data t = new t_Logger_Data();
                    t.TimeStamp = item.TimeStamp;
                    listForward.Add(t);
                }
            }
            if (listReverse.Count == 0)
            {
                foreach (var item in temp)
                {
                    t_Logger_Data t = new t_Logger_Data();
                    t.TimeStamp = item.TimeStamp;
                    listReverse.Add(t);
                }
            }
            if (listPressure1.Count == 0)
            {
                foreach (var item in temp)
                {
                    t_Logger_Data t = new t_Logger_Data();
                    t.TimeStamp = item.TimeStamp;
                    listPressure1.Add(t);
                }
            }
            if (listPressure2.Count == 0)
            {
                foreach (var item in temp)
                {
                    t_Logger_Data t = new t_Logger_Data();
                    t.TimeStamp = item.TimeStamp;
                    listPressure2.Add(t);
                }
            }
            if (listForwardIndex.Count == 0)
            {
                foreach (var item in temp)
                {
                    t_Logger_Data t = new t_Logger_Data();
                    t.TimeStamp = item.TimeStamp;
                    listForwardIndex.Add(t);
                }
            }
            if (listReverseIndex.Count == 0)
            {
                foreach (var item in temp)
                {
                    t_Logger_Data t = new t_Logger_Data();
                    t.TimeStamp = item.TimeStamp;
                    listReverseIndex.Add(t);
                }
            }
            //double interval = temp[1].TimeStamp.Subtract(temp[0].TimeStamp).TotalMinutes;
            //double mul = interval / 60;
            for (int i = 0; i < temp.Count; i++)
            {
                LoggerDataViewModel loggerDataViewModel = new LoggerDataViewModel();
                loggerDataViewModel.ForwardIndex = listForwardIndex[i].Value ?? 0;
                loggerDataViewModel.NetIndex = (listForwardIndex[i].Value ?? 0) - (listReverseIndex[i].Value ?? 0);
                loggerDataViewModel.FlowRate = (listForward[i].Value) ?? 0 - (listReverse[i].Value ?? 0);
                loggerDataViewModel.Pressure = (listPressure2[i].Value) ?? (listPressure1[i].Value ?? 0);
                loggerDataViewModel.ReverseIndex = listReverseIndex[i].Value ?? 0;
                loggerDataViewModel.TimeStamp = temp[i].TimeStamp;
                listLoggerDataViewModel.Add(loggerDataViewModel);
            }
            return listLoggerDataViewModel;
        }

        public List<LoggerDataViewModel> GetComplexLoggerDataForWebService(string siteID, DateTime startDate, DateTime endDate)
        {
            List<LoggerDataViewModel> listLoggerDataViewModel = new List<LoggerDataViewModel>();
            var site = _siteBL.GetSite(siteID);
            var loggerConfiguration = site.t_Logger_Configurations;
            double startHour = Convert.ToDouble(loggerConfiguration.StartHour);
            if (site.LoggerId.Contains("__"))//inventia
            {
                startDate = startDate.AddHours(startHour).AddSeconds(1).AddMilliseconds(1);
                endDate = endDate.AddDays(1).AddHours(startHour).AddSeconds(1);
            }
            else
            {
                startDate = startDate.AddHours(startHour).AddMilliseconds(1);
                endDate = endDate.AddDays(1).AddHours(startHour);
            }
            List<t_Logger_Data> listForward = new List<t_Logger_Data>();
            List<t_Logger_Data> listReverse = new List<t_Logger_Data>();
            List<t_Logger_Data> listPressure1 = new List<t_Logger_Data>();
            List<t_Logger_Data> listPressure2 = new List<t_Logger_Data>();
            //List<t_Logger_Data> listForwardIndex = new List<t_Logger_Data>();
            //List<t_Logger_Data> listReverseIndex = new List<t_Logger_Data>();
            try
            {
                if (loggerConfiguration.ForwardFlow != null)
                {
                    string channelForward = "";
                    //string channelForward = loggerConfiguration.LoggerId + "_" + string.Format("{0:00}", loggerConfiguration.ForwardFlow);
                    channelForward = _channelConfigurationBL.GetChannelConfigurationByType(loggerConfiguration.LoggerId, "f").ChannelId;

                    listForward = _loggerDataBL.GetLoggerData(channelForward, startDate, endDate);
                    //listForwardIndex = _loggerDataBL.GetLoggerIndex(channelForward, startDate, endDate);
                }
            }
            catch (Exception ex)
            {
                //throw ex;
            }

            try
            {
                if (loggerConfiguration.ReverseFlow != null)
                {
                    string channelReverse = "";
                    //string channelReverse = loggerConfiguration.LoggerId + "_" + string.Format("{0:00}", loggerConfiguration.ReverseFlow);
                    channelReverse = _channelConfigurationBL.GetChannelConfigurationByType(loggerConfiguration.LoggerId, "r").ChannelId;

                    listReverse = _loggerDataBL.GetLoggerData(channelReverse, startDate, endDate);
                    //listReverseIndex = _loggerDataBL.GetLoggerIndex(channelReverse, startDate, endDate);
                }
            }
            catch (Exception ex)
            {
                //throw ex;
            }

            try
            {
                if (loggerConfiguration.Pressure1 != null)
                {
                    string channelPressure1 = "";
                    //string channelPressure1 = loggerConfiguration.LoggerId + "_" + string.Format("{0:00}", loggerConfiguration.Pressure1);
                    channelPressure1 = _channelConfigurationBL.GetChannelConfigurationByType(loggerConfiguration.LoggerId, "p1").ChannelId;

                    listPressure1 = _loggerDataBL.GetLoggerData(channelPressure1, startDate, endDate);
                }
            }
            catch (Exception ex)
            {
                //throw ex;
            }

            try
            {
                if (loggerConfiguration.Pressure2 != null)
                {
                    string channelPressure2 = "";
                    //string channelPressure2 = loggerConfiguration.LoggerId + "_" + string.Format("{0:00}", loggerConfiguration.Pressure2);
                    channelPressure2 = _channelConfigurationBL.GetChannelConfigurationByType(loggerConfiguration.LoggerId, "p2").ChannelId;

                    listPressure2 = _loggerDataBL.GetLoggerData(channelPressure2, startDate, endDate);
                }
            }
            catch (Exception ex)
            {
                //throw ex;
            }

            List<t_Logger_Data> temp = new List<t_Logger_Data>();
            if (listForward.Count != 0)
            {
                temp = listForward;
                goto t;
            }
            if (listReverse.Count != 0)
            {
                temp = listReverse;
                goto t;
            }
            if (listPressure1.Count != 0)
            {
                temp = listPressure1;
                goto t;
            }
            if (listPressure2.Count != 0)
            {
                temp = listPressure2;
            }
        t:
            if (listForward.Count == 0)
            {
                foreach (var item in temp)
                {
                    t_Logger_Data t = new t_Logger_Data();
                    t.TimeStamp = item.TimeStamp;
                    listForward.Add(t);
                }
            }
            if (listReverse.Count == 0)
            {
                foreach (var item in temp)
                {
                    t_Logger_Data t = new t_Logger_Data();
                    t.TimeStamp = item.TimeStamp;
                    listReverse.Add(t);
                }
            }
            if (listPressure1.Count == 0)
            {
                foreach (var item in temp)
                {
                    t_Logger_Data t = new t_Logger_Data();
                    t.TimeStamp = item.TimeStamp;
                    listPressure1.Add(t);
                }
            }
            if (listPressure2.Count == 0)
            {
                foreach (var item in temp)
                {
                    t_Logger_Data t = new t_Logger_Data();
                    t.TimeStamp = item.TimeStamp;
                    listPressure2.Add(t);
                }
            }
            //if (listForwardIndex.Count == 0)
            //{
            //    foreach (var item in temp)
            //    {
            //        t_Logger_Data t = new t_Logger_Data();
            //        t.TimeStamp = item.TimeStamp;
            //        listForwardIndex.Add(t);
            //    }
            //}
            //if (listReverseIndex.Count == 0)
            //{
            //    foreach (var item in temp)
            //    {
            //        t_Logger_Data t = new t_Logger_Data();
            //        t.TimeStamp = item.TimeStamp;
            //        listReverseIndex.Add(t);
            //    }
            //}
            //double interval = temp[1].TimeStamp.Subtract(temp[0].TimeStamp).TotalMinutes;
            //double mul = interval / 60;
            for (int i = 0; i < temp.Count; i++)
            {
                LoggerDataViewModel loggerDataViewModel = new LoggerDataViewModel();
                //loggerDataViewModel.ForwardIndex = listForwardIndex[i].Value ?? 0;
                //loggerDataViewModel.NetIndex = listForwardIndex[i].Value ?? 0 - listReverseIndex[i].Value ?? 0;
                loggerDataViewModel.FlowRate = listForward[i].Value ?? 0 - listReverse[i].Value ?? 0;
                loggerDataViewModel.Pressure = listPressure2[i].Value ?? listPressure1[i].Value ?? 0;
                //loggerDataViewModel.ReverseIndex = listReverseIndex[i].Value ?? 0;
                loggerDataViewModel.TimeStamp = temp[i].TimeStamp;
                listLoggerDataViewModel.Add(loggerDataViewModel);
            }
            return listLoggerDataViewModel;
        }
    }
}