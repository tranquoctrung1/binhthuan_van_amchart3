using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Supervisor_Logger_Alarming : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void grvAlarm_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            
            GridDataItem item = (GridDataItem)e.Item;

            TableCell priorityCell = (TableCell)item["Priority"];
            item.Font.Bold = true;
            if (priorityCell.Text == "H")
            {
                item.BackColor = System.Drawing.ColorTranslator.FromHtml("#ff0000");
                item.ForeColor = System.Drawing.Color.White;
            }
            else if (priorityCell.Text == "L")
            {
                item.BackColor = System.Drawing.ColorTranslator.FromHtml("#F3B200");
            }
            else if (priorityCell.Text == "A")
            {
                item.BackColor = System.Drawing.ColorTranslator.FromHtml("#00A600");
                item.ForeColor = System.Drawing.Color.White;
            }

            TableCell alarmTmeCell = (TableCell)item["AlarmTme"];
            if (alarmTmeCell.Text == "00000000000000")
            {
                alarmTmeCell.Text = "NO DATA";
            }
            else
            {
                string yyyy = alarmTmeCell.Text.Substring(0, 4);
                string MM = alarmTmeCell.Text.Substring(4, 2);
                string dd = alarmTmeCell.Text.Substring(6, 2);
                string HH = alarmTmeCell.Text.Substring(8, 2);
                string mm = alarmTmeCell.Text.Substring(10, 2);
                string ss = alarmTmeCell.Text.Substring(12, 2);
                alarmTmeCell.Text = dd + "/" + MM + "/" + yyyy + " " + HH + ":" + mm + ":" + ss;
            }

            TableCell entryTmeCell = (TableCell)item["EntryTme"];
            if (entryTmeCell.Text == "00000000000000")
            {
                entryTmeCell.Text = "NO DATA";
            }
            else
            {
                string yyyy1 = entryTmeCell.Text.Substring(0, 4);
                string MM1 = entryTmeCell.Text.Substring(4, 2);
                string dd1 = entryTmeCell.Text.Substring(6, 2);
                string HH1 = entryTmeCell.Text.Substring(8, 2);
                string mm1 = entryTmeCell.Text.Substring(10, 2);
                string ss1 = entryTmeCell.Text.Substring(12, 2);
                entryTmeCell.Text = dd1 + "/" + MM1 + "/" + yyyy1 + " " + HH1 + ":" + mm1 + ":" + ss1;
            }
        }
    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
       
        AlarmDataSource1.DataBind();
        grvAlarm.DataBind();
    }
}