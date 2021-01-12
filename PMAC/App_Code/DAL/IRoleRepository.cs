using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using System.Linq.Expressions;

namespace PMAC.DAL
{
    public interface IRoleRepository : IDisposable 
    {

        t_Roles FindById(int id);

        t_Roles FindSingle(Expression<Func<t_Roles, bool>> predicate);

        IEnumerable<t_Roles> FindAll();

        IEnumerable<t_Roles> FindAll(Expression<Func<t_Roles, bool>> predicate);

        void Add(t_Roles entity);

        bool Update(t_Roles entity, string roleName);

        void Remove(t_Roles entity);

        void RemoveMultiple(List<t_Roles> entities);
    }
}