<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="Config.aspx.cs" Inherits="Supervisor_Site_Config" %>

<%@ Register src="../../Controls/ucConsumer.ascx" tagname="ucConsumer" tagprefix="uc1" %>
<%@ Register Src="~/Controls/ucConsumer.ascx" TagPrefix="uc2" TagName="ucConsumer" %>
<%@ Register Src="~/Controls/ucDisplayGroup.ascx" TagPrefix="uc1" TagName="ucDisplayGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function btnAddConsumer_Click() {
                var win = $find('<%= winAddConsumer.ClientID %>');
                win.show();
            }

            function btnAddChannel_Click() {
                var loggerID = $find('<%= txtLoggerID.ClientID %>').get_value();
                if (loggerID == "" || loggerID == null) {
                    $.ajax({
                    type: "POST",
                    url: "/Pi-Solution/Pi1.asmx/LoggerId_check",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        alert(response.d);
                    },
                    failure: function (response) {
                        alert("AJAX request failed");
                    }
                });
                    return;
                }
                var win = $find('<%= winAddChannel.ClientID %>');
                var loggerID = $find('<%= txtLoggerID.ClientID %>').get_value();
                var siteID = $find('<%= cboSites.ClientID %>').get_text();
                var startHour = $find('<%= cboStartHours.ClientID %>').get_text();
                var telNumer = $find('<%= txtLoggerPhoneNumber.ClientID %>').get_value();
                win.setUrl("../Admin/Channel.aspx?siteID=" + siteID + "&loggerID=" + loggerID + "&startHour=" + startHour + "&telNumber=" + telNumer);
                win.show();
            }

            function btnAddDisplayGroup_Click() {
                var win = $find('<%= winAddDisplayGroup.ClientID %>');
                win.show();
            }

            function winAddConsumer_Close() {
                var m = $find("<%=RadAjaxManager.GetCurrent(Page).ClientID %>");
                m.ajaxRequest("winAddConsumer_Close");
            }

            function winAddDisplayGroup_Close() {
                var m = $find("<%=RadAjaxManager.GetCurrent(Page).ClientID %>");
                m.ajaxRequest("winAddDisplayGroup_Close");
            }

            function btnDelete_Click() {
                var win = $find('<%= winConfirmDelete.ClientID %>');
                win.show();
            }

            function btnCancel_Click() {
                var win = $find('<%= winConfirmDelete.ClientID %>');
                win.close();
            }
        </script>
    </telerik:RadCodeBlock>

    <h2>
        
        <asp:Label ID="lbTitle" runat="server" Text="Cấu hình vị trí lắp đặt"></asp:Label>
    </h2>
    <div id="main">
        <div>
            <ul class="multiple_columns">
                <li class="text_grid_4_columns"><asp:Label ID="lbTagName" runat="server" Text="Mã vị trí"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboSites" runat="server" AllowCustomText="True" 
                        AutoPostBack="True" DataSourceID="SitesDataSource" DataTextField="SiteId" 
                        DataValueField="SiteId" EnableLoadOnDemand="True" Filter="StartsWith" 
                        HighlightTemplatedItems="True" DropDownWidth="685px" 
                        onselectedindexchanged="cboSites_SelectedIndexChanged">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0" style="width:660px">
                                <tr>
                                    <td style="width:160px">
                                        <asp:Label ID="locationId_header" runat="server" Text="Label"></asp:Label>
                                    </td>
                                    <td style="width:160px">
                                        <asp:Label ID="aliasname_header" runat="server" Text="Label"></asp:Label>
                                    </td>
                                    <td style="width:340px">
                                        <asp:Label ID="location_header" runat="server" Text="Label"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table cellpadding="0" cellspacing="0" style="width:660px">
                                <tr>
                                    <td style="width:160px"><%#DataBinder.Eval(Container.DataItem,"SiteId") %></td>
                                    <td style="width:160px"><%#DataBinder.Eval(Container.DataItem,"SiteAliasName") %></td>
                                    <td style="width:340px"><%#DataBinder.Eval(Container.DataItem,"Location") %></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    <asp:ObjectDataSource ID="SitesDataSource" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetSites" 
                        TypeName="PMAC.BLL.SiteBL"></asp:ObjectDataSource>
                </li>
                <li class="text_grid_4_columns">
                    <asp:LinkButton ID="btnAddConsumer" runat="server" 
                        onclientclick="btnAddConsumer_Click();return false;"><asp:Label ID="lbCustomerId" runat="server" Text="Mã khách hàng"></asp:Label>:</asp:LinkButton>
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboConsumers" runat="server" 
                        DataSourceID="ConsumersDataSource" DataTextField="ConsumerId" 
                        DataValueField="ConsumerId" DropDownWidth="300px" 
                        HighlightTemplatedItems="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width:160px">
                                        <asp:Label ID="customerId_header" runat="server" Text="Mã KH"></asp:Label>
                                    </td>
                                    <td style="width:160px">
                                        <asp:Label ID="customerName_header" runat="server" Text="Khách hàng"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width:100px"><%#DataBinder.Eval(Container.DataItem,"ConsumerId") %>
                                    </td>
                                    <td style="width:200px"><%#DataBinder.Eval(Container.DataItem,"Description") %>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    <asp:ObjectDataSource ID="ConsumersDataSource" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetConsumers" 
                        TypeName="PMAC.BLL.ConsumerBL"></asp:ObjectDataSource>
                    
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbAliasName" runat="server" Text="Alias name"></asp:Label>:</li>
                <li class="control_grid_4_columns">
                    <telerik:RadTextBox ID="txtAliasName" runat="server"></telerik:RadTextBox>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbTubingSize" runat="server" Text="Cỡ ống"></asp:Label>:</li>
                <li class="control_grid_4_columns">
                     <telerik:RadTextBox  ID="txtPipeSize" runat="server"></telerik:RadTextBox>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbLocation" runat="server" Text="Vị trí"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadTextBox ID="txtLocation" runat="server">
                    </telerik:RadTextBox>
                </li>
                <li class="text_grid_4_columns">
                    <asp:LinkButton ID="btnAddChannel" runat="server" 
                        onclientclick="btnAddChannel_Click();return false;"><asp:Label ID="lbLoggerId" runat="server" Text="Logger Id"></asp:Label>:</asp:LinkButton>
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadTextBox ID="txtLoggerID" runat="server">
                    </telerik:RadTextBox>
                    
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbLatitude" runat="server" Text="Vĩ độ"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadNumericTextBox ID="nmrLatitude" runat="server">
<NumberFormat ZeroPattern="n" decimaldigits="7"></NumberFormat>
                    </telerik:RadNumericTextBox>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbLastDate" runat="server" Text="Ngày chốt dữ liệu"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboStartDays" runat="server">
                    </telerik:RadComboBox>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbLongitude" runat="server" Text="Kinh độ"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadNumericTextBox ID="nmrLongitude" runat="server">
