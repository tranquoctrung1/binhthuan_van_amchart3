using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PMAC.BLL
{
    /// <summary>
    /// Summary description for LoggerDataViewModel
    /// </summary>
    public class LoggerDataViewModel
    {
        public DateTime TimeStamp { get; set; }
        public double? FlowRate { get; set; }
        public double? Pressure { get; set; }
        public double? ForwardIndex { get; set; }
        public double? ReverseIndex { get; set; }
        public double? NetIndex { get; set; }
    }
}