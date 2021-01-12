<%@ control language="C#" autoeventwireup="true" inherits="_controls_summary_transmitter, App_Web_b52rb5rr" %>
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
            <telerik:RadListBox ID="lstTProviders" runat="server" DataKeyField="Provider" DataSortField="Provider" DataSourceID="TProvidesDS" DataTextField="Provider" DataValueField="Provider" Height="120px" SelectionMode="Multiple">
            </telerik:RadListBox>
            <asp:SqlDataSource ID="TProvidesDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Provider] FROM [t_Transmitters] ORDER BY [Provider]"></asp:SqlDataSource>
        </td>
        <td>
            <telerik:RadListBox ID="lstTMarks" runat="server" DataKeyField="Marks" DataSortField="Marks" DataSourceID="TMarksDS" DataTextField="Marks" DataValueField="Marks" Height="120px" SelectionMode="Multiple">
            </telerik:RadListBox>
            <asp:SqlDataSource ID="TMarksDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Marks] FROM [t_Transmitters] ORDER BY [Marks]"></asp:SqlDataSource>
        </td>
        <td>
            <telerik:RadListBox ID="lstTSizes" runat="server" DataKeyField="Size" DataSortField="Size" DataSourceID="TSizesDS" DataTextField="Size" DataValueField="Size" Height="120px" SelectionMode="Multiple">
            </telerik:RadListBox>
            <asp:SqlDataSource ID="TSizesDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Size] FROM [t_Transmitters] ORDER BY [Size]"></asp:SqlDataSource>
        </td>
        <td>
            <telerik:RadListBox ID="lstTModels" runat="server" DataKeyField="Model" DataSortField="Model" DataSourceID="TModelsDS" DataTextField="Model" DataValueField="Model" Height="120px" SelectionMode="Multiple">
            </telerik:RadListBox>
            <asp:SqlDataSource ID="TModelsDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Model] FROM [t_Transmitters] ORDER BY [Model]"></asp:SqlDataSource>
        </td>
        <td>
            <telerik:RadListBox ID="lstTStatus" runat="server" DataKeyField="Status" DataSortField="Status" DataSourceID="TStatusDS" DataTextField="Status" DataValueField="Description" Height="120px" style="top: 0px; left: 0px" SelectionMode="Multiple">
                
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
            <asp:SqlDataSource ID="TStatusDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT * FROM [t_Device_Status] ORDER BY [Status]"></asp:SqlDataSource>
        </td>
        <td>
            <asp:RadioButtonList ID="lstTInstalled" runat="server">
                <asp:ListItem>True</asp:ListItem>
                <asp:ListItem>False</asp:ListItem>
                <asp:ListItem>Other</asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
</table>

<br />

<telerik:RadGrid ID="grvT" runat="server" AllowPaging="True" AllowSorting="True" CellSpacing="0" GridLines="None" PageSize="20">
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



