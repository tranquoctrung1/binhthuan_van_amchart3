<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="Press.aspx.cs" Inherits="Supervisor_Report_Press" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>
        <asp:Label ID="lbTitle" runat="server" Text="Báo cáo áp lực"></asp:Label></h2>
    <div class="row">

        <div class="col-sm-4">
            <div class="row">
                <div class="col-sm-4">
                    <asp:Label ID="lbFrom" runat="server" Text="Ngày bắt đầu"></asp:Label>:
                </div>
                <div class="col-sm-6">
                    <telerik:RadDatePicker ID="dtStart" runat="server" Culture="en-GB">
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True"></Calendar>

                        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                            <EmptyMessageStyle Resize="None"></EmptyMessageStyle>

                            <ReadOnlyStyle Resize="None"></ReadOnlyStyle>

                            <FocusedStyle Resize="None"></FocusedStyle>

                            <DisabledStyle Resize="None"></DisabledStyle>

                            <InvalidStyle Resize="None"></InvalidStyle>

                            <HoveredStyle Resize="None"></HoveredStyle>

                            <EnabledStyle Resize="None"></EnabledStyle>
                        </DateInput>

                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    </telerik:RadDatePicker>
                </div>
            </div>
        

        <div class="row">
            <div class="col-sm-4">
                <asp:Label ID="lbTo" runat="server" Text="Ngày kết thúc"></asp:Label>:
            </div>
            <div class="col-sm-6">
                <telerik:RadDatePicker ID="dtEnd" runat="server" Culture="en-GB">
                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True"></Calendar>

                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                        <EmptyMessageStyle Resize="None"></EmptyMessageStyle>

                        <ReadOnlyStyle Resize="None"></ReadOnlyStyle>

                        <FocusedStyle Resize="None"></FocusedStyle>

                        <DisabledStyle Resize="None"></DisabledStyle>

                        <InvalidStyle Resize="None"></InvalidStyle>

                        <HoveredStyle Resize="None"></HoveredStyle>

                        <EnabledStyle Resize="None"></EnabledStyle>
                    </DateInput>

                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                </telerik:RadDatePicker>
            </div>
        </div>
        </div>
        <div class="col-sm-4">
            <div class="row">
                <asp:RadioButton runat="server" ID="chkHor" Text="Hiển thị ngang" GroupName="grp1" AutoPostBack="true" OnCheckedChanged="chkHor_CheckedChanged" />
            </div>
            <div class="row">
                <asp:RadioButton runat="server" ID="chkVer" GroupName="grp1" Text="Hiển thị dọc" AutoPostBack="true" OnCheckedChanged="chkVer_CheckedChanged" />
            </div>

        </div>
        <div class="col-sm-4">
            <asp:Button ID="btnRefresh" runat="server" Text="Refresh" />&nbsp;
            <asp:Button ID="btnExport" runat="server" OnClick="btnExport_Click" Text="Export" />
        </div>


    </div>
    <div class="rowGrid">

        <telerik:RadAjaxPanel ID="radAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        

    <telerik:RadPivotGrid ID="RadPivotGrid1" runat="server" DataSourceID="SqlDataSource1" 
        EnableConfigurationPanel="true" ColumnHeaderZoneText="ColumnHeaderZone" OnPreRender="RadPivotGrid1_PreRender"
        FilterHeaderZoneText="" OnPivotGridCellExporting="RadPivotGrid1_PivotGridCellExporting" EnableZoneContextMenu="True" AllowPaging="True" PageSize="20">
        <PagerStyle ChangePageSizeButtonToolTip="Change Page Size" PageSizeControlType="RadComboBox" AlwaysVisible="True"></PagerStyle>

        <OlapSettings>
        </OlapSettings>

        <Fields>
            <telerik:PivotGridRowField DataField="SiteId" UniqueName="column" Caption="Điểm" CellStyle-Width="200">
            </telerik:PivotGridRowField>
            <telerik:PivotGridRowField DataField="Type" UniqueName="column1" Caption="Áp lực" CellStyle-Width="100">
            </telerik:PivotGridRowField>
            <telerik:PivotGridColumnField DataField="TimeStamp" UniqueName="column2" Caption="Ngày" DataFormatString="{0:dd/MM/yyyy}">
            </telerik:PivotGridColumnField>
            <telerik:PivotGridAggregateField DataField="Value" UniqueName="column3" CellStyle-BackColor="#ccffff">
                <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" />

                <CellStyle BackColor="#CCFFFF"></CellStyle>
            </telerik:PivotGridAggregateField>
        </Fields>

        <TotalsSettings ColumnGrandTotalsPosition="None" ColumnsSubTotalsPosition="None" GrandTotalsVisibility="None" RowGrandTotalsPosition="None" RowsSubTotalsPosition="None" />

        <ConfigurationPanelSettings EnableOlapTreeViewLoadOnDemand="True"></ConfigurationPanelSettings>
    </telerik:RadPivotGrid>

            </telerik:RadAjaxPanel>

    <telerik:RadPivotGrid ID="RadPivotGrid2" runat="server" DataSourceID="SqlDataSource1" FilterHeaderZoneText="" OnPreRender="RadPivotGrid1_PreRender"
        OnPivotGridCellExporting="RadPivotGrid1_PivotGridCellExporting" EnableZoneContextMenu="True" AllowPaging="True" PageSize="20">
        <PagerStyle ChangePageSizeButtonToolTip="Change Page Size" PageSizeControlType="RadComboBox" AlwaysVisible="True"></PagerStyle>

        <OlapSettings>
        </OlapSettings>

        <Fields>
            <telerik:PivotGridColumnField DataField="SiteId" UniqueName="column" Caption="Điểm" CellStyle-Width="200">
            </telerik:PivotGridColumnField>
            <telerik:PivotGridColumnField DataField="Type" UniqueName="column1" Caption="Áp lực" CellStyle-Width="100">
            </telerik:PivotGridColumnField>
            <telerik:PivotGridRowField DataField="TimeStamp" UniqueName="column2" Caption="Ngày" DataFormatString="{0:dd/MM/yyyy}">
            </telerik:PivotGridRowField>
            <telerik:PivotGridAggregateField DataField="Value" UniqueName="column3" CellStyle-BackColor="#ccffff">
                <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" />

                <CellStyle BackColor="#CCFFFF"></CellStyle>
            </telerik:PivotGridAggregateField>
        </Fields>

        <TotalsSettings ColumnGrandTotalsPosition="None" ColumnsSubTotalsPosition="None" GrandTotalsVisibility="None" RowGrandTotalsPosition="None" RowsSubTotalsPosition="None" />

        <ConfigurationPanelSettings EnableOlapTreeViewLoadOnDemand="True"></ConfigurationPanelSettings>
    </telerik:RadPivotGrid>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="p_Press_Get_2015" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="dtStart" Name="Start" PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="dtEnd" Name="End" PropertyName="SelectedDate" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="chkHor">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadPivotGrid1" UpdatePanelCssClass="" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadPivotGrid2" UpdatePanelCssClass="" LoadingPanelID="RadAjaxLoadingPanel2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnRefresh">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadPivotGrid1" UpdatePanelCssClass="" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadPivotGrid2" LoadingPanelID="RadAjaxLoadingPanel2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="chkVer">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadPivotGrid1" UpdatePanelCssClass="" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadPivotGrid2" UpdatePanelCssClass="" LoadingPanelID="RadAjaxLoadingPanel2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadPivotGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadPivotGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadPivotGrid2">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadPivotGrid2" LoadingPanelID="RadAjaxLoadingPanel2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Metro"></telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" Skin="Metro"></telerik:RadAjaxLoadingPanel>
</asp:Content>


