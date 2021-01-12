using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Web.Http.Description;
using VanControllServices;

namespace VanControllServices.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class t_Valve_StatusController : ApiController
    {
        private binhthuanEntities db = new binhthuanEntities();

        // GET: api/t_Valve_Status
        public IQueryable<t_Valve_Status> Gett_Valve_Status()
        {
            return db.t_Valve_Status;
        }

        // GET: api/t_Valve_Status/5
        [ResponseType(typeof(t_Valve_Status))]
        public IHttpActionResult Gett_Valve_Status(string id)
        {
            t_Valve_Status t_Valve_Status = db.t_Valve_Status.Find(id);
            if (t_Valve_Status == null)
            {
                return NotFound();
            }

            return Ok(t_Valve_Status);
        }

        // PUT: api/t_Valve_Status/5
        [ResponseType(typeof(void))]
        public IHttpActionResult Putt_Valve_Status(string id, t_Valve_Status t_Valve_Status)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != t_Valve_Status.ValveID)
            {
                return BadRequest();
            }

            db.Entry(t_Valve_Status).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!t_Valve_StatusExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/t_Valve_Status
        [ResponseType(typeof(t_Valve_Status))]
        public IHttpActionResult Postt_Valve_Status(t_Valve_Status t_Valve_Status)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.t_Valve_Status.Add(t_Valve_Status);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (t_Valve_StatusExists(t_Valve_Status.ValveID))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = t_Valve_Status.ValveID }, t_Valve_Status);
        }

        // DELETE: api/t_Valve_Status/5
        [ResponseType(typeof(t_Valve_Status))]
        public IHttpActionResult Deletet_Valve_Status(string id)
        {
            t_Valve_Status t_Valve_Status = db.t_Valve_Status.Find(id);
            if (t_Valve_Status == null)
            {
                return NotFound();
            }

            db.t_Valve_Status.Remove(t_Valve_Status);
            db.SaveChanges();

            return Ok(t_Valve_Status);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool t_Valve_StatusExists(string id)
        {
            return db.t_Valve_Status.Count(e => e.ValveID == id) > 0;
        }
    }
}