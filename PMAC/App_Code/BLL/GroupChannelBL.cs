using PMAC.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GroupChannelBL
/// </summary>
namespace PMAC.BLL
{
    [DataObject]
    public class GroupChannelBL : IDisposable
    {
        private bool disposedValue = false;
        private IGroupChannelRepository groupChannelRepository;

        public GroupChannelBL()
        {
            this.groupChannelRepository = new GroupChannelRepository();
        }

        public GroupChannelBL(IGroupChannelRepository groupChannelRepository)
        {
            this.groupChannelRepository = groupChannelRepository;
        }


        public IEnumerable<t_Units> GetAllunits()
        {
            return groupChannelRepository.GetAllunits();
        }


        public t_GroupChannel GetGroupChannel(string groupID)
        {
            return groupChannelRepository.GetGroupChannel(groupID);
        }

        public IEnumerable<t_Channel_Configurations> GetGroupChannelByLoggerId(string loggerID)
        {
            return groupChannelRepository.GetGroupChannelByLoggerId(loggerID);
        }
        public IEnumerable<t_Channel_Configurations> GetChannelByGroupChannel(string loggerId, string groupChannel)
        {
            return groupChannelRepository.GetChannelByGroupChannel(loggerId, groupChannel);
        }

        public t_Channel_Configurations CheckDisplayGroupChannelDefault(string loggerId)
        {
            return groupChannelRepository.CheckDisplayGroupChannelDefault(loggerId);
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public IEnumerable<t_GroupChannel> GetGroupChannels()
        {
            return groupChannelRepository.GetGroupChannels();
        }

        public void InsertGroupChannel(t_GroupChannel groupChannel)
        {
            try
            {
                groupChannelRepository.InsertGroupChannel(groupChannel);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateGroupChannel(t_GroupChannel groupChannel, t_GroupChannel origGroupChannel)
        {
            try
            {
                groupChannelRepository.UpdateGroupChannel(groupChannel, origGroupChannel);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteGroupChannel(t_GroupChannel groupChannel)
        {
            try
            {
                groupChannelRepository.DeleteGroupChannel(groupChannel);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        protected void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    groupChannelRepository.Dispose();
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