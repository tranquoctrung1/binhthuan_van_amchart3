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

public partial class Controls_ucRoleManagement : System.Web.UI.UserControl
{
    LanguageBL languageBL = new LanguageBL();
    SysParamBL sysParamBL = new SysParamBL();
    RoleBL roleBL = new RoleBL();
    
    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;

        // Pi-solution
        language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/System/Roles.aspx")).ToList();
        

        // Load language contents - vietnamse
        List<t_Roles> contentList = roleBL.FindAll().ToList();
        List<t_Roles_DTO> listDTO = new List<t_Roles_DTO>();
        int index = 0;
        foreach (var item in contentList)
        {
            listDTO.Add(new t_Roles_DTO
            {
                Id_display = (index+1).ToString("0000"),
                Role = item.Role,
                Description = item.Description,
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

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string Id = (sender as LinkButton).ID;
        string urlRedirect = string.Format("/Supervisor/System/General/Edit.aspx?Id={0}", Id);
        Response.Redirect(urlRedirect);
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("/Supervisor/System/Roles/Add.aspx");
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        int index = 0;
        foreach (GridViewRow gvr in GridView1.Rows)
        {
            if (index > -1)
            {
                TextBox type_vi1 = ((TextBox)gvr.FindControl("Description"));
                type_vi1.Enabled = true;
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
                HiddenField roleName = ((HiddenField)gvr.FindControl("Role"));
                TextBox type_vi1 = ((TextBox)gvr.FindControl("Description"));
                type_vi1.Enabled = false;

                // Update to SQL
                t_Roles updateRole = new t_Roles
                {
                    Description = type_vi1.Text,
                };

                roleBL.Update(updateRole, roleName.Value);

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