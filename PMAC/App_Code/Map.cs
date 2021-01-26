using PMAC.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using PMAC.ULT;
using System.Configuration;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Text;
using System.Data;
using System.Net.Sockets;
using PMAC.DAL;
using System.Activities.Statements;

/// <summary>
/// Summary description for Map
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Map : System.Web.Services.WebService
{
    private DBEntities context = new DBEntities();
    System.Globalization.CultureInfo cu = new System.Globalization.CultureInfo("en-GB");
    public Map()
    {
        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }
    [WebMethod]
    public List<t_TakeSampleHistory> GetTakeSampleHistory(string username)
    {
        UserBL _userBL = new UserBL();
        var user = _userBL.GetUser(username);
        if (user.Role != "admin")
        {
            return context.t_TakeSampleHistory.Where(s => s.UserTake == username).OrderByDescending(x => x.TimeStamp).ToList();
        }
        else
        {
            return context.t_TakeSampleHistory.OrderByDescending(x => x.TimeStamp).ToList();
        }

    }
    [WebMethod]
    public List<GroupLogger> GetDataAll(string username)
    {
        var siteBL = new SiteBL();
        UserBL _userBL = new UserBL();

        var user = _userBL.GetUser(username);
        List<t_SiteCustomer> sites;
        if (user.Role == "consumer")
        {
            sites = siteBL.GetSitesForMapByConsumerIdCustom(user.ConsumerId).ToList();
        }
        else if (user.Role == "staff")
        {
            sites = siteBL.GetSitesForMapByStaffIdCustom(user.StaffId).ToList();
        }
        else
        {
            sites = siteBL.GetSitesForMapCustom().ToList();
            // sites = null;
        }
        List<GroupLogger> groupLoggers = new List<GroupLogger>();
        var index = 0;
        foreach (var item in sites)
        {
            var flag = true;
            GroupLogger groupLogger = new GroupLogger();
            if (index == 0)
            {
                groupLogger.DisplayGroup = item.DisplayGroup;
                groupLogger.Name = item.Name;
                groupLoggers.Add(groupLogger);
            }
            else
            {
                foreach (var gr in groupLoggers)
                {
                    if (gr.DisplayGroup == item.DisplayGroup)
                    {
                        flag = false;
                        break;
                    }
                }
                if (flag)
                {
                    groupLogger.DisplayGroup = item.DisplayGroup;
                    groupLogger.Name = item.Name;
                    groupLoggers.Add(groupLogger);
                }
            }
            index++;
        }

        foreach (var gr in groupLoggers)
        {
            var x = from s in sites
                    where s.DisplayGroup == gr.DisplayGroup
                    select new DataAll
                    {
                        SiteId = s.SiteId,
                        SiteAliasName = s.SiteAliasName,
                        Location = s.Location,
                        Latitude = (double)s.Latitude,
                        Longitude = (double)s.Longitude,
                        LoggerId = s.LoggerId,
                        LabelAnchorX = s.LabelAnchorX,
                        LabelAnchorY = s.LabelAnchorY
                    };
            gr.lstDataAll = x.ToList();
            var channelConfigurationBL = new ChannelConfigurationBL();
            foreach (var item in gr.lstDataAll)
            {
                var groupchannel = channelConfigurationBL.GetChannelConfigurationsByLoggerID(item.LoggerId).ToList();
                var countGroupCN = 0;
                List<GroupChannels> groupChannels = new List<GroupChannels>();
                foreach (var cn in groupchannel)
                {
                    var flag = true;
                    GroupChannels groupChannel = new GroupChannels();
                    if (countGroupCN == 0)
                    {
                        groupChannel.GroupChannel = cn.GroupChannel;
                        groupChannels.Add(groupChannel);
                    }
                    else
                    {
                        foreach (var grc in groupChannels)
                        {
                            if (grc.GroupChannel == cn.GroupChannel)
                            {
                                flag = false;
                                break;
                            }
                        }
                        if (flag)
                        {
                            groupChannel.GroupChannel = cn.GroupChannel;
                            groupChannels.Add(groupChannel);
                        }
                    }
                    countGroupCN++;
                }

                item.lstGroupChannels = groupChannels;

                var s = sites.Find(site => site.LoggerId == item.LoggerId);
                int? setDelayTime = s.SetDelayTime != null ? s.SetDelayTime : 60;
                double? setDiffValue = s.SetDiffValue != null ? s.SetDiffValue : 0.3;
                int status = 0;

                foreach (var itemCN in item.lstGroupChannels)
                {
                    var st = from c in channelConfigurationBL.GetChannelConfigurationsByLoggerID(item.LoggerId)
                             where c.GroupChannel == itemCN.GroupChannel
                             select new MChannel
                             {
                                 Status = setStatus(c.ChannelId, c.LastValue, c.TimeStamp, setDelayTime, setDiffValue, c.Pressure1, c.Pressure2),
                             };
                    foreach (var itemST in st)
                    {
                        if (itemST.Status > 1)
                        {
                            status = itemST.Status;
                            break;
                        }
                    }
                }
                foreach (var itemCN in item.lstGroupChannels)
                {
                    var y = from c in channelConfigurationBL.GetChannelConfigurationsByLoggerID(item.LoggerId)
                            where c.GroupChannel == itemCN.GroupChannel
                            select new MChannel
                            {
                                ChannelId = c.ChannelId,
                                LoggerId = c.LoggerId,
                                ChannelName = c.ChannelName,
                                Unit = c.Unit,
                                Description = c.Description,
                                ForwardFlow = c.ForwardFlow,
                                ReverseFlow = c.ReverseFlow,

                                TimeStamp = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).ToString("dd/MM/yyyy HH:mm"),
                                yyyy = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Year.ToString(),
                                MM = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Month.ToString(),
                                dd = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Day.ToString(),
                                HH = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Hour.ToString(),
                                mm = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Minute.ToString(),

                                LastValue = c.LastValue == null ? "NO DATA" : ((double)c.LastValue).ToString("0.00"),
                                LastIndex = c.LastIndex == null ? "" : ((double)c.LastIndex).ToString(),
                                Status = status,
                            };
                    itemCN.Channels = y.ToList();
                }
            }
        }

        return groupLoggers;
    }

    private int setStatus(string channelID, double? value, DateTime? timestamp, int? delayTime, double? diffValue, bool? pressure1, bool? pressure2)
    {
        if (timestamp != null && (DateTime.Now - (DateTime)timestamp).TotalMinutes >= delayTime)
        {
            return 2;
        }
        if (pressure1 == true || pressure2 == true)
        {
            if (value <= 0 || value == null)
            {
                return 4;
            }
            if (timestamp != null && value != null)
            {
                var result = context.Database.SqlQuery<LoggerData>("p_Data_Logger_Get @ChannelID, @StartDate, @EndDate",
                             new SqlParameter("StartDate", ((DateTime)timestamp).AddDays(-1).ToString("yyyy-MM-dd HH:mm")),
                             new SqlParameter("EndDate", ((DateTime)timestamp).AddDays(-1).ToString("yyyy-MM-dd HH:mm")),
                             new SqlParameter("ChannelID", channelID)).OrderByDescending(d => d.TimeStamp).FirstOrDefault();
                try
                {
                    if (value != null && (((double)value <= ((double)result.Value) * (1 - diffValue)) || ((double)value >= ((double)result.Value) * (1 + diffValue))))
                    {
                        return 3;
                    }
                }
                catch
                {
                    return 4;
                }

            }
        }
        return 1;
    }


    /*[WebMethod]
       public List<M_Channel_All> GetChannelAll()
       {
           ChannelConfigurationBL _channelConfigurationBL = new ChannelConfigurationBL();

           var x = from s in _channelConfigurationBL.GetchannelAll()
                   select new M_Channel_All
                   {
                       ChannelId = s.ChannelId,
                       LoggerId = s.LoggerId,
                       ChannelName = s.ChannelName                    
                   };

           List<M_Channel_All> t = x.ToList();


           return t.OrderBy(d => d.ChannelId).ToList();

       }*/
    [WebMethod]
    public List<LoggerData> Getchanneldetail(string channel, string startDate, string endDate, bool isGraph)
    {
        DateTime start = DateTime.Parse(startDate, cu);
        start = start.AddHours(-6);
        DateTime end = DateTime.Parse(endDate, cu);
        end = end.AddHours(12);
        if (isGraph == true)
        {
            return context.Database.SqlQuery<LoggerData>("p_Data_Logger_Get @ChannelID, @StartDate, @EndDate",
                  new SqlParameter("StartDate", start),
                  new SqlParameter("EndDate", end),
                  new SqlParameter("ChannelID", channel)).OrderBy(d => d.TimeStamp).ToList();
        }
        else
        {
            return context.Database.SqlQuery<LoggerData>("p_Data_Logger_Get @ChannelID, @StartDate, @EndDate",
                  new SqlParameter("StartDate", start),
                  new SqlParameter("EndDate", end),
                  new SqlParameter("ChannelID", channel)).OrderByDescending(d => d.TimeStamp).ToList();
        }
    }

    [WebMethod]
    public List<DisplayGroup> GetGroupSite()
    {
        var result = context.t_DisplayGroups.ToList();
        var model = (from d in result
                     select new DisplayGroup
                     {
                         Group = d.Group
                     }).ToList();

        return model;
    }

    [WebMethod]
    public List<MSite> GetSiteByGroupSite(string groupSite)
    {
        SiteBL _siteBL = new SiteBL();
        var sourceSite = _siteBL.GetSitesByDisplayGroup(groupSite);
        return (from m in sourceSite
                select new MSite
                {
                    SiteAliasName = m.SiteAliasName,
                    SiteId = m.SiteId
                }).ToList();
    }


    [WebMethod]
    public List<ChannelMultipleDataViewModel> GetMultipleChannelsData(string listChannelId, string startDate, string endDate)
    {
        DateTime start = DateTime.Parse(startDate, cu);
        start = start.AddHours(-6);
        DateTime end = DateTime.Parse(endDate, cu);
        end = end.AddHours(12);

        var lstChannel = listChannelId.Split('|');

        var dataTable = new DataTable();
        dataTable.Columns.Add("TimeStamp");
        foreach (var channel in lstChannel)
        {
            dataTable.Columns.Add(channel);

        }
        var index = 0;
        foreach (var channel in lstChannel)
        {

            var result = context.Database.SqlQuery<LoggerData>("p_Data_Logger_Get @ChannelID, @StartDate, @EndDate",
             new SqlParameter("StartDate", start),
             new SqlParameter("EndDate", end),
             new SqlParameter("ChannelID", channel)).OrderByDescending(d => d.TimeStamp).ToList();
            int row = 0;
            foreach (var item in result)
            {
                if (index == 0)
                {
                    dataTable.Rows.Add();
                    dataTable.Rows[row][index] = item.TimeStamp;
                    dataTable.Rows[row][index + 1] = item.Value ?? null;
                }
                else
                {
                    dataTable.Rows[row][index + 1] = item.Value ?? null;
                }
                row++;
            }
            index++;
        }
        List<ChannelMultipleDataViewModel> lst = new List<ChannelMultipleDataViewModel>();
        for (int i = 0; i < dataTable.Rows.Count; i++)
        {
            ChannelMultipleDataViewModel d = new ChannelMultipleDataViewModel();
            d.Timestamp = DateTime.Parse(dataTable.Rows[i][0].ToString());
            List<double?> vals = new List<double?>();
            for (int j = 1; j <= lstChannel.Length; j++)
            {
                if (dataTable.Rows[i][j] != null)
                {
                    vals.Add(double.Parse(dataTable.Rows[i][j].ToString()));
                }
                else
                {
                    vals.Add(null);
                }
            }
            d.Values = vals;
            lst.Add(d);
        }

        return lst;
    }



    [WebMethod]
    public toado LatLng(string userName)
    {
        toado list = new toado();
        var siteBL = new SiteBL();
        UserBL _userBL = new UserBL();

        var user = _userBL.GetUser(userName);
        List<t_Sites> sites;
        if (user.Role == "consumer")
        {
            sites = siteBL.GetSitesForMapByConsumerID(user.ConsumerId).ToList();
        }
        else if (user.Role == "staff")
        {
            sites = siteBL.GetSitesForMapByStaffId(user.StaffId).ToList();
        }
        else
        {
            sites = siteBL.GetSitesForMap().ToList();
            // sites = null;
        }
        if (sites.ToList().Count > 0)
        {
            list.Lat = sites.ToList()[0].Latitude.ToString();
            list.Lng = sites.ToList()[0].Longitude.ToString();
        }
        else
        {
            list.Lat = "20.261721";
            list.Lng = "105.969358";
        }
        return list;
    }
    [WebMethod]
    public logo Logo(string path)
    {
        logo list = new logo();

        list.Path = "http://113.161.76.112:6767/logo_consumer125.png";


        return list;
    }
    [WebMethod]
    public mySite GetSite(string siteID)
    {
        SiteBL _siteBL = new SiteBL();
        mySite ms = new mySite();
        var s = _siteBL.GetSite(siteID);
        ms.SiteID = s.SiteAliasName;
        return ms;
    }
    [WebMethod]
    public myLogin Dologin(string user, string pass)
    {
        myLogin list = new myLogin();
        UserBL _userBL = new UserBL();
        StringUT _stringUT = new StringUT();
        t_Users dbUser = _userBL.GetUser(user);
        if (dbUser != null)
        {
            string hashedPassword = _stringUT.HashMD5(_stringUT.HashMD5(pass) + dbUser.Salt);
            if (string.Equals(hashedPassword, dbUser.Password))
                list.username = dbUser.Username;
        }
        return list;
    }
    /*
    [WebMethod]
    public List<LoggerDataViewModel> GetLoggerDataViewModel(string siteID, string startDate, string endDate)
    {
        LoggerDataHelper _loggerDataHelper = new LoggerDataHelper();
        return _loggerDataHelper.GetComplexLoggerDataForWebService(siteID, startDate, endDate);
    }
   */

    [WebMethod]
    public List<ComplexData> GetCustomSearch(string search)
    {
        return context.Database.SqlQuery<ComplexData>("exec CustomSearch @search", new SqlParameter("search", search)).ToList();
    }
    [WebMethod]
    public List<ComplexData> GetCustomComplexDataForSiteId(string SiteId)
    {
        return context.Database.SqlQuery<ComplexData>("exec p_ComplexData_Select_For_Site @SiteId", new SqlParameter("SiteId", SiteId)).ToList();
    }

    [WebMethod]
    public List<ComplexData> GetCustomComplexData()
    {
        return context.Database.SqlQuery<ComplexData>("exec p_ComplexData_Select_Faster").ToList();
    }

    [WebMethod]
    public List<MSite> GetSitesForMap(string username)
    {
        var siteBL = new SiteBL();
        UserBL _userBL = new UserBL();

        var user = _userBL.GetUser(username);
        List<t_Sites> sites;
        if (user.Role == "consumer")
        {
            sites = siteBL.GetSitesForMapByConsumerID(user.ConsumerId).ToList();
        }
        else if (user.Role == "staff")
        {
            sites = siteBL.GetSitesForMapByStaffId(user.StaffId).ToList();
        }
        else
        {
            sites = siteBL.GetSitesForMap().ToList();
            // sites = null;
        }

        // var x = from s in siteBL.GetSitesForMap()
        var x = from s in sites
                select new MSite
                {
                    SiteId = s.SiteId,
                    SiteAliasName = s.SiteAliasName,
                    Location = s.Location,
                    Latitude = (double)s.Latitude,
                    Longitude = (double)s.Longitude,
                    LoggerId = s.LoggerId,
                    LabelAnchorX = s.LabelAnchorX,
                    LabelAnchorY = s.LabelAnchorY,
                    DisplayGroup = s.DisplayGroup
                };

        List<MSite> t = x.ToList();
        var loggerBL = new LoggerConfigurationBL();
        foreach (MSite item in t)
        {
            var y = loggerBL.GetLoggerConfiguration(item.LoggerId);
            // item.Status1 = y.Status1;
            // item.Status2 = y.Status2;
            //item.TimeDelayAlarm = y.TimeDelayAlarm ?? 0;
        }

        return t.OrderBy(d => d.DisplayGroup).ThenBy(n => n.SiteAliasName).ToList();

    }

    [WebMethod]
    public List<MSite> GetSitesForMapNonAdmin()
    {
        var _siteBL = new SiteBL();
        UserBL _userBL = new UserBL();

        var user = _userBL.GetUser(HttpContext.Current.User.Identity.Name);
        List<t_Sites> sites;
        if (user.Role == "consumer")
        {
            sites = _siteBL.GetSitesForMapByConsumerID(user.ConsumerId).ToList();
        }
        else if (user.Role == "staff")
        {
            sites = _siteBL.GetSitesForMapByStaffId(user.StaffId).ToList();
        }
        else
        {
            sites = null;
        }


        var x = from s in sites
                select new MSite
                {
                    SiteId = s.SiteId,
                    SiteAliasName = s.SiteAliasName,
                    Location = s.Location,
                    Latitude = (double)s.Latitude,
                    Longitude = (double)s.Longitude,
                    LoggerId = s.LoggerId,
                    LabelAnchorX = s.LabelAnchorX,
                    LabelAnchorY = s.LabelAnchorY,
                    DisplayGroup = s.DisplayGroup
                };

        List<MSite> t = x.ToList();
        var loggerBL = new LoggerConfigurationBL();
        foreach (MSite item in t)
        {
            var y = loggerBL.GetLoggerConfiguration(item.LoggerId);
            //  item.Status1 = y.Status1;
            // item.Status2 = y.Status2;
            // item.TimeDelayAlarm = y.TimeDelayAlarm ?? 0;
        }

        return t.OrderBy(d => d.DisplayGroup).ThenBy(n => n.SiteAliasName).ToList();

    }

    private string serverKey = "AAAAfbAp3hY:APA91bFTHqH3LN-L-WuPmgbmoC97TMNGTczCq-E4aI_7rxgDaiw3JMkMGisS-jJVBjY0hvAXd_JzowQN006PBrudZwIQHUQA98RUnjFM5fcCm0Onn8L7mpQN7cjv--EYfZdJ7sE8SnXn";
    private string senderId = "539826445846";
    private string webAddr = "https://fcm.googleapis.com/fcm/send";
    [WebMethod]
    public string SendNotification(string DeviceToken, string title, string msg)
    {
        var result = "-1";
        var httpWebRequest = (HttpWebRequest)WebRequest.Create(webAddr);
        httpWebRequest.ContentType = "application/json";
        httpWebRequest.Headers.Add(string.Format("Authorization: key={0}", serverKey));
        httpWebRequest.Headers.Add(string.Format("Sender: id={0}", senderId));
        httpWebRequest.Method = "POST";

        var payload = new
        {
            to = DeviceToken,
            priority = "high",
            content_available = true,
            notification = new
            {
                body = msg,
                title = title
            },
        };
        var serializer = new JavaScriptSerializer();
        using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
        {
            string json = serializer.Serialize(payload);
            streamWriter.Write(json);
            streamWriter.Flush();
        }

        var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
        using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
        {
            result = streamReader.ReadToEnd();
        }
        return result;
    }

    public List<string> GetListDeviceTokenByUsers(string SiteId)
    {
        var listString = new List<string>();
        var result = context.Database.SqlQuery<DeviceTokenApp>("exec p_GetDataDeviceToken @SiteId",
            new SqlParameter("SiteId", SiteId)
            ).ToList();

        foreach (var item in result)
        {
            listString.Add(item.DeviceToken.ToString());
        }
        return listString;
    }

    [WebMethod]
    public bool SubmitNotification(string loggerID, string title, string body)
    {
        var _loggerConfigurationBL = new LoggerConfigurationBL();
        var loggerConfiguration = _loggerConfigurationBL.GetLoggerConfiguration(loggerID);
        var SiteId = loggerConfiguration.SiteId;
        var listToken = GetListDeviceTokenByUsers(SiteId);
        PushNotification(listToken, title, body);
        return true;
    }

    [WebMethod]
    public void PushNotification(List<string> fcmToken, string titleNoti, string bodyNoti)
    {
        for (int i = 0; i < fcmToken.Count; i++)
        {
            //check status sound
            try
            {
                //server key meesapp
                //cannot update applicationID
                var applicationID = "AAAAJye0M2Q:APA91bFAPFp2nDnEuhi7H9Z40nYX9mG5HOQLOdJKEdUfcBPfxZBRwbhq6nZwRspb3uQmOZSM7uK_h1O_nygBp-xnhZx55OQLBp0Tbkqhc2_QsmfYyChXxbkrGKsTIhQTV2kFFbuGveXH";
                var senderId = "168169845604";
                HttpWebRequest tRequest = (HttpWebRequest)WebRequest.Create("https://fcm.googleapis.com/fcm/send");
                tRequest.Method = "post";
                tRequest.ContentType = "application/json";
                var data = new
                {
                    to = fcmToken[i],
                    notification = new
                    {
                        body = bodyNoti,
                        title = titleNoti,
                        // android_sound = "",
                        // Volume = 0.0
                        icon = "ic_launcher.png"
                    }
                };

                var serializer = new JavaScriptSerializer();

                var json = serializer.Serialize(data);

                Byte[] byteArray = Encoding.UTF8.GetBytes(json);

                tRequest.Headers.Add(string.Format("Authorization: key={0}", applicationID));

                tRequest.Headers.Add(string.Format("Sender: id={0}", senderId));

                tRequest.ContentLength = byteArray.Length;
                //add new
                tRequest.UseDefaultCredentials = true;
                tRequest.PreAuthenticate = true;
                tRequest.Credentials = CredentialCache.DefaultCredentials;
                //add new
                using (Stream dataStream = tRequest.GetRequestStream())
                {
                    dataStream.Write(byteArray, 0, byteArray.Length);
                    using (WebResponse tResponse = tRequest.GetResponse())
                    {
                        using (Stream dataStreamResponse = tResponse.GetResponseStream())
                        {
                            using (StreamReader tReader = new StreamReader(dataStreamResponse))
                            {
                                String sResponseFromServer = tReader.ReadToEnd();
                                string str = sResponseFromServer;
                            }
                        }
                    }
                }
            }

            catch (Exception ex)
            {

                string str = ex.Message;

            }
        }
    }


    [WebMethod]
    public List<AlarmAll> GetAlarm(string username)
    {
        List<AlarmAll> lst = new List<AlarmAll>();

        try
        {
            var _siteBL = new SiteBL();
            UserBL _userBL = new UserBL();
            var user = _userBL.GetUser(username);
            List<t_Sites> sites;
            if (user.Role == "consumer")
            {
                sites = _siteBL.GetSitesForMapByConsumerID(user.ConsumerId).ToList();
            }
            else if (user.Role == "staff")
            {
                sites = _siteBL.GetSitesForMapByStaffId(user.StaffId).ToList();
            }
            else
            {
                sites = _siteBL.GetSites().ToList();
            }

            foreach (var item in sites)
            {
                var flagLooger = false;
                AlarmAll alarmAll = new AlarmAll();
                alarmAll.LoggerId = item.LoggerId;
                alarmAll.SiteAliasName = item.SiteAliasName;
                alarmAll.SiteId = item.SiteId;

                var channelConfigurationBL = new ChannelConfigurationBL();

                var channels = channelConfigurationBL.GetAlarmChannelByLoggerID(item.LoggerId);

                List<Alarm> lstAlarm = new List<Alarm>();
                foreach (var channel in channels)
                {
                    Alarm alarm = new Alarm();
                    int? delayTime = item.SetDelayTime != null ? item.SetDelayTime : 60;

                    if (channel.TimeStamp != null)
                    {
                        alarm.TimeStamp = channel.TimeStamp;
                    }

                    if (channel.LastValue != null)
                    {
                        alarm.LastValue = channel.LastValue ?? 0;
                    }

                    if (channel.basemin != null)
                    {
                        if (channel.LastValue < channel.basemin)
                        {
                            Alarm iAlarm = new Alarm();
                            iAlarm.ChannelName = channel.ChannelName;
                            iAlarm.Unit = channel.Unit;
                            iAlarm.ChannelId = channel.ChannelId;
                            iAlarm.StatusViewAlarm = channel.StatusViewAlarm;
                            if (channel.TimeStamp != null)
                            {
                                iAlarm.TimeStamp = channel.TimeStamp;
                            }
                            if (channel.LastValue != null)
                            {
                                iAlarm.LastValue = channel.LastValue ?? 0;
                            }
                            iAlarm.Description = "Low";
                            lstAlarm.Add(iAlarm);
                            flagLooger = true;
                        }
                    }
                    if (channel.basemax != null)
                    {
                        if (channel.LastValue > channel.basemax)
                        {
                            Alarm iAlarm = new Alarm();
                            iAlarm.ChannelName = channel.ChannelName;
                            iAlarm.Unit = channel.Unit;
                            iAlarm.ChannelId = channel.ChannelId;
                            iAlarm.StatusViewAlarm = channel.StatusViewAlarm;
                            if (channel.TimeStamp != null)
                            {
                                iAlarm.TimeStamp = channel.TimeStamp;
                            }
                            if (channel.LastValue != null)
                            {
                                iAlarm.LastValue = channel.LastValue ?? 0;
                            }
                            iAlarm.Description = "High";
                            lstAlarm.Add(iAlarm);
                            flagLooger = true;
                        }
                    }

                    if (channel.Baseline != null)
                    {
                        if (channel.LastValue > channel.Baseline)
                        {
                            Alarm iAlarm = new Alarm();
                            iAlarm.ChannelName = channel.ChannelName;
                            iAlarm.Unit = channel.Unit;
                            iAlarm.ChannelId = channel.ChannelId;
                            iAlarm.StatusViewAlarm = channel.StatusViewAlarm;
                            if (channel.TimeStamp != null)
                            {
                                iAlarm.TimeStamp = channel.TimeStamp;
                            }
                            if (channel.LastValue != null)
                            {
                                iAlarm.LastValue = channel.LastValue ?? 0;
                            }
                            iAlarm.Description = "Baseline";
                            lstAlarm.Add(iAlarm);
                            flagLooger = true;
                        }
                    }

                    if (channel.TimeStamp != null)
                    {
                        if ((DateTime.Now - (DateTime)channel.TimeStamp).TotalMinutes >= delayTime)
                        {
                            Alarm iAlarm = new Alarm();
                            iAlarm.ChannelName = channel.ChannelName;
                            iAlarm.Unit = channel.Unit;
                            iAlarm.ChannelId = channel.ChannelId;
                            iAlarm.StatusViewAlarm = channel.StatusViewAlarm;
                            if (channel.TimeStamp != null)
                            {
                                iAlarm.TimeStamp = channel.TimeStamp;
                            }
                            if (channel.LastValue != null)
                            {
                                iAlarm.LastValue = channel.LastValue ?? 0;
                            }
                            iAlarm.Description = "Delay";
                            lstAlarm.Add(iAlarm);
                            flagLooger = true;
                        }
                    }
                }
                alarmAll.Alarms = lstAlarm;
                if (flagLooger)
                {
                    lst.Add(alarmAll);
                }
            }
        }
        catch (Exception ex)
        {
            AlarmAll alarmAll = new AlarmAll();
            alarmAll.SiteAliasName = ex.Message;
            lst.Add(alarmAll);
            return lst;
        }
        return lst;
    }

    [WebMethod]
    public bool ConfirmAlarm(string username)
    {
        try
        {
            var _siteBL = new SiteBL();
            UserBL _userBL = new UserBL();
            var user = _userBL.GetUser(username);
            List<t_Sites> sites;
            if (user.Role == "consumer")
            {
                sites = _siteBL.GetSitesForMapByConsumerID(user.ConsumerId).ToList();
            }
            else if (user.Role == "staff")
            {
                sites = _siteBL.GetSitesForMapByStaffId(user.StaffId).ToList();
            }
            else
            {
                sites = _siteBL.GetSites().ToList();
            }

            foreach (var item in sites)
            {
                var channelConfigurationBL = new ChannelConfigurationBL();
                var channels = channelConfigurationBL.ConfirmAlarmByLoggerID(item.LoggerId);
                if (channels == false)
                {
                    return false;
                }
            }
            return true;
        }
        catch (Exception)
        {
            return false;
        }
    }



    [WebMethod]
    public int GetCountAlamr(string username)
    {
        int count = 0;
        var alarms = GetAlarm(username);
        foreach (var item in alarms)
        {
            foreach (var cn in item.Alarms)
            {
                count++;
            }
        }
        return count;
    }

    [WebMethod]
    public List<MChannel> GetChannelConfigurationsByLoggerID(string loggerId)
    {
        var channelConfigurationBL = new ChannelConfigurationBL();
        var x = from c in channelConfigurationBL.GetChannelConfigurationsByLoggerID(loggerId)
                select new MChannel
                {
                    ChannelId = c.ChannelId,
                    LoggerId = c.LoggerId,
                    ChannelName = c.ChannelName,
                    Unit = c.Unit,
                    Description = c.Description,

                    TimeStamp = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).ToString("dd/MM/yyyy HH:mm"),
                    yyyy = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Year.ToString(),
                    MM = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Month.ToString(),
                    dd = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Day.ToString(),
                    HH = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Hour.ToString(),
                    mm = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Minute.ToString(),

                    LastValue = c.LastValue == null ? "NO DATA" : ((double)c.LastValue).ToString("0.00"),
                    LastIndex = c.LastIndex == null ? "" : ((double)c.LastIndex).ToString("0,0"),
                    // DisplayOnLabel = c.DisplayOnLabel == null ? false : bool.Parse(c.DisplayOnLabel.ToString())
                };

        return x.OrderBy(d => d.ChannelName).ToList();
    }
    [WebMethod]
    public List<MChannelNew> GetChannelLoggerID(string loggerId)
    {
        var channelConfigurationBL = new ChannelConfigurationBL();
        var x = from c in channelConfigurationBL.GetChannelConfigurationsByLoggerID(loggerId)
                select new MChannelNew
                {
                    ChannelId = c.ChannelId,
                    LoggerId = c.LoggerId,
                    ChannelName = c.ChannelName,
                };
        return x.OrderBy(d => d.ChannelName).ToList();
    }
    [WebMethod]
    public List<MSite> GetSitesByUid(string username)
    {
        UserBL _userBL = new UserBL();
        var siteBL = new SiteBL();
        var user = _userBL.GetUser(username);

        List<MSite> lst = new List<MSite>();
        List<t_Sites> sites;
        if (user.Role == "consumer")
        {
            sites = siteBL.GetSitesForMapByConsumerID(user.ConsumerId).ToList();
        }
        else if (user.Role == "staff")
        {
            sites = siteBL.GetSitesForMapByStaffId(user.StaffId).ToList();
        }
        else
        {
            sites = siteBL.GetSitesForMap().ToList();
            // sites = null;
        }

        var x = from s in sites
                select new MSite
                {
                    SiteId = s.SiteId,
                    SiteAliasName = s.SiteAliasName,
                    Location = s.Location,
                    Latitude = (double)s.Latitude,
                    Longitude = (double)s.Longitude,
                    LoggerId = s.LoggerId,
                    LabelAnchorX = s.LabelAnchorX,
                    LabelAnchorY = s.LabelAnchorY,
                    DisplayGroup = s.DisplayGroup
                };
        lst = x.ToList();
        return lst;
    }

    [WebMethod]
    public List<MSampler> GetListDataControl(string userName)
    {
        UserBL _userBL = new UserBL();
        var user = _userBL.GetUser(userName);
        if (user.Role == "consumer")
        {
            return context.Database.SqlQuery<MSampler>("p_getListControlSampler_consumer @userName",
             new SqlParameter("userName", userName)).ToList();
        }
        else if (user.Role == "staff")
        {
            return context.Database.SqlQuery<MSampler>("p_getListControlSampler_staff @userName",
            new SqlParameter("userName", userName)).ToList();
        }
        else
        {
            return context.Database.SqlQuery<MSampler>("p_getListControlSampler @userName",
             new SqlParameter("userName", userName)).ToList();
            // sites = null;
        }

    }


    [WebMethod]
    public result_sampler ControlSampler(string siteid, string ip, string port, string username)
    {
        TakeSampleHistoryBL _samHisBL = new TakeSampleHistoryBL();
        result_sampler r = new result_sampler();
        string host_name = ip;
        int PORT_NUMBER = int.Parse(port);
        var isSuccess = false;
        if (host_name == "113.161.76.112" && PORT_NUMBER == 443)
        {
            r.Result = "1";//->1 success, 0 warning
            r.Knumber = "4";// ->sô k
            isSuccess = true;
        }
        else
        {
            r.Result = "0";//->1 success, 0 warning
            r.Knumber = "4";// ->sô k
            isSuccess = false;
        }
        //insert takehistory
        var samHis = new t_TakeSampleHistory();
        samHis.SiteID = siteid;
        samHis.TimeStamp = DateTime.Now;
        samHis.Status = isSuccess;
        samHis.Type = "Thủ công";
        samHis.UserTake = username;
        samHis.Description = "Lấy mẫu thủ công " + (isSuccess ? "Thành công" : "Thất bại") + " lúc " + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
        var isAdded = _samHisBL.AddTakeSampleHistory(samHis);
        return r;
    }

    [WebMethod]
    public result_sampler ResetSampler(string ip, string port, string partnerid)
    {
        result_sampler r = new result_sampler();
        string host_name = ip;
        int PORT_NUMBER = int.Parse(port);
        TcpClient clientreset = new TcpClient();

        // 1. connect
        clientreset.Connect(host_name, PORT_NUMBER);
        Stream stream2 = clientreset.GetStream();
        while (true)
        {
            string str = partnerid;
            var reader = new StreamReader(stream2);
            var writer = new StreamWriter(stream2);
            writer.AutoFlush = true;

            // 2. send
            string strcm = "$CMD03," + str + ",SMPRST#AB*";
            writer.WriteLine(strcm);
            r.Result = "Reset";
            break;
        }

        // 4. close
        stream2.Close();
        clientreset.Close();
        return r;
    }

    [WebMethod]
    public bool GetDeviceTokenFromApp(string username, string deviceToken)
    {
        var result = context.Database.SqlQuery<DeviceTokenApp>("exec InsertDeviceToken @UserName, @Token",
            new SqlParameter("UserName", username),
             new SqlParameter("Token", deviceToken)
            ).ToList();


        return true;

    }

    [WebMethod]
    public bool UpdateStatusPushNoti(string token, bool status)
    {
        var result = context.Database.SqlQuery<DeviceTokenApp>("exec UpdateStatusPushNoti @Token, @Status",
            new SqlParameter("Token", token),
             new SqlParameter("Status", status)
            ).ToList();

        return true;

    }

    [WebMethod]
    public bool RemoveTokenLogoutApp(string token)
    {
        context.Database.SqlQuery<DeviceTokenApp>("exec p_RemoveTokenLogoutApp @Token",
            new SqlParameter("Token", token)
            ).ToList();

        return true;
    }

    [WebMethod]
    public ConfigLogger GetValueConfiglogger(string siteId)
    {
        ConfigLogger _configLogger = new ConfigLogger();
        SiteBL _siteBL = new SiteBL();
        var site = _siteBL.GetSite(siteId);
        if (site != null)
        {
            _configLogger.SiteAliasName = site.SiteAliasName;
            _configLogger.ConsumerId = site.ConsumerId;
            _configLogger.Description = site.Description;
            _configLogger.DisplayGroup = site.DisplayGroup;
            _configLogger.Latitude = site.Latitude.ToString();
            _configLogger.Location = site.Location;
            _configLogger.LoggerId = site.LoggerId;
            _configLogger.Longitude = site.Longitude.ToString();
            _configLogger.SiteId = site.SiteId;

            // if (site.StartDay != null)
            _configLogger.StartDay = site.StartDay.ToString();
            //  if (site.Zoom != null)
            _configLogger.Zoom = (byte)site.Zoom;
            if (site.t_Logger_Configurations != null)
            {
                _configLogger.StartHour = site.t_Logger_Configurations.StartHour.ToString();
                _configLogger.TelephoneNumber = site.t_Logger_Configurations.TelephoneNumber;
            }
            else
            {
                _configLogger.StartHour = "0";
                _configLogger.TelephoneNumber = string.Empty;
            }

            _configLogger.MeterSerial = site.MeterSerial;
            _configLogger.TransmitterSerial = site.TransmitterSerial;
            _configLogger.LoggerSerial = site.LoggerSerial;
            _configLogger.Status = site.Status;
            _configLogger.Availability = site.Availability;
            _configLogger.Staffs = site.Staffs;
            _configLogger.PipeSize = site.PipeSize;
            _configLogger.SetDiffValue = site.SetDiffValue.ToString();
            if (site.SetDiffValue != null)
            {
                _configLogger.SetDiffValue = ((double)site.SetDiffValue * 100).ToString();
            }
            _configLogger.SetDelayTime = site.SetDelayTime.ToString() ?? "0";
            _configLogger.DMA_In = site.DMA_In;
            _configLogger.DMA_Out = site.DMA_Out;
            _configLogger.Checked = site.DisplayOnGraph ?? false;

            MeterHistoryBL _meterHistoryBL = new MeterHistoryBL();
            TransmitterHistoryBL _transmitterHistoryBL = new TransmitterHistoryBL();
            LoggerHistoryBL _loggerHistoryBL = new LoggerHistoryBL();

            var meterHistory = _meterHistoryBL.GetLastMeterHistory(siteId);
            var transmitterHistory = _transmitterHistoryBL.GetLastTransmitterHistory(siteId);
            var loggerHistory = _loggerHistoryBL.GetLastLoggerHistory(siteId);
            if (meterHistory != null)
            {
                _configLogger.dtmMeterChanged = meterHistory.DateChanged.ToShortDateString();
            }
            if (transmitterHistory != null)
            {
                _configLogger.dtmTransmitterChanged = transmitterHistory.DateChanged.ToShortDateString();
            }
            if (loggerHistory != null)
            {
                _configLogger.dtmLoggerChanged = loggerHistory.DateChanged.ToShortDateString();
            }
        }
        return _configLogger;
    }


    [WebMethod]
    public List<MyCusComer> GetListCuscomer()
    {
        var cuscomerBUL = new ConsumerBL();
        var result = cuscomerBUL.GetConsumers();
        return (from u in result
                select new MyCusComer
                {
                    CuscomerId = u.ConsumerId,
                    Description = u.Description
                }).ToList();
    }

    [WebMethod]
    public List<tSiteStatus> GetAllSiteStatus()
    {
        var siteBL = new SiteStatusBL();
        var result = siteBL.GetAllSiteStatusForApp();
        var lstStatus = (from s in result
                         select new tSiteStatus
                         {
                             Description = s.Description,
                             Language = s.Language,
                             Status = s.Status
                         }).ToList();
        return lstStatus;
    }


    [WebMethod]
    public List<tSiteAvailabilities> GetAllSiteAvailabilities()
    {
        var siteBL = new SiteAvailabilityBL();
        var result = siteBL.GetAllSiteAvailabilitiesForApp();
        var lstStatus = (from s in result
                         select new tSiteAvailabilities
                         {
                             Description = s.Description,
                             Language = s.Language,
                             Availability = s.Availability
                         }).ToList();
        return lstStatus;
    }

    [WebMethod]

    public int InsertUpdateConfigLogger(ConfigLogger config)
    {
        try
        {
            SiteBL _siteBL = new SiteBL();
            LoggerConfigurationBL _loggerConfigurationBL = new LoggerConfigurationBL();
            var dbSite = _siteBL.GetSite(config.SiteId);
            var site = GetSite(config);
            var loggerConfiguration = GetLoggerConfiguration(config);

            var dbLoggerConfiguration = _loggerConfigurationBL.GetLoggerConfiguration(config.LoggerId);
            if (dbSite == null)
            {
                if (dbLoggerConfiguration == null)
                {
                    _loggerConfigurationBL.InsertLoggerConfiguration(loggerConfiguration);
                }
                else
                {
                    loggerConfiguration.ForwardFlow = dbLoggerConfiguration.ForwardFlow;
                    loggerConfiguration.Pressure1 = dbLoggerConfiguration.Pressure1;
                    loggerConfiguration.Pressure2 = dbLoggerConfiguration.Pressure2;
                    loggerConfiguration.ReverseFlow = dbLoggerConfiguration.ReverseFlow;
                    _loggerConfigurationBL.UpdateLoggerConfiguration(loggerConfiguration, dbLoggerConfiguration);
                }
                _siteBL.InsertSite(site);
                return 0;
            }
            else
            {

                if (dbLoggerConfiguration == null)
                {
                    _loggerConfigurationBL.InsertLoggerConfiguration(loggerConfiguration);
                }
                else
                {
                    loggerConfiguration.ForwardFlow = dbLoggerConfiguration.ForwardFlow;
                    loggerConfiguration.Pressure1 = dbLoggerConfiguration.Pressure1;
                    loggerConfiguration.Pressure2 = dbLoggerConfiguration.Pressure2;
                    loggerConfiguration.ReverseFlow = dbLoggerConfiguration.ReverseFlow;
                    _loggerConfigurationBL.UpdateLoggerConfiguration(loggerConfiguration, dbLoggerConfiguration);
                }
                _siteBL.UpdateSite(site, dbSite);
            }

            return 1;
        }
        catch (Exception ex)
        {

            return -1;
        }

    }



    private t_Logger_Configurations GetLoggerConfiguration(ConfigLogger config)
    {
        t_Logger_Configurations loggerConfiguration = new t_Logger_Configurations();
        loggerConfiguration.LoggerId = config.LoggerId;
        loggerConfiguration.SiteId = config.SiteId;
        int intStartHour;
        bool isNumericlati = int.TryParse(config.StartHour, out intStartHour);
        if (isNumericlati)
        {
            loggerConfiguration.StartHour = byte.Parse(intStartHour.ToString()); ;
        }

        loggerConfiguration.TelephoneNumber = config.TelephoneNumber;
        return loggerConfiguration;
    }
    private t_Sites GetSite(ConfigLogger config)
    {
        t_Sites site = new t_Sites();
        site.SiteAliasName = config.SiteAliasName;
        site.ConsumerId = config.ConsumerId;
        site.Description = config.Description;
        site.DisplayGroup = config.DisplayGroup;
        int lati;
        bool isNumericlati = int.TryParse(config.Latitude, out lati);
        if (isNumericlati)
        {
            site.Latitude = lati;
        }
        site.Location = config.Location;
        site.LoggerId = config.LoggerId;
        int lalog;
        bool isNumericlalong = int.TryParse(config.Longitude, out lalog);
        if (isNumericlalong)
        {
            site.Longitude = lalog;
        }

        site.SiteId = config.SiteId;
        int std;
        bool isNumericStartDay = int.TryParse(config.StartDay, out std);
        if (isNumericStartDay)
        {
            site.StartDay = byte.Parse(std.ToString());
        }

        int intzoom;
        bool isNumericintzoom = int.TryParse(config.StartDay, out intzoom);
        if (isNumericintzoom)
        {
            site.Zoom = byte.Parse(intzoom.ToString());
        }

        site.MeterSerial = string.IsNullOrEmpty(config.MeterSerial) ? null : config.MeterSerial;
        site.TransmitterSerial = string.IsNullOrEmpty(config.TransmitterSerial) ? null : config.TransmitterSerial;
        site.LoggerSerial = string.IsNullOrEmpty(config.LoggerSerial) ? null : config.LoggerSerial;
        site.Status = string.IsNullOrEmpty(config.Status) ? null : config.Status;
        site.Availability = string.IsNullOrEmpty(config.Availability) ? null : config.Availability;
        if (!string.IsNullOrEmpty(config.dtmMeterChanged))
        {
            site.MeterDateChanged = DateTime.Parse(config.dtmMeterChanged);
        }
        if (!string.IsNullOrEmpty(config.dtmTransmitterChanged))
        {
            site.TransmitterDateChanged = DateTime.Parse(config.dtmTransmitterChanged);
        }
        if (!string.IsNullOrEmpty(config.dtmLoggerChanged))
        {
            site.LoggerDateChanged = DateTime.Parse(config.dtmLoggerChanged);
        }
        site.Staffs = config.Staffs;
        site.PipeSize = config.PipeSize;

        int ndelay;
        bool isNumericdelayt = int.TryParse(config.SetDelayTime, out ndelay);
        if (isNumericdelayt)
        {
            site.SetDelayTime = ndelay;
        }

        int ndif;
        bool isNumericdif = int.TryParse(config.SetDiffValue, out ndif);
        if (isNumericdif)
        {
            site.SetDiffValue = ndif;
        }

        site.DMA_In = config.DMA_In;
        site.DMA_Out = config.DMA_Out;
        site.DisplayOnGraph = config.Checked;
        return site;
    }

    [WebMethod]
    public int DeleteSiteConfig(string siteId)
    {
        try
        {
            SiteBL _siteBL = new SiteBL();
            var site = _siteBL.GetSite(siteId);
            if (site != null)
            {
                _siteBL.DeleteSite(site);
            }
            else
            {
                return 0;
            }
        }
        catch (Exception)
        {
            return -1;
        }
        return 1;
    }
    [WebMethod]
    public List<tChannelConfigurations> GetChannelConfigByLoggerID(string loggerId)
    {
        ChannelConfigurationBL channelConfigurationBL = new ChannelConfigurationBL();
        var result = channelConfigurationBL.GetChannelConfigurationsByLoggerID(loggerId);
        return (from c in result
                select new tChannelConfigurations
                {
                    Baseline = c.Baseline.ToString(),
                    ChannelId = c.ChannelId,
                    LoggerId = c.LoggerId,
                    ChannelName = c.ChannelName,
                    Unit = c.Unit,
                    Description = c.Description,
                    Pressure1 = c.Pressure1,
                    Pressure2 = c.Pressure2,
                    ForwardFlow = c.ForwardFlow,
                    ReverseFlow = c.ReverseFlow,
                    TimeStamp = c.TimeStamp.ToString(),
                    LastValue = c.LastValue.ToString(),
                    IndexTimeStamp = c.IndexTimeStamp.ToString(),
                    LastIndex = c.LastIndex.ToString(),
                    DisplayOnLabel = c.DisplayOnLabel,
                    ChannelOther = c.ChannelOther,
                    basemin = c.basemin.ToString(),
                    basemax = c.basemax.ToString(),
                    GroupChannel = c.GroupChannel,
                    DisplayOnGraph = c.DisplayOnGraph,
                }).ToList();

    }

    [WebMethod]
    public tChannelConfigurations GetChannelByChannelId(string channelId)
    {
        ChannelConfigurationBL _channelConfigurationBL = new ChannelConfigurationBL();
        var channelConfiguration = _channelConfigurationBL.GetChannelConfiguration(channelId);
        tChannelConfigurations tChannel = new tChannelConfigurations();
        tChannel.ChannelId = channelConfiguration.ChannelId;
        tChannel.ChannelName = channelConfiguration.ChannelName;
        tChannel.Unit = channelConfiguration.Unit;
        tChannel.Description = channelConfiguration.Description;
        tChannel.ForwardFlow = channelConfiguration.ForwardFlow ?? false;
        tChannel.Pressure1 = channelConfiguration.Pressure1 ?? false;
        tChannel.Pressure2 = channelConfiguration.Pressure2 ?? false;
        tChannel.ReverseFlow = channelConfiguration.ReverseFlow ?? false;
        tChannel.basemin = channelConfiguration.basemin.ToString();
        tChannel.basemax = channelConfiguration.basemax.ToString();
        tChannel.GroupChannel = channelConfiguration.GroupChannel;
        tChannel.DisplayOnGraph = channelConfiguration.DisplayOnGraph ?? false;
        tChannel.DisplayOnLabel = channelConfiguration.DisplayOnLabel ?? false;
        tChannel.Baseline = channelConfiguration.Baseline.ToString();
        return tChannel;
    }

    [WebMethod]
    public int DeleteChannelById(string channelid)
    {
        try
        {
            ChannelConfigurationBL _channelConfigurationBL = new ChannelConfigurationBL();
            var channelConfiguration = _channelConfigurationBL.GetChannelConfiguration(channelid);

            if (channelConfiguration != null)
            {
                _channelConfigurationBL.DeleteChannelConfiguration(channelConfiguration);
            }
            else
            {
                return 0;
            }
        }
        catch (Exception)
        {
            return -1;
        }
        return 1;
    }

    [WebMethod]
    public int InsertUpdateChannelConfig(tChannelConfigurations tChannel)
    {
        if (string.IsNullOrEmpty(tChannel.ChannelOther.ToString()))
        {
            tChannel.ChannelOther = null;
        }
        ChannelConfigurationBL _channelConfigurationBL = new ChannelConfigurationBL();
        try
        {

            var dbChannelConfiguration = _channelConfigurationBL.GetChannelConfiguration(tChannel.ChannelId);
            var channelConfiguration = GetChannelConfiguration(tChannel);
            if (dbChannelConfiguration == null)
            {
                _channelConfigurationBL.InsertChannelConfiguration(channelConfiguration);
                return 0;
            }
            else
            {
                _channelConfigurationBL.UpdateChannelConfiguration(channelConfiguration, dbChannelConfiguration);
                return 1;
            }

        }
        catch (Exception)
        {

            return -1;
        }

    }



    [WebMethod]
    private t_Channel_Configurations GetChannelConfiguration(tChannelConfigurations tChannel)
    {
        t_Channel_Configurations channelConfiguration = new t_Channel_Configurations();
        channelConfiguration.ChannelId = tChannel.ChannelId;
        channelConfiguration.ChannelName = tChannel.ChannelName;
        channelConfiguration.Description = tChannel.Description;
        channelConfiguration.ForwardFlow = tChannel.ForwardFlow;
        channelConfiguration.LoggerId = tChannel.LoggerId;
        channelConfiguration.Pressure1 = tChannel.Pressure1;
        channelConfiguration.Pressure2 = tChannel.Pressure2;
        channelConfiguration.ReverseFlow = tChannel.ReverseFlow;
        channelConfiguration.Unit = tChannel.Unit;
        channelConfiguration.GroupChannel = tChannel.GroupChannel;
        channelConfiguration.DisplayOnGraph = tChannel.DisplayOnGraph;
        channelConfiguration.DisplayOnLabel = tChannel.DisplayOnLabel;
        int numbLine;
        bool isNumericbLine = int.TryParse(tChannel.Baseline, out numbLine);
        if (isNumericbLine)
        {
            channelConfiguration.Baseline = numbLine;
        }

        int numbMin;
        bool isNumericbMin = int.TryParse(tChannel.basemin, out numbMin);
        if (isNumericbMin)
        {
            channelConfiguration.basemin = numbMin;
        }

        int numbMax;
        bool isNumericbMax = int.TryParse(tChannel.basemax, out numbMax);
        if (isNumericbMin)
        {
            channelConfiguration.basemax = numbMax;
        }
        channelConfiguration.t_Logger_Configurations = GetLoggerConfiguration(tChannel);
        return channelConfiguration;
    }

    private t_Logger_Configurations GetLoggerConfiguration(tChannelConfigurations tChannel)
    {
        t_Logger_Configurations loggerConfiguration = new t_Logger_Configurations();
        loggerConfiguration.LoggerId = tChannel.LoggerId;
        loggerConfiguration.SiteId = tChannel.SiteId;
        int numbHour;
        bool isNumericbHout = int.TryParse(tChannel.StartHour, out numbHour);
        if (isNumericbHout)
        {
            loggerConfiguration.StartHour = byte.Parse(numbHour.ToString());
        }

        loggerConfiguration.TelephoneNumber = tChannel.TelephoneNumber;

        if (tChannel.ForwardFlow == true)
        {
            loggerConfiguration.ForwardFlow = 3;
        }
        if (tChannel.Pressure1 == true)
        {
            loggerConfiguration.Pressure1 = 1;
        }
        if (tChannel.Pressure2 == true)
        {
            loggerConfiguration.Pressure2 = 2;
        }
        if (tChannel.ReverseFlow == true)
        {
            loggerConfiguration.ReverseFlow = 4;
        }

        return loggerConfiguration;
    }
    [WebMethod]
    public List<tGroupChannel> GetGroupChannels()
    {
        GroupChannelBL groupChannelBL = new GroupChannelBL();
        var result = groupChannelBL.GetGroupChannels();
        return (from g in result
                select new tGroupChannel
                {
                    Description = g.Description,
                    GroupChannel = g.GroupChannel
                }).ToList();
    }

    [WebMethod]
    public List<tUnits> GetUnits()
    {
        GroupChannelBL groupChannelBL = new GroupChannelBL();
        var result = groupChannelBL.GetAllunits();
        return (from g in result
                select new tUnits
                {
                    Description = g.Description,
                    Unit = g.Unit
                }).ToList();
    }

    [WebMethod]
    public List<SiteRecent> GetSiteRecentById(int start, int end, string username)
    {
        List<SiteRecent> siteRecents = new List<SiteRecent>();
        UserBL _userBL = new UserBL();

        var user = _userBL.GetUser(username);
        if (user.Role == "consumer" || user.Role == "staff")
        {
            var idUser = user.Role == "consumer" ? user.ConsumerId : user.StaffId;

            siteRecents = context.Database.SqlQuery<SiteRecent>("p_GetSiteRecentByUser @start, @end, @StaffId",
             new SqlParameter("start", start),
             new SqlParameter("end", end),
              new SqlParameter("StaffId", idUser)).ToList().Where(s => s.SiteId[0] != 'V').ToList();
        }
        else
        {

            siteRecents = context.Database.SqlQuery<SiteRecent>("p_GetSiteRecentByAdmin @start, @end",
              new SqlParameter("start", start), new SqlParameter("end", end)).ToList().Where(s => s.SiteId[0] != 'V').ToList();
        }


        foreach (var site in siteRecents)
        {
            List<MChannelRecent> lstChannel = new List<MChannelRecent>();

            var channelConfigurationBL = new ChannelConfigurationBL();
            int? setDelayTime = site.SetDelayTime != null ? site.SetDelayTime : 60;
            double? setDiffValue = site.SetDiffValue != null ? site.SetDiffValue : 0.3;

            var channels = (from c in channelConfigurationBL.GetChannelConfigurationsByLoggerID(site.LoggerId)
                            select new MChannelRecent
                            {
                                ChannelId = c.ChannelId,
                                ChannelName = c.ChannelName,
                                LoggerId = c.LoggerId,
                                Description = c.Description,
                                LastValue = c.LastValue.ToString(),
                                LastIndex = c.LastIndex.ToString(),
                                Status = setStatus(c.ChannelId, c.LastValue, c.TimeStamp, setDelayTime, setDiffValue, c.Pressure1, c.Pressure2),
                                Unit = c.Unit,
                                TimeStamp = c.TimeStamp.ToString(),
                                ForwardFlow = c.ForwardFlow,
                                ReverseFlow = c.ReverseFlow,
                                GroupChannel = c.GroupChannel

                            }).ToList();

            site.lstChannels = channels;
        }


        return siteRecents;
    }

    public class SiteRecent
    {
        public string SiteId { get; set; }
        public string SiteAliasName { get; set; }
        public string Location { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string LoggerId { get; set; }
        public int? LabelAnchorX { get; set; }
        public int? LabelAnchorY { get; set; }
        public string DisplayGroup { get; set; }
        public Nullable<int> SetDelayTime { get; set; }
        public Nullable<double> SetDiffValue { get; set; }
        public List<MChannelRecent> lstChannels { get; set; }

    }
    public class MChannelRecent
    {
        public string ChannelId { get; set; }
        public string LoggerId { get; set; }
        public string ChannelName { get; set; }
        public string Unit { get; set; }
        public string Description { get; set; }
        public Nullable<bool> ForwardFlow { get; set; }
        public Nullable<bool> ReverseFlow { get; set; }
        public int Status { get; set; }
        public string TimeStamp { get; set; }
        public string LastValue { get; set; }
        public string LastIndex { get; set; }
        public string GroupChannel { get; set; }
    }





    public class ConfigLogger
    {
        public string SiteAliasName { get; set; }
        public string ConsumerId { get; set; }
        public string Description { get; set; }
        public string DisplayGroup { get; set; }
        public string Latitude { get; set; }
        public string Location { get; set; }
        public string LoggerId { get; set; }
        public string Longitude { get; set; }
        public string SiteId { get; set; }
        public string StartDay { get; set; }
        public string StartHour { get; set; }
        public Nullable<int> Zoom { get; set; }
        public string TelephoneNumber { get; set; }
        public string MeterSerial { get; set; }
        public string TransmitterSerial { get; set; }
        public string LoggerSerial { get; set; }
        public string Status { get; set; }
        public string Availability { get; set; }
        public string Staffs { get; set; }
        public string PipeSize { get; set; }
        public string SetDiffValue { get; set; }
        public string SetDelayTime { get; set; }
        public string DMA_In { get; set; }
        public string DMA_Out { get; set; }
        public bool Checked { get; set; }
        public string DateChanged { get; set; }
        public string dtmMeterChanged { get; set; }
        public string dtmTransmitterChanged { get; set; }
        public string dtmLoggerChanged { get; set; }
    }

    public class tUnits
    {
        public string Unit { get; set; }
        public string Description { get; set; }
    }

    public class DeviceTokenApp
    {
        public string UserName { get; set; }
        public string DeviceToken { get; set; }
        public bool Status { get; set; }
        public bool Sound { get; set; }
    }

    public class result_sampler
    {
        public string Result { get; set; }
        public string Knumber { get; set; }
    }

    public class MSampler
    {
        public string stationId { get; set; }
        public string ipaddress { get; set; }
        public string port { get; set; }
        public string partnerId { get; set; }
        public string time { get; set; }
    }

    public class SiteViewModel
    {

        public string SiteId { get; set; }
        public double? BaseLine { get; set; }
        public string DisplayGroup { get; set; }

        public string Location { get; set; }
        public string LoggerId { get; set; }

        public double? Latitude { get; set; }

        public double? Longitude { get; set; }
        public int? LabelAnchorX { get; set; }

        public int? LabelAnchorY { get; set; }

        public double? Index { get; set; }

        public string Role { get; set; }
    }
    public class DisplayGroup
    {
        public string Group { get; set; }
        public string Description { get; set; }
        public string Name { get; set; }
    }
    public class MLoggerConfig
    {
        public bool? Status1 { get; set; }
        public bool? Status2 { get; set; }
        public int? TimeDelayAlarm { get; set; }
    }
    public class mySite
    {
        public string SiteID { get; set; }
    }
    public partial class LoggerData
    {
        public System.DateTime TimeStamp { get; set; }
        public Nullable<double> Value { get; set; }
    }
    public class M_Channel_All
    {
        public string ChannelId { get; set; }
        public string LoggerId { get; set; }
        public string ChannelName { get; set; }

    }
    public class myLogin
    {
        public string username { get; set; }

    }
    public class MSite
    {
        public string SiteId { get; set; }
        public string SiteAliasName { get; set; }
        public string Location { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string LoggerId { get; set; }
        public double? LabelAnchorX { get; set; }
        public double? LabelAnchorY { get; set; }
        public string DisplayGroup { get; set; }
        public bool? Status1 { get; set; }
        public bool? Status2 { get; set; }
        public int? TimeDelayAlarm { get; set; }

    }
    public class toado
    {
        public string Lat { get; set; }
        public string Lng { get; set; }

    }
    public class logo
    {
        public string Path { get; set; }


    }

    public class AlarmAll
    {
        public string SiteId { get; set; }
        public string SiteAliasName { get; set; }
        public string LoggerId { get; set; }
        public List<Alarm> Alarms { get; set; }
    }
    public class ValueAlarm
    {
        public DateTime TimeStamp { get; set; }
        public string NamePath { get; set; }
        public string Channelname { get; set; }
        public double LasValue { get; set; }

        public double BaseLine { get; set; }

        public double BaseMax { get; set; }

        public double InterVal { get; set; }

        public double BaseMin { get; set; }
        public string Status { get; set; }
    }
    public class Alarm
    {
        public string ChannelId { get; set; }
        public string ChannelName { get; set; }
        public string Unit { get; set; }
        public string Description { get; set; }
        public DateTime? TimeStamp { get; set; }
        public double LastValue { get; set; }
        public string StrTimeStamp { get; set; }
        public string Strvalue { get; set; }
        public bool? StatusViewAlarm { get; set; }

        public string yyyy { get; set; }
        public string MM { get; set; }
        public string dd { get; set; }
        public string HH { get; set; }
        public string mm { get; set; }
    }
    public class MChannelNew
    {
        public string ChannelId { get; set; }
        public string LoggerId { get; set; }
        public string ChannelName { get; set; }


    }
    public class GroupLogger
    {
        public string DisplayGroup { get; set; }
        public string Name { get; set; }
        public List<DataAll> lstDataAll { get; set; }
    }
    public class DataAll
    {
        public string SiteId { get; set; }
        public string SiteAliasName { get; set; }
        public string Location { get; set; }
        public double Latitude { get; set; }
        public double Longitude { get; set; }
        public string LoggerId { get; set; }
        public double? LabelAnchorX { get; set; }
        public double? LabelAnchorY { get; set; }
        public List<GroupChannels> lstGroupChannels { get; set; }
    }

    public class GroupChannels
    {
        public string GroupChannel { get; set; }
        public List<MChannel> Channels { get; set; }
    }
    public class MChannel
    {
        public string ChannelId { get; set; }
        public string LoggerId { get; set; }
        public string ChannelName { get; set; }
        public string Unit { get; set; }
        public string Description { get; set; }
        public Nullable<bool> ForwardFlow { get; set; }
        public Nullable<bool> ReverseFlow { get; set; }
        public int Status { get; set; }
        public string TimeStamp { get; set; }
        public string LastValue { get; set; }
        public string IndexTimeStamp { get; set; }
        public string LastIndex { get; set; }
        public bool DisplayOnLabel { get; set; }
        public string StrTimeStamp { get; set; }

        public string yyyy { get; set; }
        public string MM { get; set; }
        public string dd { get; set; }
        public string HH { get; set; }
        public string mm { get; set; }
    }

    public class ChannelMultipleDataViewModel
    {
        public DateTime Timestamp { get; set; }
        public List<Nullable<double>> Values { get; set; }

    }

    public class MyCusComer
    {
        public string CuscomerId { get; set; }
        public string Description { get; set; }
    }


    public partial class tSiteStatus
    {
        public string Status { get; set; }
        public string Description { get; set; }
        public string Language { get; set; }

    }

    public partial class tSiteAvailabilities
    {

        public string Availability { get; set; }
        public string Description { get; set; }
        public string Language { get; set; }

    }

    public class tChannelConfigurations
    {
        public string ChannelId { get; set; }
        public string LoggerId { get; set; }
        public string SiteId { get; set; }
        public string TelephoneNumber { get; set; }
        public string StartHour { get; set; }
        public string ChannelName { get; set; }
        public string Unit { get; set; }
        public string Description { get; set; }
        public bool? Pressure1 { get; set; }
        public bool? Pressure2 { get; set; }
        public bool? ForwardFlow { get; set; }
        public bool? ReverseFlow { get; set; }
        public string TimeStamp { get; set; }
        public string LastValue { get; set; }
        public string IndexTimeStamp { get; set; }
        public string LastIndex { get; set; }
        public bool? DisplayOnLabel { get; set; }
        public bool? ChannelOther { get; set; }
        public string basemin { get; set; }
        public string basemax { get; set; }
        public string GroupChannel { get; set; }
        public bool? DisplayOnGraph { get; set; }
        public string Baseline { get; set; }
    }

    public class tGroupChannel
    {
        public string GroupChannel { get; set; }
        public string Description { get; set; }
    }

}
