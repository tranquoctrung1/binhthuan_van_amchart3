using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;


namespace PMAC.DAL
{
    public interface IUseRepository : IDisposable
    {
        List<t_Users> FindAll();

        void InsertUser(t_Users user);

        void UpdateUser(t_Users user, t_Users origUser);
        

        void DeleteUser(t_Users user);

        IEnumerable<t_Users> GetUsers(string filterConsumerID);

        IEnumerable<t_Users> GetUsersByRole(string role);

        t_Users GetUser(string username);

    }
}