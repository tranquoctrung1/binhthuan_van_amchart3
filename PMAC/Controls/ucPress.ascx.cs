﻿using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Controls_ucPress : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnExport_Click(object sender, EventArgs e)
    {
        if (dtStart.SelectedDate==null||dtEnd.SelectedDate==null)
        {
            return;
        }
        string dateformat = "MMMdd";
        RadPivotGrid1.ExportSettings.IgnorePaging = true;
        RadPivotGrid1.ExportSettings.FileName = "Press_" + ((DateTime)dtStart.SelectedDate).ToString(dateformat) + "_to_" + ((DateTime)dtEnd.SelectedDate).ToString(dateformat);
        RadPivotGrid1.ExportToExcel();
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
}