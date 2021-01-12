using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SiteViewModel
/// </summary>
public class SiteViewModel
{
    public int STT { get; set; }
    public string SiteID { get; set; }
    public string SiteAliasName { get; set; }
    public string Location { get; set; }
    public string MeterSerial { get; set; }
    public string MeterMarks { get; set; }
    public short? MeterSize { get; set; }
    public string TransmitterSerial { get; set; }
    public string LoggerSerial { get; set; }
    public string ConsumerID { get; set; }
    public string LoggerModel { get; set; }
    public string SiteStatus { get; set; }
    public string SiteAvailability { get; set; }
    public string Description { get; set; }
    public string AccreditationDocument { get; set; }
    public string PipeSize { get; set; }
}