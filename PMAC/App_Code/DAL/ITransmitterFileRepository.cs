using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for ITransmitterFileRepository
    /// </summary>
    public interface ITransmitterFileRepository : IDisposable
    {
        IEnumerable<t_Transmitter_Files> GetTransmitterFilesByTransmitterSerial(string TransmitterSerial);

        t_Transmitter_Files GetTransmitterFile(string fileName);

        void InsertTransmitterFile(t_Transmitter_Files TransmitterFile);

        void UpdateTransmitterFile(t_Transmitter_Files TransmitterFile, t_Transmitter_Files orgiTransmitterFile);

        void DeleteTransmitterFile(t_Transmitter_Files TransmitterFile);
    }
}