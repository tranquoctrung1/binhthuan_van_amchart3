using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;


namespace PMAC.DAL
{
    public interface IConsumerRepository : IDisposable
    {

        void DeleteConsumer(t_Consumers consumer);

        t_Consumers GetConsumer(string consumerID);

        IEnumerable<t_Consumers> GetConsumers();

        void InsertConsumer(t_Consumers consumer);

        void UpdateConsumer(t_Consumers consumer, t_Consumers origConsumer);
    }
}