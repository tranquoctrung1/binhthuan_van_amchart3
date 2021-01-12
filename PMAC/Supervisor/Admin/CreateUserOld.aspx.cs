using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using PMAC.BLL;
using PMAC.ULT;


public partial class Supervisor_Admin_CreateUser : System.Web.UI.Page
{
    StringUT _stringUTL = new StringUT();
    UserBL _userBL = new UserBL();

    protected void Page_Load(object sender, EventArgs e)
    {
        RadAjaxManager manager = RadAjaxManager.GetCurrent(Page);
        manager.AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(manager_AjaxRequest);
        manager.AjaxSettings.AddAjaxSetting(manager, cboConsumers);
        manager.AjaxSettings.AddAjaxSetting(manager, ConsumersDataSource);
        manager.AjaxSettings.AddAjaxSetting(manager, cboStaffs);
        manager.AjaxSettings.AddAjaxSetting(manager, StaffsDataSource);
        ntf.VisibleOnPageLoad = false;
    }

    void manager_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        switch (e.Argument)
        {
            case "winAddConsumer_Close":
                ConsumersDataSource.DataBind();
                cboConsumers.DataBind();
                break;
            case "winAddStaff_Close":
                StaffsDataSource.DataBind();
                cboStaffs.DataBind();
                break;
            default:
                break;
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = true;
        bool invalid = IsInvalidInput();
        if (invalid)
        {
            return;
        }
        var user = GetUser();
        var dbUser = _userBL.GetUser(user.Username);
        if (dbUser == null)
        {
            user.Salt = _stringUTL.CreateSalt(8);
            user.Password = _stringUTL.HashMD5(_stringUTL.HashMD5(user.Password) + user.Salt);
            _userBL.InsertUser(user);
            ntf.Text = "Đã thêm mới người dùng.";
        }
        else
        {
            if (!string.Equals(user.Password, "********"))
            {
                user.Salt = _stringUTL.CreateSalt(8);
                user.Password = _stringUTL.HashMD5(_stringUTL.HashMD5(user.Password) + user.Salt);
            }
            else
            {
                user.Salt = dbUser.Salt;
                user.Password = dbUser.Password;
            }
            _userBL.UpdateUser(user, dbUser);
            ntf.Text = "Đã cập nhật thông tin người dùng.";
        }
    }

    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = true;
        if (string.IsNullOrEmpty(cboUsers.Text))
        {
            ntf.Text = "Chưa nhập ký danh.";
            cboUsers.Focus();
            return;
        }
        var user = _userBL.GetUser(cboUsers.Text);
        if (user != null)
        {
            _userBL.DeleteUser(user);
            ntf.Text = "Đã xóa người dùng.";
            SetEmpty();
        }
    }

    protected void cboUsers_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        string username=cboUsers.Text;
        var user = _userBL.GetUser(username);
        if (user != null)
        {
            SetValues(user);
        }
        txtPassword.Focus();
    }

    private bool IsInvalidInput()
    {
        if (string.IsNullOrEmpty(cboUsers.Text))
        {
            ntf.Text = "Chưa nhập ký danh.";
            cboUsers.Focus();
            return true;
        }
        if (string.IsNullOrEmpty(txtPassword.Text))
        {
            ntf.Text = "Chưa nhập mật khẩu.";
            txtPassword.Focus();
            return true;
        }
        if (string.IsNullOrEmpty(txtEmail.Text))
        {
            ntf.Text = "Chưa nhập email.";
            txtEmail.Focus();
            return true;
        }
        return false;
    }

    private t_Users GetUser()
    {
        t_Users user = new t_Users();
        user.ConsumerId = cboConsumers.Text;
        user.Email = txtEmail.Text;
        user.Password = txtPassword.Text;
        user.Role = cboRoles.Text;
        user.StaffId = cboStaffs.Text;
        user.Username = cboUsers.Text;
        return user;
    }

    private void SetValues(t_Users user)
    {
        cboUsers.Text = user.Username;
        txtPassword.Text = "********";
        txtEmail.Text = user.Email;
        cboRoles.SelectedValue = user.Role;
        cboConsumers.SelectedValue = user.ConsumerId;
        cboStaffs.SelectedValue = user.StaffId;
    }

    private void SetEmpty()
    {
        cboUsers.Text = string.Empty;
        txtPassword.Text = string.Empty;
        txtEmail.Text = string.Empty;
        cboRoles.SelectedIndex = 0;
        cboConsumers.SelectedIndex = 0;
        cboStaffs.SelectedIndex = 0;
    }
}