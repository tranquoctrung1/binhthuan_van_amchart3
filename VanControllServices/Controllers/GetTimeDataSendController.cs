using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Web.Mvc;

namespace VanControllServices.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class GetTimeDataSendController : ApiController
    {
        // GET: GetTimeDataSend
        private binhthuanEntities db = new binhthuanEntities();
        public DateTime? GetTimeDataSend(string valveId)
        {
            DateTime? temp = null;

            try
            {
                t_Valve_Status t = db.t_Valve_Status.Find(valveId);
                temp = t.TimeStamp;
            }
            catch
            {
                temp = null;
            }

            return temp;
        }
    }
}