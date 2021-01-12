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
    public class LanguageBL : IDisposable
    {
        private bool disposedValue = false;
        private ILanguageRepository languageRepository;

        public LanguageBL()
        {
            this.languageRepository = new LanguageRepository();
        }

        public LanguageBL(ILanguageRepository languageRepository)
        {
            this.languageRepository = languageRepository;
        }
    
        public t_LanguageTranslate FindSingle(Expression<Func<t_LanguageTranslate, bool>> predicate)
        {
            return languageRepository.FindSingle(predicate);
        }

        public IEnumerable<t_LanguageTranslate> FindAll(Expression<Func<t_LanguageTranslate, bool>> predicate)
        {
            return languageRepository.FindAll(predicate);
        }

        public bool Update(t_LanguageTranslate entity, int id)
        {
            return languageRepository.Update(entity, id);
        }


        protected void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    languageRepository.Dispose();
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
