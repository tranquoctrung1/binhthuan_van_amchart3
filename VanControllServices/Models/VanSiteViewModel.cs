using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VanControllServices.Models
{
    public class VanSiteViewModel
    {
        public string ChannelId { get; set; }
        public Nullable<double> MaxValue { get; set; }
        public Nullable<double> MinValue { get; set; }
        public Nullable<DateTime> InstantTime { get; set; }
        public Nullable<double> InstantValue { get; set; }
        public string Unit { get; set; }
    }
}