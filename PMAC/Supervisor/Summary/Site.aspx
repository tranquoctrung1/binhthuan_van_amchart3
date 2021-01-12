<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="Site.aspx.cs" Inherits="Supervisor_Summary_Site" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
            table-layout:fixed;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<div id="title">
        <div class="div_title_left">Thống kê điểm lắp đặt</div>
        <div class="div_center">
        </div>
    </div>--%>
    <h2>
        <asp:Label ID="lbTitle" runat="server" Text="Thống kê điểm lắp đặt"></asp:Label>
    </h2>
    <div id="main">
        <table class="style1">
            <tr>
                <td align="left" valign="top">
                    <asp:Label ID="lbCustomerId" runat="server" Text="Mã khách hàng"></asp:Label></td>
                <td align="left" valign="top">
                    <asp:Label ID="lbStatus" runat="server" Text="Trạng thái"></asp:Label></td>
                <td align="left" valign="top">
                    <asp:Label ID="lbCondition" runat="server" Text="Tình trạng"></asp:Label></td>
                <td align="left" valign="top">
                    <asp:Label ID="lbModelLogger" runat="server" Text="Model logger"></asp:Label></td>
            </tr>
            <tr>
                <td align="left" valign="top">
                    <asp:CheckBoxList ID="chkListConsumers" runat="server" 
                        DataSourceID="ConsumerDataSource" DataTextField="ConsumerId" 
                        DataValueField="ConsumerId">
                    </asp:CheckBoxList>
                    <asp:ObjectDataSource ID="ConsumerDataSource" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetConsumers" 
                        TypeName="PMAC.BLL.ConsumerBL"></asp:ObjectDataSource>
                </td>
                <td align="left" valign="top">
                    <asp:CheckBoxList ID="chkListStatus" runat="server" 
                        DataSourceID="StatusDataSource" DataTextField="Status" DataValueField="Status">
                    </asp:CheckBoxList>
                    <asp:ObjectDataSource ID="StatusDataSource" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllSiteStatus" 
                        TypeName="PMAC.DAL.SiteStatusBL"></asp:ObjectDataSource>
                </td>
                <td align="left" valign="top">
                    <asp:CheckBoxList ID="chkListAvailabilities" runat="server" 
                        DataSourceID="AvailabilityDataSource" DataTextField="Availability" 
                        DataValueField="Availability">
                    </asp:CheckBoxList>
                    <asp:ObjectDataSource ID="AvailabilityDataSource" runat="server" 
                        OldValuesParameterFormatString="original_{0}" 
                        SelectMethod="GetAllSiteAvailabilities" 
                        TypeName="PMAC.DAL.SiteAvailabilityBL"></asp:ObjectDataSource>
                </td>
                <td align="left" valign="top">
                    <asp:CheckBoxList ID="chkListLoggerModels" runat="server" 
                        DataSourceID="LoggerModelDataSource">
                    </asp:CheckBoxList>
                    <asp:ObjectDataSource ID="LoggerModelDataSource" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllLoggerModels" 
                        TypeName="PMAC.BLL.LoggerBL"></asp:ObjectDataSource>
                </td>
            </tr>
        </table>
        <div align="center">
            <telerik:RadButton ID="btnView" runat="server" Text="Xem" 
                onclick="btnView_Click">
            </telerik:RadButton>
            <telerik:RadButton ID="btnExport" runat="server" Text="Export" 
                onclick="btnExport_Click">
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
        <%--<telerik:GridBoundColumn DataField="SiteID" 
            FilterControlAltText="Filter column1 column" HeaderText="Mã vị trí (tag name)" 
            UniqueName="column1">
        </telerik:GridBoundColumn>--%>
        <telerik:GridBoundColumn DataField="SiteAliasName" 
            FilterControlAltText="Filter column13 column" HeaderText="Mã vị trí (alias name)" 
            UniqueName="column13">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Location" 
            FilterControlAltText="Filter column2 column" HeaderText="Vị trí" 
            UniqueName="column2">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="PipeSize"
            FilterControlAltText="Filter column14 column" HeaderText="Cỡ ống" 
            UniqueName="column14">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="MeterSerial" 
            FilterControlAltText="Filter column3 column" HeaderText="Đồng hồ" 
            UniqueName="column3">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="MeterMarks" 
            FilterControlAltText="Filter column4 column" HeaderText="Hiệu" 
            UniqueName="column4">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="MeterSize" 
            FilterControlAltText="Filter column5 column" HeaderText="Cỡ" 
            UniqueName="column5">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="TransmitterSerial" 
            FilterControlAltText="Filter column6 column" HeaderText="Bộ hiển thị" 
            UniqueName="column6">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="LoggerSerial" 
            FilterControlAltText="Filter column7 column" HeaderText="Logger" 
            UniqueName="column7">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="AccreditationDocument" 
            FilterControlAltText="Filter column8 column" HeaderText="Giấy kiểm định" 
            UniqueName="column8">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="ConsumerID" 
            FilterControlAltText="Filter column9 column" HeaderText="Mã khách hàng" 
            UniqueName="column9">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="SiteStatus" 
            FilterControlAltText="Filter column10 column" HeaderText="Tình trạng" 
            UniqueName="column10">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="SiteAvailability" 
            FilterControlAltText="Filter column11 column" HeaderText="Trạng thái" 
            UniqueName="column11">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Description" 
            FilterControlAltText="Filter column12 column" HeaderText="Ghi chú" 
            UniqueName="column12">
        </telerik:GridBoundColumn>
    </Columns>

<EditFormSettings>
<EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
</EditFormSettings>
</MasterTableView>

<FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>
        </div>
    </div>
</asp:Content>

