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
    public class RoleFunctionBL : IDisposable
    {
        private bool disposedValue = false;
        private IRoleFunctionRepository RoleFunctionRepository;

        public RoleFunctionBL()
        {
            this.RoleFunctionRepository = new RoleFunctionRepository();
        }

        public RoleFunctionBL(IRoleFunctionRepository RoleFunctionRepository)
        {
            this.RoleFunctionRepository = RoleFunctionRepository;
        }
    
        public t_RoleFunction FindSingle(Expression<Func<t_RoleFunction, bool>> predicate)
        {
            return RoleFunctionRepository.FindSingle(predicate);
        }

        public IEnumerable<t_RoleFunction> FindAll(Expression<Func<t_RoleFunction, bool>> predicate)
        {
            return RoleFunctionRepository.FindAll(predicate);
        }

        public IEnumerable<t_RoleFunction> FindAll()
        {
            return RoleFunctionRepository.FindAll();
        }

        public bool Update(t_RoleFunction entity, string roleName, int functionId)
        {
            return RoleFunctionRepository.Update(entity, roleName, functionId);
        }

        public void AddRole(t_RoleFunction entity)
        {
            RoleFunctionRepository.Add(entity);
        }

        protected void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    RoleFunctionRepository.Dispose();
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
