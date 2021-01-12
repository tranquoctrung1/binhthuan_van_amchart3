using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for ITransmitterRepository
    /// </summary>
    public interface ITransmitterRepository : IDisposable
    {
        t_Transmitters GetTransmitter(string serial);

        List<t_Transmitters> GetAllTransmitters();

        List<DeviceViewModel> GetTransmitterByConds(List<string> listProviders, List<string> listMarks, List<short> listSizes, List<string> listModels, List<string> listStatus, List<bool> listInstalleds);

        List<string> GetAllTransmitterProviders();

        List<string> GetAllTransmitterMarks();

        List<short?> GetAllTransmitterSizes();

        List<string> GetAllTransmitterModels();

        void InsertTransmitter(t_Transmitters Transmitter);

        void UpdateTransmitter(t_Transmitters Transmitter, t_Transmitters origTransmitter);

        void DeleteTransmitter(t_Transmitters Transmitter);
    }
}