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
    public class RoleRepository : IDisposable, IRoleRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

        public void Add(t_Roles entity)
        {
            context.t_Roles.Add(entity);
            context.SaveChanges();
        }        

        public IEnumerable<t_Roles> FindAll()
        {
            return context.t_Roles.ToList();
        }

        public IEnumerable<t_Roles> FindAll(Expression<Func<t_Roles, bool>> predicate)
        {
            return context.t_Roles.Where(predicate).ToList();
        }

        public t_Roles FindById(int id)
        {
            throw new NotImplementedException();
        }

        public t_Roles FindSingle(Expression<Func<t_Roles, bool>> predicate)
        {
            return context.t_Roles.Where(predicate).FirstOrDefault();
        }

        public void Remove(t_Roles entity)
        {
            throw new NotImplementedException();
        }

        public void RemoveMultiple(List<t_Roles> entities)
        {
            throw new NotImplementedException();
        }

        public bool Update(t_Roles entity, string roleName)
        {
            try
            {
                t_Roles content = FindSingle(x => x.Role == roleName);
                content.Description = entity.Description;

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