using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DeviceViewModel
/// </summary>
public class DeviceViewModel
{
    public int STT { get; set; }
    public DateTime? ReceiptDate { get; set; }
    public DateTime? AccreditationDate { get; set; }
    public string Description { get; set; }
    public string Serial { get; set; }
    public string Provider { get; set; }
    public string Marks { get; set; }
    public short? Size { get; set; }
    public string Model { get; set; }
    public string Status { get; set; }
    public bool Installed { get; set; }
    public string SiteID { get; set; }
    public string SitaAliasName { get; set; }
    public string Location { get; set; }

}