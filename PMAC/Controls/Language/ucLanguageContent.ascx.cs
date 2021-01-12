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

public partial class Controls_ucLanguageContent : System.Web.UI.UserControl
{
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        ntf.VisibleOnPageLoad = false;

        // Pi-solution
        language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Language/ChangeContent.aspx")).ToList();

        // Load language contents - vietnamse
        List<t_LanguageTranslate> contentList_vi = languageBL.FindAll(x => x.Language == "vi").OrderBy(x=> x.Noted).ToList();
        List<t_LanguageTranslate> contentList_en = languageBL.FindAll(x => x.Language == "en").OrderBy(x => x.Noted).ToList();
        List<t_LanguageTranslate> contentList_other = languageBL.FindAll(x => x.Language == "other").OrderBy(x => x.Noted).ToList();

        List<t_Content_DTO> listDTO = new List<t_Content_DTO>();

        listDTO.Add(new t_Content_DTO
        {
            Id_display = "Icon",
            Content_vi = "",
            Content_en = "",
            Content_other = "",
        });

        int index = 0;
        foreach (var item in contentList_en)
        {
            listDTO.Add(new t_Content_DTO
            {
                Id_display = index.ToString("0000"),
                Id_vi = contentList_vi[index].Id,
                Id_en = contentList_en[index].Id,
                Id_other = contentList_other[index].Id,
                Content_vi = contentList_vi[index].Contents,
                Content_en = contentList_en[index].Contents,
                Content_other = contentList_other[index].Contents,
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

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string Id = (sender as LinkButton).ID;
        string urlRedirect = string.Format("/Supervisor/Language/Contents/Edit.aspx?Id={0}", Id);
        Response.Redirect(urlRedirect);
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        int index = 0;
        foreach (GridViewRow gvr in GridView1.Rows)
        {
            if (index > 0)
            {
                TextBox type_vi = ((TextBox)gvr.FindControl("Content_vi"));
                type_vi.Enabled = true;
                TextBox type_en = ((TextBox)gvr.FindControl("Content_en"));
                type_en.Enabled = true;
                TextBox type_other = ((TextBox)gvr.FindControl("Content_other"));
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
                TextBox type_vi = ((TextBox)gvr.FindControl("Content_vi"));
                type_vi.Enabled = false;
                TextBox type_en = ((TextBox)gvr.FindControl("Content_en"));
                type_en.Enabled = false;
                TextBox type_other = ((TextBox)gvr.FindControl("Content_other"));
                type_other.Enabled = false;

                // Update to SQL
                t_LanguageTranslate entity_vi = new t_LanguageTranslate
                {
                    Contents = type_vi.Text,
                };
                string Id_vi = (gvr.FindControl("Id_vi") as HiddenField).Value;
                bool updateStatus = languageBL.Update(entity_vi, int.Parse(Id_vi));

                t_LanguageTranslate entity_en = new t_LanguageTranslate
                {
                    Contents = type_en.Text,
                };
                string Id_en = (gvr.FindControl("Id_en") as HiddenField).Value;
                updateStatus = languageBL.Update(entity_en, int.Parse(Id_en));

                t_LanguageTranslate entity_other = new t_LanguageTranslate
                {
                    Contents = type_other.Text,
                };
                string Id_other = (gvr.FindControl("Id_other") as HiddenField).Value;
                updateStatus = languageBL.Update(entity_other, int.Parse(Id_other));
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