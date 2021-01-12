using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WindowsService
{
    public class Chn
    {
        string _id;

        string _name;

        bool? _pres1;

        bool? _pres2;

        DateTime? _tmstmp;

        DateTime? _indexTmstmp;

        double? _val;

        double? _lastIndex;

        string _unit;

        int _ss;

        bool _ss1;

        bool _ss2;

        bool _ss3;

        bool _ss4;

        string _siteId;

        string _siteName;

        string _loggerId;

        double _difValPer;

        public double DifValPer { get { return _difValPer; } set { _difValPer = value; } }

        public string SiteId { get { return _siteId; } set { _siteId = value; } }

        public string SiteName { get { return _siteName; } set { _siteName = value; } }

        public string LoggerId { get { return _loggerId; } set { _loggerId = value; } }

        public bool SS1 { get { return _ss1; } set { _ss1 = value; } }

        public bool SS2 { get { return _ss2; } set { _ss2 = value; } }

        public bool SS3 { get { return _ss3; } set { _ss3 = value; } }

        public bool SS4 { get { return _ss4; } set { _ss4 = value; } }

        public string Id { get { return _id; } set { _id = value; } }

        public string Name { get { return _name; } set { _name = value; } }

        public bool? Pres1 { get { return _pres1; } set { _pres1 = value; } }

        public bool? Pres2 { get { return _pres2; } set { _pres2 = value; } }

        public DateTime? Tmstmp { get { return _tmstmp; } set { _tmstmp = value; } }

        public DateTime? IndexTmstmp { get { return _indexTmstmp; } set { _indexTmstmp = value; } }

        public double? Val { get { return _val; } set { _val = value; } }

        public double? LastIndex { get { return _lastIndex; } set { _lastIndex = value; } }

        public string Unit { get { return _unit; } set { _unit = value; } }

        public int SS { get { return _ss; } set { _ss = value; } }
    }

    public class Site
    {
        string _id;

        string _aName;

        string _dispGrp;

        string _loc;

        string _loggerId;

        double? _lat;

        double? _lng;

        int? _lblX;

        int? _lblY;

        double? _index;

        string _role;

        IEnumerable<Chn> _chns;

        public string Id { get { return _id; } set { _id = value; } }

        public string AName { get { return _aName; } set { _aName = value; } }

        public string DispGrp { get { return _dispGrp; } set { _dispGrp = value; } }

        public string Loc { get { return _loc; } set { _loc = value; } }

        public string LoggerId { get { return _loggerId; } set { _loggerId = value; } }

        public double? Lat { get { return _lat; } set { _lat = value; } }

        public double? Lng { get { return _lng; } set { _lng = value; } }

        public int? LblX { get { return _lblX; } set { _lblX = value; } }

        public int? LblY { get { return _lblY; } set { _lblY = value; } }

        public double? Index { get { return _index; } set { _index = value; } }

        public string Role { get { return _role; } set { _role = value; } }

        public IEnumerable<Chn> Chns { get { return _chns; } set { _chns = value; } }
    }

    public class AlmCfg
    {
        int id;

        string siteId;

        string telNr;

        bool ss1;

        bool ss2;

        bool ss3;

        bool ss4;

        bool ena;

        public int Id { get { return id; } set { id = value; } }

        public string TelNr { get { return telNr; } set { telNr = value; } }

        public string SiteId { get { return siteId; } set { siteId = value; } }

        public bool SS1 { get { return ss1; } set { ss1 = value; } }

        public bool SS2 { get { return ss2; } set { ss2 = value; } }

        public bool SS3 { get { return ss3; } set { ss3 = value; } }

        public bool SS4 { get { return ss4; } set { ss4 = value; } }

        public bool Ena { get { return ena; } set { ena = value; } }
    }

    public class Alm
    {
        int id;

        string siteId;

        string siteName;

        string chnName;

        DateTime tmstmp;

        string msg1;

        string msg2;

        string msg3;

        string msg4;

        bool trig;

        string msg;

        AlmCfg almCfg;

        public int Id { get { return id; } set { id = value; } }

        public string SiteId { get { return siteId; } set { siteId = value; } }

        public string SiteName { get { return siteName; } set { siteName = value; } }

        public string ChnName { get { return chnName; } set { chnName = value; } }

        public DateTime Tmstmp { get { return tmstmp; } set { tmstmp = value; } }

        public string Msg1 { get { return msg1; } set { msg1 = value; } }

        public string Msg2 { get { return msg2; } set { msg2 = value; } }

        public string Msg3 { get { return msg3; } set { msg3 = value; } }

        public string Msg4 { get { return msg4; } set { msg4 = value; } }

        public bool Trig { get { return trig; } set { trig = value; } }

        public string Msg { get { return msg; } set { msg = value; } }

        public AlmCfg AlmCfg { get { return almCfg; } set { almCfg = value; } }
    }
}
