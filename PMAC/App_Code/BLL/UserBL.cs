using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;

using PMAC.DAL;

namespace PMAC.BLL
{
    [DataObject]
    public class UserBL : IDisposable
    {
        private IUseRepository userRepository;
        private bool disposedValue = false;

        public UserBL()
        {
            this.userRepository = new UserRepository();
        }

        public UserBL(IUseRepository userRepository)
        {
            this.userRepository = userRepository;
        }

        public List<t_Users> FindAll()
        {
            try
            {
                return userRepository.FindAll();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void InsertUser(t_Users user)
        {
            try
            {
                userRepository.InsertUser(user);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateUser(t_Users user, t_Users origUser)
        {
            try
            {
                userRepository.UpdateUser(user, origUser);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteUser(t_Users user)
        {
            try
            {
                userRepository.DeleteUser(user);
            }
            catch (Exception ex)
            {
                //
                throw;
            }
        }

        public t_Users GetUser(string username)
        {
            return userRepository.GetUser(username);
        }

        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public IEnumerable<t_Users> GetUsers(string filterConsumerID)
        {
            return userRepository.GetUsers(filterConsumerID);
        }

        public IEnumerable<t_Users> GetUsersByRole(string role)
        {
            return userRepository.GetUsersByRole(role);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    userRepository.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}
