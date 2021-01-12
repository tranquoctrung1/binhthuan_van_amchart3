<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucSummaryLogger.ascx.cs" Inherits="Controls_ucSummaryLogger" %>
<style type="text/css">
    .style1
    {
        width: 100%;
        table-layout:fixed;
    }
</style>
<div class="tab_content">

    <table class="style1">
        <tr align="center">
            <td align="left" valign="top">
                <asp:Label ID="lbManufacturer" runat="server" Text="Nhà sản xuất"></asp:Label></td>
            <td align="left" valign="top">
                <asp:Label ID="lbBrandName" runat="server" Text="Hiệu"></asp:Label></td>
            
            <td align="left" valign="top">
                <asp:Label ID="lbModel" runat="server" Text="Mẫu"></asp:Label></td>
            <td align="left" valign="top">
                <asp:Label ID="lbStatus" runat="server" Text="Tình trạng"></asp:Label></td>
            <td align="left" valign="top">
                <asp:Label ID="lbSetup" runat="server" Text="Lắp đặt"></asp:Label></td>
        </tr>
        <tr>
            <td align="left" valign="top">
                <asp:CheckBoxList ID="chkListProviders" runat="server" 
                    DataSourceID="ProviderDataSource">
                </asp:CheckBoxList>
                <asp:ObjectDataSource ID="ProviderDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetAllLoggerProviders" TypeName="PMAC.BLL.LoggerBL">
                </asp:ObjectDataSource>
            </td>
            <td align="left" valign="top">
                <asp:CheckBoxList ID="chkListMarks" runat="server" 
                    DataSourceID="MarksDataSource">
                </asp:CheckBoxList>
                <asp:ObjectDataSource ID="MarksDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllLoggerMarks" 
                    TypeName="PMAC.BLL.LoggerBL"></asp:ObjectDataSource>
            </td>
            <td align="left" valign="top">
                <asp:CheckBoxList ID="chkListModels" runat="server" 
                    DataSourceID="ModelDataSource">
                </asp:CheckBoxList>
                <asp:ObjectDataSource ID="ModelDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllLoggerModels" 
                    TypeName="PMAC.BLL.LoggerBL"></asp:ObjectDataSource>
            </td>
            <td align="left" valign="top">
                <asp:CheckBoxList ID="chkListStatus" runat="server" 
                    DataSourceID="DeviceStatusDataSource" DataTextField="Status" 
                    DataValueField="Status">
                </asp:CheckBoxList>
                <asp:ObjectDataSource ID="DeviceStatusDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllDeviceStatus" 
                    TypeName="PMAC.DAL.DeviceStatusBL"></asp:ObjectDataSource>
            </td>
            <td align="left" valign="top">
                <asp:CheckBoxList ID="chkListInstalled" runat="server">
                    <asp:ListItem Value="True">Yes</asp:ListItem>
                    <asp:ListItem Value="False">No</asp:ListItem>
                </asp:CheckBoxList>
            </td>
        </tr>
    </table>

</div>
<div align="center">
    <telerik:RadButton ID="btnView" runat="server" Text="Xem" 
        onclick="btnView_Click">
    </telerik:RadButton>
    <telerik:RadButton ID="btnExport" runat="server" onclick="btnExport_Click" 
        Text="Export">
    </telerik:RadButton>
</div>
<br />
<div>
    <telerik:RadGrid ID="grv" runat="server" AutoGenerateColumns="False" 
        CellSpacing="0" GridLines="None" onitemdatabound="grv_ItemDataBound">
<MasterTableView>
<CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

<RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>

    <Columns>
        <telerik:GridBoundColumn FilterControlAltText="Filter column column" 
            HeaderText="STT" UniqueName="STT">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Serial" 
            FilterControlAltText="Filter column1 column" HeaderText="Số seri" 
            UniqueName="column1">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Provider" 
            FilterControlAltText="Filter column2 column" HeaderText="Nhà sản xuất" 
            UniqueName="column2">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Marks" 
            FilterControlAltText="Filter column3 column" HeaderText="Hiệu" 
            UniqueName="column3">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Installed" 
            FilterControlAltText="Filter column5 column" HeaderText="Lắp đặt" 
            UniqueName="column5">
        </telerik:GridBoundColumn>
        <%--<telerik:GridBoundColumn DataField="SiteId" 
            FilterControlAltText="Filter column6 column" HeaderText="Mã vị trí (tag name)" 
            UniqueName="column6">
            <ItemStyle HorizontalAlign="Left" />
        </telerik:GridBoundColumn>--%>
        <telerik:GridBoundColumn DataField="SiteAliasName" 
            FilterControlAltText="Filter column13 column" HeaderText="Mã vị trí (alias name)" 
            UniqueName="column13">
            <ItemStyle HorizontalAlign="Left" />
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Location" 
            FilterControlAltText="Filter column7 column" HeaderText="Vị trí" 
            UniqueName="column7">
            <ItemStyle HorizontalAlign="Left" />
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="ReceiptDate" 
            FilterControlAltText="Filter column8 column" HeaderText="Ngày nhập kho" 
            UniqueName="column8" DataFormatString="{0:dd/MM/yyyy}" >
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Model" 
            FilterControlAltText="Filter column10 column" HeaderText="Model" 
            UniqueName="column10">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Status" 
            FilterControlAltText="Filter column11 column" HeaderText="Tình trạng" 
            UniqueName="column11">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Description" 
            FilterControlAltText="Filter column12 column" HeaderText="Ghi chú" 
            UniqueName="column12">
            <ItemStyle HorizontalAlign="Left" />
        </telerik:GridBoundColumn>
    </Columns>

<EditFormSettings>
<EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
</EditFormSettings>
</MasterTableView>

<FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>
</div>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnView">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="grv" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

