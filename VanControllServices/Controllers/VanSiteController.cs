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
    public class VanSiteController : ApiController
    {
        private binhthuanEntities db = new binhthuanEntities();
        // GET: VanSite
        [EnableCors(origins: "*", headers: "*", methods: "*")]
        public List<VanSiteViewModel> GetVanSite(string valveId, string start, string end)
        {
            DateTime startTime = new DateTime(1970, 01, 01).AddSeconds(double.Parse(start)).AddHours(7);
            DateTime endTime = new DateTime(1970, 01, 01).AddSeconds(double.Parse(end)).AddHours(7);

            List<VanSiteViewModel> list = new List<VanSiteViewModel>();

            List<string> listChannnel = new List<string>()
            {
                "Acquy", "Humidity", "P1", "P2", "P2Set", "Solar", "Temp"
            };

            foreach(string channel in listChannnel)
            {
                var data = db.Database.SqlQuery<VanSiteViewModel>("p_GetDataCardSite @ChannelID, @start, @end, @siteid",
                new SqlParameter("channelid", channel),
                new SqlParameter("start", startTime),
                new SqlParameter("end", endTime),
                new SqlParameter("siteid", valveId)).FirstOrDefault();

                if(data != null)
                {
                    data.ChannelId = channel;
                    list.Add(data);
                }
            }

            return list;

        }
    }
}