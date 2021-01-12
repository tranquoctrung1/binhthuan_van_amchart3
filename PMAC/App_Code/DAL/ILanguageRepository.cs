using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using System.Linq.Expressions;

namespace PMAC.DAL
{
    public interface ILanguageRepository : IDisposable 
    {

        t_LanguageTranslate FindById(int id);

        t_LanguageTranslate FindSingle(Expression<Func<t_LanguageTranslate, bool>> predicate);

        IEnumerable<t_LanguageTranslate> FindAll();

        IEnumerable<t_LanguageTranslate> FindAll(Expression<Func<t_LanguageTranslate, bool>> predicate);

        bool Add(t_LanguageTranslate entity);

        bool Update(t_LanguageTranslate entity, int id);

        void Remove(t_LanguageTranslate entity);

        void RemoveMultiple(List<t_LanguageTranslate> entities);
    }
}