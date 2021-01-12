using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for t_Function_DTO
/// </summary>
public class t_SysParam_DTO
{
    public t_SysParam_DTO()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public int Id { get; set; }

    public string Id_display { get; set; }
    public string NavigateURL { get; set; }
    public string HyperLinkText { get; set; }
    public string Val { get; set; }
    public string Description { get; set; }
    
}