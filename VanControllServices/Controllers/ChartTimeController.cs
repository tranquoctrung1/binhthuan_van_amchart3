using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using VanControllServices.Models;
using WebGrease.ImageAssemble;

namespace VanControllServices.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class ChartTimeController : ApiController
    {
        private binhthuanEntities db = new binhthuanEntities();
        public dynamic GetTime(string id)
        {
            var data = db.Database.SqlQuery<TotalSecond>("p_Get_DateTime_Data_Exists @channelid",
                new SqlParameter("channelid", id));

            return data;
        }
    }
}