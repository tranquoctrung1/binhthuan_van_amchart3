<%@ control language="C#" autoeventwireup="true" inherits="Controls_ucMeter, App_Web_dmjolkrd" %>

<style type="text/css">
    .auto-style1 {
        width: 100%;
    }
</style>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript" id="telerikClientEvents2">
    //<![CDATA[

            function btnCancelMeter_Clicked(sender, args) {
                var win = $find('<%= winConfirmDeleteMeter.ClientID %>');
                win.close();
            }
    //]]>
    </script>
    <script type="text/javascript" id="telerikClientEvents1">
    //<![CDATA[

        function btnDeleteMeter_Clicked(sender, args) {
            var win = $find('<%= winConfirmDeleteMeter.ClientID %>');
            win.show();
        }
    //]]>
    </script>
    <script type="text/javascript">
        function lnkFileMeter_Clicked() {
            var win = $find('<%= winFileMeter.ClientID %>');
            var meter = $find('<%= cboSerials.ClientID %>').get_text();
            win.setUrl("../File/Meter.aspx?meter=" + meter);
            win.show();
        }
    </script>
    <script type="text/javascript">
        function lnkInfoMeter_Clicked() {
            var win = $find('<%= winAccreditationMeter.ClientID %>');
            var acc = $find('<%= txtAccreditation.ClientID %>').get_value();
            win.setUrl("../Device/Accreditation.aspx?acc=" + acc);
            win.show();
        }
    </script>
</telerik:RadCodeBlock>
<div class="tab_content">
    <ul class="multiple_columns">
        <li class="text_grid_4_columns">Số seri:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboSerials" runat="server" AllowCustomText="True" 
                EnableLoadOnDemand="True" Filter="StartsWith" AutoPostBack="true"
                HighlightTemplatedItems="True" DataSourceID="SerialDataSource" 
                DataTextField="Serial" DataValueField="Serial" DropDownWidth="395px"
                onselectedindexchanged="cboSerials_SelectedIndexChanged">
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
            <asp:ObjectDataSource ID="SerialDataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllMeters" 
                TypeName="PMAC.BLL.MeterBL"></asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">
            <asp:LinkButton ID="lnkInfo" runat="server" 
                onclientclick="lnkInfoMeter_Clicked(); return false;">Giấy kiểm định:</asp:LinkButton>
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadTextBox ID="txtAccreditation" runat="server">
            </telerik:RadTextBox>
            
        </li>
        <li class="text_grid_4_columns">Ngày nhập kho:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadDatePicker ID="dtmReceipt" runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
            </telerik:RadDatePicker>
        </li>
        <li class="text_grid_4_columns">Số seri bộ hiển thị:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboTransmitterSerials" runat="server" 
                DataSourceID="TransmitterDataSource" DataTextField="Serial" 
                DataValueField="Serial" DropDownWidth="395px" HighlightTemplatedItems="True">
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
        <li class="text_grid_4_columns">Nhà sản xuất:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboProviders" runat="server" AllowCustomText="True" 
                EnableLoadOnDemand="True" Filter="StartsWith" 
                HighlightTemplatedItems="True"
                DataSourceID="ProviderDataSource">
            </telerik:RadComboBox>
            <asp:ObjectDataSource ID="ProviderDataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetAllMeterProviders" TypeName="PMAC.BLL.MeterBL">
            </asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">Phê duyệt mẫu:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadTextBox ID="txtApprovalDecision" runat="server">
            </telerik:RadTextBox>
        </li>
        <li class="text_grid_4_columns">Hiệu:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboMarks" runat="server" AllowCustomText="True" 
                EnableLoadOnDemand="True" Filter="StartsWith" 
                HighlightTemplatedItems="True"
                DataSourceID="MarksDataSource">
            </telerik:RadComboBox>
            <asp:ObjectDataSource ID="MarksDataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllMeterMarks" 
                TypeName="PMAC.BLL.MeterBL"></asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">Ngày phê duyệt:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadDatePicker ID="dtmApproved" runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
            </telerik:RadDatePicker>
        </li>
        <li class="text_grid_4_columns">Cỡ:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboSize" runat="server" AllowCustomText="True" 
                EnableLoadOnDemand="True" Filter="StartsWith" 
                HighlightTemplatedItems="True" DataSourceID="SizeDataSource">
            </telerik:RadComboBox>
            <asp:ObjectDataSource ID="SizeDataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllMeterSizes" 
                TypeName="PMAC.BLL.MeterBL"></asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">Đã phê duyệt:
        </li>
        <li class="control_grid_4_columns">
            <asp:CheckBox ID="chkApproved" runat="server" />
        </li>
        <li class="text_grid_4_columns">Model:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboModels" runat="server" AllowCustomText="True" 
                EnableLoadOnDemand="True" Filter="StartsWith" 
                HighlightTemplatedItems="True"
                DataSourceID="ModelDataSource">
            </telerik:RadComboBox>
            <asp:ObjectDataSource ID="ModelDataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllMeterModels" 
                TypeName="PMAC.BLL.MeterBL"></asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">
            
        </li>
        <li class="control_grid_4_columns">
            <asp:LinkButton ID="lnkUpload" runat="server" 
                onclientclick="lnkFileMeter_Clicked(); return false;">Up/Down tài liệu đồng hồ</asp:LinkButton>
        </li>
        <li class="text_grid_4_columns">Tình trạng:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboStatus" runat="server" HighlightTemplatedItems="true"
                DataSourceID="StatusDataSource" DataTextField="Status" DataValueField="Status">
                <HeaderTemplate>
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="width:80px">Tình trạng</td>
                            <td style="width:80px">Mô tả</td>
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

        <li class="text_grid_4_columns">Đã lắp đặt:
        </li>
        <li class="control_grid_4_columns">
            <asp:CheckBox ID="chkInstalled" runat="server" />
        </li>

        <li class="text_grid_4_columns">
        </li>
        <li class="control_grid_4_columns">
        </li>
        
        
        <li class="text_grid_4_columns">Ghi chú:
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
            AutoPostBack="False" onclientclicked="btnDeleteMeter_Clicked">
        </telerik:RadButton>
        <telerik:RadButton ID="RadButton1" runat="server" Text="Thống kê" PostBackUrl="~/Supervisor/Summary/Device.aspx"></telerik:RadButton>
    </div>
