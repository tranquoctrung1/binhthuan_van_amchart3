using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using System.Linq.Expressions;

namespace PMAC.DAL
{
    public interface IFunctionRepository : IDisposable 
    {

        t_Function FindById(int id);

        t_Function FindSingle(Expression<Func<t_Function, bool>> predicate);

        IEnumerable<t_Function> FindAll();

        IEnumerable<t_Function> FindAll(Expression<Func<t_Function, bool>> predicate);

        bool Add(t_Function entity);

        bool Update(t_Function entity, int functionId);

        void Remove(t_Function entity);

        void RemoveMultiple(List<t_Function> entities);
    }
}