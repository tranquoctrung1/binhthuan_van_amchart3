<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucTransmitter.ascx.cs" Inherits="Controls_ucTransmitter" %>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript" id="telerikClientEvents2">
    //<![CDATA[

        function btnCancelTransmitter_Clicked(sender, args) {
            var win = $find('<%= winConfirmDeleteTransmitter.ClientID %>');
            win.close();
        }
    //]]>
    </script>
    <script type="text/javascript" id="telerikClientEvents1">
    //<![CDATA[

        function btnDeleteTransmitter_Clicked(sender, args) {
            var win = $find('<%= winConfirmDeleteTransmitter.ClientID %>');
            win.show();
        }
    //]]>
    </script>
    <script type="text/javascript">
        function lnkFileTransmitter_Clicked() {
            var win = $find('<%= winFileTransmitter.ClientID %>');
            var transmitter = $find('<%= cboSerials.ClientID %>').get_text();
            win.setUrl("../File/Transmitter.aspx?transmitter=" + transmitter);
            win.show();
        }
    </script>
    <script type="text/javascript">
        function lnkInfoTransmitter_Clicked() {
            var win = $find('<%= winAccreditationTransmitter.ClientID %>');
            win.show();
        }
    </script>
</telerik:RadCodeBlock>
<div class="tab_content">
    <ul class="multiple_columns">
        <li class="text_grid_4_columns"><asp:Label ID="lbSeri" runat="server" Text="Số seri"></asp:Label>:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboSerials" runat="server" AllowCustomText="True" 
                EnableLoadOnDemand="True" Filter="StartsWith" HighlightTemplatedItems="True" 
                AutoPostBack="true" DataSourceID="SerialDataSource" 
                DataTextField="Serial" DataValueField="Serial" DropDownWidth="395px"
                onselectedindexchanged="cboSerials_SelectedIndexChanged">
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
            <asp:ObjectDataSource ID="SerialDataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllTransmitters" 
                TypeName="PMAC.BLL.TransmitterBL"></asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">
            <asp:LinkButton ID="lnkInfo" runat="server" 
                onclientclick="lnkInfoTransmitter_Clicked(); return false;">
                <asp:Label ID="lbLegalDocument" runat="server" Text="Giấy kiểm định"></asp:Label>:
            </asp:LinkButton>
            
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadTextBox ID="txtAccreditation" runat="server">
            </telerik:RadTextBox>
            
        </li>
        <li class="text_grid_4_columns">
            <asp:Label ID="lbStockImportDay" runat="server" Text="Ngày nhập kho"></asp:Label>:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadDatePicker ID="dtmReceipt" runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
            </telerik:RadDatePicker>
        </li>
        <li class="text_grid_4_columns">
            <asp:Label ID="lbConfirm" runat="server" Text="Phê duyệt mẫu"></asp:Label>:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadTextBox ID="txtApprovalDecision" runat="server">
            </telerik:RadTextBox>
        </li>
        <li class="text_grid_4_columns">
            <asp:Label ID="lbManufacturer" runat="server" Text="Nhà sản xuất"></asp:Label>:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboProviders" runat="server" AllowCustomText="True" 
                EnableLoadOnDemand="True" Filter="StartsWith" 
                HighlightTemplatedItems="True"
                DataSourceID="ProviderDataSource">
            </telerik:RadComboBox>
            <asp:ObjectDataSource ID="ProviderDataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetAllTransmitterProviders" 
                TypeName="PMAC.BLL.TransmitterBL"></asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">
            <asp:Label ID="lbConfirmDate" runat="server" Text="Ngày phê duyệt"></asp:Label>:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadDatePicker ID="dtmApproved" runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
            </telerik:RadDatePicker>
        </li>
        <li class="text_grid_4_columns"><asp:Label ID="lbBrand" runat="server" Text="Hiệu"></asp:Label>:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboMarks" runat="server" AllowCustomText="True" 
                EnableLoadOnDemand="True" Filter="StartsWith" 
                HighlightTemplatedItems="True"
                DataSourceID="MarksDataSource">
            </telerik:RadComboBox>
            <asp:ObjectDataSource ID="MarksDataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetAllTransmitterMarks" TypeName="PMAC.BLL.TransmitterBL">
            </asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">
            <asp:Label ID="lbIsConfirmed" runat="server" Text="Đã phê duyệt"></asp:Label>:
        </li>
        <li class="control_grid_4_columns">
            <asp:CheckBox ID="chkApproved" runat="server" />
        </li>
        <li class="text_grid_4_columns">
            <asp:Label ID="lbSize" runat="server" Text="Cỡ"></asp:Label>:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboSize" runat="server" AllowCustomText="True" 
                EnableLoadOnDemand="True" Filter="StartsWith" 
                HighlightTemplatedItems="True" DataSourceID="SizeDataSource">
            </telerik:RadComboBox>
            <asp:ObjectDataSource ID="SizeDataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetAllTransmitterSizes" TypeName="PMAC.BLL.TransmitterBL">
            </asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">
            <li class="control_grid_4_columns">
            <asp:LinkButton ID="lnkUpload" runat="server" 
                onclientclick="lnkFileTransmitter_Clicked(); return false;">
                <asp:Label ID="lbUpload" runat="server" Text="Up/Down tài liệu bộ hiển thị"></asp:Label>
            </asp:LinkButton>
        </li>
        
        </li>
        <li class="text_grid_4_columns">
            <asp:Label ID="lbModel" runat="server" Text="Model"></asp:Label>:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboModels" runat="server" AllowCustomText="True" 
                EnableLoadOnDemand="True" Filter="StartsWith" 
                HighlightTemplatedItems="True"
                DataSourceID="ModelDataSource">
            </telerik:RadComboBox>
            <asp:ObjectDataSource ID="ModelDataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetAllTransmitterModels" TypeName="PMAC.BLL.TransmitterBL">
            </asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">
        </li>
        <li class="control_grid_4_columns">
            <%--<asp:LinkButton ID="lnkDownload" runat="server" 
                onclientclick="lnkFileTransmitter_Clicked(); return false;">Download</asp:LinkButton>--%>
        </li>
        <li class="text_grid_4_columns">
            <asp:Label ID="lbStatus" runat="server" Text="Tình trạng"></asp:Label>:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboStatus" runat="server" HighlightTemplatedItems="True"
                DataSourceID="StatusDataSource" DataTextField="Status" DataValueField="Status">
                <HeaderTemplate>
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="width: 160px">
                                 <asp:Label ID="status_header" runat="server" Text="Tình trạng"></asp:Label>
                             </td>
                            <td style="width: 160px">
                                 <asp:Label ID="description_header" runat="server" Text="Mô tả"></asp:Label>
                             </td>
                        </tr>
                    </table>
                </HeaderTemplate>
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="width:80px"><%# DataBinder.Eval(Container.DataItem,"Status") %></td>
                            <td style="width:80px"><%# DataBinder.Eval(Container.DataItem,"Description") %></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </telerik:RadComboBox>
            <asp:ObjectDataSource ID="StatusDataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllDeviceStatus" 
                TypeName="PMAC.DAL.DeviceStatusBL"></asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">
        </li>
        <li class="control_grid_4_columns">

        </li>

        <li class="text_grid_4_columns">
            <asp:Label ID="lbIsInstallation" runat="server" Text="Đã lắp đặt"></asp:Label>:
        </li>
        <li class="control_grid_4_columns">
            <asp:CheckBox ID="chkInstalled" runat="server" />
        </li>

        
        <li class="text_grid_4_columns">
        </li>
        <li class="control_grid_4_columns">
        </li>
        
        <li class="text_grid_4_columns">
            <asp:Label ID="lbNote" runat="server" Text="Note"></asp:Label>:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadTextBox ID="txtDescription" runat="server" Height="50px" TextMode="MultiLine" Width="250px">
            </telerik:RadTextBox>
        </li>

        <li class="text_grid_4_columns">
        </li>
        <li class="control_grid_4_columns">
        </li>
    </ul>
    <div style="text-align: center; clear:left; padding-top:50px">
        <telerik:RadButton ID="btnAdd" runat="server" Text="Thêm/Sửa" 
            onclick="btnAdd_Click">
        </telerik:RadButton>
        <telerik:RadButton ID="btnDelete" runat="server" Text="Xóa" 
            AutoPostBack="False" onclientclicked="btnDeleteTransmitter_Clicked">
        </telerik:RadButton>
        <telerik:RadButton ID="RadButton1" runat="server" Text="Thống kê" PostBackUrl="~/Supervisor/Summary/Device.aspx"></telerik:RadButton>
    </div>
