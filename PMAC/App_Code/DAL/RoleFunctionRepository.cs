using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;
using System.Linq.Expressions;

namespace PMAC.DAL
{
    public class RoleFunctionRepository : IDisposable, IRoleFunctionRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

        public void Add(t_RoleFunction entity)
        {
            context.t_RoleFunction.Add(entity);
            context.SaveChanges();
        }        

        public IEnumerable<t_RoleFunction> FindAll()
        {
            return context.t_RoleFunction.ToList();
        }

        public IEnumerable<t_RoleFunction> FindAll(Expression<Func<t_RoleFunction, bool>> predicate)
        {
            return context.t_RoleFunction.Where(predicate).ToList();
        }

        public t_RoleFunction FindById(int id)
        {
            throw new NotImplementedException();
        }

        public t_RoleFunction FindSingle(Expression<Func<t_RoleFunction, bool>> predicate)
        {
            return context.t_RoleFunction.Where(predicate).FirstOrDefault();
        }

        public void Remove(t_RoleFunction entity)
        {
            throw new NotImplementedException();
        }

        public void RemoveMultiple(List<t_RoleFunction> entities)
        {
            throw new NotImplementedException();
        }

        public bool Update(t_RoleFunction entity, string roleName, int functionId)
        {
            try
            {
                t_RoleFunction content = FindSingle(x => x.Role == roleName && x.FunctionId == functionId);
                content.Active = entity.Active;
                context.SaveChanges();

                return true;
            }
            catch (Exception)
            {
                return false;
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