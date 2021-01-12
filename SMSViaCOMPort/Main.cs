using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO.Ports;
using System.Threading;
using System.Data.SqlClient;
using System.Configuration;

namespace SMSViaCOMPort
{
    public partial class Main : Form
    {
        SerialPort sp = new SerialPort();
        string rec = "";

        public Main()
        {
            InitializeComponent();

            string[] ports = SerialPort.GetPortNames();
            cboPortName.DataSource = ports;

            btnDisconnect.Enabled = false;

            btnAutoOff.Enabled = false;

            sp.DataReceived += serialPort_DataReceived;
        }

        void serialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            SerialPort _sp = (SerialPort)sender;

            byte[] buffer = new byte[_sp.ReadBufferSize];

            int bytesRead=0;

            try
            {
                bytesRead = _sp.Read(buffer, 0, buffer.Length);
            }
            catch (Exception ex) 
            {
                MessageBox.Show(ex.Message);
            }

            rec += Encoding.ASCII.GetString(buffer, 0, bytesRead);
        }

        private void btnConnect_Click(object sender, EventArgs e)
        {
            sp.BaudRate = int.Parse(cboBaudRate.Text);
            sp.DataBits = int.Parse(cboDataBit.Text);
            sp.Handshake = (Handshake)Enum.Parse(typeof(Handshake), cboHandShake.Text, true);
            sp.Parity = (Parity)Enum.Parse(typeof(Parity), cboParityBits.Text, true);
            sp.PortName = cboPortName.Text;
            sp.StopBits = (StopBits)Enum.Parse(typeof(StopBits), cboStopBits.Text, true);
            sp.ReadTimeout = (int)nmrReadTimeOut.Value;
            sp.WriteTimeout = (int)nmrWriteTimeout.Value;

            try
            {
                sp.Open();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                //throw;
            }

            if (sp.IsOpen)
            {
                lblStatus.Text = "Connected at " + sp.PortName;
                btnConnect.Enabled = false;
                btnDisconnect.Enabled = true;
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

        private void btnDisconnect_Click(object sender, EventArgs e)
        {
            try
            {
                sp.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                //throw;
            }
            
            if (!sp.IsOpen)
            {
                lblStatus.Text = "Disconnected";
                btnConnect.Enabled = true;
                btnDisconnect.Enabled = false;
            }
        }

        private void btnSend_Click(object sender, EventArgs e)
        {
            int i=0;
            while (i < 5)
            {
                SendSMS(StringUtilities.RemoveSign4VietnameseString(txtMsg.Text), txtSIM.Text);
                Thread.Sleep(5000);
                i++;
            }

        }

        private void btnAutoOn_Click(object sender, EventArgs e)
        {
            lblAlarmStatus.Text = "SMS On";
            btnAutoOff.Enabled = true;
            btnAutoOn.Enabled = false;

            //first time
            SendAlm(GetAlms());
            timer1.Enabled = true;
        }

        private void btnAutoOff_Click(object sender, EventArgs e)
        {
            lblAlarmStatus.Text = "SMS Off";
            btnAutoOff.Enabled = false;
            btnAutoOn.Enabled = true;
            timer1.Enabled = false;
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            SendAlm(GetAlms());
        }

        public bool SendSMS(string msg, string telNr)
        {
            bool sent = false;

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

        public void SendAlm(List<Alm> lstAlm)
        {
            //extend interval for next time
            if (lstAlm.Count == 0)
            {
                timer1.Interval = 5000;
            }
            else
            {
                timer1.Interval = lstAlm.Count * 6000;
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
    }
}
