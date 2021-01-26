using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GroupChannelRepository
/// </summary>
namespace PMAC.DAL
{
    public class GroupChannelRepository : IDisposable, IGroupChannelRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

        public IEnumerable<t_Units> GetAllunits()
        {
            return context.t_Units.ToList();
        }

        public IEnumerable<t_Channel_Configurations> GetGroupChannelByLoggerId(string loggerId)
        {
            var result = context.t_Channel_Configurations.GroupBy(x => x.GroupChannel)
                   .Select(grp => grp.FirstOrDefault(x=>x.LoggerId==loggerId && x.GroupChannel != null))
                   .ToList();

            var newList = new List<t_Channel_Configurations>();
            for (int i = 0; i < result.Count; i++)
            {
                if(result[i]!= null)
                {
                    newList.Add(result[i]);
                }
            }
            return newList;
        }

        public t_Channel_Configurations CheckDisplayGroupChannelDefault(string loggerId)
        {
            return context.t_Channel_Configurations.FirstOrDefault(x => x.LoggerId == loggerId && x.DisplayOnGraph == true);
        }

        public IEnumerable<t_Channel_Configurations> GetChannelByGroupChannel(string loggerId, string groupChannel)
        {
            return context.t_Channel_Configurations.OrderBy(g => g.GroupChannel)
                .Where(g => g.LoggerId == loggerId && g.GroupChannel== groupChannel).ToList();
        }

        public IEnumerable<t_GroupChannel> GetGroupChannels()
        {
            return context.t_GroupChannel.OrderBy(g => g.GroupChannel).ToList();
        }

        public t_GroupChannel GetGroupChannel(string groupID)
        {
            return context.t_GroupChannel.SingleOrDefault(g => g.GroupChannel == groupID);
        }

        public void InsertGroupChannel(t_GroupChannel group)
        {
            try
            {
                group.Status = 1;
                context.t_GroupChannel.Add(group);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateGroupChannel(t_GroupChannel group, t_GroupChannel origGroup)
        {
            try
            {
                context.t_GroupChannel.Attach(origGroup);
                origGroup.GroupChannel = group.GroupChannel;
                origGroup.Description = group.Description;
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteGroupChannel(t_GroupChannel group)
        {
            try
            {
                context.t_GroupChannel.Attach(group);
                context.t_GroupChannel.Remove(group);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
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