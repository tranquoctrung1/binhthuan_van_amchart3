using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using System.Linq.Expressions;

namespace PMAC.DAL
{
    public interface ISysParamRepository : IDisposable 
    {

        t_SysParam FindById(int id);

        t_SysParam FindSingle(Expression<Func<t_SysParam, bool>> predicate);

        IEnumerable<t_SysParam> FindAll();

        IEnumerable<t_SysParam> FindAll(Expression<Func<t_SysParam, bool>> predicate);

        bool Add(t_SysParam entity);

        bool Update(t_SysParam entity, int id);

        void Remove(t_SysParam entity);

        void RemoveMultiple(List<t_SysParam> entities);
    }
}