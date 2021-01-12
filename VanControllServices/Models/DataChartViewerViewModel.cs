using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VanControllServices.Models
{
    public class DataChartViewerViewModel
    {
        public string ChannelID { get; set; }
        public DateTime TimeStamp { get; set; }
        public double? Value { get; set; }
    }
}