using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PMAC.DAL
{
    public interface IGroupChannelRepository : IDisposable
    {

        void DeleteGroupChannel(t_GroupChannel group);

        t_GroupChannel GetGroupChannel(string groupID);

        IEnumerable<t_Channel_Configurations> GetGroupChannelByLoggerId(string loggerId);
        IEnumerable<t_Channel_Configurations> GetChannelByGroupChannel(string loggerId, string groupChannel);
        IEnumerable<t_GroupChannel> GetGroupChannels();

        void InsertGroupChannel(t_GroupChannel group);

        void UpdateGroupChannel(t_GroupChannel group, t_GroupChannel origGroup);
        t_Channel_Configurations CheckDisplayGroupChannelDefault(string loggerId);
        IEnumerable<t_Units> GetAllunits();
    }
}