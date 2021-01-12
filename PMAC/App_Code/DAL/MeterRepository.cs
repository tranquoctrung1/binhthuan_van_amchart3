using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for MeterRepository
    /// </summary>
    public class MeterRepository : IDisposable, IMeterRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();

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

        public t_Meters GetMeter(string serial)
        {
            return context.t_Meters.SingleOrDefault(m => m.Serial == serial);
        }

        public List<t_Meters> GetAllMeters()
        {
            return context.t_Meters.OrderBy(m => m.Serial).ToList();
        }

        public List<DeviceViewModel> GetMeterByConds(List<string> listProviders, List<string> listMarks, List<short> listSizes, List<string> listModels, List<string> listStatus, List<bool> listInstalleds)
        {
            return (from m in context.t_Meters
                    join s in context.t_Sites on m.Serial equals s.MeterSerial into ms
                    where listProviders.Contains(m.Provider ?? string.Empty)
                    && listMarks.Contains(m.Marks ?? string.Empty)
                    && listSizes.Contains(m.Size ?? 0)
                    && listModels.Contains(m.Model ?? string.Empty)
                    && listStatus.Contains(m.Status ?? string.Empty)
                    && listInstalleds.Contains(m.Installed ?? false)
                    orderby m.Serial
                    from s in ms.DefaultIfEmpty()
                    where m.Serial != string.Empty
                    select new DeviceViewModel
                    {
                        Serial = m.Serial,
                        Provider = m.Provider,
                        Marks = m.Marks,
                        Size = m.Size,
                        Model = m.Model,
                        Status = m.Status,
                        Installed = m.Installed ?? false,
                        ReceiptDate = m.ReceiptDate,
                        Description = m.Description,
                        SiteID = s.SiteId,
                        SitaAliasName = s.SiteAliasName,
                        Location = s.Location
                    }).ToList();
        }

        public List<string> GetAllMeterProviders()
        {
            return context.t_Meters.OrderBy(m => m.Provider).Select(m => m.Provider).Distinct().ToList();
        }

        public List<string> GetAllMeterMarks()
        {
            return context.t_Meters.OrderBy(m => m.Marks).Select(m => m.Marks).Distinct().ToList();
        }

        public List<short?> GetAllMeterSizes()
        {
            return context.t_Meters.OrderBy(m => m.Size).Select(m => m.Size).Distinct().ToList();
        }

        public List<string> GetAllMeterModels()
        {
            return context.t_Meters.OrderBy(m => m.Model).Select(m => m.Model).Distinct().ToList();
        }

        public void InsertMeter(t_Meters meter)
        {
            try
            {
                context.t_Meters.Add(meter);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateMeter(t_Meters meter, t_Meters origMeter)
        {
            try
            {
                context.t_Meters.Attach(origMeter);
                origMeter.AccreditationDocument = meter.AccreditationDocument;
                origMeter.ApprovalDecision = meter.ApprovalDecision;
                origMeter.Approved = meter.Approved;
                origMeter.ApprovedDate = meter.ApprovedDate;
                origMeter.Description = meter.Description;
                origMeter.Installed = meter.Installed;
                origMeter.Marks = meter.Marks;
                origMeter.Model = meter.Model;
                origMeter.Provider = meter.Provider;
                origMeter.ReceiptDate = meter.ReceiptDate;
                origMeter.Serial = meter.Serial;
                origMeter.Size = meter.Size;
                origMeter.Status = meter.Status;
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteMeter(t_Meters meter)
        {
            try
            {
                context.t_Meters.Attach(meter);
                context.t_Meters.Remove(meter);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }
    }
}