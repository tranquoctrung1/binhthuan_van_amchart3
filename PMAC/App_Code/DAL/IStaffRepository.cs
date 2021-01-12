using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;


namespace PMAC.DAL
{
    public interface IStaffRepository : IDisposable
    {
        void DeleteStaff(t_Staffs Staff);

        t_Staffs GetStaff(string StaffID);

        IEnumerable<t_Staffs> GetStaffs();

        void InsertStaff(t_Staffs Staff);

        void UpdateStaff(t_Staffs Staff, t_Staffs origStaff);
    }
}
