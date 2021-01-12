using PMAC.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Supervisor_Admin_ViewUsers : System.Web.UI.Page
{
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";
    protected void Page_Load(object sender, EventArgs e)
    {
        // Pi-solution
        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Admin/ViewUsers.aspx")).ToList();

            var var1 = list.Where(x => x.ControlId.Contains("lbTitle")).FirstOrDefault();
            lbTitle.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("lbFilter")).FirstOrDefault();
            lbFilter.Text = (var2 == null) ? "" : var2.Contents;

            var var3 = list.Where(x => x.ControlId.Contains("AliasName")).FirstOrDefault();
            var var4 = list.Where(x => x.ControlId.Contains("StaffId")).FirstOrDefault();
            var var5 = list.Where(x => x.ControlId.Contains("CustomerId")).FirstOrDefault();
            var var6 = list.Where(x => x.ControlId.Contains("Email")).FirstOrDefault();
            var var7 = list.Where(x => x.ControlId.Contains("Role")).FirstOrDefault();
            var var8 = list.Where(x => x.ControlId.Contains("IsActive")).FirstOrDefault();
            var var9 = list.Where(x => x.ControlId.Contains("LoginNum")).FirstOrDefault();

            foreach (GridColumn col in RadGrid1.MasterTableView.Columns)
            {
                if (col.UniqueName == "Username")
                    col.HeaderText = (var3 == null) ? "" : var3.Contents;
                if (col.UniqueName == "StaffId")
                    col.HeaderText = (var4 == null) ? "" : var4.Contents;
                if (col.UniqueName == "ConsumerId")
                    col.HeaderText = (var5 == null) ? "" : var5.Contents;
                if (col.UniqueName == "Email")
                    col.HeaderText = (var6 == null) ? "" : var6.Contents;
                if (col.UniqueName == "Role")
                    col.HeaderText = (var7 == null) ? "" : var7.Contents;
                if (col.UniqueName == "Active")
                    col.HeaderText = (var8 == null) ? "" : var8.Contents;
                if (col.UniqueName == "LoginTime")
                    col.HeaderText = (var9 == null) ? "" : var9.Contents;
            }


            // Change header of combobox
            list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();
            Label label22 = cboConsumers.Header.FindControl("customerId_header") as Label;
            var var50 = list.Where(x => x.ControlId.Contains("winAddConsumer_customerId")).FirstOrDefault();
            label22.Text = (var50 == null) ? "" : var50.Contents;

            label22 = cboConsumers.Header.FindControl("customerName_header") as Label;
            var50 = list.Where(x => x.ControlId.Contains("winAddConsumer_customerName")).FirstOrDefault();
            label22.Text = (var50 == null) ? "" : var50.Contents;

            RadGrid1.Rebind();
        }
    }
}