using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using PMAC.BLL;

/// <summary>
/// Summary description for DailyChart
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class Chart : System.Web.Services.WebService {

    //[WebMethod]
    //public t_Sites GetSite(string siteID)
    //{
    //    SiteBL _siteBL = new SiteBL();
    //    return _siteBL.GetSite(siteID);
    //}

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
    public List<LoggerDataViewModel> GetLoggerDataViewModel(string siteID, DateTime startDate, DateTime endDate)
    {
        LoggerDataHelper _loggerDataHelper = new LoggerDataHelper();
        return _loggerDataHelper.GetComplexLoggerDataForWebService(siteID, startDate, endDate);
    }

    public class mySite
    {
        public string SiteID { get; set; }
    }
}