<NumberFormat ZeroPattern="n" decimaldigits="7"></NumberFormat>
                    </telerik:RadNumericTextBox>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbTimeVerified" runat="server" Text="Giờ chốt dữ liệu"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboStartHours" runat="server">
                    </telerik:RadComboBox>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbDelayTime" runat="server" Text="Thời gian báo trễ (phút)"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadNumericTextBox ID="nmrSetDelayTime" runat="server" DataType="System.Int16" MaxValue="44640" MinValue="0">
<NegativeStyle Resize="None"></NegativeStyle>

<NumberFormat ZeroPattern="n" DecimalDigits="0"></NumberFormat>

<EmptyMessageStyle Resize="None"></EmptyMessageStyle>

<ReadOnlyStyle Resize="None"></ReadOnlyStyle>

<FocusedStyle Resize="None"></FocusedStyle>

<DisabledStyle Resize="None"></DisabledStyle>

<InvalidStyle Resize="None"></InvalidStyle>

<HoveredStyle Resize="None"></HoveredStyle>

<EnabledStyle Resize="None"></EnabledStyle>
                    </telerik:RadNumericTextBox>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbDiffValue" runat="server" Text="Giá trị chênh lệch"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadNumericTextBox ID="nmrSetDiffValue" runat="server" MaxValue="100" MinValue="0" Type="Percent">
<NegativeStyle Resize="None"></NegativeStyle>

<NumberFormat ZeroPattern="n %"></NumberFormat>

<EmptyMessageStyle Resize="None"></EmptyMessageStyle>

<ReadOnlyStyle Resize="None"></ReadOnlyStyle>

<FocusedStyle Resize="None"></FocusedStyle>

<DisabledStyle Resize="None"></DisabledStyle>

<InvalidStyle Resize="None"></InvalidStyle>

<HoveredStyle Resize="None"></HoveredStyle>

