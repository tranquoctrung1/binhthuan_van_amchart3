using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PMAC.DAL;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for TransmitterRepository
    /// </summary>
    public class TransmitterRepository : IDisposable, ITransmitterRepository
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

        public t_Transmitters GetTransmitter(string serial)
        {
            return context.t_Transmitters.SingleOrDefault(m => m.Serial == serial);
        }

        public List<t_Transmitters> GetAllTransmitters()
        {
            return context.t_Transmitters.OrderBy(t => t.Serial).ToList();
        }

        public List<DeviceViewModel> GetTransmitterByConds(List<string> listProviders, List<string> listMarks, List<short> listSizes, List<string> listModels, List<string> listStatus, List<bool> listInstalleds)
        {
            return (from t in context.t_Transmitters
                    join s in context.t_Sites on t.Serial equals s.TransmitterSerial into ts
                    where listProviders.Contains(t.Provider ?? string.Empty)
                    && listMarks.Contains(t.Marks ?? string.Empty)
                    && listSizes.Contains(t.Size ?? 0)
                    && listModels.Contains(t.Model ?? string.Empty)
                    && listStatus.Contains(t.Status ?? string.Empty)
                    && listInstalleds.Contains(t.Installed ?? false)
                    orderby t.Serial
                    from s in ts.DefaultIfEmpty()
                    where t.Serial != string.Empty
                    select new DeviceViewModel
                    {
                        Serial = t.Serial,
                        Provider = t.Provider,
                        Marks = t.Marks,
                        Size = t.Size,
                        Model = t.Model,
                        Status = t.Status,
                        Installed = t.Installed ?? false,
                        ReceiptDate = t.ReceiptDate,
                        Description = t.Description,
                        SiteID = s.SiteId,
                        SitaAliasName = s.SiteAliasName,
                        Location = s.Location
                    }).ToList();
        }

        public List<string> GetAllTransmitterProviders()
        {
            return context.t_Transmitters.OrderBy(m => m.Provider).Select(m => m.Provider).Distinct().ToList();
        }

        public List<string> GetAllTransmitterMarks()
        {
            return context.t_Transmitters.OrderBy(m => m.Marks).Select(m => m.Marks).Distinct().ToList();
        }

        public List<short?> GetAllTransmitterSizes()
        {
            return context.t_Transmitters.OrderBy(m => m.Size).Select(m => m.Size).Distinct().ToList();
        }

        public List<string> GetAllTransmitterModels()
        {
            return context.t_Transmitters.OrderBy(m => m.Model).Select(m => m.Model).Distinct().ToList();
        }

        public void InsertTransmitter(t_Transmitters transmitter)
        {
            try
            {
                context.t_Transmitters.Add(transmitter);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateTransmitter(t_Transmitters transmitter, t_Transmitters origTransmitter)
        {
            try
            {
                context.t_Transmitters.Attach(origTransmitter);
                origTransmitter.AccreditationDocument = transmitter.AccreditationDocument;
                origTransmitter.ApprovalDecision = transmitter.ApprovalDecision;
                origTransmitter.Approved = transmitter.Approved;
                origTransmitter.ApprovedDate = transmitter.ApprovedDate;
                origTransmitter.Description = transmitter.Description;
                origTransmitter.Installed = transmitter.Installed;
                origTransmitter.Marks = transmitter.Marks;
                origTransmitter.Model = transmitter.Model;
                origTransmitter.Provider = transmitter.Provider;
                origTransmitter.ReceiptDate = transmitter.ReceiptDate;
                origTransmitter.Size = transmitter.Size;
                origTransmitter.Status = transmitter.Status;
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteTransmitter(t_Transmitters transmitter)
        {
            try
            {
                context.t_Transmitters.Attach(transmitter);
                context.t_Transmitters.Remove(transmitter);
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