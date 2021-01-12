using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;

using Telerik.Web.UI;
using Telerik.Web.UI.GridExcelBuilder;

public partial class Controls_ucDailyReport_rev2 : System.Web.UI.UserControl
{
    SiteBL _siteBL = new SiteBL();
    ComplexDataHelper _complexDataHelper = new ComplexDataHelper();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        // Pi-solution developer - multi languages
        if (!IsPostBack)
        {
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();
        }

    }

    public IList<ComplexDataViewModel> GetData()
    {
        if (dtmStart.SelectedDate != null && dtmEnd.SelectedDate != null)
        {
            DateTime startDate = (DateTime)dtmStart.SelectedDate;
            DateTime endDate = (DateTime)dtmEnd.SelectedDate;
            List<string> loggerIds = new List<string>();
            DropDownListItem selectedItem = DropDownSite.SelectedItem;
            loggerIds.Add(_siteBL.GetSite(selectedItem.Value).LoggerId);
            var listDailyComplexData = _complexDataHelper.GetDailyComplexData_Multiple(loggerIds, startDate, endDate);

            //var tempMaxFlow = listDailyComplexData.Max(d => d.MaxFlowRate);
            //var maxFlow = listDailyComplexData.Where(d => d.MaxFlowRate == tempMaxFlow).ToList();

            //var tempMinFlow = listDailyComplexData.Min(d => d.MinFlowRate);
            //var minFlow = listDailyComplexData.Where(d => d.MinFlowRate == tempMinFlow).ToList();

            //var tempMaxPress = listDailyComplexData.Max(d => d.MaxPressure);
            //var maxPress = listDailyComplexData.Where(d => d.MaxPressure == tempMaxPress).ToList();

            //var tempMinPress = listDailyComplexData.Min(d => d.MinPressure);
            //var minPress = listDailyComplexData.Where(d => d.MinPressure == tempMinPress).ToList();

            return listDailyComplexData;
        }
        else return null;
    }
}