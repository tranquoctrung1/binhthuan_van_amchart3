using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for t_Function_DTO
/// </summary>
public class t_Function_DTO
{
    public t_Function_DTO()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public int FunctionId_vi { get; set; }
    public int FunctionId_en { get; set; }
    public int FunctionId_other { get; set; }

    public string Id_display { get; set; }
    public string FunctionName_vi { get; set; }
    public string FunctionName_en { get; set; }
    public string FunctionName_other { get; set; }
    
}