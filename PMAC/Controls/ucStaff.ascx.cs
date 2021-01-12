using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;


public partial class Controls_ucStaff : System.Web.UI.UserControl
{
    StaffBL _staffBL = new StaffBL();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cboStaffs.Focus();
        }
        msg.Text = string.Empty;


        if (!IsPostBack)
        {
            // Pi-solution
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Admin/CreateUser.aspx")).ToList();

            var var1 = list.Where(x => x.ControlId.Contains("winAddStaff_staffId")).FirstOrDefault();
            winAddStaff_staffId.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("winAddStaff_staffName")).FirstOrDefault();
            winAddStaff_staffName.Text = (var2 == null) ? "" : var2.Contents;
            var var3 = list.Where(x => x.ControlId.Contains("winAddStaff_staffLastName")).FirstOrDefault();
            winAddStaff_staffLastName.Text = (var3 == null) ? "" : var3.Contents;
            var var4 = list.Where(x => x.ControlId.Contains("winAddStaff_staffAddress")).FirstOrDefault();
            winAddStaff_staffAddress.Text = (var4 == null) ? "" : var4.Contents;
            var var5 = list.Where(x => x.ControlId.Contains("winAddStaff_staffMobile")).FirstOrDefault();
            winAddStaff_staffMobile.Text = (var5 == null) ? "" : var5.Contents;


            var var28 = list.Where(x => x.ControlId.Contains("winAddStaff_btnEdit")).FirstOrDefault();
            btnAdd.Text = (var28 == null) ? "" : var28.Contents;
            var var29 = list.Where(x => x.ControlId.Contains("winAddStaff_btnDelete")).FirstOrDefault();
            btnDelete.Text = (var29 == null) ? "" : var29.Contents;
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Admin/CreateUser.aspx")).ToList();
        var add_staff_successfully = list.Where(x => x.ControlId.Contains("add_staff_successfully")).FirstOrDefault();

        string staffID = cboStaffs.Text;
        var staff = GetStaff();
        var dbStaff = _staffBL.GetStaff(staffID);
        if (dbStaff == null)
        {
            _staffBL.InsertStaff(staff);
            msg.Text = add_staff_successfully.Contents;
            ReBind();
        }
        else
        {
            _staffBL.UpdateStaff(staff, dbStaff);
            msg.Text = "Đã cập nhật thông tin nhân viên.";
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Admin/CreateUser.aspx")).ToList();
        var lb_staff_delete_confirm = list.Where(x => x.ControlId.Contains("lb_staff_delete_confirm")).FirstOrDefault();

        string staffID = cboStaffs.Text;
        var staff = _staffBL.GetStaff(staffID);
        if (staff != null)
        {
            _staffBL.DeleteStaff(staff);
            //msg.Text = "Đã xóa nhân viên.";
            msg.Text = lb_staff_delete_confirm.Contents;
            ReBind();
            SetEmpty();
        }
    }

    protected void cboStaffs_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        string staffID = cboStaffs.Text;
        var staff = _staffBL.GetStaff(staffID);
        if (staff != null)
        {
            SetValues(staff);
        }
        txtFirstName.Focus();
    }

    private void ReBind()
    {
        StaffsDataSource.DataBind();
        cboStaffs.DataBind();
    }

    private void SetValues(t_Staffs staff)
    {
        cboStaffs.Text = staff.StaffId;
        txtAddress.Text = staff.Address;
        txtFirstName.Text = staff.FirstName;
        txtLastName.Text = staff.LastName;
        txtTel.Text = staff.TelephoneNumber;
    }

    private void SetEmpty()
    {
        cboStaffs.Text = string.Empty;
        txtAddress.Text = string.Empty;
        txtFirstName.Text = string.Empty;
        txtLastName.Text = string.Empty;
        txtTel.Text = string.Empty;
    }

    private t_Staffs GetStaff()
    {
        t_Staffs staff = new t_Staffs();
        staff.Address = txtAddress.Text;
        staff.FirstName = txtFirstName.Text;
        staff.LastName = txtLastName.Text;
        staff.StaffId = cboStaffs.Text;
        staff.TelephoneNumber = txtTel.Text;
        return staff;
    }
}