</div>
<telerik:RadNotification ID="ntf" runat="server" Title="Message">
</telerik:RadNotification>
<telerik:RadWindowManager ID="RadWindowManager2" runat="server">
    <Windows>
        <telerik:RadWindow ID="winConfirmDeleteTransmitter" runat="server"  
            Height="150px" Modal="True" style="display:none;" Title="Confirm" 
            Width="400px" VisibleStatusbar="False">
            <ContentTemplate>
                <div style="text-align:center;padding:10px;">
                    <asp:Label ID="lb_delete_confirm" runat="server" Text="Label"></asp:Label>
                </div>
                <div style="text-align:center;padding:10px;">
                    <telerik:RadButton ID="btnOK" runat="server" Text="OK"
                        OnClick="btnOK_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel" 
                        AutoPostBack="False" onclientclicked="btnCancelTransmitter_Clicked">
                    </telerik:RadButton>
                </div>
            </ContentTemplate>
        </telerik:RadWindow>
        <telerik:RadWindow ID="winFileTransmitter" runat="server" style="display:none; z-index:7001" 
            VisibleStatusbar="False" Width="600px" 
             Height="400px" 
            Modal="True">
        </telerik:RadWindow>
        <telerik:RadWindow ID="winAccreditationTransmitter" runat="server"  
            NavigateUrl="~/Supervisor/Device/Accreditation.aspx"
            Height="450px" Modal="True" style="display:none;" Title="Thông tin kiểm định" 
            VisibleStatusbar="False" Width="400px">
        </telerik:RadWindow>
    </Windows>
