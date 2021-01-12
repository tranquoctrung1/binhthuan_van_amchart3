using PMAC.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using PMAC.ULT;

/// <summary>
/// Summary description for Map
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class Map : System.Web.Services.WebService {
    private DBEntities context = new DBEntities();
	System.Globalization.CultureInfo cu = new System.Globalization.CultureInfo("en-GB");
    public Map () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

 [WebMethod]
    public List<DataAll> GetDataAll(string username)
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
                select new DataAll
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

        List<DataAll> t = x.ToList();
        var channelConfigurationBL = new ChannelConfigurationBL();
        foreach (DataAll item in t)
        {
           
            var y = from c in channelConfigurationBL.GetChannelConfigurationsByLoggerID(item.LoggerId)
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
            item.Channels = y.ToList();
        }

        return t.OrderBy(d => d.DisplayGroup).ThenBy(n => n.SiteAliasName).ToList();

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
    public List<LoggerData> Getchanneldetail(string channel, string startDate, string endDate)
    {
        DateTime start = DateTime.Parse(startDate,cu);
		start =start.AddHours(-6);
        DateTime end = DateTime.Parse(endDate, cu);
		end = end.AddHours(12);
          return context.Database.SqlQuery<LoggerData>("p_Data_Logger_Get @ChannelID, @StartDate, @EndDate",
                new SqlParameter("StartDate", start),
                new SqlParameter("EndDate", end),
                new SqlParameter("ChannelID", channel)).ToList();
    }
 [WebMethod]
    public toado LatLng(string lat, string lng)
    {
        toado list = new toado();

        list.Lat = System.Configuration.ConfigurationManager.AppSettings["gLatInit"];
        list.Lng = System.Configuration.ConfigurationManager.AppSettings["gLngInit"]; ;
        
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
                    LabelAnchorY =s.LabelAnchorY,
                    DisplayGroup = s.DisplayGroup
                };

        List<MSite> t = x.ToList();
        var loggerBL= new LoggerConfigurationBL();
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
 [WebMethod]
     public List<Alarm> GetAlarm(string siteid)
    {
        var _siteBL = new SiteBL();
        var site = _siteBL.GetSite(siteid);
        var channelConfigurationBL = new ChannelConfigurationBL();
        var loggerConfiguration = site.t_Logger_Configurations;
        var loggerId = loggerConfiguration.LoggerId;
        var x = from c in channelConfigurationBL.GetChannelConfigurationsByLoggerID(loggerId)
                select new Alarm
                {
                    ChannelId = c.ChannelId,
                    LoggerId = c.LoggerId,
                    ChannelName = c.ChannelName,
                    Unit = c.Unit,
                    Description = c.Description,

                    TimeStamp = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).ToString("dd/MM/yyyy HH:mm"),
                   // yyyy = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Year.ToString(),
                   // MM = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Month.ToString(),
                   // dd = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Day.ToString(),
                  // HH = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Hour.ToString(),
                   // mm = c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).Minute.ToString(),

                    LastValue = c.LastValue == null ? "NO DATA" : ((double)c.LastValue).ToString("0.00"),
                    Strvalue = c.LastValue + " " + c.Unit,
 			SiteId = siteid,
                };

        return x.ToList();
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

        return x.ToList();
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
        return x.ToList();
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
        public string Path{ get; set; }
        

    }
 public class Alarm
    {
        public string ChannelId { get; set; }
        public string LoggerId { get; set; }
        public string ChannelName { get; set; }
        public string Unit { get; set; }
        public string Description { get; set; }
        public string TimeStamp { get; set; }
        public string LastValue { get; set; }     
        public string StrTimeStamp { get; set; }
        public string Strvalue { get; set; }
        public string SiteId { get; set; }

        public string yyyy { get; set; }
        public string MM { get; set; }
        public string dd { get; set; }
        public string HH { get; set; }
        public string mm { get; set; }
    }
    public class MChannel
    {
        public string ChannelId { get; set; }
        public string LoggerId { get; set; }
        public string ChannelName { get; set; }
        public string Unit { get; set; }
        public string Description { get; set; }
        public string TimeStamp { get; set; }
        public string LastValue { get; set; }
        public string IndexTimeStamp { get; set; }
        public string LastIndex { get; set; }
        public bool DisplayOnLabel { get; set; }
        //public double LastIndex { get; set; }
        public string StrTimeStamp { get; set; }

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
        public string DisplayGroup { get; set; }
       
        public List<MChannel> Channels { get; set; }
        

    }  
}

