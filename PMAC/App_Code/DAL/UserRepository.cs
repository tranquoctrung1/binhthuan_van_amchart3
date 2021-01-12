using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;

using PMAC.DAL;

namespace PMAC.DAL
{
    public class UserRepository : IDisposable, IUseRepository
    {
        private DBEntities context = new DBEntities();
        private bool disposedValue = false;

        public IEnumerable<t_Users> GetUsers(string filterConsumerID)
        {
            if (string.Equals(filterConsumerID, "_All") || string.IsNullOrWhiteSpace(filterConsumerID))
            {
                filterConsumerID = "";
            }
            try
            {
                context.Database.ExecuteSqlCommand("UPDATE t_Users SET [Active] = 0 WHERE DATEDIFF(minute,ISNULL([TimeStamp],GETDATE()),GETDATE()) > 20");
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }

            if (string.IsNullOrEmpty(filterConsumerID))
            {
                return context.t_Users.OrderBy(u => u.Username).ToList();
            }
            else
            return context.t_Users.Where(u => u.ConsumerId.StartsWith(filterConsumerID)).OrderBy(u => u.Username).ToList();
        }

        public IEnumerable<t_Users> GetUsersByRole(string role)
        {
            return context.t_Users.Where(u => u.Role == role);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    context.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public void InsertUser(t_Users user)
        {
            try
            {
                context.t_Users.Add(user);
                context.SaveChanges();
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
                context.t_Users.Attach(user);
                context.t_Users.Remove(user);
                context.SaveChanges();
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
                origUser.Active = user.Active;
                origUser.ConsumerId = user.ConsumerId;
                origUser.Email = user.Email;
                origUser.Ip = user.Ip;
                origUser.LoginTime = user.LoginTime;
                origUser.Password = user.Password;
                origUser.Role = user.Role;
                origUser.Salt = user.Salt;
                origUser.StaffId = user.StaffId;
                origUser.TimeStamp = user.TimeStamp;
                origUser.Username = user.Username;
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public t_Users GetUser(string username)
        {
            return context.t_Users.SingleOrDefault(u => u.Username == username);
        }

        public List<t_Users> FindAll()
        {
            return context.t_Users.ToList();
        }
    }
}
