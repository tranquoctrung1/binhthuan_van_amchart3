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
    public class FunctionRepository:IDisposable, IFunctionRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

        public bool Add(t_Function entity)
        {
            throw new NotImplementedException();
        }        

        public IEnumerable<t_Function> FindAll()
        {
            return context.t_Function.OrderBy(c => c.Sort).ToList();
        }

        public IEnumerable<t_Function> FindAll(Expression<Func<t_Function, bool>> predicate)
        {
            return context.t_Function.Where(predicate).ToList();
        }

        public t_Function FindById(int id)
        {
            throw new NotImplementedException();
        }

        public t_Function FindSingle(Expression<Func<t_Function, bool>> predicate)
        {
            return context.t_Function.Where(predicate).FirstOrDefault();
        }

        public void Remove(t_Function entity)
        {
            throw new NotImplementedException();
        }

        public void RemoveMultiple(List<t_Function> entities)
        {
            throw new NotImplementedException();
        }

        public bool Update(t_Function entity, int functionId)
        {
            try
            {
                t_Function function = FindSingle(x => x.FunctionId == functionId);
                function.FunctionName = entity.FunctionName;
                //function.URL = entity.URL;
                function.IsOnMenu = entity.IsOnMenu;

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