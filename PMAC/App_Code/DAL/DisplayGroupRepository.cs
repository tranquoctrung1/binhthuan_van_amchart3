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
    public class DisplayGroupRepository : IDisposable, IDisplayGroupRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();
    
        public IEnumerable<t_DisplayGroups> GetDisplayGroups()
        {
            return context.t_DisplayGroups.OrderBy(g => g.Group).ToList();
        }

        public t_DisplayGroups GetDisplayGroup(string groupID)
        {
            return context.t_DisplayGroups.SingleOrDefault(g => g.Group == groupID);
        }

        public void InsertDisplayGroup(t_DisplayGroups group)
        {
            try
            {
                context.t_DisplayGroups.Add(group);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateDisplayGroup(t_DisplayGroups group, t_DisplayGroups origGroup)
        {
            try
            {
                context.t_DisplayGroups.Attach(origGroup);
                origGroup.Group = group.Group;
                origGroup.Description = group.Description;
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteDisplayGroup(t_DisplayGroups group)
        {
            try
            {
                context.t_DisplayGroups.Attach(group);
                context.t_DisplayGroups.Remove(group);
                context.SaveChanges();
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