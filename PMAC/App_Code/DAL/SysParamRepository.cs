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
    public class SysParamRepository : IDisposable, ISysParamRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

        public bool Add(t_SysParam entity)
        {
            throw new NotImplementedException();
        }        

        public IEnumerable<t_SysParam> FindAll()
        {
            return context.t_SysParam.OrderBy(c => c.ID).ToList();
        }

        public IEnumerable<t_SysParam> FindAll(Expression<Func<t_SysParam, bool>> predicate)
        {
            return context.t_SysParam.Where(predicate).ToList();
        }

        public t_SysParam FindById(int id)
        {
            throw new NotImplementedException();
        }

        public t_SysParam FindSingle(Expression<Func<t_SysParam, bool>> predicate)
        {
            return context.t_SysParam.Where(predicate).FirstOrDefault();
        }

        public void Remove(t_SysParam entity)
        {
            throw new NotImplementedException();
        }

        public void RemoveMultiple(List<t_SysParam> entities)
        {
            throw new NotImplementedException();
        }

        public bool Update(t_SysParam entity, int id)
        {
            try
            {
                t_SysParam content = FindSingle(x => x.ID == id);
                //content.ControlId = entity.ControlId;
                content.Val = entity.Val;
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