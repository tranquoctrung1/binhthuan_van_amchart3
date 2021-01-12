using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;


namespace PMAC.DAL
{
    public interface IDisplayGroupRepository : IDisposable
    {

        void DeleteDisplayGroup(t_DisplayGroups group);

        t_DisplayGroups GetDisplayGroup(string groupID);

        IEnumerable<t_DisplayGroups> GetDisplayGroups();

        void InsertDisplayGroup(t_DisplayGroups group);

        void UpdateDisplayGroup(t_DisplayGroups group, t_DisplayGroups origGroup);
    }
}