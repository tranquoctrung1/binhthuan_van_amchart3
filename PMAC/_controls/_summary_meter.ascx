<%@ Control Language="C#" AutoEventWireup="true" CodeFile="_summary_meter.ascx.cs" Inherits="_controls_summary_meter" %>
<style type="text/css">
    .auto-style1 {
        width: 100%;
    }
</style>

<table class="auto-style1">
    <tr>
        <td>Nhà sản xuất</td>
        <td>Hiệu</td>
        <td>Cỡ</td>
        <td>Model</td>
        <td>Tình trạng</td>
        <td>Đã lắp đặt</td>
    </tr>
    <tr>
        <td>
            <telerik:RadListBox ID="lstMProviders" runat="server" DataKeyField="Provider" DataSortField="Provider" DataSourceID="MProvidesDS" DataTextField="Provider" DataValueField="Provider" Height="120px" SelectionMode="Multiple">
            </telerik:RadListBox>
            <asp:SqlDataSource ID="MProvidesDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Provider] FROM [t_Meters] ORDER BY [Provider]"></asp:SqlDataSource>
        </td>
        <td>
            <telerik:RadListBox ID="lstMMarks" runat="server" DataKeyField="Marks" DataSortField="Marks" DataSourceID="MMarksDS" DataTextField="Marks" DataValueField="Marks" Height="120px" SelectionMode="Multiple">
            </telerik:RadListBox>
            <asp:SqlDataSource ID="MMarksDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Marks] FROM [t_Meters] ORDER BY [Marks]"></asp:SqlDataSource>
        </td>
        <td>
            <telerik:RadListBox ID="lstMSizes" runat="server" DataKeyField="Size" DataSortField="Size" DataSourceID="MSizesDS" DataTextField="Size" DataValueField="Size" Height="120px" SelectionMode="Multiple">
            </telerik:RadListBox>
            <asp:SqlDataSource ID="MSizesDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Size] FROM [t_Meters] ORDER BY [Size]"></asp:SqlDataSource>
        </td>
        <td>
            <telerik:RadListBox ID="lstMModels" runat="server" DataKeyField="Model" DataSortField="Model" DataSourceID="MModelsDS" DataTextField="Model" DataValueField="Model" Height="120px" SelectionMode="Multiple">
            </telerik:RadListBox>
            <asp:SqlDataSource ID="MModelsDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Model] FROM [t_Meters] ORDER BY [Model]"></asp:SqlDataSource>
        </td>
        <td>
            <telerik:RadListBox ID="RadListBox4" runat="server" DataKeyField="Status" DataSortField="Status" DataSourceID="StatusDS" DataTextField="Status" DataValueField="Description" Height="120px" style="top: 0px; left: 0px" SelectionMode="Multiple">
                
<ButtonSettings TransferButtons="All"></ButtonSettings>
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" class="auto-style1">
                        <tr>
                            <td style="width: 50px"><%# DataBinder.Eval(Container.DataItem,"Status") %></td>
                            <td style="width: 80px"><%# DataBinder.Eval(Container.DataItem,"Description") %></td>
                        </tr>
                    </table>
                </ItemTemplate>
                
            </telerik:RadListBox>
            <asp:SqlDataSource ID="StatusDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT * FROM [t_Device_Status] ORDER BY [Status]"></asp:SqlDataSource>
        </td>
        <td>
            <asp:RadioButtonList ID="lstInstalled" runat="server">
                <asp:ListItem>True</asp:ListItem>
                <asp:ListItem>False</asp:ListItem>
                <asp:ListItem>Other</asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
</table>

<br />

<telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" CellSpacing="0" GridLines="None" PageSize="20">
    <ExportSettings ExportOnlyData="True" FileName="Export_Summary_Dong_Ho" HideStructureColumns="True" IgnorePaging="True" OpenInNewWindow="True">
        <Excel AutoFitImages="True" Format="Biff" />
        <Csv ColumnDelimiter="VerticalBar" />
    </ExportSettings>
    <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True">
    </ClientSettings>
<MasterTableView CommandItemDisplay="Top">
<CommandItemSettings ExportToPdfText="Export to PDF" ShowAddNewRecordButton="False" ShowExportToCsvButton="True" ShowExportToExcelButton="True"></CommandItemSettings>

<RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column" Created="True">
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>

<EditFormSettings>
<EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
</EditFormSettings>

<PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>
</MasterTableView>

    <HeaderStyle Font-Strikeout="False" Font-Underline="True" />

<PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>

<FilterMenu EnableImageSprites="False"></FilterMenu>
</telerik:RadGrid>


