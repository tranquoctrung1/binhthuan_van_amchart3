using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using PMAC.BLL;

public partial class Supervisor_Summary_Site : System.Web.UI.Page
{
    SiteBL _siteBL = new SiteBL();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Summary/Site.aspx")).ToList();

            var var01 = list.Where(x => x.ControlId.Contains("lbTitle")).FirstOrDefault();
            lbTitle.Text = (var01 == null) ? "" : var01.Contents;

            var var02 = list.Where(x => x.ControlId.Contains("lbCustomerId")).FirstOrDefault();
            lbCustomerId.Text = (var02 == null) ? "" : var02.Contents;
            var var04 = list.Where(x => x.ControlId.Contains("lbStatus")).FirstOrDefault();
            lbStatus.Text = (var04 == null) ? "" : var04.Contents;
            var var14 = list.Where(x => x.ControlId.Contains("lbCondition")).FirstOrDefault();
            lbCondition.Text = (var14 == null) ? "" : var14.Contents;
            var var15 = list.Where(x => x.ControlId.Contains("lbModelLogger")).FirstOrDefault();
            lbModelLogger.Text = (var15 == null) ? "" : var15.Contents;

            // Change header of rad grid
            var var5 = list.Where(x => x.ControlId.Contains("grv_STT")).FirstOrDefault();
            grv.MasterTableView.GetColumn("STT").HeaderText = (var5 == null) ? "" : var5.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("grv_SiteAliasName")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column13").HeaderText = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("grv_Location")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column2").HeaderText = (var7 == null) ? "" : var7.Contents;
            var var8 = list.Where(x => x.ControlId.Contains("grv_PipeSize")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column14").HeaderText = (var8 == null) ? "" : var8.Contents;


            var var10 = list.Where(x => x.ControlId.Contains("grv_MeterSerial")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column3").HeaderText = (var10 == null) ? "" : var10.Contents;

            var var11 = list.Where(x => x.ControlId.Contains("grv_MeterMarks")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column4").HeaderText = (var11 == null) ? "" : var11.Contents;
            var var12 = list.Where(x => x.ControlId.Contains("grv_MeterSize")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column5").HeaderText = (var12 == null) ? "" : var12.Contents;

            var var22 = list.Where(x => x.ControlId.Contains("grv_TransmitterSerial")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column6").HeaderText = (var22 == null) ? "" : var22.Contents;
            var var32 = list.Where(x => x.ControlId.Contains("grv_LoggerSerial")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column7").HeaderText = (var32 == null) ? "" : var32.Contents;
            var var42 = list.Where(x => x.ControlId.Contains("grv_AccreditationDocument")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column8").HeaderText = (var42 == null) ? "" : var42.Contents;
            var var52 = list.Where(x => x.ControlId.Contains("grv_ConsumerID")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column9").HeaderText = (var52 == null) ? "" : var52.Contents;
            var var53 = list.Where(x => x.ControlId.Contains("grv_SiteStatus")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column10").HeaderText = (var53 == null) ? "" : var53.Contents;
            var var54 = list.Where(x => x.ControlId.Contains("grv_SiteAvailability")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column11").HeaderText = (var54 == null) ? "" : var54.Contents;
            var var55 = list.Where(x => x.ControlId.Contains("grv_Description")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column12").HeaderText = (var55 == null) ? "" : var55.Contents;

            var var003 = list.Where(x => x.ControlId.Contains("btnView")).FirstOrDefault();
            btnView.Text = (var003 == null) ? "" : var003.Contents;
            var var004 = list.Where(x => x.ControlId.Contains("btnExport")).FirstOrDefault();
            btnExport.Text = (var004 == null) ? "" : var004.Contents;
        }

        if (!IsPostBack)
        {
            BindData();
        }
    }

    private void BindData()
    {
        grv.DataSource = _siteBL.GetSiteByConds(GetConsumers(),
            GetStatus(),
            GetAvailabilities(),
            GetLoggerModels()
            );
        grv.DataBind();
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected void btnExport_Click(object sender, EventArgs e)
    {
        try
        {
            grv.ExportSettings.FileName = "Điểm lắp đặt";
            grv.MasterTableView.ExportToExcel();
        }
        catch (Exception ex)
        {

            //throw;
        }
    }
    protected void grv_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = (GridDataItem)e.Item;
            dataItem["STT"].Text = (e.Item.ItemIndex + 1).ToString();
        }
    }

    private List<string> GetConsumers()
    {
        List<string> list = new List<string>();
        foreach (ListItem item in chkListConsumers.Items)
        {
            if (item.Selected)
            {
                list.Add(item.Value);
            }
        }
        if (list.Count == 0)
        {
            foreach (ListItem item in chkListConsumers.Items)
            {
                list.Add(item.Value);
            }
            list.Add("");
        }
        return list;
    }

    private List<string> GetStatus()
    {
        List<string> list = new List<string>();
        foreach (ListItem item in chkListStatus.Items)
        {
            if (item.Selected)
            {
                list.Add(item.Value);
            }
        }
        if (list.Count == 0)
        {
            foreach (ListItem item in chkListStatus.Items)
            {
                list.Add(item.Value);
            }
            list.Add("");
        }
        return list;
    }

    private List<string> GetAvailabilities()
    {
        List<string> list = new List<string>();
        foreach (ListItem item in chkListAvailabilities.Items)
        {
            if (item.Selected)
            {
                list.Add(item.Value);
            }
        }
        if (list.Count == 0)
        {
            foreach (ListItem item in chkListAvailabilities.Items)
            {
                list.Add(item.Value);
            }
            list.Add("");
        }
        return list;
    }

    private List<string> GetLoggerModels()
    {
        List<string> list = new List<string>();
        foreach (ListItem item in chkListLoggerModels.Items)
        {
            if (item.Selected)
            {
                list.Add(item.Value);
            }
        }
        if (list.Count == 0)
        {
            foreach (ListItem item in chkListLoggerModels.Items)
            {
                list.Add(item.Value);
            }
            list.Add("");
        }
        return list;
    }
}