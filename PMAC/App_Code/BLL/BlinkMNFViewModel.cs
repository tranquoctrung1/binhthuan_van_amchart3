using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace PMAC.BLL
{
    /// <summary>
    /// Summary description for BlinkMNFViewModel
    /// </summary>
    public class BlinkMNFViewModel
    {
        public DateTime TimeStamp { get; set; }
     
        public double? TotalLogger { get; set; }
        public double? LoggerError { get; set; }
        public double? LoggerZero { get; set; }
        public double? MNFLowBaseline { get; set; }
        public double? MNFHighFirst { get; set; }
       
    }
}