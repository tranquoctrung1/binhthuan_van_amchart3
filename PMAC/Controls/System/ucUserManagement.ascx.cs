using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;
using PMAC.ULT;

public partial class Controls_ucUserManagement : System.Web.UI.UserControl
{
    LanguageBL languageBL = new LanguageBL();
    SysParamBL sysParamBL = new SysParamBL();
    UserBL userBL = new UserBL();
    RoleBL roleBL = new RoleBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;

        // Pi-solution
        language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/System/Users.aspx")).ToList();
        

        // Load language contents - vietnamse
        List<t_Users> contentList = userBL.FindAll().OrderBy(s=> s.Role).ToList();
        List<t_Users_DTO> listDTO = new List<t_Users_DTO>();
        int index = 0;


        foreach (var item in contentList)
        {
            if (item.Active == null)
                item.Active = false;

            listDTO.Add(new t_Users_DTO
            {
                Id_display = (index+1).ToString("0000"),
                Password = item.Password,
                Salt = item.Salt,
                Email = item.Email,
                ConsumerId = item.ConsumerId,
                Role = item.Role,
                StaffId = item.StaffId,
                Username = item.Username,
                Active = (bool)item.Active ? "True" : "False"
            });
            index++;
        }
        

        if (!IsPostBack)
        {
            DataTable dt = new DataTable();
            GridView1.DataSource = ToDataTable(listDTO);
            GridView1.DataBind();

            // Language
            var var1 = list.Where(x => x.ControlId.Contains("btnEdit")).FirstOrDefault();
            btnEdit.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("btnUpdate")).FirstOrDefault();
            btnUpdate.Text = (var2 == null) ? "" : var2.Contents;
            var var3 = list.Where(x => x.ControlId.Contains("btnAdd")).FirstOrDefault();
            btnAdd.Text = (var3 == null) ? "" : var3.Contents;
        }

    }

    // Bind dropdownlist
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList DropDownList1 = (e.Row.FindControl("ddlRole") as DropDownList);

            DataTable dt = new DataTable();

            DropDownList1.DataSource = ToDataTable(roleBL.FindAll().ToList());
            DropDownList1.DataTextField = "Description";
            DropDownList1.DataValueField = "Role";


            DropDownList1.DataBind();

            HiddenField role = (e.Row.FindControl("Role") as HiddenField);
            DropDownList1.SelectedValue = role.Value;
        }

    }


    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string Id = (sender as LinkButton).ID;
        string urlRedirect = string.Format("/Supervisor/System/General/Edit.aspx?Id={0}", Id);
        Response.Redirect(urlRedirect);
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("/Supervisor/System/Users/Add.aspx");
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        int index = 0;
        foreach (GridViewRow gvr in GridView1.Rows)
        {
            if (index > -1)
            {
                DropDownList type_vi5 = ((DropDownList)gvr.FindControl("ddlRole"));
                type_vi5.Enabled = true;
                DropDownList type_vi6 = ((DropDownList)gvr.FindControl("ddlActive"));
                type_vi6.Enabled = true;
            }
            index++;
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        int index = 0;
        foreach (GridViewRow gvr in GridView1.Rows)
        {
            if (index > -1)
            {
                TextBox type_vi1 = ((TextBox)gvr.FindControl("Username"));
                type_vi1.Enabled = false;
                TextBox type_vi2 = ((TextBox)gvr.FindControl("StaffId"));
                type_vi2.Enabled = false;
                TextBox type_vi3 = ((TextBox)gvr.FindControl("ConsumerId"));
                type_vi3.Enabled = false;
                TextBox type_vi4 = ((TextBox)gvr.FindControl("Email"));
                type_vi4.Enabled = false;
                DropDownList type_vi5 = ((DropDownList)gvr.FindControl("ddlRole"));
                type_vi5.Enabled = false;
                DropDownList type_vi6 = ((DropDownList)gvr.FindControl("ddlActive"));
                type_vi6.Enabled = false;

                // Update to SQL
                t_Users original = userBL.GetUser(type_vi1.Text);
                t_Users newUser = original;
                newUser.Active = (type_vi6.SelectedValue == "True") ? true : false;
                newUser.Role = type_vi5.SelectedValue;

                userBL.UpdateUser(newUser, original);

            }
            index++;
        }
    }

    public static DataTable ToDataTable<T>(List<T> items)
    {
        var tb = new DataTable(typeof(T).Name);

        PropertyInfo[] props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);

        foreach (var prop in props)
        {
            tb.Columns.Add(prop.Name, Nullable.GetUnderlyingType(
            prop.PropertyType) ?? prop.PropertyType);
        }

        foreach (var item in items)
        {
            var values = new object[props.Length];
            for (var i = 0; i < props.Length; i++)
            {
                values[i] = props[i].GetValue(item, null);
            }

            tb.Rows.Add(values);
        }

        return tb;
    }
}