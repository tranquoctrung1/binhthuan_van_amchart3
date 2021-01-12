using PMAC.BLL;
using PMAC.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Consumer_Logger_Complex : System.Web.UI.Page
{
    DBEntities _db = new DBEntities();

    ComplexDataRepository complexDataRepository = new ComplexDataRepository();
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";
    protected void Page_Load(object sender, EventArgs e)
    {      
        if (!IsPostBack)
        {
            // Pi-solution developer - multi languages
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();
            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Logger/Complex_TA.aspx")).ToList();

            //Parse content to form
            var var1 = list.Where(x => x.ControlId.Contains("lbTitle")).FirstOrDefault();
            lbTitle.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("btnSearch")).FirstOrDefault();
            btnSearch.Text = (var2 == null) ? "" : var2.Contents;

            // Pi-solution
            // Binding data source            
            this.BindItemsList();
        }
    }
    
    public void BindData()
    {
        var username = HttpContext.Current.User.Identity.Name;

        var user = _db.t_Users.SingleOrDefault(s => s.Username == username);
        if (user != null)
        {
            if (user.Role.ToLower() == "staff")
            {
                ListView1.DataSource = DataSource1;
                DataSource1.DataBind();

            }
            if (user.Role.ToLower() == "consumer")
            {
                ListView1.DataSource = DataSource2;
                DataSource2.DataBind();
            }
        }

        ListView1.DataBind();
    }
    protected void DataSource1_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        var username = HttpContext.Current.User.Identity.Name;

        var user = _db.t_Users.SingleOrDefault(s => s.Username == username);

        if (user != null)
        {
            if (user.Role.ToLower() == "staff")
            {
                e.InputParameters["staffId"] = user.StaffId;
            }
        }
    }
    protected void DataSource2_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        var username = HttpContext.Current.User.Identity.Name;

        var user = _db.t_Users.SingleOrDefault(s => s.Username == username);

        if (user != null)
        {
            if (user.Role.ToLower() == "consumer")
            {
                e.InputParameters["consumerId"] = user.ConsumerId;
            }
        }
    }


    private void repTest_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Logger/Complex_TA.aspx"))

            .ToList();

        Label lblHeader = e.Item.FindControl("lbAliasName") as Label;
        var var1 = list.Where(x => x.ControlId.Contains("lbAliasName")).FirstOrDefault();
        if (lblHeader != null)
        {
            lblHeader.Text = (var1 == null) ? "" : var1.Contents;
        }

        lblHeader = e.Item.FindControl("lbSiteId") as Label;
        var var2 = list.Where(x => x.ControlId.Contains("lbSiteId")).FirstOrDefault();
        if (lblHeader != null)
        {
            lblHeader.Text = (var2 == null) ? "" : var2.Contents;
        }

        lblHeader = e.Item.FindControl("lbTimeStamp") as Label;
        var var3 = list.Where(x => x.ControlId.Contains("lbTimeStamp")).FirstOrDefault();
        if (lblHeader != null)
        {
            lblHeader.Text = (var3 == null) ? "" : var3.Contents;
        }

        lblHeader = e.Item.FindControl("lbPressure1") as Label;
        var var4 = list.Where(x => x.ControlId.Contains("lbPressure1")).FirstOrDefault();
        if (lblHeader != null)
        {
            lblHeader.Text = (var4 == null) ? "" : var4.Contents;
        }

        lblHeader = e.Item.FindControl("lbPressure2") as Label;
        var var5 = list.Where(x => x.ControlId.Contains("lbPressure2")).FirstOrDefault();
        if (lblHeader != null)
        {
            lblHeader.Text = (var5 == null) ? "" : var5.Contents;
        }

        lblHeader = e.Item.FindControl("lbForwardFlow") as Label;
        var var6 = list.Where(x => x.ControlId.Contains("lbForwardFlow")).FirstOrDefault();
        if (lblHeader != null)
        {
            lblHeader.Text = (var6 == null) ? "" : var6.Contents;
        }

        lblHeader = e.Item.FindControl("lbReverseFlow") as Label;
        var var7 = list.Where(x => x.ControlId.Contains("lbReverseFlow")).FirstOrDefault();
        if (lblHeader != null)
        {
            lblHeader.Text = (var7 == null) ? "" : var7.Contents;
        }

        lblHeader = e.Item.FindControl("lbForwardIndex") as Label;
        var var8 = list.Where(x => x.ControlId.Contains("lbPressure1")).FirstOrDefault();
        if (lblHeader != null)
        {
            lblHeader.Text = (var8 == null) ? "" : var8.Contents;
        }

        lblHeader = e.Item.FindControl("lbReverseIndex") as Label;
        var var9 = list.Where(x => x.ControlId.Contains("lbReverseIndex")).FirstOrDefault();
        if (lblHeader != null)
        {
            lblHeader.Text = (var9 == null) ? "" : var9.Contents;
        }

        lblHeader = e.Item.FindControl("lbNetIndex") as Label;
        var var10 = list.Where(x => x.ControlId.Contains("lbNetIndex")).FirstOrDefault();
        if (lblHeader != null)
        {
            lblHeader.Text = (var10 == null) ? "" : var10.Contents;
        }
    }

    PagedDataSource _PageDataSource = new PagedDataSource();
    private DataTable GetDataTable()
    {
        DataTable dtItems = new DataTable();
        string srch = Request.QueryString["srch"];

        var username = HttpContext.Current.User.Identity.Name;

        var user = _db.t_Users.SingleOrDefault(s => s.Username == username);
        var ListData = new List<ComplexData>();
        if (user != null)
        {
            if (user.Role.ToLower() == "staff")
            {
                ListData = complexDataRepository.GetCustomComplexDataForStaff(user.StaffId).ToList();
            }
            if (user.Role.ToLower() == "consumer")
            {
                ListData = complexDataRepository.GetCustomComplexDataForStaff(user.ConsumerId).ToList();
            }
        }

        if (String.IsNullOrEmpty(srch))
        {
            dtItems = ToDataTable<ComplexData>(ListData);
        }
        else
        {
            //perform search and display results            
            dtItems = ToDataTable<ComplexData>(ListData.AsQueryable().Where(
                s => Contains(s.SiteAliasName, srch) || Contains(s.SiteId, srch)
                ).ToList());
        }
        return dtItems;

    }
    private void BindItemsList()
    {
        DataTable dataTable = this.GetDataTable();
        _PageDataSource.DataSource = dataTable.DefaultView;
        _PageDataSource.AllowPaging = true;
        _PageDataSource.PageSize = 6;
        _PageDataSource.CurrentPageIndex = CurrentPage;
        ViewState["TotalPages"] = _PageDataSource.PageCount;

        this.lblPageInfo.Text = "Page " + (CurrentPage + 1) + " of " + _PageDataSource.PageCount;
        this.lbtnPrevious.Enabled = !_PageDataSource.IsFirstPage;
        this.lbtnNext.Enabled = !_PageDataSource.IsLastPage;
        this.lbtnFirst.Enabled = !_PageDataSource.IsFirstPage;
        this.lbtnLast.Enabled = !_PageDataSource.IsLastPage;

        this.ListView1.DataSource = _PageDataSource;
        // Convert label between multi- languages
        ListView1.ItemDataBound += new RepeaterItemEventHandler(repTest_ItemDataBound);
        this.ListView1.DataBind();

        this.doPaging();
    }

    private void doPaging()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("PageIndex");
        dt.Columns.Add("PageText");

        fistIndex = CurrentPage - 5;

        if (CurrentPage > 5)
        {
            lastIndex = CurrentPage + 5;
        }
        else
        {
            lastIndex = 10;
        }
        if (lastIndex > Convert.ToInt32(ViewState["TotalPages"]))
        {
            lastIndex = Convert.ToInt32(ViewState["TotalPages"]);
            fistIndex = lastIndex - 10;
        }

        if (fistIndex < 0)
        {
            fistIndex = 0;
        }

        for (int i = fistIndex; i < lastIndex; i++)
        {
            DataRow dr = dt.NewRow();
            dr[0] = i;
            dr[1] = i + 1;
            dt.Rows.Add(dr);
        }

        this.dlPaging.DataSource = dt;
        this.dlPaging.DataBind();
    }

    protected void dlPaging_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName.Equals("Paging"))
        {
            CurrentPage = Convert.ToInt16(e.CommandArgument.ToString());
            this.BindItemsList();
        }
    }

    protected void dlPaging_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        LinkButton lnkbtnPage = (LinkButton)e.Item.FindControl("lnkbtnPaging");
        if (lnkbtnPage.CommandArgument.ToString() == CurrentPage.ToString())
        {
            lnkbtnPage.Enabled = false;
            lnkbtnPage.Style.Add("fone-size", "14px");
            lnkbtnPage.Font.Bold = true;

        }
    }

    protected void lbtnNext_Click(object sender, EventArgs e)
    {
        CurrentPage += 1;
        this.BindItemsList();

    }
    protected void lbtnPrevious_Click(object sender, EventArgs e)
    {
        CurrentPage -= 1;
        this.BindItemsList();

    }
    protected void lbtnLast_Click(object sender, EventArgs e)
    {

        CurrentPage = (Convert.ToInt32(ViewState["TotalPages"]) - 1);
        this.BindItemsList();

    }
    protected void lbtnFirst_Click(object sender, EventArgs e)
    {

        CurrentPage = 0;
        this.BindItemsList();

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        var searchText = Server.UrlEncode(txtSearchMaster.Text); // URL encode in case of special characters
        Response.Redirect("~/Consumer/Logger/Complex.aspx?srch=" + searchText);
    }

    private int CurrentPage
    {
        get
        {
            object objPage = ViewState["_CurrentPage"];
            int _CurrentPage = 0;
            if (objPage == null)
            {
                _CurrentPage = 0;
            }
            else
            {
                _CurrentPage = (int)objPage;
            }
            return _CurrentPage;
        }
        set { ViewState["_CurrentPage"] = value; }
    }
    private int fistIndex
    {
        get
        {

            int _FirstIndex = 0;
            if (ViewState["_FirstIndex"] == null)
            {
                _FirstIndex = 0;
            }
            else
            {
                _FirstIndex = Convert.ToInt32(ViewState["_FirstIndex"]);
            }
            return _FirstIndex;
        }
        set { ViewState["_FirstIndex"] = value; }
    }
    private int lastIndex
    {
        get
        {

            int _LastIndex = 0;
            if (ViewState["_LastIndex"] == null)
            {
                _LastIndex = 0;
            }
            else
            {
                _LastIndex = Convert.ToInt32(ViewState["_LastIndex"]);
            }
            return _LastIndex;
        }
        set { ViewState["_LastIndex"] = value; }
    }


    protected void Timer1_Tick(object sender, EventArgs e)
    {
        DataSource1.DataBind();
        ListView1.DataBind();
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

    public static bool Contains(string target, string value)
    {
        return target.IndexOf(value, StringComparison.OrdinalIgnoreCase) >= 0;
    }
}