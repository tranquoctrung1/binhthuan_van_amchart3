using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace PMAC.BLL
{
    /// <summary>
    /// Summary description for DailyComplexDataViewModel
    /// </summary>
    public class ComplexDataViewModel
    {
        public DateTime TimeStamp { get; set; }
        public string SiteID { get; set; }
        public string SiteAliasName { get; set; }
        public string Location { get; set; }
        public double? MinFlowRate { get; set; }
        public double? MaxFlowRate { get; set; }
        public double? Output { get; set; }
        public double? MinPressure { get; set; }
        public double? MaxPressure { get; set; }
        public string AltMinFlow { get; set; }
        public string AltMaxFlow { get; set; }
        public string AltMinPress { get; set; }
        public string AltMaxPress { get; set; }
    }
}