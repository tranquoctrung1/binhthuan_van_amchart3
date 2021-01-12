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

public partial class Supervisor_Admin_SettingSMS : System.Web.UI.Page
{
    private string connectionString;
    private string cmdText;
    private string strEna2;
    private string strEna3;
    private string strEna4;
    private string strEna;

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";
    protected void Page_Load(object sender, EventArgs e)
    {
        // Pi-solution
        if (!IsPostBack)
        {
            // Pi-solution developer
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();
            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Admin/SettingSMS.aspx")).ToList();

            //Parse content to form
            var var1 = list.Where(x => x.ControlId.Contains("lbTitle")).FirstOrDefault();
            lbTitle.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("lbInstallationPoint")).FirstOrDefault();
            lbInstallationPoint.Text = (var2 == null) ? "" : var2.Contents;
            var var3= list.Where(x => x.ControlId.Contains("lbSelected")).FirstOrDefault();
            lbSelected.Text = (var3 == null) ? "" : var3.Contents;
            var var4 = list.Where(x => x.ControlId.Contains("lbMobileNumber")).FirstOrDefault();
            lbMobileNumber.Text = (var4 == null) ? "" : var4.Contents;
            var var5 = list.Where(x => x.ControlId.Contains("lbNote")).FirstOrDefault();
            lbNote.Text = (var5 == null) ? "" : var5.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("lbEnable")).FirstOrDefault();
            lbEnable.Text = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("CheckBoxEnable")).FirstOrDefault();
            CheckBoxEnable.Text = (var7 == null) ? "" : var7.Contents;
            var var8 = list.Where(x => x.ControlId.Contains("CheckBoxEnableDelay")).FirstOrDefault();
            CheckBoxEnableDelay.Text = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("CheckBoxEnableDiff")).FirstOrDefault();
            CheckBoxEnableDiff.Text = (var9 == null) ? "" : var9.Contents;
            var var10 = list.Where(x => x.ControlId.Contains("CheckBoxEnablePress")).FirstOrDefault();
            CheckBoxEnablePress.Text = (var10 == null) ? "" : var10.Contents;

            var var11 = list.Where(x => x.ControlId.Contains("btnAdd")).FirstOrDefault();
            ButtonAdd.Text = (var2 == null) ? "" : var2.Contents;
            var var12 = list.Where(x => x.ControlId.Contains("btnDelete")).FirstOrDefault();
            var var13 = list.Where(x => x.ControlId.Contains("btnEdit")).FirstOrDefault();

            foreach (GridColumn col in grid.MasterTableView.Columns)
            {
                if (col.UniqueName == "Ena")
                    col.HeaderText = (var6 == null) ? "" : var6.Contents;
                if (col.UniqueName == "SiteId")
                    col.HeaderText = (var2 == null) ? "" : var2.Contents;
                if (col.UniqueName == "PhoneNr")
                    col.HeaderText = (var4 == null) ? "" : var4.Contents;
                if (col.UniqueName == "Ena2")
                    col.HeaderText = (var8 == null) ? "" : var8.Contents;
                if (col.UniqueName == "Ena3")
                    col.HeaderText = (var9 == null) ? "" : var9.Contents;
                if (col.UniqueName == "Ena4")
                    col.HeaderText = (var10 == null) ? "" : var10.Contents;
                if (col.UniqueName == "Note")
                    col.HeaderText = (var5 == null) ? "" : var5.Contents;
            }
            grid.Rebind();

            // Language for area "Add new record"
        }
    }

    protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
    {
        // Pi-solution developer
        language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Admin/SettingSMS.aspx")).ToList();

        //Parse content to form
        var var1 = list.Where(x => x.ControlId.Contains("lbTitle")).FirstOrDefault();
        lbTitle.Text = (var1 == null) ? "" : var1.Contents;
        var var2 = list.Where(x => x.ControlId.Contains("lbInstallationPoint")).FirstOrDefault();
        lbInstallationPoint.Text = (var2 == null) ? "" : var2.Contents;
        var var3 = list.Where(x => x.ControlId.Contains("lbSelected")).FirstOrDefault();
        lbSelected.Text = (var3 == null) ? "" : var3.Contents;
        var var4 = list.Where(x => x.ControlId.Contains("lbMobileNumber")).FirstOrDefault();
        lbMobileNumber.Text = (var4 == null) ? "" : var4.Contents;
        var var5 = list.Where(x => x.ControlId.Contains("lbNote")).FirstOrDefault();
        lbNote.Text = (var5 == null) ? "" : var5.Contents;
        var var6 = list.Where(x => x.ControlId.Contains("lbEnable")).FirstOrDefault();
        lbEnable.Text = (var6 == null) ? "" : var6.Contents;
        var var7 = list.Where(x => x.ControlId.Contains("CheckBoxEnable")).FirstOrDefault();
        CheckBoxEnable.Text = (var7 == null) ? "" : var7.Contents;
        var var8 = list.Where(x => x.ControlId.Contains("CheckBoxEnableDelay")).FirstOrDefault();
        CheckBoxEnableDelay.Text = (var8 == null) ? "" : var8.Contents;
        var var9 = list.Where(x => x.ControlId.Contains("CheckBoxEnableDiff")).FirstOrDefault();
        CheckBoxEnableDiff.Text = (var9 == null) ? "" : var9.Contents;
        var var10 = list.Where(x => x.ControlId.Contains("CheckBoxEnablePress")).FirstOrDefault();
        CheckBoxEnablePress.Text = (var10 == null) ? "" : var10.Contents;

        if (e.Item.IsInEditMode && e.Item is GridEditFormItem)
        {
            GridEditFormItem editForm = (GridEditFormItem)e.Item;
            Label label_Ena = (Label)editForm.FindControl("label_Ena");
            label_Ena.Text = (var6 == null) ? "" : var6.Contents;
            Label label_SiteId = (Label)editForm.FindControl("label_SiteId");
            label_SiteId.Text = (var2 == null) ? "" : var2.Contents;
            Label label_PhoneNr = (Label)editForm.FindControl("label_PhoneNr");
            label_PhoneNr.Text = (var4 == null) ? "" : var4.Contents;
            Label label_Ena2 = (Label)editForm.FindControl("label_Ena2");
            label_Ena2.Text = (var8 == null) ? "" : var8.Contents;
            Label label_Ena3 = (Label)editForm.FindControl("label_Ena3");
            label_Ena3.Text = (var9 == null) ? "" : var9.Contents;
            Label label_Ena4 = (Label)editForm.FindControl("label_Ena4");
            label_Ena4.Text = (var10 == null) ? "" : var10.Contents;
            Label label_Note = (Label)editForm.FindControl("label_Note");
            label_Note.Text = (var5 == null) ? "" : var5.Contents;

            // Button
            RadButton btn_Edit = (RadButton)editForm.FindControl("RadButton1");
            RadButton btn_Cancel = (RadButton)editForm.FindControl("RadButton2");
            if (language == "vi")
            {
                btn_Edit.Text = (btn_Edit.Text == "Insert") ? "Thêm vào" : "Cập nhật";
                btn_Cancel.Text = "Hủy";
            }
        }
    }

    protected void grid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == RadGrid.InitInsertCommandName)
        {
            e.Canceled = true;
            System.Collections.Specialized.ListDictionary newValues = new System.Collections.Specialized.ListDictionary();
            newValues["Ena"] = false;
            newValues["Ena2"] = false;
            newValues["Ena3"] = false;
            newValues["Ena4"] = false;
            newValues["PhoneNr"] = "";
            newValues["SiteId"] = "";
            newValues["Note"] = "";
            e.Item.OwnerTableView.InsertItem(newValues);
        }
    }
    protected void grid_ItemInserted(object sender, GridInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            e.KeepInInsertMode = true;
            ntf.Show("Cannot insert! check the data again");
        }
    }
    protected void grid_ItemUpdated(object sender, GridUpdatedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            e.KeepInEditMode = true;
            ntf.Show("Cannot update! check the data again");
        }
    }
    protected void grid_ItemDeleted(object sender, GridDeletedEventArgs e)
    {
        if (e.Exception != null)
        {
            e.ExceptionHandled = true;
            ntf.Show("Cannot delete! check the data again");
        }
    }
    protected void ButtonAdd_Click(object sender, EventArgs e)
    {
        List<AlarmConfig> list = GetConfigs();
        connectionString = ConfigurationManager.ConnectionStrings["DbConnectionString"].ConnectionString;
        foreach (AlarmConfig item in list)
        {
            bool exists = false;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                cmdText = "select top 1 * from [t_Alarm_Configurations] where [SiteId]='" + item.SiteId + "' and [PhoneNr]='" + item.PhoneNr + "'";
                connection.Open();
                SqlCommand cmd = new SqlCommand(cmdText, connection);
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    exists = true;
                }

                connection.Close();

                strEna2 = item.Ena2 ? "1" : "0";
                strEna3 = item.Ena3 ? "1" : "0";
                strEna4 = item.Ena4 ? "1" : "0";
                strEna = item.Ena ? "1" : "0";

                if (!exists)
                {
                    cmdText = "insert into [t_Alarm_Configurations]([SiteId],[PhoneNr],[Ena2],[Ena3],[Ena4],[Ena],[Note]) values('" + item.SiteId + "','" + item.PhoneNr + "'," + strEna2 + "," + strEna3 + "," + strEna4 + ","+strEna+",'" + item.Note + "')";
                }
                else
                {
                    cmdText = "update [t_Alarm_Configurations] set [Ena2]=" + strEna2 + ",[Ena3]=" + strEna3 + ",[Ena4]=" + strEna4 + ",[Ena]=" + strEna + ",[Note]='" + item.Note + "' where [SiteId]='" + item.SiteId + "' and [PhoneNr]='" + item.PhoneNr + "'";
                }
                connection.Open();
                SqlCommand cmd1 = new SqlCommand(cmdText, connection);
                cmd1.ExecuteNonQuery();
                connection.Close();
            }
        }
        grid.DataBind();

    }
    public List<AlarmConfig> GetConfigs()
    {
        List<AlarmConfig> list = new List<AlarmConfig>();

        foreach (RadListBoxItem item in listBoxSelectedSites.Items)
        {
            AlarmConfig c = new AlarmConfig();
            c.SiteId = item.Value;
            c.PhoneNr = TextBoxPhoneNr.Text;
            c.Note = TextBoxDescription.Text;
            c.Ena = CheckBoxEnable.Checked;
            c.Ena2 = CheckBoxEnableDelay.Checked;
            c.Ena3 = CheckBoxEnableDiff.Checked;
            c.Ena4 = CheckBoxEnablePress.Checked;
            if (!string.IsNullOrEmpty(c.PhoneNr))
                list.Add(c);
        }

        return list;
    }
    public class AlarmConfig
    {
        string siteId;

        string phoneNr;

        bool ena1;

        bool ena2;

        bool ena3;

        bool ena4;

        bool ena;

        string note;

        public string SiteId { get { return siteId; } set { siteId = value; } }

        public string PhoneNr { get { return phoneNr; } set { phoneNr = value; } }

        public bool Ena1 { get { return ena1; } set { ena1 = value; } }

        public bool Ena2 { get { return ena2; } set { ena2 = value; } }

        public bool Ena3 { get { return ena3; } set { ena3 = value; } }

        public bool Ena4 { get { return ena4; } set { ena4 = value; } }

        public bool Ena { get { return ena; } set { ena = value; } }

        public string Note { get { return note; } set { note = value; } }
    }
}