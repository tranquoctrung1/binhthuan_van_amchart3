using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;

using Telerik.Web.UI;

public partial class Controls_ucManualDataAdd : System.Web.UI.UserControl
{
    SiteBL _siteBL = new SiteBL();
    ComplexDataHelper _complexDataHelper = new ComplexDataHelper();
    RawIndexBL _rawIndexBL = new RawIndexBL();
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var sites = _siteBL.GetSites();
            cboSites.DataSource = sites;
            cboSites.DataBind();
            SetLatestData();

            // Pi-solution developer
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();
            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/ManualData/Add_Change.aspx")).ToList();

            //Parse content to form
            var var1 = list.Where(x => x.ControlId.Contains("ucManualDataAdd_btnAdd")).FirstOrDefault();
            btnAdd.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("ucManualDataAdd_btnClear")).FirstOrDefault();
            btnClear.Text = (var2 == null) ? "" : var2.Contents;

            var var3 = list.Where(x => x.ControlId.Contains("Column1")).FirstOrDefault();
            var var4 = list.Where(x => x.ControlId.Contains("Column2")).FirstOrDefault();
            var var5 = list.Where(x => x.ControlId.Contains("Column3")).FirstOrDefault();

            foreach (GridColumn col in grv.MasterTableView.Columns)
            {
                if (col.UniqueName == "Description")
                    col.HeaderText = (var3 == null) ? "" : var3.Contents;
                if (col.UniqueName == "TimeStamp")
                    col.HeaderText = (var4 == null) ? "" : var4.Contents;
                if (col.UniqueName == "Index")
                    col.HeaderText = (var5 == null) ? "" : var5.Contents;
            }
            grv.Rebind();

            var var6 = list.Where(x => x.ControlId.Contains("lbAliasName")).FirstOrDefault();
            lbAliasName.Text = (var6 == null) ? "" : var6.Contents;
        }
        ntf.VisibleOnPageLoad = false;
    }

    private void SetEmpty()
    {
        grv.DataSource = null;
        grv.DataBind();
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        SetLatestData();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = true;
        string msg = string.Empty;
        var list = GetIndexes();
        foreach (var index in list)
        {
            var dbIndex = _rawIndexBL.GetRawIndex(index.SiteId, (DateTime)index.TimeStamp);
            if (dbIndex == null)
            {
                ntf.Text = "Đã cập nhật dữ liệu.";
                try
                {
                    _rawIndexBL.InsertRawIndex(index);
                }
                catch (Exception ex)
                {
                    ntf.Text = "Lỗi " + ex.Message;
                    //throw;
                }
            }
            else
            {
                try
                {
                    _rawIndexBL.UpdateRawIndex(index, dbIndex);

                }
                catch (Exception ex)
                {
                    ntf.Text = "Lỗi " + ex.Message;
                    //throw;
                }
            }
        }
    }

    protected void nmrIndex_TextChanged(object sender, EventArgs e)
    {
        var dbList = GetIndexes();
        List<RawIndexViewModel> list = new List<RawIndexViewModel>();
        foreach (var item in dbList)
        {
            RawIndexViewModel temp = new RawIndexViewModel();
            temp.Description = item.Description;
            temp.Index = item.Index;
            temp.SiteId = item.SiteId;
            temp.TimeStamp = item.TimeStamp;
            list.Add(temp);
        }
        RawIndexViewModel emptyIndex = new RawIndexViewModel();
        list.Add(emptyIndex);
        grv.DataSource = list;
        grv.DataBind();
        SetFocusItemControl();
    }

    private List<t_Data_Raw_Indexes> GetIndexes()
    {
        List<t_Data_Raw_Indexes> list = new List<t_Data_Raw_Indexes>();
        foreach (Telerik.Web.UI.GridItem row in grv.Items)
        {
            Telerik.Web.UI.RadTextBox TextBoxDescription = row.FindControl("txtDescription") as Telerik.Web.UI.RadTextBox;
            Telerik.Web.UI.RadDatePicker DatePicker = row.FindControl("dtmTimeStamp") as Telerik.Web.UI.RadDatePicker;
            Telerik.Web.UI.RadNumericTextBox NummericTextBoxIndex = row.FindControl("nmrIndex") as Telerik.Web.UI.RadNumericTextBox;
            t_Data_Raw_Indexes data = new t_Data_Raw_Indexes();
            if (NummericTextBoxIndex.Value != null && DatePicker.SelectedDate != null)
            {
                data.Description = TextBoxDescription.Text;
                data.Index = (double)NummericTextBoxIndex.Value;
                data.TimeStamp = (DateTime)DatePicker.SelectedDate;
                data.SiteId = cboSites.SelectedValue;
                list.Add(data);
            }
        }
        return list;
    }

    private void SetEmptyData()
    {
        List<RawIndexViewModel> list = new List<RawIndexViewModel>();
        RawIndexViewModel rawIndex = new RawIndexViewModel();
        list.Add(rawIndex);
        grv.DataSource = list;
        grv.DataBind();
    }

    private void SetLatestData()
    {
        t_Data_Raw_Indexes rawIndex = _rawIndexBL.GetLastRawIndex(cboSites.SelectedValue);
        List<RawIndexViewModel> list = new List<RawIndexViewModel>();
        if (rawIndex != null)
        {
            RawIndexViewModel display = new RawIndexViewModel();
            display.Description = rawIndex.Description;
            display.Index = rawIndex.Index;
            display.SiteId = rawIndex.SiteId;
            display.TimeStamp = rawIndex.TimeStamp;
            list.Add(display);
        }
        RawIndexViewModel empty = new RawIndexViewModel();
        list.Add(empty);
        grv.DataSource = list;
        grv.DataBind();
        SetFocusItemControl();
    }

    private void SetFocusItemControl()
    {
        int rowCount = grv.Items.Count;
        Telerik.Web.UI.GridItem lastRow = grv.Items[rowCount - 1];
        Telerik.Web.UI.RadDatePicker DatePicker = lastRow.FindControl("dtmTimeStamp") as Telerik.Web.UI.RadDatePicker;
        DatePicker.Focus();
    }

    protected void cboSites_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        SetLatestData();
    }
    protected void cboSites_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cboSites.SelectedIndex = 0;
        }
    }
}