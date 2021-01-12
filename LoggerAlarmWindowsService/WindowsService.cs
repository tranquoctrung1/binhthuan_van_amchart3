using System;
using System.Configuration;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.ServiceProcess;
using System.Linq;
using System.Timers;
using System.IO;
using System.Threading;
using System.IO.Ports;
using System.Text;

namespace WindowsService
{
    class WindowsService : ServiceBase
    {
        private System.Timers.Timer timer1 = null;
        private System.Timers.Timer timer2 = null;
        SerialPort sp = new SerialPort();
        string rec = "";

        /// <summary>
        /// Public Constructor for WindowsService.
        /// - Put all of your Initialization code here.
        /// </summary>
        public WindowsService()
        {
            this.ServiceName = "Data Logger Alarming Service";
            this.EventLog.Log = "Application";

            // These Flags set whether or not to handle that specific
            //  type of event. Set to true if you need it, false otherwise.
            this.CanHandlePowerEvent = true;
            this.CanHandleSessionChangeEvent = true;
            this.CanPauseAndContinue = true;
            this.CanShutdown = true;
            this.CanStop = true;
        }

        /// <summary>
        /// The Main Thread: This is where your Service is Run.
        /// </summary>
        static void Main()
        {
            ServiceBase.Run(new WindowsService());
        }

        /// <summary>
        /// Dispose of objects that need it here.
        /// </summary>
        /// <param name="disposing">Whether
        ///    or not disposing is going on.</param>
        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
        }

        /// <summary>
        /// OnStart(): Put startup code here
        ///  - Start threads, get inital data, etc.
        /// </summary>
        /// <param name="args"></param>
        protected override void OnStart(string[] args)
        {
            AddAlm();

            timer1 = new System.Timers.Timer();
            this.timer1.Interval = 29000;
            this.timer1.Elapsed += timer1_Elapsed;
            timer1.Enabled = true;

            timer2 = new System.Timers.Timer();
            this.timer2.Interval = 29000;
            this.timer2.Elapsed += timer2_Elapsed;
            timer2.Enabled = true;

            base.OnStart(args);
        }

        void timer2_Elapsed(object sender, ElapsedEventArgs e)
        {
            //throw new NotImplementedException();
            SendAlm(GetAlms());
        }

        void timer1_Elapsed(object sender, ElapsedEventArgs e)
        {
            AddAlm();

            //WriteLogFile("text");
            //InsertTestRecord();
            //throw new NotImplementedException();
        }

        /// <summary>
        /// OnStop(): Put your stop code here
        /// - Stop threads, set final data, etc.
        /// </summary>
        protected override void OnStop()
        {
            timer1.Enabled = false;
            timer2.Enabled = false;
            base.OnStop();
        }

        /// <summary>
        /// OnPause: Put your pause code here
        /// - Pause working threads, etc.
        /// </summary>
        protected override void OnPause()
        {
            base.OnPause();
        }

        /// <summary>
        /// OnContinue(): Put your continue code here
        /// - Un-pause working threads, etc.
        /// </summary>
        protected override void OnContinue()
        {
            base.OnContinue();
        }

        /// <summary>
        /// OnShutdown(): Called when the System is shutting down
        /// - Put code here when you need special handling
        ///   of code that deals with a system shutdown, such
        ///   as saving special data before shutdown.
        /// </summary>
        protected override void OnShutdown()
        {
            base.OnShutdown();
        }

        /// <summary>
        /// OnCustomCommand(): If you need to send a command to your
        ///   service without the need for Remoting or Sockets, use
        ///   this method to do custom methods.
        /// </summary>
        /// <param name="command">Arbitrary Integer between 128 & 256</param>
        protected override void OnCustomCommand(int command)
        {
            //  A custom command can be sent to a service by using this method:
            //#  int command = 128; //Some Arbitrary number between 128 & 256
            //#  ServiceController sc = new ServiceController("NameOfService");
            //#  sc.ExecuteCommand(command);

            base.OnCustomCommand(command);
        }

        /// <summary>
        /// OnPowerEvent(): Useful for detecting power status changes,
        ///   such as going into Suspend mode or Low Battery for laptops.
        /// </summary>
        /// <param name="powerStatus">The Power Broadcast Status
        /// (BatteryLow, Suspend, etc.)</param>
        protected override bool OnPowerEvent(PowerBroadcastStatus powerStatus)
        {
            return base.OnPowerEvent(powerStatus);
        }

