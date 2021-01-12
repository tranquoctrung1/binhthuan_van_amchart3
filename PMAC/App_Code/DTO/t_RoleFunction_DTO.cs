using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for t_Function_DTO
/// </summary>
public class t_RoleFunction_DTO
{
    public t_RoleFunction_DTO()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string Id_display { get; set; }
    public string Role { get; set; }
    public int FunctionId { get; set; }
    public bool Active { get; set; }
    public string FunctionName_vi { get; set; }
    public string FunctionName_en { get; set; }
    public string FunctionName_other { get; set; }
}