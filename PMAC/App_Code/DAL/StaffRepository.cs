using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;


namespace PMAC.DAL
{
    public class StaffRepository:IDisposable, IStaffRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();
    
        public IEnumerable<t_Staffs> GetStaffs()
        {
            return context.t_Staffs.OrderBy(s => s.StaffId).ToList();
        }

        public t_Staffs GetStaff(string staffID)
        {
            return context.t_Staffs.SingleOrDefault(s => s.StaffId == staffID);
        }

        public void InsertStaff(t_Staffs staff)
        {
            try
            {
                context.t_Staffs.Add(staff);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateStaff(t_Staffs staff, t_Staffs origStaff)
        {
            try
            {
                context.t_Staffs.Attach(origStaff);
                origStaff.Address = staff.Address;
                origStaff.FirstName = staff.FirstName;
                origStaff.LastName = staff.LastName;
                origStaff.StaffId = staff.StaffId;
                origStaff.TelephoneNumber = staff.TelephoneNumber;
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteStaff(t_Staffs staff)
        {
            try
            {
                context.t_Staffs.Attach(staff);
                context.t_Staffs.Remove(staff);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        protected void Dispose(bool isDisposing)
        {
            if (!this.disposedValue)
            {
                if (isDisposing)
                {
                    context.Dispose();
                }   
            }
            disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}