        /// <summary>
        /// OnSessionChange(): To handle a change event
        ///   from a Terminal Server session.
        ///   Useful if you need to determine
        ///   when a user logs in remotely or logs off,
        ///   or when someone logs into the console.
        /// </summary>
        /// <param name="changeDescription">The Session Change
        /// Event that occured.</param>
        protected override void OnSessionChange(
                  SessionChangeDescription changeDescription)
        {
            base.OnSessionChange(changeDescription);
        }

        /// <summary>
        /// Test Only
        /// </summary>
        /// <param name="text"></param>
        public void WriteLogFile(string text)
        {
            StreamWriter sw = null;
            try 
            {
                sw = new StreamWriter("D:\\LogFile.txt", true);
                sw.WriteLine(DateTime.Now.ToString() + " : " + text);
                sw.Flush();
                sw.Close();
            }
            catch { }
        }

        /// <summary>
        /// Test Only
        /// </summary>
        public void AddTestRecord()
        {
            string cnnStr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnnStr))
            {
                Random rand = new Random();
                
                string cmdText = "insert into t_Test_Service values ('" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") 
                    + "','" 
                    + (100*rand.NextDouble()).ToString() + "')";

                SqlCommand cmd = new SqlCommand(cmdText, cnn);

                cnn.Open();

                cmd.ExecuteNonQuery();

                cnn.Close();
            }
        }

        /// <summary>
        /// Insert Alarm to SQL
        /// </summary>
        public void AddAlm()
        {
            string cnnStr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

            IEnumerable<Site> sites = GetSites();
            foreach (Site s in sites)
            {
                IEnumerable<Chn> chns = GetChns(s.LoggerId);

                foreach (Chn c in chns)
                {
                    if (c.Tmstmp != null && (c.Pres1 == true || c.Pres2 == true))
                    {
                        bool exists = false;
                        using (SqlConnection cnn = new SqlConnection(cnnStr))
                        {
                            string cmdText = "select*from [t_Alarms] where [siteId]='" + s.Id 
                                + "' and [channelId]='" + c.Id 
                                + "' and [timeStamp]='" + ((DateTime)c.Tmstmp).ToString("yyyy-MM-dd HH:mm:ss") + "'";

                            SqlCommand cmd = new SqlCommand(cmdText, cnn);

                            cnn.Open();

                            SqlDataReader rd = cmd.ExecuteReader();
                            while (rd.Read())
                            {
                                exists = true;
                            }

                            cnn.Close();
                        }

                        if (!exists)
                        {
                            string msg1 = s.Id + ", " + c.Name + ", " + ((DateTime)c.Tmstmp).ToString("dd/MM/yyyy HH:mm");
                            string msg2 = "";
                            string msg3 = "";
                            string msg4 = "";

                            if (c.SS2)
                                msg2 += "Delay " + Math.Round((DateTime.Now - (DateTime)c.Tmstmp).TotalMinutes).ToString() + " min";

                            if (c.SS3)
                                msg3 += "Differ value " + c.DifValPer.ToString("#,00.00") + "%";

                            if (c.SS4)
                                msg4 += "Press=0";

                            if (!string.IsNullOrEmpty(msg2) || !string.IsNullOrEmpty(msg3) || !string.IsNullOrEmpty(msg4))
                            {
                                using (SqlConnection cnn = new SqlConnection(cnnStr))
                                {
                                    string cmdText = "insert into [t_Alarms]([SiteId],[SiteName],[ChannelId],[ChannelName],[TimeStamp],[Msg1],[Msg2],[Msg3],[Msg4],[Trigger]) values('" 
                                        + s.Id + "','" + s.AName + "','" + c.Id + "','" + StringUtilities.RemoveSign4VietnameseString(c.Name) + "','" + ((DateTime)c.Tmstmp).ToString("yyyy-MM-dd HH:mm:ss") + "','" 
                                        + StringUtilities.RemoveSign4VietnameseString(msg1) + "','" + StringUtilities.RemoveSign4VietnameseString(msg2) + "','" + StringUtilities.RemoveSign4VietnameseString(msg3) + "','" + StringUtilities.RemoveSign4VietnameseString(msg4) + "',1)";
                                    
                                    SqlCommand cmd = new SqlCommand(cmdText, cnn);

                                    cnn.Open();

                                    cmd.ExecuteNonQuery();

                                    cnn.Close();
                                }
                            }
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Get Sites
        /// </summary>
        /// <returns></returns>
        public IEnumerable<Site> GetSites()
        {
            List<Site> lst = new List<Site>();

            string cnnStr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnnStr))
            {
                string cmdText = "select [siteId],[siteAliasName],[location],[loggerId],[displayGroup],[latitude],[longitude],[labelAnchorX],[labelAnchorY] from [t_sites] order by [displayGroup],[location]";
                SqlCommand cmd = new SqlCommand(cmdText, cnn);

                cnn.Open();

                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    Site s = new Site();

                    if (rd["siteId"] != DBNull.Value)
                        s.Id = (string)rd["siteId"];

                    if (rd["siteAliasName"] != DBNull.Value)
                        s.AName = (string)rd["siteAliasName"];

                    if (rd["displayGroup"] != DBNull.Value)
                        s.DispGrp = (string)rd["displayGroup"];

                    if (rd["location"] != DBNull.Value)
                        s.Loc = (string)rd["location"];

                    if (rd["loggerId"] != DBNull.Value)
                        s.LoggerId = (string)rd["loggerId"];

                    if (rd["latitude"] != DBNull.Value)
                        s.Lat = (double)rd["latitude"];

                    if (rd["longitude"] != DBNull.Value)
                        s.Lng = (double)rd["longitude"];

                    if (rd["labelAnchorX"] != DBNull.Value)
                        s.LblX = (int)rd["labelAnchorX"];

                    if (rd["labelAnchorY"] != DBNull.Value)
                        s.LblY = (int)rd["labelAnchorY"];
                    lst.Add(s);
                }

                cnn.Close();
            }

            return lst.Where(i => (i.LoggerId != null) && (i.LoggerId != "")).ToList();
        }

        /// <summary>
        /// Get Channels
        /// </summary>
        /// <param name="loggerId"></param>
        /// <returns></returns>
        public IEnumerable<Chn> GetChns(string loggerId)
        {
            List<Chn> lst = new List<Chn>();

            string cnnStr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnnStr))
            {
                string cmdText = "select [loggerId],[channelId],[channelName],[pressure1],[pressure2],[timestamp],[lastValue],[unit],[indexTimestamp],[lastIndex] from [t_channel_configurations] where [loggerId]='" + loggerId + "' order by [channelName]";
                SqlCommand cmd = new SqlCommand(cmdText, cnn);

                cnn.Open();

                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    Chn c = new Chn();

                    if (rd["loggerId"] != DBNull.Value)
                        c.LoggerId = (string)rd["loggerId"];

                    if (rd["channelId"] != DBNull.Value)
                        c.Id = (string)rd["channelId"];

                    if (rd["channelName"] != DBNull.Value)
                        c.Name = (string)rd["channelName"];

                    if (rd["pressure1"] != DBNull.Value)
                        c.Pres1 = (bool)rd["pressure1"];

                    if (rd["pressure2"] != DBNull.Value)
                        c.Pres2 = (bool)rd["pressure2"];

                    if (rd["timestamp"] != DBNull.Value)
                        c.Tmstmp = (DateTime)rd["timestamp"];

                    if (rd["lastValue"] != DBNull.Value)
                        c.Val = (double)rd["lastValue"];

                    if (rd["indexTimestamp"] != DBNull.Value)
                        c.IndexTmstmp = (DateTime)rd["indexTimestamp"];

                    if (rd["lastIndex"] != DBNull.Value)
                        c.LastIndex = (double)rd["lastIndex"];

                    if (rd["unit"] != DBNull.Value)
                        c.Unit = rd["unit"].ToString();

                    lst.Add(c);
                }

                cnn.Close();
            }

            int setDelayTime = 60;
            double setDiffValue = 0.3;

            using (SqlConnection cnn = new SqlConnection(cnnStr))
            {
                string cmdText = "select top 1 [setDelayTime],[setDiffValue] from [t_sites] where [loggerId]='" + loggerId + "'";
                SqlCommand cmd = new SqlCommand(cmdText, cnn);

                cnn.Open();

                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    if (rd["setDelayTime"] != DBNull.Value)
                        setDelayTime = (int)rd["setDelayTime"];

                    if (rd["setDiffValue"] != DBNull.Value)
                        setDiffValue = (double)rd["setDiffValue"];
                }

                cnn.Close();
            }

            foreach (var c in lst)
            {
                using (SqlConnection cnn = new SqlConnection(cnnStr))
                {
                    string cmdText = "select [siteId],[siteAliasName] from [t_sites] where [loggerId]='" + c.LoggerId + "'";
                    SqlCommand cmd = new SqlCommand(cmdText, cnn);

                    cnn.Open();
                    SqlDataReader rd = cmd.ExecuteReader();

                    while (rd.Read())
                    {
                        if (rd["siteId"] != DBNull.Value)
                            c.SiteId = rd["siteId"].ToString();

                        if (rd["siteAliasName"] != DBNull.Value)
                            c.SiteName = rd["siteAliasName"].ToString();
                    }

                    cnn.Close();
                }

                if (c.Pres1 == true || c.Pres2 == true)
                {
                    c.SS = 1;

                    if (c.Tmstmp != null && (DateTime.Now - (DateTime)c.Tmstmp).TotalMinutes >= setDelayTime)
                    {
                        c.SS = 2;
                        c.SS2 = true;
                    }

                    if (c.Tmstmp != null && c.Val != null)
                    {
                        double? value = null;

                        using (SqlConnection cnn = new SqlConnection(cnnStr))
                        {
                            string cmdText = "select [value] from [t_Data_Logger_" + c.Id + "] where [Timestamp]='" + ((DateTime)c.Tmstmp).AddDays(-1).ToString("yyyy-MM-dd HH:mm") + "'";
                            SqlCommand cmd = new SqlCommand(cmdText, cnn);

                            cnn.Open();
                            SqlDataReader rd = cmd.ExecuteReader();

                            while (rd.Read())
                            {
                                if (rd["Value"] != DBNull.Value) 
                                    value = (double)rd["Value"];
                            }

                            cnn.Close();
                        }

                        if (value != null && (((double)value <= ((double)c.Val) * (1 - setDiffValue)) || ((double)value >= ((double)c.Val) * (1 + setDiffValue))))
                        {
                            c.SS = 3;
                            c.SS3 = true;
                            c.DifValPer = 100 * ((double)c.Val - (double)value) / (double)value;
                        }
                    }

                    if (c.Val <= 0 || c.Val == null)
                    {
                        c.SS = 4;
                        c.SS4 = true;
                    }

                    if (c.SS != 1)
                        c.SS1 = false;
                }
            }

            if (lst.Count == 0)
                lst.Add(new Chn());
            return lst;
        }

        /// <summary>
        /// Get Alarm for SMS
        /// </summary>
        /// <returns></returns>
        public List<Alm> GetAlms()
        {
            string cnnStr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

            List<Alm> lst = new List<Alm>();

            using (SqlConnection cnn = new SqlConnection(cnnStr))
            {
                string cmdText = "select ac.[id] as [AlmCfgId],ac.[phoneNr],ac.[ena1],ac.[ena2],ac.[ena3],ac.[ena4],ac.[ena],a.[id] as [AlmId],a.[msg1],a.[msg2],a.[msg3],a.[msg4] from t_Alarm_Configurations ac inner join t_Alarms a on ac.[siteId]=a.[siteId] where a.[trigger]=1 and ac.[ena]=1 order by a.[timestamp]";
                SqlCommand cmd = new SqlCommand(cmdText, cnn);

                cnn.Open();

                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    Alm a = new Alm();
                    AlmCfg c = new AlmCfg();

                    c.Id = (int)rd["AlmCfgId"];

                    a.Id = (int)rd["AlmId"];

                    string p = "";
                    if (rd["phoneNr"] != DBNull.Value)
                        p = rd["PhoneNr"].ToString();

                    c.TelNr = p;

                    bool ena1 = false;
                    bool ena2 = false;
                    bool ena3 = false;
                    bool ena4 = false;

                    if (rd["ena1"] != DBNull.Value)
                        ena1 = (bool)rd["ena1"];

                    if (rd["ena2"] != DBNull.Value)
                        ena2 = (bool)rd["ena2"];

                    if (rd["ena3"] != DBNull.Value)
                        ena3 = (bool)rd["ena3"];

                    if (rd["ena4"] != DBNull.Value)
                        ena4 = (bool)rd["ena4"];

                    a.Msg1 = StringUtilities.RemoveSign4VietnameseString(rd["msg1"].ToString());

                    a.Msg2 = StringUtilities.RemoveSign4VietnameseString(rd["msg2"].ToString());

                    a.Msg3 = StringUtilities.RemoveSign4VietnameseString(rd["msg3"].ToString());

                    a.Msg4 = StringUtilities.RemoveSign4VietnameseString(rd["msg4"].ToString());

                    string content = a.Msg1 + ": ";
                    string init = content;

                    if (ena2)
                        content += a.Msg2 + ";";

                    if (ena3)
                        content += a.Msg3 + ";";

                    if (ena4)
                        content += a.Msg4 + ";";

                    a.Msg = content;

                    a.AlmCfg = c;

                    if (content != init)
                    {
                        lst.Add(a);
                    }
                }

                cnn.Close();
            }

            return lst;
        }

        /// <summary>
        /// Send Alarm
        /// </summary>
        /// <param name="lstAlm"></param>
        public void SendAlm(List<Alm> lstAlm)
        {
            //extend interval for next time
            if (lstAlm.Count == 0)
            {
                timer2.Interval = 6000;
            }
            else
            {
                timer2.Interval = lstAlm.Count * 6000;
            }
            string cnnStr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

            bool sent;

            for (int i = 0; i < lstAlm.Count; i++)
            {
                sent = SendSMS(lstAlm[i].Msg, lstAlm[i].AlmCfg.TelNr);

                Thread.Sleep(5000);

                if (sent)
                {
                    using (SqlConnection cnn = new SqlConnection(cnnStr))
                    {
                        string cmdText = "update t_Alarms set [trigger]=0 where [Id]=" + lstAlm[i].Id.ToString();
                        SqlCommand cmd = new SqlCommand(cmdText, cnn);
                        cnn.Open();
                        cmd.ExecuteNonQuery();
                        cnn.Close();
                    }
                }

                else
                {
                    using (SqlConnection cnn = new SqlConnection(cnnStr))
                    {
                        string cmdText = "insert into t_Alarm_Failed([alarmId],[alarmConfiguration],[failed]) values (" + lstAlm[i].Id + "," + lstAlm[i].AlmCfg.Id + ",1)";
                        SqlCommand cmd = new SqlCommand(cmdText, cnn);
                        cnn.Open();
                        cmd.ExecuteNonQuery();
                        cnn.Close();
                    }
                }
            }
        }

        /// <summary>
        /// Send SMS
        /// </summary>
        /// <param name="msg"></param>
        /// <param name="telNr"></param>
        /// <returns></returns>
        public bool SendSMS(string msg, string telNr)
        {
            bool sent = false;

            sp.BaudRate = 9600;
            sp.DataBits = 8;
            sp.Handshake = Handshake.None;
            sp.Parity = Parity.None;
            sp.PortName = "COM4";//Change it to current configs
            sp.StopBits = StopBits.None;
            sp.ReadTimeout = 5000;
            sp.WriteTimeout = 5000;

            if (!sp.IsOpen)
            {
                try
                {
                    sp.Open();
                }
                catch (Exception ex)
                {
                    //MessageBox.Show(ex.Message);
                    //throw;
                }

                if (sp.IsOpen)
                {
                    //lblStatus.Text = "Connected at " + sp.PortName;
                    //btnConnect.Enabled = false;
                    //btnDisconnect.Enabled = true;
                }

                try
                {
                    sp.Write("AT\r\n");
                }
                catch (Exception ex)
                {

                    //throw;
                }

                Thread.Sleep(400);

                if (rec == "\r\nOKr\n")
                {
                    rec = "";
                }

                try
                {
                    sp.Write("AT+CMGF=1\r");
                }

                catch (Exception ex)
                {

                    //throw;
                }

                Thread.Sleep(100);

                if (rec == "\r\nOK\r\n")
                {

                    rec = "";
                }
            }

            if (!sp.IsOpen)
            {
                return false;
            }

            try
            {
                sp.Write("AT+CMGS=\"" + telNr + "\"\r");
            }
            catch (Exception ex)
            {

                //throw;
            }

            Thread.Sleep(100);


            if (rec == "\r\n")
            {

                rec = "";
            }

            try
            {
                sp.Write(msg + (char)26);
            }
            catch (Exception ex)
            {

                //throw;
            }

            Thread.Sleep(100);

            try
            {
                sp.Write("" + (char)27);
            }
            catch (Exception ex)
            {

                //throw;
            }

            Thread.Sleep(100);

            if (rec == "\r\nOK\r\n")
            {

                rec = "";
            }

            Thread.Sleep(100);

            if (rec.Contains("\r\nOK\r\n"))
            {
                sent = true;
                rec = "";
            }

            Thread.Sleep(100);

            if (rec.Contains("ERROR"))
            //if (received == "\r\n+CMS ERROR: 515\r\n")
            {
                sent = false;
                rec = "";
            }

            return sent;
        }

        void serialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            SerialPort _sp = (SerialPort)sender;

            byte[] buffer = new byte[_sp.ReadBufferSize];

            int bytesRead = 0;

            try
            {
                bytesRead = _sp.Read(buffer, 0, buffer.Length);
            }
            catch (Exception ex)
            {
                //MessageBox.Show(ex.Message);
            }

            rec += Encoding.ASCII.GetString(buffer, 0, bytesRead);
        }
    }
}