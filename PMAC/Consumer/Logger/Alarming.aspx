<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Alarming.aspx.cs" Inherits="Supervisor_Logger_Alarming" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <div>
    
                <telerik:RadGrid ID="grvAlarm" runat="server" AllowPaging="True" CellSpacing="0" DataSourceID="AlarmDataSource1" GridLines="None" PageSize="2" Width="99%" OnItemDataBound="grvAlarm_ItemDataBound">
<MasterTableView AutoGenerateColumns="False" DataSourceID="AlarmDataSource1" >
<CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

<RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column" Created="True">
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>

    <Columns>
        <telerik:GridBoundColumn DataField="AlarmTme" FilterControlAltText="Filter AlarmTme column" HeaderText="AlarmTme" SortExpression="AlarmTme" UniqueName="AlarmTme">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="EntryTme" FilterControlAltText="Filter EntryTme column" HeaderText="EntryTme" SortExpression="EntryTme" UniqueName="EntryTme">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" SortExpression="Id" UniqueName="Id">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="SiteName" FilterControlAltText="Filter SiteName column" HeaderText="SiteName" SortExpression="SiteName" UniqueName="SiteName">
        </telerik:GridBoundColumn>
        <%--<telerik:GridBoundColumn DataField="PrfGroup" DataType="System.Int32" FilterControlAltText="Filter PrfGroup column" HeaderText="PrfGroup" SortExpression="PrfGroup" UniqueName="PrfGroup">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="PrfName" FilterControlAltText="Filter PrfName column" HeaderText="PrfName" SortExpression="PrfName" UniqueName="PrfName">
        </telerik:GridBoundColumn>--%>
        <telerik:GridBoundColumn DataField="Descript" FilterControlAltText="Filter Descript column" HeaderText="Descript" SortExpression="Descript" UniqueName="Descript">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Priority" FilterControlAltText="Filter Priority column" HeaderText="Priority" SortExpression="Priority" UniqueName="Priority">
        </telerik:GridBoundColumn>
        <%--<telerik:GridBoundColumn DataField="AAPName" FilterControlAltText="Filter AAPName column" HeaderText="AAPName" SortExpression="AAPName" UniqueName="AAPName">
        </telerik:GridBoundColumn>--%>
    </Columns>

<EditFormSettings>
<EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
</EditFormSettings>

<PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>
</MasterTableView>

<PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>

<FilterMenu EnableImageSprites="False"></FilterMenu>
</telerik:RadGrid>
<asp:AccessDataSource ID="AlarmDataSource1" runat="server" DataFile="C:\PMAC\PMACSITE.MDB" SelectCommand="SELECT * FROM [ALARMLOG] ORDER BY [AlarmTme] DESC"></asp:AccessDataSource>
        <asp:Panel ID="Panel1" runat="server">
            <asp:Timer ID="Timer1" runat="server" Interval="60000" OnTick="Timer1_Tick"></asp:Timer>
        </asp:Panel>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="grvAlarm">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="grvAlarm" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="Timer1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="grvAlarm" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
                </telerik:RadAjaxManager>
    </div>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" Runat="server" HorizontalAlign="Center" Skin="Metro">
        </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
