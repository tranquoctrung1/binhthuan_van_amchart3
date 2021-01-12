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
    public class LanguageRepository:IDisposable, ILanguageRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

        public bool Add(t_LanguageTranslate entity)
        {
            throw new NotImplementedException();
        }        

        public IEnumerable<t_LanguageTranslate> FindAll()
        {
            return context.t_LanguageTranslate.OrderBy(c => c.Noted).ToList();
        }

        public IEnumerable<t_LanguageTranslate> FindAll(Expression<Func<t_LanguageTranslate, bool>> predicate)
        {
            return context.t_LanguageTranslate.Where(predicate).OrderBy(c=> c.Noted).ToList();
        }

        public t_LanguageTranslate FindById(int id)
        {
            throw new NotImplementedException();
        }

        public t_LanguageTranslate FindSingle(Expression<Func<t_LanguageTranslate, bool>> predicate)
        {
            return context.t_LanguageTranslate.Where(predicate).FirstOrDefault();
        }

        public void Remove(t_LanguageTranslate entity)
        {
            throw new NotImplementedException();
        }

        public void RemoveMultiple(List<t_LanguageTranslate> entities)
        {
            throw new NotImplementedException();
        }

        public bool Update(t_LanguageTranslate entity, int id)
        {
            try
            {
                t_LanguageTranslate content = FindSingle(x => x.Id == id);
                //content.ControlId = entity.ControlId;
                content.Contents = entity.Contents;
                //content.Noted = entity.Noted;

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