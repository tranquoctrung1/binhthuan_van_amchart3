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
    public class SysParamBL : IDisposable
    {
        private bool disposedValue = false;
        private ISysParamRepository sysParamRepository;

        public SysParamBL()
        {
            this.sysParamRepository = new SysParamRepository();
        }

        public SysParamBL(ISysParamRepository sysParamRepository)
        {
            this.sysParamRepository = sysParamRepository;
        }
    
        public t_SysParam FindSingle(Expression<Func<t_SysParam, bool>> predicate)
        {
            return sysParamRepository.FindSingle(predicate);
        }

        public IEnumerable<t_SysParam> FindAll()
        {
            return sysParamRepository.FindAll();
        }

        public IEnumerable<t_SysParam> FindAll(Expression<Func<t_SysParam, bool>> predicate)
        {
            return sysParamRepository.FindAll(predicate);
        }

        public bool Update(t_SysParam entity, int id)
        {
            return sysParamRepository.Update(entity, id);
        }


        protected void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    sysParamRepository.Dispose();
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
