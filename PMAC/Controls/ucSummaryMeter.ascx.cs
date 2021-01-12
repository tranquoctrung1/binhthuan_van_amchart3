using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using PMAC.BLL;

public partial class Controls_ucSummaryMeter : System.Web.UI.UserControl
{
    MeterBL _meterBL = new MeterBL();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Summary/Device.aspx")).ToList();

            var var01 = list.Where(x => x.ControlId.Contains("lbManufacturer")).FirstOrDefault();
            lbManufacturer.Text = (var01 == null) ? "" : var01.Contents;
            var var02 = list.Where(x => x.ControlId.Contains("lbBrandName")).FirstOrDefault();
            lbBrandName.Text = (var02 == null) ? "" : var02.Contents;
            var var03 = list.Where(x => x.ControlId.Contains("lbSize")).FirstOrDefault();
            lbSize.Text = (var03 == null) ? "" : var03.Contents;
            var var04 = list.Where(x => x.ControlId.Contains("lbModel")).FirstOrDefault();
            lbModel.Text = (var04 == null) ? "" : var04.Contents;
            var var14 = list.Where(x => x.ControlId.Contains("lbStatus")).FirstOrDefault();
            lbStatus.Text = (var14 == null) ? "" : var14.Contents;
            var var15 = list.Where(x => x.ControlId.Contains("lbSetup")).FirstOrDefault();
            lbSetup.Text = (var15 == null) ? "" : var15.Contents;

            // Change header of rad grid
            var var5 = list.Where(x => x.ControlId.Contains("grv_STT")).FirstOrDefault();
            grv.MasterTableView.GetColumn("STT").HeaderText = (var5 == null) ? "" : var5.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("grv_Serial")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column1").HeaderText = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("grv_Provider")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column2").HeaderText = (var7 == null) ? "" : var7.Contents;
            var var8 = list.Where(x => x.ControlId.Contains("grv_Marks")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column3").HeaderText = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("grv_Size")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column4").HeaderText = (var9 == null) ? "" : var9.Contents;

            var var10 = list.Where(x => x.ControlId.Contains("grv_Installed")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column5").HeaderText = (var10 == null) ? "" : var10.Contents;

            var var11 = list.Where(x => x.ControlId.Contains("grv_SiteAliasName")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column13").HeaderText = (var11 == null) ? "" : var11.Contents;
            var var12 = list.Where(x => x.ControlId.Contains("grv_Location")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column7").HeaderText = (var12 == null) ? "" : var12.Contents;

            var var22 = list.Where(x => x.ControlId.Contains("grv_ReceiptDate")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column8").HeaderText = (var22 == null) ? "" : var22.Contents;
            var var32 = list.Where(x => x.ControlId.Contains("grv_Model")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column10").HeaderText = (var32 == null) ? "" : var32.Contents;
            var var42 = list.Where(x => x.ControlId.Contains("grv_Status")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column11").HeaderText = (var42 == null) ? "" : var42.Contents;
            var var52 = list.Where(x => x.ControlId.Contains("grv_Description")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column12").HeaderText = (var52 == null) ? "" : var52.Contents;

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

    private List<string> GetProviders()
    {
        List<string> list = new List<string>();
        foreach (ListItem item in chkListProviders.Items)
        {
            if (item.Selected)
            {
                list.Add(item.Value);
            }
        }
        if (list.Count == 0)
        {
            foreach (ListItem item in chkListProviders.Items)
            {
                list.Add(item.Value);
            }
            list.Add("");
        }
        return list;
    }

    private List<string> GetMarks()
    {
        List<string> list = new List<string>();
        foreach (ListItem item in chkListMarks.Items)
        {
            if (item.Selected)
            {
                list.Add(item.Value);
            }
        }
        if (list.Count == 0)
        {
            foreach (ListItem item in chkListMarks.Items)
            {
                list.Add(item.Value);
            }
            list.Add("");
        }
        return list;
    }

    private List<short> GetSizes()
    {
        List<short> list = new List<short>();
        foreach (ListItem item in chkListSizes.Items)
        {
            if (item.Selected)
            {
                list.Add(short.Parse(item.Value));
            }
        }
        if (list.Count == 0)
        {
            foreach (ListItem item in chkListSizes.Items)
            {
                list.Add(short.Parse(item.Value));
            }
            list.Add(0);
        }
        return list;
    }

    private List<string> GetModels()
    {
        List<string> list = new List<string>();
        foreach (ListItem item in chkListModels.Items)
        {
            if (item.Selected)
            {
                list.Add(item.Value);
            }
        }
        if (list.Count == 0)
        {
            foreach (ListItem item in chkListModels.Items)
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

    private List<bool> GetInstalleds()
    {
        List<bool> list = new List<bool>();
        foreach (ListItem item in chkListInstalled.Items)
        {
            if (item.Selected)
            {
                list.Add(bool.Parse(item.Value));
            }
        }
        if (list.Count == 0)
        {
            list.Add(true);
            list.Add(false);
        }
        return list;
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        BindData();
    }

    private void BindData()
    {
        grv.DataSource = _meterBL.GetMeterByConds(GetProviders(),
            GetMarks(),
            GetSizes(),
            GetModels(),
            GetStatus(),
            GetInstalleds()
            );
        grv.DataBind();
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        try
        {
            grv.ExportSettings.FileName = "Đồng hồ";
            grv.MasterTableView.ExportToExcel();
        }
        catch (Exception ex)
        {

            //throw;
        }
    }

    protected void grv_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = (GridDataItem)e.Item;
            dataItem["STT"].Text = (e.Item.ItemIndex + 1).ToString();
        }
    }
}