using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Supervisor_Logger_Complex : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        ComplexDataSource1.DataBind();
        rGrid1.DataBind();
    }

    public class Alarm
    {
        public string Id { get; set; }
        public string Priority { get; set; }
        public string SiteName { get; set; }
        public string Descript { get; set; }
        public string EntryTme { get; set; }
    }

    protected void rGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        List<Alarm> listAlarm = new List<Alarm>();
        OleDbConnection aCnn = new OleDbConnection("");
        
        aCnn.ConnectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;Data source=C:\PMAC\PMACSITE.MDB";

        try
        {
            string strCmd = "SELECT*FROM [ALARMLOG] WHERE [Priority] LIKE 'H' OR [Priority] LIKE 'L'";
            Alarm alrm = new Alarm();
            aCnn.Open();
            OleDbCommand aCmd = new OleDbCommand(strCmd, aCnn);
            OleDbDataReader aRdr = aCmd.ExecuteReader();
            while (aRdr.Read())
            {
                alrm.Id = aRdr["Id"].ToString();
                alrm.Priority = aRdr["Priority"].ToString();
                alrm.SiteName = aRdr["SiteName"].ToString();
                alrm.Descript = aRdr["Descript"].ToString();
                alrm.EntryTme = aRdr["EntryTme"].ToString();
            }
            aCnn.Close();
            aCnn.Dispose();

        }
        catch (Exception ex)
        {

            throw ex;
        }

        var newList = listAlarm.OrderByDescending(o => o.EntryTme)
            .GroupBy(g => g.Id)
            .Select(s => new { s, Count = s.Count() })
            .SelectMany(sm => sm.s.Select(s => s)
                .Zip(Enumerable.Range(1, sm.Count), (_myAlrm, index) 
                    => new { Nr = index, _myAlrm.Id, _myAlrm.Priority, _myAlrm.Descript })).ToList();

        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;

            TableCell alrmCell = (TableCell)item["Alarm"];
            TableCell loggerIdCell = (TableCell)item["LoggerId"];

            string priority = "";
            foreach (var al in newList)
            {
                if (al.Id == loggerIdCell.Text)
                {
                    priority = al.Priority;
                    item.Font.Bold = true;
                    item["Alarm"].Text = al.Descript;
                    if (priority == "H")
                    {
                        item.BackColor = System.Drawing.ColorTranslator.FromHtml("#ff0000");
                        item.ForeColor = System.Drawing.Color.White;
                    }
                    else if (priority == "L")
                    {
                        item.BackColor = System.Drawing.ColorTranslator.FromHtml("#F3B200");
                    }
                    //else if (priority == "A")
                    //{
                    //    item.BackColor = System.Drawing.ColorTranslator.FromHtml("#00A600");
                    //    item.ForeColor = System.Drawing.Color.White;
                    //}
                }
            }
        }
    }
}