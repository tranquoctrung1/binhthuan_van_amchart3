using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ReportDataViewModel
/// </summary>
public class ReportDataViewModel
{
    public string SiteID { get; set; }

    public string SiteAliasName { get; set; }

    public string Location { get; set; }

    public DateTime StartDate { get; set; }

    public DateTime EndDate { get; set; }

    public double? StartIndex { get; set; }

    public double? EndIndex { get; set; }

    public double? Output { get; set; }
}