using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for t_Function_DTO
/// </summary>
public class t_Users_DTO
{
    public t_Users_DTO()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string Id_display { get; set; }
    public string Username { get; set; }
    public string Password { get; set; }
    public string Salt { get; set; }
    public string StaffId { get; set; }
    public string ConsumerId { get; set; }
    public string Email { get; set; }
    public string Role { get; set; }
    public string Active { get; set; }

}