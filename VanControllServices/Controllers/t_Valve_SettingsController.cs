using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Web.Http.Description;

namespace VanControllServices.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class t_Valve_SettingController : ApiController
    {
        private binhthuanEntities db = new binhthuanEntities();

        // GET: api/t_Valve_Setting
        public IQueryable<t_Valve_Setting> Gett_Valve_Setting()
        {
            return db.t_Valve_Setting;
        }

        // GET: api/t_Valve_Setting/5
        [ResponseType(typeof(t_Valve_Setting))]
        public IHttpActionResult Gett_Valve_Setting(string id)
        {
            t_Valve_Setting t_Valve_Setting = db.t_Valve_Setting.Find(id);
            if (t_Valve_Setting == null)
            {
                return NotFound();
            }

            return Ok(t_Valve_Setting);
        }

        // PUT: api/t_Valve_Setting/5
        [ResponseType(typeof(void))]
        public IHttpActionResult Putt_Valve_Setting(t_Valve_Setting t_Valve_Setting)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            int nRows = 0;

            using(SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlQuery = $"update t_Valve_Setting set ValveID = '{t_Valve_Setting.ValveID}', ValveTag = '{t_Valve_Setting.ValveTag}', Value = {t_Valve_Setting.Value}, Flag = '{t_Valve_Setting.Flag}'";

                connect.Open();
                using(SqlCommand command = new SqlCommand(sqlQuery, connect))
                {
                    nRows = command.ExecuteNonQuery();
                }
            }

            return Ok(nRows);
        }

        // POST: api/t_Valve_Setting
        [ResponseType(typeof(t_Valve_Setting))]
        public IHttpActionResult Postt_Valve_Setting(t_Valve_Setting t_Valve_Setting)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.t_Valve_Setting.Add(t_Valve_Setting);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (t_Valve_SettingExists(t_Valve_Setting.ValveID))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = t_Valve_Setting.ValveID }, t_Valve_Setting);
        }

        // DELETE: api/t_Valve_Setting/5
        [ResponseType(typeof(t_Valve_Setting))]
        public IHttpActionResult Deletet_Valve_Setting(string id)
        {
            t_Valve_Setting t_Valve_Setting = db.t_Valve_Setting.Find(id);
            if (t_Valve_Setting == null)
            {
                return NotFound();
            }

            db.t_Valve_Setting.Remove(t_Valve_Setting);
            db.SaveChanges();

            return Ok(t_Valve_Setting);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool t_Valve_SettingExists(string id)
        {
            return db.t_Valve_Setting.Count(e => e.ValveID == id) > 0;
        }
    }
}