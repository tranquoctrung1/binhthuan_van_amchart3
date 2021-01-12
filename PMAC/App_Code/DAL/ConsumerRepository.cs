using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using PMAC.DAL;


namespace PMAC.DAL
{
    public class ConsumerRepository:IDisposable, IConsumerRepository
    {
        private bool disposedValue = false;
        private DBEntities context = new DBEntities();
    
        public IEnumerable<t_Consumers> GetConsumers()
        {
            return context.t_Consumers.OrderBy(c => c.ConsumerId).ToList();
        }

        public t_Consumers GetConsumer(string consumerID)
        {
            return context.t_Consumers.SingleOrDefault(c => c.ConsumerId == consumerID);
        }

        public void InsertConsumer(t_Consumers consumer)
        {
            try
            {
                context.t_Consumers.Add(consumer);
                context.SaveChanges();
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
                context.t_Consumers.Attach(origConsumer);
                origConsumer.ConsumerId = consumer.ConsumerId;
                origConsumer.Description = consumer.Description;
                context.SaveChanges();
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
                context.t_Consumers.Attach(consumer);
                context.t_Consumers.Remove(consumer);
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