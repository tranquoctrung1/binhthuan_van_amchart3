using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Web.Http.Description;
using VanControllServices.Models;

namespace VanControllServices.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class WriteTakeSampleController : ApiController
    {
        private binhthuanEntities db = new binhthuanEntities();

        [ResponseType(typeof(bool))]
        public IHttpActionResult PutWriteTakeSample(string ip, string port, string tagname,  string value)
        {
            TakeSampleHelper takeSampleHelper = new TakeSampleHelper(ip, port);

            return Ok(takeSampleHelper.ChangeThreshold(tagname, value.ToString()));

        }
    }
}
