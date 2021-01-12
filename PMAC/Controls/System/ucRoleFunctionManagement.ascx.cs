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

public partial class Controls_ucRoleFunctionManagement : System.Web.UI.UserControl
{
    LanguageBL languageBL = new LanguageBL();
    SysParamBL sysParamBL = new SysParamBL();
    UserBL userBL = new UserBL();
    RoleBL roleBL = new RoleBL();
    RoleFunctionBL roleFunctionBL = new RoleFunctionBL();
    FunctionBL functionBL = new FunctionBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;

        // Pi-solution
        language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/System/RoleFunction.aspx")).ToList();
        

        if (!IsPostBack)
        {
            DataTable dt = new DataTable();

            ddlRole.DataSource = ToDataTable(roleBL.FindAll().ToList());
            ddlRole.DataTextField = "Description";
            ddlRole.DataValueField = "Role";
            ddlRole.DataBind();
            ddlRole.SelectedValue = "admin";

            LoadData("admin");

            // Language
            var var1 = list.Where(x => x.ControlId.Contains("btnEdit")).FirstOrDefault();
            btnEdit.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("btnUpdate")).FirstOrDefault();
            btnUpdate.Text = (var2 == null) ? "" : var2.Contents;

            var var3 = list.Where(x => x.ControlId.Contains("lbSelectRole")).FirstOrDefault();
            lbRole.Text = (var3 == null) ? "" : var3.Contents;

        }

    }

    private void LoadData(string role)
    {
        CheckList(role);
        // Load language contents - vietnamse
        List<t_RoleFunction> contentList = roleFunctionBL.FindAll(s=> s.Role == role).OrderBy(s => s.Role).ToList();
        List<t_RoleFunction_DTO> listDTO = new List<t_RoleFunction_DTO>();
        int index = 0;
        foreach (var item in contentList)
        {
            t_Function singleF_vi = functionBL.FindSingle(x => x.FunctionId == item.FunctionId);
            if (string.IsNullOrEmpty(singleF_vi.URL))
                continue;

            t_Function singleF_en = functionBL.FindSingle(x => x.URL == singleF_vi.URL && x.Language == "en");
            t_Function singleF_other = functionBL.FindSingle(x => x.URL == singleF_vi.URL && x.Language == "other");

            string functionname = "";
            switch (language)
            {
                case "vi":
                    functionname = singleF_vi.FunctionName;
                    break;
                case "en":
                    functionname = singleF_en.FunctionName;
                    break;
                case "other":
                    functionname = singleF_other.FunctionName;
                    break;
                default:
                    functionname = singleF_vi.FunctionName;
                    break;
            }

            switch (singleF_vi.Note)
            {
                case "Parent":
                    break;
                case "Children":
                    functionname = "--  " + functionname;
                    break;
                default:
                    break;
            }

            listDTO.Add(new t_RoleFunction_DTO
            {
                Id_display = (index + 1).ToString("0000"),
                FunctionName_vi = functionname,
                //FunctionName_en = singleF_en.FunctionName,
                //FunctionName_other = singleF_other.FunctionName,
                Active = (bool)item.Active,
                Role = item.Role,
                FunctionId = item.FunctionId,
            });
            index++;
        }

        DataTable dt = new DataTable();
        GridView1.DataSource = ToDataTable(listDTO);
        GridView1.DataBind();
    }
    
    protected void ddlRoleLoad(object sender, EventArgs e)
    {
        
    }

    protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
    {
        string role = ddlRole.SelectedValue;
        LoadData(role);
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string Id = (sender as LinkButton).ID;
        string urlRedirect = string.Format("/Supervisor/System/General/Edit.aspx?Id={0}", Id);
        Response.Redirect(urlRedirect);
    }

    

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        int index = 0;
        foreach (GridViewRow gvr in GridView1.Rows)
        {
            if (index > -1)
            {
                CheckBox type_vi5 = ((CheckBox)gvr.FindControl("chkActive"));
                type_vi5.Enabled = true;
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
                CheckBox chk = ((CheckBox)gvr.FindControl("chkActive"));
                chk.Enabled = false;
                HiddenField roleName = ((HiddenField)gvr.FindControl("Role"));
                HiddenField functionId = ((HiddenField)gvr.FindControl("FunctionId"));
                // Update to SQL
                t_RoleFunction newone = new t_RoleFunction
                {
                    Active = chk.Checked
                };
                
                roleFunctionBL.Update(newone, roleName.Value, int.Parse(functionId.Value));

            }
            index++;
        }
    }

    private void CheckList(string role)
    {
        List<t_RoleFunction> listRoleFunction = roleFunctionBL.FindAll(x => x.Role == role).ToList();
        List<t_Function> listFunction = functionBL.FindAll(x => x.Language == "vi").ToList();
        if (listFunction.Count == listRoleFunction.Count)
        {
            return;
        }
        foreach (var item in listFunction)
        {
            var isExit = listRoleFunction.FirstOrDefault(x => x.FunctionId == item.FunctionId);
            if (isExit == null)
            {
                roleFunctionBL.AddRole(new t_RoleFunction
                {
                    Active = false,
                    FunctionId = item.FunctionId,
                    Role = role
                });
            }
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