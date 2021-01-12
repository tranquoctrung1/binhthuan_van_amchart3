using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;


namespace PMAC.BLL
{
    [DataObject]
    public class ConsumerBL : IDisposable
    {
        private bool disposedValue = false;
        private IConsumerRepository consumerRepository;

        public ConsumerBL()
        {
            this.consumerRepository = new ConsumerRepository();
        }

        public ConsumerBL(IConsumerRepository consumerRepository)
        {
            this.consumerRepository = consumerRepository;
        }
    
        public t_Consumers GetConsumer(string consumerID)
        {
            return consumerRepository.GetConsumer(consumerID);
        }

        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public IEnumerable<t_Consumers> GetConsumers()
        {
            return consumerRepository.GetConsumers();
        }

        public void InsertConsumer(t_Consumers consumer)
        {
            try
            {
                consumerRepository.InsertConsumer(consumer);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void UpdateConsumer(t_Consumers consumer, t_Consumers origConsumer)
        {
            try
            {
                consumerRepository.UpdateConsumer(consumer, origConsumer);
            }
            catch (Exception ex)
            {
                //
                throw ex;
            }
        }

        public void DeleteConsumer(t_Consumers consumer)
        {
            try
            {
                consumerRepository.DeleteConsumer(consumer);
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
                    consumerRepository.Dispose();
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
