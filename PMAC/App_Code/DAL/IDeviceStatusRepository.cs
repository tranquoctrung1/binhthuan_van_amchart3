using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace PMAC.DAL
{
    /// <summary>
    /// Summary description for IDeviceStatusRepository
    /// </summary>
    public interface IDeviceStatusRepository : IDisposable
    {
        List<t_Device_Status> GetAllDeviceStatus();
    }
}