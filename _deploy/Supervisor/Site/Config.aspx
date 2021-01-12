<%@ page title="" language="C#" masterpagefile="~/Supervisor/MasterPage.master" autoeventwireup="true" inherits="Supervisor_Site_Config, App_Web_pi0iyogq" theme="Default" %>

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
                    alert("Chưa nhập ID Logger");
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
    <%--<div id="title">
        <div style="position:absolute; font-size:20px; margin-left:10px">Cấu hình vị trí lắp đặt</div>
        <div class="div_center">
            <telerik:RadButton ID="btnAdd" runat="server" Text="Thêm/Sửa [A]" AccessKey="A" 
                onclick="btnAdd_Click">
            </telerik:RadButton>
            <telerik:RadButton ID="btnDelete" runat="server" Text="Xóa" 
                AutoPostBack="False" onclientclicked="btnDelete_Click">
            </telerik:RadButton>
        </div>
    </div>--%>
    <h2>
        Cấu hình vị trí lắp đặt
    </h2>
    <div id="main">
        <div>
            <ul class="multiple_columns">
                <li class="text_grid_4_columns">Mã vị trí (tag name):
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
                                    <td style="width:160px">Mã vị trí (tag name)</td>
                                    <td style="width:160px">Alias name</td>
                                    <td style="width:340px">Vị trí</td>
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
                        onclientclick="btnAddConsumer_Click();return false;">Mã khách hàng:</asp:LinkButton>
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboConsumers" runat="server" 
                        DataSourceID="ConsumersDataSource" DataTextField="ConsumerId" 
                        DataValueField="ConsumerId" DropDownWidth="300px" 
                        HighlightTemplatedItems="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width:100px">Mã KH
                                    </td>
                                    <td style="width:200px">Khách hàng
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
                <li class="text_grid_4_columns">Alias Name:</li>
                <li class="control_grid_4_columns">
                    <telerik:RadTextBox ID="txtAliasName" runat="server"></telerik:RadTextBox>
                </li>
                <li class="text_grid_4_columns">Cỡ ống</li>
                <li class="control_grid_4_columns">
                    <asp:TextBox ID="txtPipeSize" runat="server"></asp:TextBox>
                </li>
                <li class="text_grid_4_columns">Vị trí:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadTextBox ID="txtLocation" runat="server">
                    </telerik:RadTextBox>
                </li>
                <li class="text_grid_4_columns">
                    <asp:LinkButton ID="btnAddChannel" runat="server" 
                        onclientclick="btnAddChannel_Click();return false;">Logger ID:</asp:LinkButton>
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadTextBox ID="txtLoggerID" runat="server">
                    </telerik:RadTextBox>
                    
                </li>
                <li class="text_grid_4_columns">Vĩ độ:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadNumericTextBox ID="nmrLatitude" runat="server">
<NumberFormat ZeroPattern="n" decimaldigits="7"></NumberFormat>
                    </telerik:RadNumericTextBox>
                </li>
                <li class="text_grid_4_columns">Ngày chốt dữ liệu:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboStartDays" runat="server">
                    </telerik:RadComboBox>
                </li>
                <li class="text_grid_4_columns">Kinh độ:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadNumericTextBox ID="nmrLongitude" runat="server">