<EnabledStyle Resize="None"></EnabledStyle>
                    </telerik:RadNumericTextBox>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbZoom" runat="server" Text="Phóng to"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboZoomLevels" runat="server">
                    </telerik:RadComboBox>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbLoggerMobileNumber" runat="server" Text="Số điện thoại logger"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadTextBox ID="txtLoggerPhoneNumber" runat="server">
                    </telerik:RadTextBox>
                </li>
                <li class="text_grid_4_columns">
                    <asp:LinkButton ID="btnAddDisplayGroup" runat="server" 
                        onclientclick="btnAddDisplayGroup_Click();return false;"><asp:Label ID="lbGroupDisplay" runat="server" Text="Nhóm hiển thị"></asp:Label>:</asp:LinkButton>
                    
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboDisplayGroups" runat="server" 
                        DataSourceID="DisplayGroupsDataSource" DataTextField="Group" 
                        DataValueField="Group" DropDownWidth="300px" 
                        HighlightTemplatedItems="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width:100px">
                                        <asp:Label ID="group_header" runat="server" Text="Nhóm hiển thị"></asp:Label>
                                    </td>
                                    <td style="width:200px">
                                        <asp:Label ID="description_header" runat="server" Text="Mô tả"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width:100px"><%#DataBinder.Eval(Container.DataItem, "Group")%>
                                    </td>
                                    <td style="width:200px"><%#DataBinder.Eval(Container.DataItem,"Description") %>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    <asp:ObjectDataSource ID="DisplayGroupsDataSource" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetDisplayGroups" 
                        TypeName="PMAC.BLL.DisplayGroupBL"></asp:ObjectDataSource>
                    
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbNote" runat="server" Text="Note"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadTextBox ID="txtDescription" runat="server">
                    </telerik:RadTextBox>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbGaugeSeri" runat="server" Text="Seri đồng hồ"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboMeterSerials" runat="server" EnableLoadOnDemand="true"
                        DataSourceID="MeterDataSource" DataTextField="Serial" DropDownWidth="395px"
                        DataValueField="Serial" AllowCustomText="True" Filter="StartsWith" 
                        HighlightTemplatedItems="True" MarkFirstMatch="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0" style="width:370px">
                                 <tr>
                                    <td style="width: 160px">
                                        <asp:Label ID="seri_header" runat="server" Text="Số seri"></asp:Label>
                                    </td>
                                    <td style="width: 60px">
                                        <asp:Label ID="manufacturer_header" runat="server" Text="Nhà SX"></asp:Label>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:Label ID="brandname_header" runat="server" Text="Hiệu"></asp:Label>
                                    </td>
                                    <td style="width: 50px">
                                        <asp:Label ID="size_header" runat="server" Text="Cỡ"></asp:Label>
                                    </td>
                                </tr>
                            </table>

                        </HeaderTemplate>
                        <ItemTemplate>
                            <table  cellpadding="0" cellspacing="0" style="width:370px">
                                <tr>
                                    <td style="width: 160px"><%#DataBinder.Eval(Container.DataItem,"Serial") %></td>
                                    <td style="width: 60px"><%#DataBinder.Eval(Container.DataItem,"Provider") %></td>
                                    <td style="width: 100px"><%#DataBinder.Eval(Container.DataItem,"Marks") %></td>
                                    <td style="width: 50px"><%#DataBinder.Eval(Container.DataItem,"Size") %></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    <asp:ObjectDataSource ID="MeterDataSource" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllMeters" 
                        TypeName="PMAC.BLL.MeterBL"></asp:ObjectDataSource>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbChangeGaugeDate" runat="server" Text="Ngày thay đồng hồ"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadDatePicker ID="dtmMeterChanged" runat="server" Culture="en-GB" 
                        Enabled="False">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    </telerik:RadDatePicker>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbTransmitterSeri" runat="server" Text="Seri bộ hiển thị"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboTransmitterSerials" runat="server" DropDownWidth="395px"
                        DataSourceID="TransmitterDataSource" DataTextField="Serial" 
                        DataValueField="Serial" EnableLoadOnDemand="true" AllowCustomText="True" 
                        Filter="StartsWith" HighlightTemplatedItems="True" MarkFirstMatch="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0" style="width:370px">
                                 <tr>
                                    <td style="width: 160px">
                                        <asp:Label ID="seri_header" runat="server" Text="Số seri"></asp:Label>
                                    </td>
                                    <td style="width: 60px">
                                        <asp:Label ID="manufacturer_header" runat="server" Text="Nhà SX"></asp:Label>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:Label ID="brandname_header" runat="server" Text="Hiệu"></asp:Label>
                                    </td>
                                    <td style="width: 50px">
                                        <asp:Label ID="size_header" runat="server" Text="Cỡ"></asp:Label>
                                    </td>
                                </tr>
                            </table>

                        </HeaderTemplate>
                        <ItemTemplate>
                            <table  cellpadding="0" cellspacing="0" style="width:370px">
                                <tr>
                                    <td style="width: 160px"><%#DataBinder.Eval(Container.DataItem,"Serial") %></td>
                                    <td style="width: 60px"><%#DataBinder.Eval(Container.DataItem,"Provider") %></td>
                                    <td style="width: 100px"><%#DataBinder.Eval(Container.DataItem,"Marks") %></td>
                                    <td style="width: 50px"><%#DataBinder.Eval(Container.DataItem,"Size") %></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    <asp:ObjectDataSource ID="TransmitterDataSource" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllTransmitters" 
                        TypeName="PMAC.BLL.TransmitterBL"></asp:ObjectDataSource>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbChangeTransmitterDate" runat="server" Text="Ngày thay bộ hiển thị"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadDatePicker ID="dtmTransmitterChanged" runat="server" 
                        Culture="en-GB" Enabled="False">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    </telerik:RadDatePicker>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbLoggerSeri" runat="server" Text="Logger seri"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboLoggerSerials" runat="server" EnableLoadOnDemand="true" 
                        DataSourceID="LoggerDataSource" DataTextField="Serial" DropDownWidth="445px" 
                        DataValueField="Serial" AllowCustomText="True" Filter="StartsWith" 
                        HighlightTemplatedItems="True" MarkFirstMatch="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0" style="width:420px">
                                 <tr>
                                    <td style="width: 160px">
                                        <asp:Label ID="seri_header" runat="server" Text="Số seri"></asp:Label>
                                    </td>
                                    <td style="width: 60px">
                                        <asp:Label ID="manufacturer_header" runat="server" Text="Nhà SX"></asp:Label>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:Label ID="brandname_header" runat="server" Text="Hiệu"></asp:Label>
                                    </td>
                                    <td style="width: 50px">
                                        <asp:Label ID="size_header" runat="server" Text="Cỡ"></asp:Label>
                                    </td>
                                </tr>
                            </table>

                        </HeaderTemplate>
                        <ItemTemplate>
                            <table  cellpadding="0" cellspacing="0" style="width:420px">
                                <tr>
                                    <td style="width: 160px"><%#DataBinder.Eval(Container.DataItem,"Serial") %></td>
                                    <td style="width: 60px"><%#DataBinder.Eval(Container.DataItem,"Provider") %></td>
                                    <td style="width: 100px"><%#DataBinder.Eval(Container.DataItem,"Marks") %></td>
                                    <td style="width: 100px"><%#DataBinder.Eval(Container.DataItem,"Model") %></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    <asp:ObjectDataSource ID="LoggerDataSource" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllLoggers" 
                        TypeName="PMAC.BLL.LoggerBL"></asp:ObjectDataSource>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbChangeLoggerDate" runat="server" Text="Ngày thay logger"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadDatePicker ID="dtmLoggerChanged" runat="server" Culture="en-GB" 
                        Enabled="False">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    </telerik:RadDatePicker>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbStatus" runat="server" Text="Trạng thái"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboStatus" runat="server" DropDownWidth="265px" 
                        DataSourceID="SiteStatusDataSource" DataTextField="Status" 
                        DataValueField="Status" HighlightTemplatedItems="true"
                        >
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0" style="width:240px">
                                <tr>
                                    <td style="width:80px;">
                                        <asp:Label ID="status_header" runat="server" Text="Trạng thái"></asp:Label>
                                    </td>
                                    <td style="width:160px;">
                                        <asp:Label ID="description_header" runat="server" Text="Mô tả"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table cellpadding="0" cellspacing="0" style="width:240px">
                                <tr>
                                    <td style="width:80px;"><%#DataBinder.Eval(Container.DataItem, "Status")%></td>
                                    <td style="width:160px;"><%#DataBinder.Eval(Container.DataItem, "Description")%></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    <asp:ObjectDataSource ID="SiteAvailabilityDataSource" runat="server" 
                        OldValuesParameterFormatString="original_{0}" 
                        SelectMethod="GetAllSiteAvailabilities" 
                        TypeName="PMAC.DAL.SiteAvailabilityBL"></asp:ObjectDataSource>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbCondition" runat="server" Text="Tình trạng"></asp:Label>:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboAvailabilities" runat="server" DropDownWidth="200px"
                        DataSourceID="SiteAvailabilityDataSource" DataTextField="Availability" 
                        DataValueField="Availability" HighlightTemplatedItems="true" >
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width:80px;">
                                        <asp:Label ID="condition_status" runat="server" Text="Tình trạng"></asp:Label>
                                    </td>

                                    <td style="width:120px;">
                                        <asp:Label ID="description2_status" runat="server" Text="Mô tả"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width:80px;"><%#DataBinder.Eval(Container.DataItem, "Availability")%></td>
                                    <td style="width:120px;"><%#DataBinder.Eval(Container.DataItem, "Description")%></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    <asp:ObjectDataSource ID="SiteStatusDataSource" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllSiteStatus" 
                        TypeName="PMAC.DAL.SiteStatusBL"></asp:ObjectDataSource>
                </li>
                <li class="text_grid_4_columns"><asp:Label ID="lbStaffId" runat="server" Text="Mã nhân viên"></asp:Label>:
                </li>
                <li class="text_grid_4_columns">
                    <telerik:RadTextBox ID="txtStaffs" runat="server">
                    </telerik:RadTextBox>
                </li>
                <li class="text_grid_4_columns"> <asp:Label ID="lbBaseline" runat="server" Text="Baseline"></asp:Label>:
                </li>
                <li class="text_grid_4_columns">
                     <telerik:RadNumericTextBox ID="txtBaseline" runat="server" DataType="System.Int16" MaxValue="44640" MinValue="0">
