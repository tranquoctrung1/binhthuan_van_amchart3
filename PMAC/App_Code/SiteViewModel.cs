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

public class t_SiteCustomer
{
    public string SiteId { get; set; }
    public string Location { get; set; }
    public Nullable<double> Latitude { get; set; }
    public Nullable<double> Longitude { get; set; }
    public string DisplayGroup { get; set; }
    public Nullable<byte> Zoom { get; set; }
    public string ConsumerId { get; set; }
    public string LoggerId { get; set; }
    public Nullable<byte> StartDay { get; set; }
    public string Description { get; set; }
    public string MeterSerial { get; set; }
    public string TransmitterSerial { get; set; }
    public string LoggerSerial { get; set; }
    public Nullable<System.DateTime> MeterDateChanged { get; set; }
    public Nullable<System.DateTime> TransmitterDateChanged { get; set; }
    public Nullable<System.DateTime> LoggerDateChanged { get; set; }
    public string Availability { get; set; }
    public string Status { get; set; }
    public string Staffs { get; set; }
    public string SiteAliasName { get; set; }
    public Nullable<int> LabelAnchorX { get; set; }
    public Nullable<int> LabelAnchorY { get; set; }
    public Nullable<double> LabelLat { get; set; }
    public Nullable<double> LabelLng { get; set; }
    public string PipeSize { get; set; }
    public Nullable<int> SetDelayTime { get; set; }
    public Nullable<double> SetDiffValue { get; set; }
    public Nullable<double> Baseline { get; set; }
    public string DMA_In { get; set; }
    public string DMA_Out { get; set; }
    public string Name { get; set; }
    public string GroupChannel { get; set; }
    public Nullable<bool> DisplayOnGraph { get; set; }
}