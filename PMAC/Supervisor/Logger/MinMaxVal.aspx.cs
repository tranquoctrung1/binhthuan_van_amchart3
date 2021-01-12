using PMAC.BLL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Supervisor_Logger_MinMaxVal : System.Web.UI.Page
{
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";
    protected void Page_Load(object sender, EventArgs e)
    {
        // Pi-solution
        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Logger/MinMaxVal.aspx")).ToList();

            var var1 = list.Where(x => x.ControlId.Contains("lbTitle")).FirstOrDefault();
            lbTitle.Text = (var1 == null) ? "" : var1.Contents;

            var var2 = list.Where(x => x.ControlId.Contains("lbFrom")).FirstOrDefault();
            lbFrom.Text = (var2 == null) ? "" : var2.Contents;
            var var3 = list.Where(x => x.ControlId.Contains("lbTo")).FirstOrDefault();
            lbTo.Text = (var3 == null) ? "" : var3.Contents;

            var var4 = list.Where(x => x.ControlId.Contains("btnView")).FirstOrDefault();
            btnView.Text = (var4 == null) ? "" : var4.Contents;
            var var5 = list.Where(x => x.ControlId.Contains("btnExport")).FirstOrDefault();
            btnExport.Text = (var5 == null) ? "" : var5.Contents;

            
            // Change header of rad grid
            var var15 = list.Where(x => x.ControlId.Contains("grid_Type")).FirstOrDefault();
            grid.MasterTableView.GetColumn("Type").HeaderText = (var15 == null) ? "" : var15.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("grid_TypeVal")).FirstOrDefault();
            grid.MasterTableView.GetColumn("TypeVal").HeaderText = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("grid_SiteId")).FirstOrDefault();
            grid.MasterTableView.GetColumn("SiteId").HeaderText = (var7 == null) ? "" : var7.Contents;
            var var8 = list.Where(x => x.ControlId.Contains("grid_SiteAliasName")).FirstOrDefault();
            grid.MasterTableView.GetColumn("SiteAliasName").HeaderText = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("grid_Loc")).FirstOrDefault();
            grid.MasterTableView.GetColumn("Loc").HeaderText = (var9 == null) ? "" : var9.Contents;

            var var10 = list.Where(x => x.ControlId.Contains("grid_LoggerId")).FirstOrDefault();
            grid.MasterTableView.GetColumn("LoggerId").HeaderText = (var10 == null) ? "" : var10.Contents;

            var var11 = list.Where(x => x.ControlId.Contains("grid_ChnId")).FirstOrDefault();
            grid.MasterTableView.GetColumn("ChnId").HeaderText = (var11 == null) ? "" : var11.Contents;
            var var12 = list.Where(x => x.ControlId.Contains("grid_ChnName")).FirstOrDefault();
            grid.MasterTableView.GetColumn("ChnName").HeaderText = (var12 == null) ? "" : var12.Contents;

            var var13 = list.Where(x => x.ControlId.Contains("grid_Tmstmp")).FirstOrDefault();
            grid.MasterTableView.GetColumn("Tmstmp").HeaderText = (var13 == null) ? "" : var13.Contents;
            var var14 = list.Where(x => x.ControlId.Contains("grid_Val")).FirstOrDefault();
            grid.MasterTableView.GetColumn("Val").HeaderText = (var14 == null) ? "" : var14.Contents;
            var var16 = list.Where(x => x.ControlId.Contains("grid_Unit")).FirstOrDefault();
            grid.MasterTableView.GetColumn("Unit").HeaderText = (var16 == null) ? "" : var16.Contents;

        }
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        if (dtmStart.SelectedDate == null || dtmEnd.SelectedDate == null)
        {
            ntf.Show("Start date or end date is empty!");
            return;
        }

        DateTime start = ((DateTime)dtmStart.SelectedDate).AddMilliseconds(1);
        DateTime end = ((DateTime)dtmEnd.SelectedDate).AddMilliseconds(1);

        List<string> sites = new List<string>();
        foreach (RadListBoxItem s in listBoxSelectedSites.Items)
        {
            sites.Add(s.Value);
        }

        List<string> types = new List<string>();
        foreach (RadListBoxItem t in listBoxSelectedTypes.Items)
        {
            types.Add(t.Value);
        }

        List<MMVModel> data = GetData(sites, types, start, end);

        grid.DataSource = data;
        grid.DataBind();
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        this.grid.ExportSettings.FileName = "MinMax" + ((DateTime)dtmStart.SelectedDate).ToString("ddMMyyyyHHmm") + "to" + ((DateTime)dtmEnd.SelectedDate).ToString("ddMMyyyyHHmm");

        this.grid.GridLines = GridLines.Both;
        this.grid.BorderStyle = BorderStyle.Solid;

        grid.MasterTableView.ExportToExcel();
    }

    public List<MMVModel> GetData(List<string> sites, List<string> types, DateTime start, DateTime end)
    {
        List<MMVModel> data = new List<MMVModel>();

        string siteId = "";
        string siteAliasName = "";
        string loc = "";
        string loggerId = "";
        string typeStr = "";

        string cnnStr = ConfigurationManager.ConnectionStrings["DbConnectionString"].ConnectionString;

        foreach (var s in sites)
        {
            using (SqlConnection cnn = new SqlConnection(cnnStr))
            {
                string cmdText = "select [siteAliasName],[location],[loggerId] from t_sites where [siteId]='" + s + "'";
                SqlCommand cmd = new SqlCommand(cmdText, cnn);

                cnn.Open();

                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {

                    siteId = s;
                    if (rd["siteAliasName"] != DBNull.Value)
                        siteAliasName = (string)rd["siteAliasName"];

                    if (rd["location"] != DBNull.Value)
                        loc = (string)rd["Location"];

                    if (rd["loggerId"] != DBNull.Value)
                        loggerId = (string)rd["loggerId"];

                }

                cnn.Close();
            }

            foreach (var t in types)
            {
                switch (t)
                {
                    case "0":

                        typeStr = "[pressure1]=1";

                        GetChannelData(siteId, siteAliasName, loc, loggerId, typeStr, "Pressure 1", start, end, ref data);

                        break;

                    case "1":

                        typeStr = "[pressure2]=1";

                        GetChannelData(siteId, siteAliasName, loc, loggerId, typeStr, "Pressure 2", start, end, ref data);

                        break;

                    case "2":

                        typeStr = "[forwardFlow]=1";

                        GetChannelData(siteId, siteAliasName, loc, loggerId, typeStr, "Forward flow", start, end, ref data);

                        break;

                    case "3":

                        typeStr = "[reverseFlow]=1";

                        GetChannelData(siteId, siteAliasName, loc, loggerId, typeStr, "Reverse flow", start, end, ref data);

                        break;

                    case "4":

                        GetChannelDataNet(siteId, siteAliasName, loc, loggerId, start, end, ref data);

                        break;

                    default:

                        break;

                }
            }
        }

        return data;
    }

    public void GetChannelData(string siteId, string siteAliasName, string loc, string loggerId, string typeStr, string type, DateTime start, DateTime end, ref List<MMVModel> data)
    {
        string chnId = "";
        string chnName = "";
        string unit = "";

        string cnnStr = ConfigurationManager.ConnectionStrings["DbConnectionString"].ConnectionString;

        using (SqlConnection cnn = new SqlConnection(cnnStr))
        {
            string cmdText = "select [channelId],[channelName],[unit] from t_channel_configurations where [loggerId]='" + loggerId + "' and " + typeStr;
            SqlCommand cmd = new SqlCommand(cmdText, cnn);

            cnn.Open();

            SqlDataReader rd = cmd.ExecuteReader();
            while (rd.Read())
            {
                if (rd["channelId"] != DBNull.Value)
                    chnId = (string)rd["channelId"];

                if (rd["channelName"] != DBNull.Value)
                    chnName = (string)rd["channelName"];

                if (rd["unit"] != DBNull.Value)
                    unit = (string)rd["unit"];
            }

            cnn.Close();
        }

        if (!string.IsNullOrEmpty(chnId))
        {
            double? max = null;
            double? min = null;
            double? avg = null;

            using (SqlConnection cnn = new SqlConnection(cnnStr))
            {
                string cmdText = "select max([value]) as mx,min([value]) as mn,avg([value]) as vg from t_Data_Logger_" + chnId 
                    + " where [timestamp] between '" + start.ToString("yyyy-MM-dd HH:mm:ss") + "' and '" + end.ToString("yyyy-MM-dd HH:mm") + "'";

                SqlCommand cmd = new SqlCommand(cmdText, cnn);

                cnn.Open();

                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    if (rd["mx"] != DBNull.Value)
                        max = (double)rd["mx"];

                    if (rd["mn"] != DBNull.Value)
                        min = (double)rd["mn"];

                    if (rd["vg"] != DBNull.Value)
                        avg = (double)rd["vg"];
                }

                cnn.Close();
            }

            if (max != null)
            {
                using (SqlConnection cnn = new SqlConnection(cnnStr))
                {
                    string cmdText = "select [timestamp],[value] from t_Data_Logger_" + chnId + " where [value]=" + max + " and [timestamp] between '" 
                        + start.ToString("yyyy-MM-dd HH:mm:ss") + "' and '" + end.ToString("yyyy-MM-dd HH:mm:ss") + "'";

                    SqlCommand cmd = new SqlCommand(cmdText, cnn);

                    cnn.Open();

                    SqlDataReader rd = cmd.ExecuteReader();
                    while (rd.Read())
                    {
                        MMVModel d = new MMVModel();

                        if (rd["timestamp"] != DBNull.Value)
                            d.Tmstmp = (DateTime)rd["timestamp"];

                        if (rd["value"] != DBNull.Value)
                            d.Val = (double)rd["value"];

                        d.ChnId = chnId;
                        d.ChnName = chnName;
                        d.Unit = unit;
                        d.Loc = loc;
                        d.LoggerId = loggerId;
                        d.SiteAliasName = siteAliasName;
                        d.SiteId = siteId;
                        d.Type = type;
                        d.TypeVal = "Max";

                        data.Add(d);
                    }

                    cnn.Close();
                }
            }

            if (min != null)
            {
                using (SqlConnection cnn = new SqlConnection(cnnStr))
                {
                    string cmdText = "select [timestamp],[value] from t_Data_Logger_" + chnId + " where [value]=" + min + " and [timestamp] between '" 
                        + start.ToString("yyyy-MM-dd HH:mm:ss") + "' and '" + end.ToString("yyyy-MM-dd HH:mm:ss") + "'";

                    SqlCommand cmd = new SqlCommand(cmdText, cnn);

                    cnn.Open();

                    SqlDataReader rd = cmd.ExecuteReader();
                    while (rd.Read())
                    {
                        MMVModel d = new MMVModel();

                        if (rd["timestamp"] != DBNull.Value)
                            d.Tmstmp = (DateTime)rd["timestamp"];

                        if (rd["value"] != DBNull.Value)
                            d.Val = (double)rd["value"];

                        d.ChnId = chnId;
                        d.ChnName = chnName;
                        d.Unit = unit;
                        d.Loc = loc;
                        d.LoggerId = loggerId;
                        d.SiteAliasName = siteAliasName;
                        d.SiteId = siteId;
                        d.Type = type;
                        d.TypeVal = "Min";

                        data.Add(d);
                    }

                    cnn.Close();

                }
            }

            if (avg != null)
            {
                MMVModel d = new MMVModel();

                d.Loc = loc;
                d.LoggerId = loggerId;
                d.SiteAliasName = siteAliasName;
                d.SiteId = siteId;
                d.Type = type;
                d.TypeVal = "Avg";
                d.Unit = unit;
                d.Val = avg;
                data.Add(d);
            }
        }
    }

    public void GetChannelDataNet(string siteId, string siteAliasName, string loc, string loggerId, DateTime start, DateTime end, ref List<MMVModel> data)
    {
        double? max = null;
        double? min = null;
        double? avg = null;

        string frwdId = null;
        string rvrsId = null;


        string cnnStr = ConfigurationManager.ConnectionStrings["DbConnectionString"].ConnectionString;

        using (SqlConnection cnn = new SqlConnection(cnnStr))
        {
            string cmdText = "select [channelId] from t_channel_configurations where [forwardFlow]=1 and [loggerId]='" + loggerId + "'";
            SqlCommand cmd = new SqlCommand(cmdText, cnn);

            cnn.Open();

            SqlDataReader rd = cmd.ExecuteReader();
            while (rd.Read())
            {
                if (rd[0] != DBNull.Value)
                    frwdId = (string)rd[0];
            }

            cnn.Close();
        }

        using (SqlConnection cnn = new SqlConnection(cnnStr))
        {
            string cmdText = "select [channelId] from t_channel_configurations where [reverseFlow]=1 and [loggerId]='" + loggerId + "'";
            SqlCommand cmd = new SqlCommand(cmdText, cnn);

            cnn.Open();

            SqlDataReader rd = cmd.ExecuteReader();
            while (rd.Read())
            {
                if (rd[0] != DBNull.Value)
                    rvrsId = (string)rd[0];
            }

            cnn.Close();
        }

        if (string.IsNullOrEmpty(frwdId) && string.IsNullOrEmpty(rvrsId))
            return;

        if (!string.IsNullOrEmpty(frwdId) && string.IsNullOrEmpty(rvrsId))
        {
            using (SqlConnection cnn = new SqlConnection(cnnStr))
            {
                string cmdText = "select max([value]) as mx,min([value]) as mn,avg([value]) as vg from t_data_logger_" + frwdId + " where [timestamp] between '" 
                    + start.ToString("yyyy-MM-dd HH:mm:ss") + "' and '" + end.ToString("yyyy-MM-dd HH:mm:ss") + "'";

                SqlCommand cmd = new SqlCommand(cmdText, cnn);

                cnn.Open();

                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    if (rd["mx"] != DBNull.Value)
                        max = (double)rd["mx"];

                    if (rd["mn"] != DBNull.Value)
                        min = (double)rd["mn"];

                    if (rd["vg"] != DBNull.Value)
                        avg = (double)rd["vg"];
                }

                cnn.Close();
            }

            if (max != null)
            {
                using (SqlConnection cnn = new SqlConnection(cnnStr))
                {
                    string cmdText = "select [timestamp],[value] from t_data_logger_" + frwdId + " where [value]=" + max + " and [timestamp] between '" 
                        + start.ToString("yyyy-MM-dd HH:mm:ss") + "' and '" + end.ToString("yyyy-MM-dd HH:mm:ss") + "'";

                    SqlCommand cmd = new SqlCommand(cmdText, cnn);

                    cnn.Open();

                    SqlDataReader rd = cmd.ExecuteReader();
                    while (rd.Read())
                    {
                        MMVModel d = new MMVModel();

                        if (rd["timestamp"] != DBNull.Value)
                            d.Tmstmp = (DateTime)rd["timestamp"];

                        if (rd["value"] != DBNull.Value)
                            d.Val = (double)rd["value"];

                        d.Loc = loc;
                        d.LoggerId = loggerId;
                        d.SiteAliasName = siteAliasName;
                        d.SiteId = siteId;
                        d.Unit = "m3/h";
                        d.Type = "net";
                        d.TypeVal = "Max";

                        data.Add(d);
                    }

                    cnn.Close();
                }
            }

            if (min != null)
            {
                using (SqlConnection cnn = new SqlConnection(cnnStr))
                {
                    string cmdText = "select [timestamp],[value] from t_data_logger_" + frwdId + " where [value]=" + min + " and [timestamp] between '" 
                        + start.ToString("yyyy-MM-dd HH:mm:ss") + "' and '" + end.ToString("yyyy-MM-dd HH:mm:ss") + "'";

                    SqlCommand cmd = new SqlCommand(cmdText, cnn);

                    cnn.Open();

                    SqlDataReader rd = cmd.ExecuteReader();
                    while (rd.Read())
                    {
                        MMVModel d = new MMVModel();

                        if (rd["timestamp"] != DBNull.Value)
                            d.Tmstmp = (DateTime)rd["timestamp"];

                        if (rd["value"] != DBNull.Value)
                            d.Val = (double)rd["value"];

                        d.Loc = loc;
                        d.LoggerId = loggerId;
                        d.SiteAliasName = siteAliasName;
                        d.SiteId = siteId;
                        d.Unit = "m3/h";
                        d.Type = "net";
                        d.TypeVal = "Min";

                        data.Add(d);
                    }

                    cnn.Close();
                }
            }

            if (avg != null)
            {
                MMVModel d = new MMVModel();

                d.Loc = loc;
                d.LoggerId = loggerId;
                d.SiteAliasName = siteAliasName;
                d.SiteId = siteId;
                d.Unit = "m3/h";
                d.Type = "net";
                d.TypeVal = "Avg";
                d.Val = avg;
                data.Add(d);
            }
        }

        if (string.IsNullOrEmpty(frwdId) && !string.IsNullOrEmpty(rvrsId))
        {
            using (SqlConnection cnn = new SqlConnection(cnnStr))
            {
                string cmdText = "select max(-[value]) as mx,min(-[value]) as mn,avg(-[value]) as vg from t_data_logger_" + rvrsId + " where [timestamp] between '" 
                    + start.ToString("yyyy-MM-dd HH:mm:ss") + "' and '" + end.ToString("yyyy-MM-dd HH:mm:ss") + "'";

                SqlCommand cmd = new SqlCommand(cmdText, cnn);

                cnn.Open();

                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    if (rd["mx"] != DBNull.Value)
                        max = (double)rd["mx"];

                    if (rd["mn"] != DBNull.Value)
                        min = (double)rd["mn"];

                    if (rd["vg"] != DBNull.Value)
                        avg = (double)rd["vg"];
                }

                cnn.Close();
            }

            if (max != null)
            {
                using (SqlConnection cnn = new SqlConnection(cnnStr))
                {
                    string cmdText = "select [timestamp],(-[value]) as [value] from t_data_logger_" + rvrsId + " where (-[value])=" + max + " and [timestamp] between '" 
                        + start.ToString("yyyy-MM-dd HH:mm:ss") + "' and '" + end.ToString("yyyy-MM-dd HH:mm:ss") + "'";

                    SqlCommand cmd = new SqlCommand(cmdText, cnn);

                    cnn.Open();

                    SqlDataReader rd = cmd.ExecuteReader();
                    while (rd.Read())
                    {
                        MMVModel d = new MMVModel();

                        if (rd["timestamp"] != DBNull.Value)
                            d.Tmstmp = (DateTime)rd["timestamp"];

                        if (rd["value"] != DBNull.Value)
                            d.Val = (double)rd["value"];

                        d.Loc = loc;
                        d.LoggerId = loggerId;
                        d.SiteAliasName = siteAliasName;
                        d.SiteId = siteId;
                        d.Unit = "m3/h";
                        d.Type = "net";
                        d.TypeVal = "Max";
                        
                        data.Add(d);
                    }

                    cnn.Close();
                }
            }

            if (min != null)
            {
                using (SqlConnection cnn = new SqlConnection(cnnStr))
                {
                    string cmdText = "select [timestamp],(-[value]) as [value] from t_data_logger_" + frwdId + " where (-[value])=" + min + " and [timestamp] between '" 
                        + start.ToString("yyyy-MM-dd HH:mm:ss") + "' and '" + end.ToString("yyyy-MM-dd HH:mm:ss") + "'";

                    SqlCommand cmd = new SqlCommand(cmdText, cnn);

                    cnn.Open();

                    SqlDataReader rd = cmd.ExecuteReader();
                    while (rd.Read())
                    {
                        MMVModel d = new MMVModel();

                        if (rd["timestamp"] != DBNull.Value)
                            d.Tmstmp = (DateTime)rd["timestamp"];

                        if (rd["value"] != DBNull.Value)
                            d.Val = (double)rd["value"];

                        d.Loc = loc;
                        d.LoggerId = loggerId;
                        d.SiteAliasName = siteAliasName;
                        d.SiteId = siteId;
                        d.Unit = "m3/h";
                        d.Type = "net";
                        d.TypeVal = "Min";

                        data.Add(d);
                    }

                    cnn.Close();
                }
            }

            if (avg != null)
            {
                MMVModel d = new MMVModel();
                d.Loc = loc;
                d.LoggerId = loggerId;
                d.SiteAliasName = siteAliasName;
                d.SiteId = siteId;
                d.Unit = "m3/h";
                d.Type = "net";
                d.TypeVal = "Avg";
                d.Val = avg;
                data.Add(d);
            }
        }

        if (!string.IsNullOrEmpty(frwdId) && !string.IsNullOrEmpty(rvrsId))
        {
            using (SqlConnection cnn = new SqlConnection(cnnStr))
            {
                string cmdText = "select max(net) as mx,min(net) as mn,avg(net) as vg from (select t1.[timestamp], t1.[value] as frwd, t2.[value] as rvrs, isnull(t1.[value],0)-isnull(t2.[value],0) as net from t_data_logger_" 
                    + @frwdId + " t1 left join t_data_logger_" + @rvrsId + " t2 on t1.[timestamp]=t2.[timestamp]) t where [timestamp] between '" + start.ToString("yyyy-MM-dd HH:mm:ss") + "' and '" + end.ToString("yyyy-MM-dd HH:mm:ss") + "'";
                
                SqlCommand cmd = new SqlCommand(cmdText, cnn);

                cnn.Open();

                SqlDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    if (rd["mx"] != DBNull.Value)
                        max = (double)rd["mx"];

                    if (rd["mn"] != DBNull.Value)
                        min = (double)rd["mn"];

                    if (rd["vg"] != DBNull.Value)
                        avg = (double)rd["vg"];
                }

                cnn.Close();
            }

            if (max != null)
            {
                using (SqlConnection cnn = new SqlConnection(cnnStr))
                {
                    string cmdText = "select [timestamp],[net] as [value] from (select t1.[timestamp], t1.[value] as frwd, t2.[value] as rvrs, isnull(t1.[value],0)-isnull(t2.[value],0) as net from t_data_logger_" 
                        + @frwdId + " t1 left join t_data_logger_" + @rvrsId + " t2 on t1.[timestamp]=t2.[timestamp]) t where [net]=" + max + " and [timestamp] between '" + start.ToString("yyyy-MM-dd HH:mm:ss") + "' and '" + end.ToString("yyyy-MM-dd HH:mm:ss") + "'";
                    
                    SqlCommand cmd = new SqlCommand(cmdText, cnn);

                    cnn.Open();

                    SqlDataReader rd = cmd.ExecuteReader();
                    while (rd.Read())
                    {
                        MMVModel d = new MMVModel();

                        if (rd["timestamp"] != DBNull.Value)
                            d.Tmstmp = (DateTime)rd["timestamp"];

                        if (rd["value"] != DBNull.Value)
                            d.Val = (double)rd["value"];

                        d.Loc = loc;
                        d.LoggerId = loggerId;
                        d.SiteAliasName = siteAliasName;
                        d.SiteId = siteId;
                        d.Unit = "m3/h";
                        d.Type = "net";
                        d.TypeVal = "Max";

                        data.Add(d);
                    }

                    cnn.Close();
                }
            }

            if (min != null)
            {
                using (SqlConnection cnn = new SqlConnection(cnnStr))
                {
                    string cmdText = "select [timestamp],[net] as [value] from (select t1.[timestamp], t1.[value] as frwd, t2.[value] as rvrs, isnull(t1.[value],0)-isnull(t2.[value],0) as net from t_data_logger_"
                        + @frwdId + " t1 left join t_data_logger_" + @rvrsId + " t2 on t1.[timestamp]=t2.[timestamp]) t where [net]=" + min + " and [timestamp] between '" + start.ToString("yyyy-MM-dd HH:mm:ss") + "' and '" + end.ToString("yyyy-MM-dd HH:mm:ss") + "'";

                    SqlCommand cmd = new SqlCommand(cmdText, cnn);

                    cnn.Open();

                    SqlDataReader rd = cmd.ExecuteReader();
                    while (rd.Read())
                    {
                        MMVModel d = new MMVModel();

                        if (rd["timestamp"] != DBNull.Value)
                            d.Tmstmp = (DateTime)rd["timestamp"];

                        if (rd["value"] != DBNull.Value)
                            d.Val = (double)rd["value"];

                        d.Loc = loc;
                        d.LoggerId = loggerId;
                        d.SiteAliasName = siteAliasName;
                        d.SiteId = siteId;
                        d.Unit = "m3/h";
                        d.Type = "net";
                        d.TypeVal = "Min";

                        data.Add(d);
                    }

                    cnn.Close();
                }
            }

            if (avg != null)
            {
                MMVModel d = new MMVModel();

                d.Loc = loc;
                d.LoggerId = loggerId;
                d.SiteAliasName = siteAliasName;
                d.SiteId = siteId;
                d.Unit = "m3/h";
                d.Type = "net";
                d.TypeVal = "Avg";
                d.Val = avg;
                data.Add(d);
            }
        }
    }

    public class MMVModel
    {
        private string _type;

        private string _typeVal;

        private string _siteId;

        private string _siteAliasName;

        private string _loc;

        private string _loggerId;

        private string _chnId;

        private string _chnName;

        private DateTime _tmstmp;

        private double? _val;

        private string _unit;

        public string Type { get { return _type; } set { _type = value; } }

        public string TypeVal { get { return _typeVal; } set { _typeVal = value; } }

        public string SiteId { get { return _siteId; } set { _siteId = value; } }

        public string SiteAliasName { get { return _siteAliasName; } set { _siteAliasName = value; } }

        public string Loc { get { return _loc; } set { _loc = value; } }

        public string LoggerId { get { return _loggerId; } set { _loggerId = value; } }

        public string ChnId { get { return _chnId; } set { _chnId = value; } }

        public string ChnName { get { return _chnName; } set { _chnName = value; } }

        public DateTime Tmstmp { get { return _tmstmp; } set { _tmstmp = value; } }

        public double? Val { get { return _val; } set { _val = value; } }

        public string Unit { get { return _unit; } set { _unit = value; } }
    }

    protected void grid_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = (GridDataItem)e.Item;
            if (dataItem["Tmstmp"].Text.Split(' ')[0] == "01/01/0001")
            {
                dataItem["Tmstmp"].Text = "";
            }
        }
    }
}