</telerik:RadWindowManager>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="cboSerials">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cboSerials" />
                <telerik:AjaxUpdatedControl ControlID="SerialDataSource" />
                <telerik:AjaxUpdatedControl ControlID="txtAccreditation" />
                <telerik:AjaxUpdatedControl ControlID="dtmReceipt" />
                <telerik:AjaxUpdatedControl ControlID="txtApprovalDecision" />
                <telerik:AjaxUpdatedControl ControlID="cboProviders" />
                <telerik:AjaxUpdatedControl ControlID="dtmApproved" />
                <telerik:AjaxUpdatedControl ControlID="cboMarks" />
                <telerik:AjaxUpdatedControl ControlID="chkApproved" />
                <telerik:AjaxUpdatedControl ControlID="cboSize" />
                <telerik:AjaxUpdatedControl ControlID="cboModels" />
                <telerik:AjaxUpdatedControl ControlID="cboStatus" />
                <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                <telerik:AjaxUpdatedControl ControlID="chkInstalled" />
                <telerik:AjaxUpdatedControl ControlID="ntf" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnAdd">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cboSerials" />
                <telerik:AjaxUpdatedControl ControlID="SerialDataSource" />
                <telerik:AjaxUpdatedControl ControlID="txtAccreditation" />
                <telerik:AjaxUpdatedControl ControlID="dtmReceipt" />
                <telerik:AjaxUpdatedControl ControlID="txtApprovalDecision" />
                <telerik:AjaxUpdatedControl ControlID="cboProviders" />
                <telerik:AjaxUpdatedControl ControlID="dtmApproved" />
                <telerik:AjaxUpdatedControl ControlID="cboMarks" />
                <telerik:AjaxUpdatedControl ControlID="chkApproved" />
                <telerik:AjaxUpdatedControl ControlID="cboSize" />
                <telerik:AjaxUpdatedControl ControlID="cboModels" />
                <telerik:AjaxUpdatedControl ControlID="cboStatus" />
                <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                <telerik:AjaxUpdatedControl ControlID="chkInstalled" />
                <telerik:AjaxUpdatedControl ControlID="ntf" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnOK">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cboSerials" />
                <telerik:AjaxUpdatedControl ControlID="SerialDataSource" />
                <telerik:AjaxUpdatedControl ControlID="txtAccreditation" />
                <telerik:AjaxUpdatedControl ControlID="dtmReceipt" />
                <telerik:AjaxUpdatedControl ControlID="txtApprovalDecision" />
                <telerik:AjaxUpdatedControl ControlID="cboProviders" />
                <telerik:AjaxUpdatedControl ControlID="dtmApproved" />
                <telerik:AjaxUpdatedControl ControlID="cboMarks" />
                <telerik:AjaxUpdatedControl ControlID="chkApproved" />
                <telerik:AjaxUpdatedControl ControlID="cboSize" />
                <telerik:AjaxUpdatedControl ControlID="cboModels" />
                <telerik:AjaxUpdatedControl ControlID="cboStatus" />
                <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                <telerik:AjaxUpdatedControl ControlID="chkInstalled" />
                <telerik:AjaxUpdatedControl ControlID="ntf" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>