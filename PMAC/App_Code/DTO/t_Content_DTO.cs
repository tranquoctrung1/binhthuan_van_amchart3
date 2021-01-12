using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for t_Function_DTO
/// </summary>
public class t_Content_DTO
{
    public t_Content_DTO()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public int Id_vi { get; set; }
    public int Id_en { get; set; }
    public int Id_other { get; set; }

    public string Id_display { get; set; }
    public string Content_vi { get; set; }
    public string Content_en { get; set; }
    public string Content_other { get; set; }
    
}