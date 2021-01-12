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
    public class FunctionBL : IDisposable
    {
        private bool disposedValue = false;
        private IFunctionRepository functionRepository;

        public FunctionBL()
        {
            this.functionRepository = new FunctionRepository();
        }

        public FunctionBL(IFunctionRepository functionRepository)
        {
            this.functionRepository = functionRepository;
        }
    
        public t_Function FindSingle(Expression<Func<t_Function, bool>> predicate)
        {
            return functionRepository.FindSingle(predicate);
        }

        public IEnumerable<t_Function> FindAll()
        {
            return functionRepository.FindAll();
        }

        public IEnumerable<t_Function> FindAll(Expression<Func<t_Function, bool>> predicate)
        {
            return functionRepository.FindAll(predicate);
        }

        public bool Update(t_Function entity, int functionId)
        {
            return functionRepository.Update(entity, functionId);
        }

        protected void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    functionRepository.Dispose();
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
