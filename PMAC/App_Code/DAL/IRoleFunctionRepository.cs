using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using System.Linq.Expressions;

namespace PMAC.DAL
{
    public interface IRoleFunctionRepository : IDisposable 
    {

        t_RoleFunction FindById(int id);

        t_RoleFunction FindSingle(Expression<Func<t_RoleFunction, bool>> predicate);

        IEnumerable<t_RoleFunction> FindAll();

        IEnumerable<t_RoleFunction> FindAll(Expression<Func<t_RoleFunction, bool>> predicate);

        void Add(t_RoleFunction entity);

        bool Update(t_RoleFunction entity, string roleName, int functionId);

        void Remove(t_RoleFunction entity);

        void RemoveMultiple(List<t_RoleFunction> entities);
    }
}