<NumberFormat ZeroPattern="n" decimaldigits="7"></NumberFormat>
                    </telerik:RadNumericTextBox>
                </li>
                <li class="text_grid_4_columns">Giờ chốt dữ liệu:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboStartHours" runat="server">
                    </telerik:RadComboBox>
                </li>
                <li class="text_grid_4_columns">Zoom:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboZoomLevels" runat="server">
                    </telerik:RadComboBox>
                </li>
                <li class="text_grid_4_columns">Số điện thoại logger:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadTextBox ID="txtLoggerPhoneNumber" runat="server">
                    </telerik:RadTextBox>
                </li>
                <li class="text_grid_4_columns">
                    <asp:LinkButton ID="btnAddDisplayGroup" runat="server" 
                        onclientclick="btnAddDisplayGroup_Click();return false;">Nhóm hiển thị:</asp:LinkButton>
                    
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboDisplayGroups" runat="server" 
                        DataSourceID="DisplayGroupsDataSource" DataTextField="Group" 
                        DataValueField="Group" DropDownWidth="300px" 
                        HighlightTemplatedItems="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width:100px">Nhóm hiển thị
                                    </td>
                                    <td style="width:200px">Mô tả
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
                <li class="text_grid_4_columns">Ghi chú:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadTextBox ID="txtDescription" runat="server">
                    </telerik:RadTextBox>
                </li>
                <li class="text_grid_4_columns">Seri đồng hồ:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboMeterSerials" runat="server" EnableLoadOnDemand="true"
                        DataSourceID="MeterDataSource" DataTextField="Serial" DropDownWidth="395px"
                        DataValueField="Serial" AllowCustomText="True" Filter="StartsWith" 
                        HighlightTemplatedItems="True" MarkFirstMatch="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0" style="width:370px">
                                 <tr>
                                    <td style="width: 160px">Số seri</td>
                                    <td style="width: 60px">Nhà SX</td>
                                    <td style="width: 100px">Hiệu</td>
                                    <td style="width: 50px">Cỡ</td>
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
                <li class="text_grid_4_columns">Ngày thay đồng hồ:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadDatePicker ID="dtmMeterChanged" runat="server" Culture="en-GB" 
                        Enabled="False">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    </telerik:RadDatePicker>
                </li>
                <li class="text_grid_4_columns">Seri bộ hiển thị:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboTransmitterSerials" runat="server" DropDownWidth="395px"
                        DataSourceID="TransmitterDataSource" DataTextField="Serial" 
                        DataValueField="Serial" EnableLoadOnDemand="true" AllowCustomText="True" 
                        Filter="StartsWith" HighlightTemplatedItems="True" MarkFirstMatch="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0" style="width:370px">
                                 <tr>
                                    <td style="width: 160px">Số seri</td>
                                    <td style="width: 60px">Nhà SX</td>
                                    <td style="width: 100px">Hiệu</td>
                                    <td style="width: 50px">Cỡ</td>
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
                <li class="text_grid_4_columns">Ngày thay bộ hiển thị:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadDatePicker ID="dtmTransmitterChanged" runat="server" 
                        Culture="en-GB" Enabled="False">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    </telerik:RadDatePicker>
                </li>
                <li class="text_grid_4_columns">Seri logger:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboLoggerSerials" runat="server" EnableLoadOnDemand="true" 
                        DataSourceID="LoggerDataSource" DataTextField="Serial" DropDownWidth="445px" 
                        DataValueField="Serial" AllowCustomText="True" Filter="StartsWith" 
                        HighlightTemplatedItems="True" MarkFirstMatch="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0" style="width:420px">
                                 <tr>
                                    <td style="width: 160px">Số seri</td>
                                    <td style="width: 60px">Nhà SX</td>
                                    <td style="width: 100px">Hiệu</td>
                                    <td style="width: 100px">Model</td>
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
                <li class="text_grid_4_columns">Ngày thay logger:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadDatePicker ID="dtmLoggerChanged" runat="server" Culture="en-GB" 
                        Enabled="False">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    </telerik:RadDatePicker>
                </li>
                <li class="text_grid_4_columns">Trạng thái:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboStatus" runat="server" DropDownWidth="265px" 
                        DataSourceID="SiteStatusDataSource" DataTextField="Status" 
                        DataValueField="Status" HighlightTemplatedItems="true">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0" style="width:240px">
                                <tr>
                                    <td style="width:80px;">Trạng thái</td>
                                    <td style="width:160px;">Mô tả</td>
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
                <li class="text_grid_4_columns">Tình trạng:
                </li>
                <li class="control_grid_4_columns">
                    <telerik:RadComboBox ID="cboAvailabilities" runat="server" DropDownWidth="200px"
                        DataSourceID="SiteAvailabilityDataSource" DataTextField="Availability" 
                        DataValueField="Availability" HighlightTemplatedItems="true" >
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width:80px;">Tình trạng</td>
                                    <td style="width:120px;">Mô tả</td>
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
                <li class="text_grid_4_columns">Mã nhân viên
                </li>
                <li class="text_grid_4_columns">
                    <telerik:RadTextBox ID="txtStaffs" runat="server">
                    </telerik:RadTextBox>
                </li>
                <li class="text_grid_4_columns">
                </li>
                <li class="text_grid_4_columns">
                    
                </li>
            </ul>
        </div>
    </div>

    <div class="div_center">
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
                        Bạn có chắc chắn muốn xóa điểm lắp đặt (gồm các cấu hình logger và dữ liệu logger)?
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
            <telerik:AjaxSetting AjaxControlID="btnAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ntf" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboSites">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboSites" />
                    <telerik:AjaxUpdatedControl ControlID="txtAliasName" />
                    <telerik:AjaxUpdatedControl ControlID="cboConsumers" />
                    <telerik:AjaxUpdatedControl ControlID="txtLocation" />
                    <telerik:AjaxUpdatedControl ControlID="txtLoggerID" />
                    <telerik:AjaxUpdatedControl ControlID="nmrLatitude" />
                    <telerik:AjaxUpdatedControl ControlID="cboStartDays" />
                    <telerik:AjaxUpdatedControl ControlID="nmrLongitude" />
                    <telerik:AjaxUpdatedControl ControlID="cboStartHours" />
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
                    <telerik:AjaxUpdatedControl ControlID="cboAvailabilities" />
                    <telerik:AjaxUpdatedControl ControlID="txtStaffs" />
                    <telerik:AjaxUpdatedControl ControlID="txtPipeSize" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnOK">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboSites" />
                    <telerik:AjaxUpdatedControl ControlID="txtAliasName" />
                    <telerik:AjaxUpdatedControl ControlID="cboConsumers" />
                    <telerik:AjaxUpdatedControl ControlID="txtLocation" />
                    <telerik:AjaxUpdatedControl ControlID="txtLoggerID" />
                    <telerik:AjaxUpdatedControl ControlID="nmrLatitude" />
                    <telerik:AjaxUpdatedControl ControlID="cboStartDays" />
                    <telerik:AjaxUpdatedControl ControlID="nmrLongitude" />
                    <telerik:AjaxUpdatedControl ControlID="cboStartHours" />
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
                    <telerik:AjaxUpdatedControl ControlID="cboAvailabilities" />
                    <telerik:AjaxUpdatedControl ControlID="txtStaffs" />
                    <telerik:AjaxUpdatedControl ControlID="txtPipeSize" />
                    <telerik:AjaxUpdatedControl ControlID="ntf" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
</asp:Content>