</div>
<telerik:RadNotification ID="ntf" runat="server" Title="Message">
</telerik:RadNotification>
<telerik:RadWindowManager ID="RadWindowManager1" runat="server">
    <Windows>
        <telerik:RadWindow ID="winConfirmDeleteMeter" runat="server"  
            Height="150px" Modal="True" style="display:none;" Title="Confirm" 
            Width="400px" VisibleStatusbar="False">
            <ContentTemplate>
                <div style="text-align:center;padding:10px;">
                    Bạn có chắc chắn muốn xóa dữ liệu đồng hồ?
                </div>
                <div style="text-align:center;padding:10px;">
                    <telerik:RadButton ID="btnOK" runat="server" Text="OK"
                        OnClick="btnOK_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel" 
                        AutoPostBack="False" onclientclicked="btnCancelMeter_Clicked">
                    </telerik:RadButton>
                </div>
            </ContentTemplate>
        </telerik:RadWindow>
        <telerik:RadWindow ID="winFileMeter" runat="server" style="display:none;z-index:7001" 
            VisibleStatusbar="False" Width="600px"  Height="400px" 
            Modal="True">
        </telerik:RadWindow>
        <telerik:RadWindow ID="winAccreditationMeter" runat="server"  
            Height="450px" Modal="True" style="display:none;z-index:7001" Title="Thông tin kiểm định" 
            VisibleStatusbar="False" Width="400px">
        </telerik:RadWindow>
    </Windows>
</telerik:RadWindowManager>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="cboSerials">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cboSerials" />
                <telerik:AjaxUpdatedControl ControlID="txtAccreditation" />
                <telerik:AjaxUpdatedControl ControlID="dtmReceipt" />
                <telerik:AjaxUpdatedControl ControlID="cboTransmitterSerials" />
                <telerik:AjaxUpdatedControl ControlID="cboProviders" />
                <telerik:AjaxUpdatedControl ControlID="txtApprovalDecision" />
                <telerik:AjaxUpdatedControl ControlID="cboMarks" />
                <telerik:AjaxUpdatedControl ControlID="dtmApproved" />
                <telerik:AjaxUpdatedControl ControlID="cboSize" />
                <telerik:AjaxUpdatedControl ControlID="chkApproved" />
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
                <telerik:AjaxUpdatedControl ControlID="cboTransmitterSerials" />
                <telerik:AjaxUpdatedControl ControlID="cboProviders" />
                <telerik:AjaxUpdatedControl ControlID="txtApprovalDecision" />
                <telerik:AjaxUpdatedControl ControlID="cboMarks" />
                <telerik:AjaxUpdatedControl ControlID="dtmApproved" />
                <telerik:AjaxUpdatedControl ControlID="cboSize" />
                <telerik:AjaxUpdatedControl ControlID="chkApproved" />
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
                <telerik:AjaxUpdatedControl ControlID="cboTransmitterSerials" />
                <telerik:AjaxUpdatedControl ControlID="cboProviders" />
                <telerik:AjaxUpdatedControl ControlID="txtApprovalDecision" />
                <telerik:AjaxUpdatedControl ControlID="cboMarks" />
                <telerik:AjaxUpdatedControl ControlID="dtmApproved" />
                <telerik:AjaxUpdatedControl ControlID="cboSize" />
                <telerik:AjaxUpdatedControl ControlID="chkApproved" />
                <telerik:AjaxUpdatedControl ControlID="cboModels" />
                <telerik:AjaxUpdatedControl ControlID="cboStatus" />
                <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                <telerik:AjaxUpdatedControl ControlID="chkInstalled" />
                <telerik:AjaxUpdatedControl ControlID="ntf" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


