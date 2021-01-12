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
    public class DisplayGroupBL : IDisposable
    {
        private bool disposedValue = false;
        private IDisplayGroupRepository displayGroupRepository;

        public DisplayGroupBL()
        {
            this.displayGroupRepository = new DisplayGroupRepository();
        }

        public DisplayGroupBL(IDisplayGroupRepository displayGroupRepository)
        {
            this.displayGroupRepository = displayGroupRepository;
        }
    
        public t_DisplayGroups GetDisplayGroup(string groupID)
        {
            return displayGroupRepository.GetDisplayGroup(groupID);
        }

        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public IEnumerable<t_DisplayGroups> GetDisplayGroups()
        {
            return displayGroupRepository.GetDisplayGroups();
        }

        public void InsertDisplayGroup(t_DisplayGroups displayGroup)
        {
            try
            {
                displayGroupRepository.InsertDisplayGroup(displayGroup);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateDisplayGroup(t_DisplayGroups displayGroup, t_DisplayGroups origDisplayGroup)
        {
            try
            {
                displayGroupRepository.UpdateDisplayGroup(displayGroup, origDisplayGroup);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteDisplayGroup(t_DisplayGroups displayGroup)
        {
            try
            {
                displayGroupRepository.DeleteDisplayGroup(displayGroup);
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
                    displayGroupRepository.Dispose();
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
