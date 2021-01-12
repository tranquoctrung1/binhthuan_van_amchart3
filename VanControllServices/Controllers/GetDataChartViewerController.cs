using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Web.Mvc;
using VanControllServices.Models;

namespace VanControllServices.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class GetDataChartViewerController : ApiController
    {
        // GET: GetDataChartViewer
        private binhthuanEntities db = new binhthuanEntities();
        public List<List<DataChartViewerViewModel>> GetDataCharts(string valveId, string start, string end)
        {
            List<List<DataChartViewerViewModel>> matrix = new List<List<DataChartViewerViewModel>>();
            DateTime startDate = new DateTime(1970, 01, 01).AddSeconds(int.Parse(start)).AddHours(7);
            DateTime endDate = new DateTime(1970, 01, 01).AddSeconds(int.Parse(end)).AddHours(7);

            List<string> listChannnel = new List<string>()
            {
                "Acquy", "Humidity", "P1", "P2", "P2Set", "Solar", "Temp"
            };

            foreach (string channel in listChannnel)
            {
                var data = db.Database.SqlQuery<DataChartViewerViewModel>("p_Data_Logger_Get @ChannelId, @StartDate, @EndDate, @SiteId",
                new SqlParameter("ChannelId", channel),
                new SqlParameter("StartDate", startDate),
                new SqlParameter("EndDate", endDate),
                new SqlParameter("SiteId", valveId)).ToList();

                if (data != null && data.Count != 0)
                {
                    foreach(var item in data)
                    {
                        item.ChannelID = channel;
                    }
                    matrix.Add(data);
                }
            }

            return matrix;
        }
    }
}