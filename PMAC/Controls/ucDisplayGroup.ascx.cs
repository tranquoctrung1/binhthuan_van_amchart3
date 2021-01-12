using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;


public partial class Controls_ucDisplayGroup : System.Web.UI.UserControl
{
    DisplayGroupBL _DisplayGroupBL = new DisplayGroupBL();


    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cboDisplayGroups.Focus();

            // Pi-solution
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();

            var var1 = list.Where(x => x.ControlId.Contains("winAddDisplayGroup_group")).FirstOrDefault();
            winAddDisplayGroup_group.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("winAddDisplayGroup_description")).FirstOrDefault();
            winAddDisplayGroup_description.Text = (var2 == null) ? "" : var2.Contents;

            var var28 = list.Where(x => x.ControlId.Contains("winAddDisplayGroup_btnEdit")).FirstOrDefault();
            btnAdd.Text = (var28 == null) ? "" : var28.Contents;
            var var29 = list.Where(x => x.ControlId.Contains("winAddDisplayGroup_delete")).FirstOrDefault();
            btnDelete.Text = (var29 == null) ? "" : var29.Contents;
        }


        msg.Text = string.Empty;
    }

    protected void cboDisplayGroups_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        string groupID = cboDisplayGroups.Text;
        var group = _DisplayGroupBL.GetDisplayGroup(groupID);
        if (group != null)
        {
            SetValues(group);
        }
        txtDescription.Focus();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();
        var empty_groupDisplay = list.Where(x => x.ControlId.Contains("empty_groupDisplay")).FirstOrDefault();
        var winAddDisplayGroup_add_successfully = list.Where(x => x.ControlId.Contains("winAddDisplayGroup_add_successfully")).FirstOrDefault();
        var winAddDisplayGroup_update_successfully = list.Where(x => x.ControlId.Contains("winAddDisplayGroup_update_successfully")).FirstOrDefault();

        if (string.IsNullOrEmpty(cboDisplayGroups.Text))
        {
            msg.Text = empty_groupDisplay.Contents;
            return;
        }

        var group = GetDisplayGroup();
        var dbGroup = _DisplayGroupBL.GetDisplayGroup(cboDisplayGroups.Text);
        if (dbGroup == null)
        {
            _DisplayGroupBL.InsertDisplayGroup(group);
            msg.Text = winAddDisplayGroup_add_successfully.Contents;
            ReBind();
        }
        else
        {
            _DisplayGroupBL.UpdateDisplayGroup(group, dbGroup);
            msg.Text = winAddDisplayGroup_update_successfully.Contents;
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();
        var groupDisplay_confirm_delete = list.Where(x => x.ControlId.Contains("groupDisplay_confirm_delete")).FirstOrDefault();
        var lb_display_group_empty_group = list.Where(x => x.ControlId.Contains("lb_display_group_empty_group")).FirstOrDefault();

        if (string.IsNullOrEmpty(cboDisplayGroups.Text))
        {
            //msg.Text = "Chưa nhập nhóm hiển thị.";
            msg.Text = lb_display_group_empty_group.Contents;
            return;
        }

        var group = GetDisplayGroup();
        if (group != null)
        {
            _DisplayGroupBL.DeleteDisplayGroup(group);
            //msg.Text = "Đã xóa nhóm hiển thị.";
            msg.Text = groupDisplay_confirm_delete.Contents;
            ReBind();
            SetEmpty();
        }
    }

    private void ReBind()
    {
        DisplayGroupsDataSource.DataBind();
        cboDisplayGroups.DataBind();
    }

    private t_DisplayGroups GetDisplayGroup()
    {
        t_DisplayGroups group = new t_DisplayGroups();
        group.Group = cboDisplayGroups.Text;
        group.Description = txtDescription.Text;
        return group;
    }

    private void SetValues(t_DisplayGroups group)
    {
        cboDisplayGroups.Text = group.Group;
        txtDescription.Text = group.Description;
    }

    private void SetEmpty()
    {
        cboDisplayGroups.Text = string.Empty;
        txtDescription.Text = string.Empty;
    }
}