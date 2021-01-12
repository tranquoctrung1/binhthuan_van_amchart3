<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.master" AutoEventWireup="true" CodeFile="Accreditation.aspx.cs" Inherits="Supervisor_Device_Accreditation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="popup_panel">
        <ul class="multiple_columns">
            <li class="text_grid_2_columns">
                <asp:Label ID="winAccreditationMeter_verificationDocument" runat="server" Text="Giấy kiểm định"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadComboBox ID="cboAccreditationDocuments" Runat="server" 
                    AllowCustomText="True" AutoPostBack="True" EnableLoadOnDemand="True" 
                    Filter="StartsWith" HighlightTemplatedItems="True" 
                    onselectedindexchanged="cboAccreditationDocuments_SelectedIndexChanged" 
                    DataSourceID="AccreditationDataSource" DataTextField="AccreditationDocument" 
                    DataValueField="AccreditationDocument">
                </telerik:RadComboBox>
                <asp:ObjectDataSource ID="AccreditationDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetAllAccreditations" TypeName="PMAC.BLL.AccreditationBL">
                </asp:ObjectDataSource>
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAccreditationMeter_MeterSeri" runat="server" Text="Số seri đồng hồ"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadComboBox ID="cboMeter" runat="server" 
                    DataSourceID="MeterDataSource" DataTextField="Serial" DataValueField="Serial">
                </telerik:RadComboBox>
                <asp:ObjectDataSource ID="MeterDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllMeters" 
                    TypeName="PMAC.BLL.MeterBL"></asp:ObjectDataSource>
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAccreditationMeter_DisplaySeri" runat="server" Text="Số seri bộ hiển thị"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadComboBox ID="cboTransmitter" Runat="server" 
                    DataSourceID="TransmitterDataSource" DataTextField="Serial" 
                    DataValueField="Serial">
                </telerik:RadComboBox>
                <asp:ObjectDataSource ID="TransmitterDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllTransmitters" 
                    TypeName="PMAC.BLL.TransmitterBL"></asp:ObjectDataSource>
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAccreditationMeter_verificationType" runat="server" Text="Loại kiểm định"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadComboBox ID="cboAccreditationTypes" runat="server"
                    HighlightTemplatedItems="True" DataSourceID="AccreditationTypeDataSource" 
                    DataTextField="Type" DataValueField="Type" >
                    <HeaderTemplate>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="width:50px">Type</td>
                                <td style="width:110px">Description</td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="width:50px"><%#DataBinder.Eval(Container.DataItem, "Type")%></td>
                                <td style="width:110px"><%#DataBinder.Eval(Container.DataItem, "Description") %></td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </telerik:RadComboBox>
                <asp:ObjectDataSource ID="AccreditationTypeDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetAllAccreditationTypes" 
                    TypeName="PMAC.BLL.AccreditationTypeBL"></asp:ObjectDataSource>
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAccreditationMeter_date" runat="server" Text="Ngày kiểm định"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadDatePicker ID="dtmAccredited" runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                </telerik:RadDatePicker>
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAccreditationMeter_dueDate" runat="server" Text="Ngày hết hạn"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadDatePicker ID="dtmExpiry" runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                </telerik:RadDatePicker>
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAccreditationMeter_note" runat="server" Text="Ghi chú"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadTextBox ID="txtDescription" runat="server">
                </telerik:RadTextBox>
            </li>
            <li class="text_grid_2_columns">
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadButton ID="btnAdd" runat="server" Text="Thêm/Sửa" 
                    onclick="btnAdd_Click">
                </telerik:RadButton>
                <telerik:RadButton ID="btnDelete" runat="server" Text="Xóa" 
                    onclick="btnDelete_Click">
                </telerik:RadButton>
            </li>
        </ul>
        <div style="text-align: center;">
            <asp:Label ID="lblMessage" runat="server" Text="msg" style="font-style: italic"></asp:Label>
        </div>
    </div>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cboAccreditationDocuments">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboAccreditationDocuments" />
                    <telerik:AjaxUpdatedControl ControlID="cboMeter" />
                    <telerik:AjaxUpdatedControl ControlID="cboAccreditationTypes" />
                    <telerik:AjaxUpdatedControl ControlID="dtmAccredited" />
                    <telerik:AjaxUpdatedControl ControlID="dtmExpiry" />
                    <telerik:AjaxUpdatedControl ControlID="cboTransmitter" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboMeter" />
                    <telerik:AjaxUpdatedControl ControlID="lblMessage" />
                    <telerik:AjaxUpdatedControl ControlID="cboTransmitter" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnDelete">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboAccreditationDocuments" />
                    <telerik:AjaxUpdatedControl ControlID="cboMeter" />
                    <telerik:AjaxUpdatedControl ControlID="cboAccreditationTypes" />
                    <telerik:AjaxUpdatedControl ControlID="dtmAccredited" />
                    <telerik:AjaxUpdatedControl ControlID="dtmExpiry" />
                    <telerik:AjaxUpdatedControl ControlID="lblMessage" />
                    <telerik:AjaxUpdatedControl ControlID="cboTransmitter" />
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

