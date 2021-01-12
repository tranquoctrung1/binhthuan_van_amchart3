<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucPress.ascx.cs" Inherits="Controls_ucPress" %>
<style type="text/css">
    .auto-style1 {
        width: 100%;
    }
</style>
<h2>Báo cáo áp lực</h2>
<div class="row">
    <div class="col-sm-4">
                    <div class="row">
                <div class="col-sm-4">Ngày bắt đầu:</div>
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
        <div class="row Padding">
            <div class="col-sm-4">Ngày kết thúc:</div>
            <div class="col-sm-6">   <telerik:RadDatePicker ID="dtEnd" runat="server" Culture="en-GB">
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
            </telerik:RadDatePicker></div>


        </div>
    </div>
     <div class="col-sm-4 Padding">
         <asp:Button ID="btnRefresh" runat="server" Text="Refresh" CssClass="rfdDecorated"/>&nbsp;
          <asp:Button ID="btnExport" runat="server" OnClick="btnExport_Click" Text="Export" CssClass="rfdDecorated" />
     </div>
     <div class="col-sm-4">

     </div>
  
</div>
<div>
<telerik:RadPivotGrid ID="RadPivotGrid1" runat="server" DataSourceID="SqlDataSource1" FilterHeaderZoneText="" OnPivotGridCellExporting="RadPivotGrid1_PivotGridCellExporting" EnableZoneContextMenu="True" AllowPaging="True" PageSize="20">
    <PagerStyle ChangePageSizeButtonToolTip="Change Page Size" PageSizeControlType="RadComboBox" AlwaysVisible="True"></PagerStyle>

    <OlapSettings>
    </OlapSettings>

    <Fields>
        <telerik:PivotGridRowField DataField="Location" UniqueName="column" Caption="Vị trí">
        </telerik:PivotGridRowField>
        <telerik:PivotGridRowField DataField="Type" UniqueName="column1" Caption="Áp lực">
        </telerik:PivotGridRowField>
        <telerik:PivotGridColumnField DataField="TimeStamp" UniqueName="column2" Caption="Ngày" DataFormatString="{0:dd/MM/yyyy}">
        </telerik:PivotGridColumnField>
        <telerik:PivotGridAggregateField DataField="Value" GrandTotalAggregateFormatString="" UniqueName="column3" CellStyle-BackColor="#ccffff">
            <TotalFormat Axis="Rows" Level="0" SortOrder="Ascending" TotalFunction="NoCalculation" />

            <CellStyle BackColor="#CCFFFF"></CellStyle>
        </telerik:PivotGridAggregateField>
    </Fields>

    <TotalsSettings ColumnGrandTotalsPosition="None" ColumnsSubTotalsPosition="None" GrandTotalsVisibility="None" RowGrandTotalsPosition="None" RowsSubTotalsPosition="None" />

    <ConfigurationPanelSettings EnableOlapTreeViewLoadOnDemand="True"></ConfigurationPanelSettings>
</telerik:RadPivotGrid>
</div>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="p_Press_Getw" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="dtStart" Name="Start" PropertyName="SelectedDate" Type="DateTime" />
        <asp:ControlParameter ControlID="dtEnd" Name="End" PropertyName="SelectedDate" Type="DateTime" />
    </SelectParameters>
</asp:SqlDataSource>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnRefresh">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadPivotGrid1" UpdatePanelCssClass="" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="RadPivotGrid1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RadPivotGrid1" UpdatePanelCssClass="" LoadingPanelID="RadAjaxLoadingPanel1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Metro"></telerik:RadAjaxLoadingPanel>
