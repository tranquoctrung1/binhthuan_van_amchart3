using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;
using System.Data.SqlClient;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for SiteRepository
    /// </summary>
    public class SiteRepository : IDisposable, ISiteRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

        public IEnumerable<t_Sites> GetSites()
        {
            return context.t_Sites.OrderBy(s => s.SiteAliasName).ToList();
        }

        public IEnumerable<t_Sites> GetSitesDMA()
        {
            return context.t_Sites.Where(s => s.DisplayGroup == "DMA").OrderBy(s => s.SiteId).ToList();
        }

        public IEnumerable<t_Sites> GetSitesByDisplayGroup(string displayGroup)
        {
            return context.t_Sites.Where(s => s.DisplayGroup == displayGroup).OrderBy(s => s.SiteId).ToList();
        }

        public List<SiteViewModel> GetSiteByConds(List<string> listConsumers, List<string> listStatus, List<string> listAvailabilities, List<string> listLoggerModels)
        {
            return (from s in context.t_Sites
                    join m in context.t_Meters on s.MeterSerial equals m.Serial into sm
                    where listConsumers.Contains(s.ConsumerId ?? string.Empty)
                    && listStatus.Contains(s.Status ?? string.Empty)
                    && listAvailabilities.Contains(s.Availability ?? string.Empty)
                    && listLoggerModels.Contains(s.t_Loggers.Model ?? string.Empty)
                    orderby s.SiteId
                    from m in sm.DefaultIfEmpty()
                    select new SiteViewModel
                    {
                        SiteID = s.SiteId,
                        SiteAliasName = s.SiteAliasName,
                        Location = s.Location,
                        MeterSerial = s.MeterSerial,
                        MeterMarks = m.Marks,
                        MeterSize = m.Size,
                        TransmitterSerial = s.TransmitterSerial,
                        LoggerSerial = s.LoggerSerial,
                        AccreditationDocument = m.AccreditationDocument,
                        ConsumerID = s.ConsumerId,
                        SiteStatus = s.Status,
                        SiteAvailability = s.Availability,
                        Description = s.Description,
                        PipeSize = s.PipeSize
                    }).ToList();
        }

        public IEnumerable<t_Sites> GetSitesByConsumerId(string consumerId)
        {
            return context.t_Sites.Where(s => s.ConsumerId == consumerId).OrderBy(s => s.SiteId).ToList();
        }

        public IEnumerable<t_Sites> GetSitesByStaffId(string staffId)
        {
            return context.t_Sites.Where(s => s.Staffs.Contains(staffId)).ToList();
        }

        public IEnumerable<t_Sites> GetSitesForMap()
        {
            return context.t_Sites.Where(s => s.Latitude != null && s.Longitude != null && !string.IsNullOrEmpty(s.LoggerId) && s.t_Logger_Configurations != null).ToList();
        }

        public IEnumerable<t_Sites> GetSitesForMapByConsumerId(string consumerId)
        {
            return context.t_Sites.Where(s => s.Latitude != null && s.Longitude != null && s.ConsumerId == consumerId && !string.IsNullOrEmpty(s.LoggerId) && s.t_Logger_Configurations != null).ToList();
        }

        public IEnumerable<t_Sites> GetSitesForMapByStaffId(string staffId)
        {
            return context.t_Sites.Where(s => s.Latitude != null && s.Longitude != null && s.Staffs.Contains(staffId) && !string.IsNullOrEmpty(s.LoggerId) && s.t_Logger_Configurations != null).ToList();
        }

        public t_Sites GetSite(string siteID)
        {
            return context.t_Sites.SingleOrDefault(s => s.SiteId == siteID);
        }

        public void InsertSite(t_Sites site)
        {
            try
            {
                site.LabelLat = site.Latitude;
                site.LabelLng = site.Longitude;
                site.LabelAnchorX = 15;
                site.LabelAnchorY = 0;
                if (string.IsNullOrEmpty(site.SiteAliasName))
                {
                    site.SiteAliasName = site.SiteId;
                }
                context.t_Sites.Add(site);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateSite(t_Sites site, t_Sites origSite)
        {
            try
            {
                context.t_Sites.Attach(origSite);
                origSite.SiteId = site.SiteId;
                origSite.SiteAliasName = site.SiteAliasName;
                if (string.IsNullOrEmpty(origSite.SiteAliasName))
                {
                    origSite.SiteAliasName = site.SiteId;
                }
                origSite.ConsumerId = site.ConsumerId;
                origSite.DisplayGroup = site.DisplayGroup;
                origSite.Latitude = site.Latitude;
                origSite.Location = site.Location;
                origSite.LoggerId = site.LoggerId;
                origSite.Longitude = site.Longitude;
                origSite.StartDay = site.StartDay;
                origSite.Zoom = site.Zoom;
                origSite.Description = site.Description;
                origSite.MeterSerial = site.MeterSerial;
                origSite.TransmitterSerial = site.TransmitterSerial;
                origSite.LoggerSerial = site.LoggerSerial;
                origSite.Status = site.Status;
                origSite.Availability = site.Availability;
                origSite.Staffs = site.Staffs;
                origSite.PipeSize = site.PipeSize;
                origSite.SetDelayTime = site.SetDelayTime;
                origSite.SetDiffValue = site.SetDiffValue;
                origSite.Baseline = site.Baseline;
                if (site.t_Logger_Configurations != null)
                {
                    var loggerConfiguration = origSite.t_Logger_Configurations;
                    loggerConfiguration.SiteId = site.t_Logger_Configurations.SiteId;
                    loggerConfiguration.StartHour = site.t_Logger_Configurations.StartHour;
                    loggerConfiguration.TelephoneNumber = site.t_Logger_Configurations.TelephoneNumber;
                    origSite.t_Logger_Configurations = loggerConfiguration;
                }
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteSite(t_Sites site)
        {
            try
            {
                // var list1 = context.t_Data_Complexes.Where(d => d.LoggerId == site.LoggerId).ToList();

                // foreach (var item in list1)
                // {
                //  context.t_Data_Complexes.Remove(item);
                //}
                context.Database.ExecuteSqlCommand("exec delete_complexdata @LoggerId", new SqlParameter("@LoggerId", site.LoggerId));

                var list2 = context.t_Channel_Configurations.Where(c => c.LoggerId == site.LoggerId).ToList();
                //.ForEach(context.t_Channel_Configurations.Remove);
                foreach (var item in list2)
                {
                    context.t_Channel_Configurations.Remove(item);
                    context.Database.ExecuteSqlCommand("exec p_Drop_Data_Table @channelId", new SqlParameter("channelId", item.ChannelId));
                }
                var list3 = context.t_Logger_Configurations.Where(c => c.LoggerId == site.LoggerId).ToList();
                //.ForEach(context.t_Logger_Configurations.Remove);
                foreach (var item in list3)
                {
                    context.t_Logger_Configurations.Remove(item);
                }
                context.t_Sites.Attach(site);
                context.t_Sites.Remove(site);
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

        public IEnumerable<t_SiteCustomer> GetSitesForMapCustom()
        {
            var result = (from s in context.t_Sites
                          join td in context.t_DisplayGroups on s.DisplayGroup equals td.Group
                          where s.Latitude != null && s.Longitude != null && !string.IsNullOrEmpty(s.LoggerId) && s.t_Logger_Configurations != null
                          select new t_SiteCustomer
                          {
                              SiteId = s.SiteId,
                              SiteAliasName = s.SiteAliasName,
                              Location = s.Location,
                              Latitude = (double)s.Latitude,
                              Longitude = (double)s.Longitude,
                              LoggerId = s.LoggerId,
                              LabelAnchorX = s.LabelAnchorX,
                              LabelAnchorY = s.LabelAnchorY,
                              DisplayGroup = td.Group,
                              Name = td.Name
                          }
                         ).ToList();

            return result;
        }
        public IEnumerable<t_SiteCustomer> GetSitesForMapByConsumerIdCustom(string consumerId)
        {
            var result = (from s in context.t_Sites
                          join td in context.t_DisplayGroups on s.DisplayGroup equals td.Group
                          where s.Latitude != null && s.Longitude != null && s.ConsumerId == consumerId && !string.IsNullOrEmpty(s.LoggerId) && s.t_Logger_Configurations != null
                          select new t_SiteCustomer
                          {
                              SiteId = s.SiteId,
                              SiteAliasName = s.SiteAliasName,
                              Location = s.Location,
                              Latitude = (double)s.Latitude,
                              Longitude = (double)s.Longitude,
                              LoggerId = s.LoggerId,
                              LabelAnchorX = s.LabelAnchorX,
                              LabelAnchorY = s.LabelAnchorY,
                              DisplayGroup = s.DisplayGroup,
                              Name = td.Name
                          }
                       ).ToList();

            return result;
        }
        public IEnumerable<t_SiteCustomer> GetSitesForMapByStaffIdCustom(string staffId)
        {
            var result = (from s in context.t_Sites
                          join td in context.t_DisplayGroups on s.DisplayGroup equals td.Group
                          where s.Latitude != null && s.Longitude != null && s.Staffs.Contains(staffId) && !string.IsNullOrEmpty(s.LoggerId) && s.t_Logger_Configurations != null
                          select new t_SiteCustomer
                          {
                              SiteId = s.SiteId,
                              SiteAliasName = s.SiteAliasName,
                              Location = s.Location,
                              Latitude = (double)s.Latitude,
                              Longitude = (double)s.Longitude,
                              LoggerId = s.LoggerId,
                              LabelAnchorX = s.LabelAnchorX,
                              LabelAnchorY = s.LabelAnchorY,
                              DisplayGroup = td.Group,
                              Name = td.Name
                          }
                        ).ToList();

            return result;
        }
    }
}