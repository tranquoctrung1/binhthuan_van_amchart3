using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;

using Telerik.Web.UI;

public partial class Controls_ucManualDataChange : System.Web.UI.UserControl
{
    SiteBL _siteBL = new SiteBL();
    RawIndexBL _rawIndexBL = new RawIndexBL();
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi"; protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;
        if (!IsPostBack)
        {
            SetEmptyRow();

            // Pi-solution Developer
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();
            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/ManualData/Add_Change.aspx")).ToList();

            //Parse content to form
            var var1 = list.Where(x => x.ControlId.Contains("lbFrom")).FirstOrDefault();
            lbFrom.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("lbTo")).FirstOrDefault();
            lbTo.Text = (var2 == null) ? "" : var2.Contents;

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

            var var7 = list.Where(x => x.ControlId.Contains("btnView")).FirstOrDefault();
            btnView.Text = (var7 == null) ? "" : var7.Contents;
            var var8 = list.Where(x => x.ControlId.Contains("btnAdd")).FirstOrDefault();
            btnAdd.Text = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("btnDelete")).FirstOrDefault();
            btnDelete.Text = (var9 == null) ? "" : var9.Contents;
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = true;
        if (string.IsNullOrEmpty(cboSites.SelectedValue))
        {
            ntf.Text = "Chưa nhập Mã vị trí (alias name).";
            return;
        }
        string msg = string.Empty;
        var list = GetIndexes();
        foreach (var index in list)
        {
            var dbIndex = _rawIndexBL.GetRawIndex(index.SiteId, (DateTime)index.TimeStamp);
            if (dbIndex != null)
            {
                _rawIndexBL.UpdateRawIndex(index, dbIndex);
            }
        }
    }
    protected void btnConfim_Click(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = true;
        bool invalid = InvalidInput();
        if (invalid)
        {
            return;
        }
        try
        {
            _rawIndexBL.DeleteRawIndexes(cboSites.SelectedValue, (DateTime)dtmStart.SelectedDate, (DateTime)dtmEnd.SelectedDate);
            var updatedList = _rawIndexBL.GetRawIndexes(cboSites.SelectedValue, (DateTime)dtmStart.SelectedDate, (DateTime)dtmEnd.SelectedDate);
            grv.DataSource = updatedList;
            grv.DataBind();
            ntf.Text = "Đã xóa dữ liệu.";
        }
        catch (Exception ex)
        {
            //
            ntf.Text = "Có lỗi, thử lại.";
            throw ex;
        }
    }

    protected void cboSites_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {

    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        bool invalid = InvalidInput();
        if (invalid)
        {
            ntf.VisibleOnPageLoad = true;
            return;
        }
        var list = _rawIndexBL.GetRawIndexes(cboSites.SelectedValue, (DateTime)dtmStart.SelectedDate, (DateTime)dtmEnd.SelectedDate);
        grv.DataSource = list;
        grv.DataBind();
    }

    private bool InvalidInput()
    {
        if (string.IsNullOrEmpty(cboSites.SelectedValue))
        {
            ntf.Text = "Chưa nhập Mã vị trí (alias name).";
            return true;
        }
        if (dtmStart.SelectedDate == null)
        {
            ntf.Text = "Chưa nhập ngày bắt đầu.";
            return true;
        }
        if (dtmEnd.SelectedDate == null)
        {
            ntf.Text = "Chưa nhập ngày kết thúc.";
            return true;
        }
        return false;
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

    private void SetEmptyRow()
    {
        List<RawIndexViewModel> list = new List<RawIndexViewModel>();
        list.Add(new RawIndexViewModel());
        grv.DataSource = list;
        grv.DataBind();
    }
    protected void cboSites_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cboSites.SelectedIndex = 0;
        }
    }
}