<NegativeStyle Resize="None"></NegativeStyle>

<NumberFormat ZeroPattern="n" DecimalDigits="0"></NumberFormat>

<EmptyMessageStyle Resize="None"></EmptyMessageStyle>

<ReadOnlyStyle Resize="None"></ReadOnlyStyle>

<FocusedStyle Resize="None"></FocusedStyle>

<DisabledStyle Resize="None"></DisabledStyle>

<InvalidStyle Resize="None"></InvalidStyle>

<HoveredStyle Resize="None"></HoveredStyle>

<EnabledStyle Resize="None"></EnabledStyle>
                    </telerik:RadNumericTextBox>
                </li>
            </ul>
        </div>
    </div>
    
    <div class="div_center" style="clear:both;">
        <telerik:RadButton ID="btnAdd" runat="server" Text="Thêm/Sửa [A]" AccessKey="A" 
            onclick="btnAdd_Click">
        </telerik:RadButton>
        <telerik:RadButton ID="btnDelete" runat="server" Text="Xóa" 
            AutoPostBack="False" onclientclicked="btnDelete_Click">
        </telerik:RadButton>
        <telerik:RadButton ID="RadButton1" runat="server" Text="Thống kê" PostBackUrl="~/Supervisor/Summary/Site.aspx"></telerik:RadButton>
        <telerik:RadButton ID="RadButton2" runat="server" Text="Thay thiết bị" PostBackUrl="~/Supervisor/Site/ChangeDevice.aspx"></telerik:RadButton>
    </div>



    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow ID="winAddConsumer" runat="server"  
                Height="400px" Modal="True" OnClientClose="winAddConsumer_Close" 
                ReloadOnShow="True" style="display:none;" Title="Thêm mới khách hàng" 
                VisibleStatusbar="False" Width="400px" >
                <ContentTemplate>
                    <uc2:ucConsumer runat="server" ID="ucConsumer" />
                </ContentTemplate>
            </telerik:RadWindow>
            <telerik:RadWindow ID="winAddDisplayGroup" runat="server"  
                Height="400px" Modal="True" OnClientClose="winAddDisplayGroup_Close" 
                ReloadOnShow="True" style="display:none;" Title="Thêm mới nhóm hiển thị" 
                VisibleStatusbar="False" Width="400px" >
                <ContentTemplate>
                    <uc1:ucDisplayGroup runat="server" ID="ucDisplayGroup" />
                </ContentTemplate>
            </telerik:RadWindow>
            <telerik:RadWindow ID="winConfirmDelete" runat="server"  
                Modal="True" ReloadOnShow="True" style="display:none;" Title="Confirm" 
                VisibleStatusbar="False" Height="165px" Width="400px">
                <ContentTemplate>
                    <div style="text-align:center;padding:10px;">
                        <asp:Label ID="lbConfirmDelete" runat="server" Text="Bạn có chắc chắn muốn xóa điểm lắp đặt (gồm các cấu hình logger và dữ liệu logger)?"></asp:Label>                        
                    </div>
                    <div style="text-align:center;padding:10px;">
                        <telerik:RadButton ID="btnOK" runat="server" Text="Confirm" onclick="btnConfirmDelete_Click">
                        </telerik:RadButton>
                        <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel" AutoPostBack="False" OnClientClicked="btnCancel_Click">
                        </telerik:RadButton>
                    </div>
                </ContentTemplate>
            </telerik:RadWindow>
            <telerik:RadWindow ID="winAddChannel" runat="server"  
                Height="500px" Modal="True" ReloadOnShow="True" style="display:none;" 
                VisibleStatusbar="False" Width="400px" Title="Thêm mới channel">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadNotification ID="ntf" runat="server" >
    </telerik:RadNotification>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cboSites">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboSites" />
                    <telerik:AjaxUpdatedControl ControlID="cboConsumers" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="txtAliasName" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="txtPipeSize" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="txtLocation" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="txtLoggerID" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="nmrLatitude" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="cboStartDays" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="nmrLongitude" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="cboStartHours" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="nmrSetDelayTime" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="nmrSetDiffValue" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="cboZoomLevels" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="txtLoggerPhoneNumber" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="cboDisplayGroups" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="cboMeterSerials" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="dtmMeterChanged" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="cboTransmitterSerials" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="dtmTransmitterChanged" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="cboLoggerSerials" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="dtmLoggerChanged" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="cboStatus" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="cboAvailabilities" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="txtStaffs" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="txtBaseline" UpdatePanelCssClass="" />
                    
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ntf" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnOK">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboSites" />
                    <telerik:AjaxUpdatedControl ControlID="cboConsumers" />
                    <telerik:AjaxUpdatedControl ControlID="txtAliasName" />
                    <telerik:AjaxUpdatedControl ControlID="txtPipeSize" />
                    <telerik:AjaxUpdatedControl ControlID="txtLocation" />
                    <telerik:AjaxUpdatedControl ControlID="txtLoggerID" />
                    <telerik:AjaxUpdatedControl ControlID="nmrLatitude" />
                    <telerik:AjaxUpdatedControl ControlID="cboStartDays" />
                    <telerik:AjaxUpdatedControl ControlID="nmrLongitude" />
                    <telerik:AjaxUpdatedControl ControlID="cboStartHours" />
                    <telerik:AjaxUpdatedControl ControlID="nmrSetDelayTime" />
                    <telerik:AjaxUpdatedControl ControlID="nmrSetDiffValue" />
                    <telerik:AjaxUpdatedControl ControlID="cboZoomLevels" />
                    <telerik:AjaxUpdatedControl ControlID="txtLoggerPhoneNumber" />
                    <telerik:AjaxUpdatedControl ControlID="cboDisplayGroups" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                    <telerik:AjaxUpdatedControl ControlID="cboMeterSerials" />
                    <telerik:AjaxUpdatedControl ControlID="dtmMeterChanged" />
                    <telerik:AjaxUpdatedControl ControlID="cboTransmitterSerials" />
                    <telerik:AjaxUpdatedControl ControlID="dtmTransmitterChanged" />
                    <telerik:AjaxUpdatedControl ControlID="cboLoggerSerials" />
                    <telerik:AjaxUpdatedControl ControlID="dtmLoggerChanged" />
                    <telerik:AjaxUpdatedControl ControlID="cboStatus" />
                   <telerik:AjaxUpdatedControl ControlID="txtBaseline" /> 
                    <telerik:AjaxUpdatedControl ControlID="cboAvailabilities" />
                    <telerik:AjaxUpdatedControl ControlID="txtStaffs" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="ntf" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
                <script type="text/javascript">
            function pageLoad(sender, args) {
                $(function () {
                    $(".riTextBox").each(function () {
                        $(this).removeClass("rfdDecorated");  
                    });
                    $("#ctl00_ContentPlaceHolder1_dtmMeterChanged_dateInput").addClass("riTextBox riDisabled");
                    $("#ctl00$ContentPlaceHolder1$dtmLoggerChanged$dateInput").addClass("riTextBox riDisabled");
                })
            }
        </script>
</asp:Content>

