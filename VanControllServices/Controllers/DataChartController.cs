using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Web.Http.Description;
using VanControllServices;
using VanControllServices.Models;

namespace VanControllServices.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class DataChartController : ApiController
    {
        private binhthuanEntities db = new binhthuanEntities();
        //Get api/datachart/id/start/end
        public dynamic GetDataChart(string id, string start, string end)
        {
            try
            {
                DateTime startTime = new DateTime(1970, 01, 01).AddSeconds(double.Parse(start));
                DateTime endTime = new DateTime(1970, 01, 01).AddSeconds(double.Parse(end));

                startTime = new DateTime(startTime.Year, startTime.Month, startTime.Day, 0, 0, 0);
                endTime = new DateTime(endTime.Year, endTime.Month, endTime.Day, 23, 59, 59);

                var data = db.Database.SqlQuery<DataChart>("p_Get_Data_ChannelID @channelid, @start, @end",
                    new SqlParameter("channelid", id),
                    new SqlParameter("start", startTime),
                    new SqlParameter("end", endTime)).ToList();

                return data;
            }
            catch(Exception ex)
            {
                return new List<DataChart>();
            }
           
        }
    }
}
