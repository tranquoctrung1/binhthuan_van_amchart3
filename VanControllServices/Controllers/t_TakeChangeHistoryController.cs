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
    public class t_TakeChangeHistoryController : ApiController
    {
        private binhthuanEntities db = new binhthuanEntities();

        // GET: api/t_TakeChangeHistory
        public IQueryable<t_TakeChangeHistory> Gett_TakeChangeHistory()
        {
            return db.t_TakeChangeHistory;
        }

        // GET: api/t_TakeChangeHistory/5
        [ResponseType(typeof(t_TakeChangeHistory))]
        public IHttpActionResult Gett_TakeChangeHistory(int id)
        {
            t_TakeChangeHistory t_TakeChangeHistory = db.t_TakeChangeHistory.Find(id);
            if (t_TakeChangeHistory == null)
            {
                return NotFound();
            }

            return Ok(t_TakeChangeHistory);
        }

        // PUT: api/t_TakeChangeHistory/5
        [ResponseType(typeof(void))]
        public IHttpActionResult Putt_TakeChangeHistory(int id, t_TakeChangeHistory t_TakeChangeHistory)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != t_TakeChangeHistory.ID)
            {
                return BadRequest();
            }

            db.Entry(t_TakeChangeHistory).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!t_TakeChangeHistoryExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.OK);
        }

        // POST: api/t_TakeChangeHistory
        [ResponseType(typeof(t_TakeChangeHistory))]
        public IHttpActionResult Postt_TakeChangeHistory(t_TakeChangeHistory t_TakeChangeHistory)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.t_TakeChangeHistory.Add(t_TakeChangeHistory);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = t_TakeChangeHistory.ID }, t_TakeChangeHistory);
        }

        // DELETE: api/t_TakeChangeHistory/5
        [ResponseType(typeof(t_TakeChangeHistory))]
        public IHttpActionResult Deletet_TakeChangeHistory(int id)
        {
            t_TakeChangeHistory t_TakeChangeHistory = db.t_TakeChangeHistory.Find(id);
            if (t_TakeChangeHistory == null)
            {
                return NotFound();
            }

            db.t_TakeChangeHistory.Remove(t_TakeChangeHistory);
            db.SaveChanges();

            return Ok(t_TakeChangeHistory);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool t_TakeChangeHistoryExists(int id)
        {
            return db.t_TakeChangeHistory.Count(e => e.ID == id) > 0;
        }
    }
}