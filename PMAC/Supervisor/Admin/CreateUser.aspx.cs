using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using PMAC.BLL;
using PMAC.ULT;
using System.Configuration;
using System.Data.SqlClient;

public partial class Supervisor_Admin_CreateUser : System.Web.UI.Page
{
    StringUT _stringUTL = new StringUT();
    UserBL _userBL = new UserBL();
    SiteBL _siteBL = new SiteBL();
    LanguageBL languageBL = new LanguageBL();

    string connectionString = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;

    private static string language = "vi";
    // ComplexDataHelper _complexDataHelper = new ComplexDataHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        RadAjaxManager manager = RadAjaxManager.GetCurrent(Page);
        manager.AjaxRequest += new RadAjaxControl.AjaxRequestDelegate(manager_AjaxRequest);
        manager.AjaxSettings.AddAjaxSetting(manager, cboConsumers);
        manager.AjaxSettings.AddAjaxSetting(manager, ConsumersDataSource);
        manager.AjaxSettings.AddAjaxSetting(manager, cboStaffs);
        manager.AjaxSettings.AddAjaxSetting(manager, StaffsDataSource);
        ntf.VisibleOnPageLoad = false;


        // Pi-solution
        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Admin/CreateUser.aspx")).ToList();
            
            var var4 = list.Where(x => x.ControlId.Contains("lbTitle")).FirstOrDefault();
            lbTitle.Text = (var4 == null) ? "" : var4.Contents;

