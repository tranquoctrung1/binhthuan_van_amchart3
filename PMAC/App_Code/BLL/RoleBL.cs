using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;
using System.Linq.Expressions;

namespace PMAC.BLL
{
    [DataObject]
    public class RoleBL : IDisposable
    {
        private bool disposedValue = false;
        private IRoleRepository RoleRepository;

        public RoleBL()
        {
            this.RoleRepository = new RoleRepository();
        }

        public RoleBL(IRoleRepository RoleRepository)
        {
            this.RoleRepository = RoleRepository;
        }
    
        public t_Roles FindSingle(Expression<Func<t_Roles, bool>> predicate)
        {
            return RoleRepository.FindSingle(predicate);
        }

        public IEnumerable<t_Roles> FindAll(Expression<Func<t_Roles, bool>> predicate)
        {
            return RoleRepository.FindAll(predicate);
        }

        public IEnumerable<t_Roles> FindAll()
        {
            return RoleRepository.FindAll();
        }

        public bool Update(t_Roles entity, string roleName)
        {
            return RoleRepository.Update(entity, roleName);
        }

        public void AddRole(t_Roles entity)
        {
            RoleRepository.Add(entity);
        }

        protected void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    RoleRepository.Dispose();
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
