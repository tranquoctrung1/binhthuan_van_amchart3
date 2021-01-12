using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSViaCOMPort
{
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
