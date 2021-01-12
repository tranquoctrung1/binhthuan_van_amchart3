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

public partial class Controls_ucSystemGeneral : System.Web.UI.UserControl
{
    LanguageBL languageBL = new LanguageBL();
    SysParamBL sysParamBL = new SysParamBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;

        // Pi-solution
        language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/System/General.aspx")).ToList();


        // Load language contents - vietnamse
        List<t_SysParam> contentList = sysParamBL.FindAll().OrderBy(s=> s.ID).ToList();
        List<t_SysParam_DTO> listDTO = new List<t_SysParam_DTO>();
        int index = 0;
        foreach (var item in contentList)
        {
            string NavigateURL = "";
            string HyperLinkText = "";
            if (index == 0)
            {
                NavigateURL = "/Supervisor/System/General/Edit.aspx?Id=2";
                HyperLinkText = "Edit";
            }
            listDTO.Add(new t_SysParam_DTO
            {
                Id = item.ID,
                NavigateURL = NavigateURL,
                HyperLinkText = HyperLinkText,
                Id_display = (index+1).ToString("0000"),
                Val = item.Val,
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
        }

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
            if (index > 0)
            {
                TextBox type_vi = ((TextBox)gvr.FindControl("Val"));
                type_vi.Enabled = true;
                TextBox type_en = ((TextBox)gvr.FindControl("Description"));
                type_en.Enabled = true;
            }
            index++;
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        int index = 0;
        foreach (GridViewRow gvr in GridView1.Rows)
        {
            if (index > 0)
            {
                TextBox type_vi = ((TextBox)gvr.FindControl("Val"));
                type_vi.Enabled = false;
                TextBox type_en = ((TextBox)gvr.FindControl("Description"));
                type_en.Enabled = false;

                // Update to SQL
                t_SysParam entity_vi = new t_SysParam
                {
                    Val = type_vi.Text,
                    Description = type_en.Text
                };
                string Id = (gvr.FindControl("Id") as HiddenField).Value;
                bool updateStatus = sysParamBL.Update(entity_vi, int.Parse(Id));
                
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