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

public partial class Controls_ucLanguageFunction : System.Web.UI.UserControl
{
    LanguageBL languageBL = new LanguageBL();
    FunctionBL functionBL = new FunctionBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        // Pi-solution
        language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Language/ChangeFunction.aspx")).ToList();


        // Load language contents - vietnamse
        List<t_Function> functionList_vi = functionBL.FindAll(x => x.Language == "vi").ToList();
        List<t_Function> functionList_en = functionBL.FindAll(x => x.Language == "en").ToList();
        List<t_Function> functionList_other = functionBL.FindAll(x => x.Language == "other").ToList();

        List<t_Function_DTO> listDTO = new List<t_Function_DTO>();

        listDTO.Add(new t_Function_DTO {
            Id_display = "Icon",
            FunctionName_vi = "",
            FunctionName_en = "",
            FunctionName_other = "",
        });
        int index = 0;
        foreach (var item in functionList_vi)
        {
            listDTO.Add(new t_Function_DTO {                
                Id_display = index.ToString("0000"),
                FunctionId_vi = functionList_vi[index].FunctionId,
                FunctionId_en = functionList_en[index].FunctionId,
                FunctionId_other = functionList_other[index].FunctionId,
                FunctionName_vi = functionList_vi[index].FunctionName,
                FunctionName_en = functionList_en[index].FunctionName,
                FunctionName_other = functionList_other[index].FunctionName,
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

        // Set flag
        index = 0;
        foreach (GridViewRow gvr in GridView1.Rows)
        {
            if (index == 0)
            {
                Image type_vi = ((Image)gvr.FindControl("Image1"));
                type_vi.ImageUrl = "/_imgs/Language/Flag_of_Vietnam.PNG";
                type_vi.Attributes["style"] = "width:30px; height:20px";
                Image type_en = ((Image)gvr.FindControl("Image2"));
                type_en.ImageUrl = "/_imgs/Language/Flag_of_England.PNG";
                type_en.Attributes["style"] = "width:30px; height:20px";
            }
            break;
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        int index = 0;
        foreach (GridViewRow gvr in GridView1.Rows)
        {
            if (index > 0)
            {
                TextBox type_vi = ((TextBox)gvr.FindControl("FunctionName_vi"));
                type_vi.Enabled = true;
                TextBox type_en = ((TextBox)gvr.FindControl("FunctionName_en"));
                type_en.Enabled = true;
                TextBox type_other = ((TextBox)gvr.FindControl("FunctionName_other"));
                type_other.Enabled = true;
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
                TextBox type_vi = ((TextBox)gvr.FindControl("FunctionName_vi"));
                type_vi.Enabled = false;
                TextBox type_en = ((TextBox)gvr.FindControl("FunctionName_en"));
                type_en.Enabled = false;
                TextBox type_other = ((TextBox)gvr.FindControl("FunctionName_other"));
                type_other.Enabled = false;

                // Update to SQL
                t_Function entity_vi = new t_Function
                {
                    FunctionName = type_vi.Text,
                };
                string Id_vi = (gvr.FindControl("FunctionId_vi") as HiddenField).Value;
                bool updateStatus = functionBL.Update(entity_vi, int.Parse(Id_vi));

                t_Function entity_en = new t_Function
                {
                    FunctionName = type_en.Text,
                };
                string Id_en = (gvr.FindControl("FunctionId_en") as HiddenField).Value;
                updateStatus = functionBL.Update(entity_en, int.Parse(Id_en));

                t_Function entity_other = new t_Function
                {
                    FunctionName = type_other.Text,
                };
                string Id_other = (gvr.FindControl("FunctionId_other") as HiddenField).Value;
                updateStatus = functionBL.Update(entity_other, int.Parse(Id_other));
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