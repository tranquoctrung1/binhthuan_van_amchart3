using PMAC.BLL;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Supervisor_Report_Press : System.Web.UI.Page
{
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            RadPivotGrid1.Visible = true;
            RadPivotGrid2.Visible = false;
            

            // Pi-solution
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Report/Press.aspx")).ToList();

            var var1 = list.Where(x => x.ControlId.Contains("lbTitle")).FirstOrDefault();
            lbTitle.Text = (var1 == null) ? "" : var1.Contents;

            var var2 = list.Where(x => x.ControlId.Contains("lbFrom")).FirstOrDefault();
            lbFrom.Text = (var2 == null) ? "" : var2.Contents;
            var var3 = list.Where(x => x.ControlId.Contains("lbTo")).FirstOrDefault();
            lbTo.Text = (var3 == null) ? "" : var3.Contents;

            var var4 = list.Where(x => x.ControlId.Contains("btnRefresh")).FirstOrDefault();
            btnRefresh.Text = (var4 == null) ? "" : var4.Contents;
            var var5 = list.Where(x => x.ControlId.Contains("btnExport")).FirstOrDefault();
            btnExport.Text = (var5 == null) ? "" : var5.Contents;

            var var6 = list.Where(x => x.ControlId.Contains("chkHor")).FirstOrDefault();
            chkHor.Text = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("chkVer")).FirstOrDefault();
            chkVer.Text = (var7 == null) ? "" : var7.Contents;


            // Pi-solution - Set language for RadPivotGrid - Telerik 
            var var8 = list.Where(x => x.ControlId.Contains("RadPivotGrid_SiteId")).FirstOrDefault();
            RadPivotGrid1.Fields[0].Caption = (var8 == null) ? "" : var8.Contents;
            RadPivotGrid2.Fields[0].Caption = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("RadPivotGrid_Type")).FirstOrDefault();
            RadPivotGrid1.Fields[1].Caption = (var9 == null) ? "" : var9.Contents;
            RadPivotGrid2.Fields[1].Caption = (var9 == null) ? "" : var9.Contents;
            var var10 = list.Where(x => x.ControlId.Contains("RadPivotGrid_TimeStamp")).FirstOrDefault();
            RadPivotGrid1.Fields[2].Caption = (var10 == null) ? "" : var10.Contents;
            RadPivotGrid2.Fields[2].Caption = (var10 == null) ? "" : var10.Contents;
            var var11 = list.Where(x => x.ControlId.Contains("RadPivotGrid_Value")).FirstOrDefault();
            RadPivotGrid1.Fields[3].Caption = (var11 == null) ? "" : var11.Contents;
            RadPivotGrid2.Fields[3].Caption = (var11 == null) ? "" : var11.Contents;
        }

    }

    protected void RadPivotGrid1_PreRender(object sender, EventArgs e)
    {
        
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        if (dtStart.SelectedDate == null || dtEnd.SelectedDate == null)
        {
            return;
        }
        string dateformat = "MMMdd";

        if (chkHor.Checked && !chkVer.Checked)
        {
            RadPivotGrid1.ExportSettings.IgnorePaging = true;
            RadPivotGrid1.ExportSettings.FileName = "Press_" + ((DateTime)dtStart.SelectedDate).ToString(dateformat) + "_to_" + ((DateTime)dtEnd.SelectedDate).ToString(dateformat);
            RadPivotGrid1.ExportToExcel();
        }

        if (!chkHor.Checked && chkVer.Checked)
        {
            RadPivotGrid2.ExportSettings.IgnorePaging = true;
            RadPivotGrid2.ExportSettings.FileName = "Press_" + ((DateTime)dtStart.SelectedDate).ToString(dateformat) + "_to_" + ((DateTime)dtEnd.SelectedDate).ToString(dateformat);
            RadPivotGrid2.ExportToExcel();
        }
    }

    protected void RadPivotGrid1_PivotGridCellExporting(object sender, Telerik.Web.UI.PivotGridCellExportingArgs e)
    {
        PivotGridBaseModelCell modelDataCell = e.PivotGridModelCell as PivotGridBaseModelCell;
        if (modelDataCell != null)
        {
            AddStylesToDataCells(modelDataCell, e);
        }

        if (modelDataCell.TableCellType == PivotGridTableCellType.RowHeaderCell)
        {
            AddStylesToRowHeaderCells(modelDataCell, e);
        }

        if (modelDataCell.TableCellType == PivotGridTableCellType.ColumnHeaderCell)
        {
            AddStylesToColumnHeaderCells(modelDataCell, e);
        }

        if (modelDataCell.IsGrandTotalCell)
        {
            e.ExportedCell.Style.BackColor = Color.FromArgb(128, 128, 128);
            e.ExportedCell.Style.Font.Bold = true;
        }

        if (IsTotalDataCell(modelDataCell))
        {
            e.ExportedCell.Style.BackColor = Color.FromArgb(150, 150, 150);
            e.ExportedCell.Style.Font.Bold = true;
            AddBorders(e);
        }

        if (IsGrandTotalDataCell(modelDataCell))
        {
            e.ExportedCell.Style.BackColor = Color.FromArgb(128, 128, 128);
            e.ExportedCell.Style.Font.Bold = true;
            AddBorders(e);
        }
    }

    private void AddStylesToDataCells(PivotGridBaseModelCell modelDataCell, PivotGridCellExportingArgs e)
    {
        if (modelDataCell.Data != null && modelDataCell.Data.GetType() == typeof(decimal))
        {
            decimal value = Convert.ToDecimal(modelDataCell.Data);
            if (value > 100000)
            {
                e.ExportedCell.Style.BackColor = Color.FromArgb(51, 204, 204);
                AddBorders(e);
            }

            e.ExportedCell.Format = "0.00";
        }
    }

    private void AddStylesToColumnHeaderCells(PivotGridBaseModelCell modelDataCell, PivotGridCellExportingArgs e)
    {
        if (e.ExportedCell.Table.Columns[e.ExportedCell.ColIndex].Width == 0)
        {
            e.ExportedCell.Table.Columns[e.ExportedCell.ColIndex].Width = 20D;
        }

        if (modelDataCell.IsTotalCell)
        {
            e.ExportedCell.Style.BackColor = Color.FromArgb(150, 150, 150);
            e.ExportedCell.Style.Font.Bold = true;
        }
        else
        {
            e.ExportedCell.Style.BackColor = Color.FromArgb(192, 192, 192);
        }
        AddBorders(e);
        e.ExportedCell.Value = "'" + e.ExportedCell.Value.ToString().Split(' ')[0];
    }

    private void AddStylesToRowHeaderCells(PivotGridBaseModelCell modelDataCell, PivotGridCellExportingArgs e)
    {
        if (e.ExportedCell.Table.Columns[e.ExportedCell.ColIndex].Width == 0)
        {
            e.ExportedCell.Table.Columns[e.ExportedCell.ColIndex].Width = 11D;
        }
        if (e.ExportedCell.ColIndex == 0)
        {
            e.ExportedCell.Table.Columns[e.ExportedCell.ColIndex].Width = 25D;
        }
        else
        {
            e.ExportedCell.Table.Columns[e.ExportedCell.ColIndex].Width = 15D;
        }
        if (modelDataCell.IsTotalCell)
        {
            e.ExportedCell.Style.BackColor = Color.FromArgb(150, 150, 150);
            e.ExportedCell.Style.Font.Bold = true;
        }
        else
        {
            e.ExportedCell.Style.BackColor = Color.FromArgb(192, 192, 192);
        }

        AddBorders(e);
    }

    private static void AddBorders(PivotGridCellExportingArgs e)
    {
        e.ExportedCell.Style.BorderBottomColor = Color.FromArgb(128, 128, 128);
        e.ExportedCell.Style.BorderBottomWidth = new Unit(1);
        e.ExportedCell.Style.BorderBottomStyle = BorderStyle.Solid;

        e.ExportedCell.Style.BorderRightColor = Color.FromArgb(128, 128, 128);
        e.ExportedCell.Style.BorderRightWidth = new Unit(1);
        e.ExportedCell.Style.BorderRightStyle = BorderStyle.Solid;

        e.ExportedCell.Style.BorderLeftColor = Color.FromArgb(128, 128, 128);
        e.ExportedCell.Style.BorderLeftWidth = new Unit(1);
        e.ExportedCell.Style.BorderLeftStyle = BorderStyle.Solid;

        e.ExportedCell.Style.BorderTopColor = Color.FromArgb(128, 128, 128);
        e.ExportedCell.Style.BorderTopWidth = new Unit(1);
        e.ExportedCell.Style.BorderTopStyle = BorderStyle.Solid;
    }

    private bool IsTotalDataCell(PivotGridBaseModelCell modelDataCell)
    {
        return modelDataCell.TableCellType == PivotGridTableCellType.DataCell &&
           (modelDataCell.CellType == PivotGridDataCellType.ColumnTotalDataCell ||
             modelDataCell.CellType == PivotGridDataCellType.RowTotalDataCell ||
             modelDataCell.CellType == PivotGridDataCellType.RowAndColumnTotal);
    }

    private bool IsGrandTotalDataCell(PivotGridBaseModelCell modelDataCell)
    {
        return modelDataCell.TableCellType == PivotGridTableCellType.DataCell &&
            (modelDataCell.CellType == PivotGridDataCellType.ColumnGrandTotalDataCell ||
                modelDataCell.CellType == PivotGridDataCellType.ColumnGrandTotalRowTotal ||
                modelDataCell.CellType == PivotGridDataCellType.RowGrandTotalColumnTotal ||
                modelDataCell.CellType == PivotGridDataCellType.RowGrandTotalDataCell ||
                modelDataCell.CellType == PivotGridDataCellType.RowAndColumnGrandTotal);
    }

    protected void chkHor_CheckedChanged(object sender, EventArgs e)
    {
        RadPivotGrid2.Visible = false;
        RadPivotGrid1.Visible = true;
        RadPivotGrid1.Rebind();
    }

    protected void chkVer_CheckedChanged(object sender, EventArgs e)
    {
        RadPivotGrid1.Visible = false;
        RadPivotGrid2.Visible = true;
        RadPivotGrid2.Rebind();
    }
}