            var var5 = list.Where(x => x.ControlId.Contains("lbTitle")).FirstOrDefault();
            lbAliasName.Text = (var5 == null) ? "" : var5.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("lbPassword")).FirstOrDefault();
            lbPassword.Text = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("lbEmail")).FirstOrDefault();
            lbEmail.Text = (var7 == null) ? "" : var7.Contents;
            var var8 = list.Where(x => x.ControlId.Contains("lbRole")).FirstOrDefault();
            lbRole.Text = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("lbCustomerId")).FirstOrDefault();
            lbCustomerId.Text = (var9 == null) ? "" : var9.Contents;
            var var10 = list.Where(x => x.ControlId.Contains("lbStaffId")).FirstOrDefault();
            lbStaffId.Text = (var10 == null) ? "" : var10.Contents;

            var var11 = list.Where(x => x.ControlId.Contains("btnAdd")).FirstOrDefault();
            btnAdd.Text = (var11 == null) ? "" : var11.Contents;
            var var12 = list.Where(x => x.ControlId.Contains("btnDelete")).FirstOrDefault();
            btnDelete.Text = (var12 == null) ? "" : var12.Contents;


            // Pop-up (Customer Id)
            var var33 = list.Where(x => x.ControlId.Contains("winAddConsumer")).FirstOrDefault();
            winAddConsumer.Title = (var33 == null) ? "" : var33.Contents;

            // Pop-up (Channel)
            var var34 = list.Where(x => x.ControlId.Contains("winAddStaff")).FirstOrDefault();
            winAddStaff.Title = (var34 == null) ? "" : var34.Contents;

            // Change header of combobox
            list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Admin/CreateUser.aspx")).ToList();
            Label label22 = cboRoles.Header.FindControl("role_header") as Label;
            var var50 = list.Where(x => x.ControlId.Contains("role_role_header")).FirstOrDefault();
            label22.Text = (var50 == null) ? "" : var50.Contents;

            label22 = cboRoles.Header.FindControl("description_header") as Label;
            var50 = list.Where(x => x.ControlId.Contains("role_description_header")).FirstOrDefault();
            label22.Text = (var50 == null) ? "" : var50.Contents;

            // Change header of combobox
            label22 = cboConsumers.Header.FindControl("customerId_header") as Label;
            var50 = list.Where(x => x.ControlId.Contains("customerId_header")).FirstOrDefault();
            label22.Text = (var50 == null) ? "" : var50.Contents;

            label22 = cboConsumers.Header.FindControl("customer_header") as Label;
            var50 = list.Where(x => x.ControlId.Contains("customer_header")).FirstOrDefault();
            label22.Text = (var50 == null) ? "" : var50.Contents;

            // Change header of combobox
            label22 = cboStaffs.Header.FindControl("staffID_header") as Label;
            var50 = list.Where(x => x.ControlId.Contains("staffID_header")).FirstOrDefault();
            label22.Text = (var50 == null) ? "" : var50.Contents;

            label22 = cboStaffs.Header.FindControl("staff_firstname_header") as Label;
            var50 = list.Where(x => x.ControlId.Contains("staff_firstname_header")).FirstOrDefault();
            label22.Text = (var50 == null) ? "" : var50.Contents;

            label22 = cboStaffs.Header.FindControl("staff_lastname_header") as Label;
            var50 = list.Where(x => x.ControlId.Contains("staff_lastname_header")).FirstOrDefault();
            label22.Text = (var50 == null) ? "" : var50.Contents;



            var10 = list.Where(x => x.ControlId.Contains("lb_user_delete_confirm")).FirstOrDefault();
            lb_user_delete_confirm.Text = (var10 == null) ? "" : var10.Contents;
        }
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
    protected void mnuDisplayGroup_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        SetEmpty();
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Admin/CreateUser.aspx")).ToList();
        var lb_user_update_confirm = list.Where(x => x.ControlId.Contains("lb_user_update_confirm")).FirstOrDefault();


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
                string staff = user.StaffId + ";";
                foreach (RadListBoxItem item in listBoxSelectedSites.Items)
                {
                    //loggerIds.Add(_siteBL.GetSite(item.Value).LoggerId);
                    string logger = _siteBL.GetSite(item.Value).LoggerId;
                    //update t_site set staffid =staff where loggerid = logger

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string cmdText = "UPDATE [t_Sites] SET [Staffs]=CONCAT('" + staff + "',[Staffs]) WHERE [LoggerId] = '" + logger + "'"; 
                        SqlCommand cmd = new SqlCommand(cmdText, connection);
                        connection.Open();
                        cmd.ExecuteReader();

                        // SqlDataReader rd = cmd.ExecuteReader();
                        // rd.Read();
                        connection.Close();
                    }//end using
                }
            }
            else
            {   
                user.Salt = dbUser.Salt;
                user.Password = dbUser.Password;
                string staff = user.StaffId + ";";
                foreach (RadListBoxItem item in listBoxSelectedSites.Items)
                {
                    //loggerIds.Add(_siteBL.GetSite(item.Value).LoggerId);
                    string logger = _siteBL.GetSite(item.Value).LoggerId;
                    //update t_site set staffid =staff where loggerid = logger

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string cmdText = "UPDATE [dbo].[t_Sites] SET [Staffs]=CONCAT('" + staff + "',[Staffs]) WHERE [LoggerId] = '" + logger + "'";
                        //string cmdText = "UPDATE [dbo].[t_Sites] SET [Staffs]=  [Staffs] + '" + staff + "'  WHERE [LoggerId] = '" + logger + "'";

                        SqlCommand cmd = new SqlCommand(cmdText, connection);
                        connection.Open();
                        cmd.ExecuteReader();

                        // SqlDataReader rd = cmd.ExecuteReader();
                        // rd.Read();
                        connection.Close();
                    }//end using
                }
            }
            _userBL.UpdateUser(user, dbUser);
            //ntf.Text = "Đã cập nhật thông tin người dùng.";
            ntf.Text = lb_user_update_confirm.Contents;
        }
    }

    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Admin/CreateUser.aspx")).ToList();
        var empty_username = list.Where(x => x.ControlId.Contains("empty_username")).FirstOrDefault();
        var delete_user_successfully = list.Where(x => x.ControlId.Contains("delete_user_successfully")).FirstOrDefault();

        ntf.VisibleOnPageLoad = true;
        if (string.IsNullOrEmpty(cboUsers.Text))
        {
            ntf.Text = empty_username.Contents;
            cboUsers.Focus();
            return;
        }
        var user = _userBL.GetUser(cboUsers.Text);
        if (user != null)
        {
            _userBL.DeleteUser(user);
            ntf.Text = delete_user_successfully.Contents;
            SetEmpty();
        }
    }

    protected void cboUsers_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        string username=cboUsers.Text;
        var user = _userBL.GetUser(username);
        if (user != null)
        {
           // List<string> loggerIds = new List<string>();
            SetValues(user);
            string staff = user.StaffId;
            grv.DataSource = GetData(staff);
            grv.DataBind();
        }
        txtPassword.Focus();
        // string staff = cboStaffs.Text;
       
    }
    public IEnumerable<t_Sites> GetData(string staff)
    {
        if (staff != null)
        {
            var listMonthlyComplexData = _siteBL.GetSitesByStaffId(staff);
            return listMonthlyComplexData;
        }
        else return null;
    
    }
   

    private bool IsInvalidInput()
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Admin/CreateUser.aspx")).ToList();
        var empty_username = list.Where(x => x.ControlId.Contains("empty_username")).FirstOrDefault();
        var empty_password = list.Where(x => x.ControlId.Contains("empty_password")).FirstOrDefault();
        var empty_email = list.Where(x => x.ControlId.Contains("empty_email")).FirstOrDefault();

        if (string.IsNullOrEmpty(cboUsers.Text))
        {
            ntf.Text = empty_username.Contents;
            cboUsers.Focus();
            return true;
        }
        if (string.IsNullOrEmpty(txtPassword.Text))
        {
            ntf.Text = empty_password.Contents;
            txtPassword.Focus();
            return true;
        }
        if (string.IsNullOrEmpty(txtEmail.Text))
        {
            ntf.Text = empty_email.Contents;
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
    protected void grv_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        grv.DataSource = GetData(cboStaffs.Text);
    }

    protected void grv_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        grv.DataSource = GetData(cboStaffs.Text);
    }
}