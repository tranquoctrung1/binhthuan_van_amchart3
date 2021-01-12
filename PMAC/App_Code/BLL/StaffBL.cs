using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;


namespace PMAC.BLL
{
    [DataObject]
    public class StaffBL : IDisposable
    {
        private bool disposedValue = false;
        private IStaffRepository staffRepository;

        public StaffBL()
        {
            this.staffRepository = new StaffRepository();
        }

        public StaffBL(IStaffRepository staffRepository)
        {
            this.staffRepository = staffRepository;
        }
    
        public t_Staffs GetStaff(string StaffID)
        {
            return staffRepository.GetStaff(StaffID);
        }

        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public IEnumerable<t_Staffs> GetStaffs()
        {
            return staffRepository.GetStaffs();
        }

        public void InsertStaff(t_Staffs Staff)
        {
            try
            {
                staffRepository.InsertStaff(Staff);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateStaff(t_Staffs Staff, t_Staffs origStaff)
        {
            try
            {
                staffRepository.UpdateStaff(Staff, origStaff);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteStaff(t_Staffs Staff)
        {
            try
            {
                staffRepository.DeleteStaff(Staff);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        protected void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    staffRepository.Dispose();
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
