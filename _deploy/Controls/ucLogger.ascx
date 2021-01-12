<%@ control language="C#" autoeventwireup="true" inherits="Controls_ucLogger, App_Web_dmjolkrd" %>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript" id="telerikClientEvents4">
    //<![CDATA[

        function btnCancelLogger_Clicked(sender, args) {
            var win = $find('<%= winConfirmDeleteLogger.ClientID %>');
            win.close();
        }
    //]]>
    </script>
    <script type="text/javascript" id="telerikClientEvents1">
    //<![CDATA[

        function btnDeleteLogger_Clicked(sender, args) {
            var win = $find('<%= winConfirmDeleteLogger.ClientID %>');
            win.show();
        }
    //]]>
    </script>
    <script type="text/javascript">
        function lnkFileLogger_Clicked() {
            var win = $find('<%= winFileLogger.ClientID %>');
            var logger = $find('<%= cboSerials.ClientID %>').get_text();
            win.setUrl("../File/Logger.aspx?logger=" + logger);
            win.show();
        }
    </script>
</telerik:RadCodeBlock>
<div class="tab_content" >
    <ul class="multiple_columns">
        <li class="text_grid_4_columns">Số seri:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboSerials" runat="server" AllowCustomText="True" 
                AutoPostBack="True" EnableLoadOnDemand="True" Filter="StartsWith" 
                HighlightTemplatedItems="True" DataSourceID="Serial_DataSource" 
                onselectedindexchanged="cboSerials_SelectedIndexChanged" DropDownWidth="445px" 
                DataTextField="Serial" DataValueField="Serial">
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
            <asp:ObjectDataSource ID="Serial_DataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllLoggers" 
                TypeName="PMAC.BLL.LoggerBL">
            </asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">
            <asp:LinkButton ID="lnkUpload" runat="server" 
                onclientclick="lnkFileLogger_Clicked(); return false;">Up/Down tài liệu logger</asp:LinkButton>
        </li>
        <li class="control_grid_4_columns">
            
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
        <li class="text_grid_4_columns">
        </li>
        <li class="control_grid_4_columns">
            
        </li>
        <li class="text_grid_4_columns">Nhà sản xuất:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboProviders" runat="server" AllowCustomText="True" 
                EnableLoadOnDemand="True" Filter="StartsWith" 
                HighlightTemplatedItems="True" DataSourceID="Provider_DataSource">
            </telerik:RadComboBox>
            <asp:ObjectDataSource ID="Provider_DataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetAllLoggerProviders" TypeName="PMAC.BLL.LoggerBL">
            </asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">
        </li>
        <li class="control_grid_4_columns">
        </li>
        <li class="text_grid_4_columns">Hiệu:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboMarks" runat="server" AllowCustomText="True" 
                EnableLoadOnDemand="True" Filter="StartsWith" 
                HighlightTemplatedItems="True" DataSourceID="Marks_DataSource">
            </telerik:RadComboBox>
            <asp:ObjectDataSource ID="Marks_DataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllLoggerMarks" 
                TypeName="PMAC.BLL.LoggerBL"></asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">
        </li>
        <li class="control_grid_4_columns">
        </li>
        <li class="text_grid_4_columns">Model:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboModels" runat="server" AllowCustomText="True" 
                EnableLoadOnDemand="True" Filter="StartsWith" 
                HighlightTemplatedItems="True" DataSourceID="Model_DataSource">
            </telerik:RadComboBox>
            <asp:ObjectDataSource ID="Model_DataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllLoggerModels" 
                TypeName="PMAC.BLL.LoggerBL"></asp:ObjectDataSource>
        </li>
        <li class="text_grid_4_columns">
        </li>
        <li class="control_grid_4_columns">
        </li>
        <li class="text_grid_4_columns">Tình trạng:
        </li>
        <li class="control_grid_4_columns">
            <telerik:RadComboBox ID="cboStatus" runat="server" 
                DataSourceID="Status_DataSource" HighlightTemplatedItems="true"
                DataTextField="Status" DataValueField="Status" Filter="StartsWith" MarkFirstMatch="True">
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
            <asp:ObjectDataSource ID="Status_DataSource" runat="server" 
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
            AutoPostBack="False" onclientclicked="btnDeleteLogger_Clicked">
        </telerik:RadButton>
        <telerik:RadButton ID="RadButton1" runat="server" Text="Thống kê" PostBackUrl="~/Supervisor/Summary/Device.aspx"></telerik:RadButton>
    </div>
</div>
<telerik:RadNotification ID="ntf" runat="server" Title="Message">
</telerik:RadNotification>
<telerik:RadWindowManager ID="RadWindowManager3" runat="server">
    <Windows>
        <telerik:RadWindow ID="winConfirmDeleteLogger" runat="server"  
            Height="150px" Modal="True" style="display:none;" Title="Confirm" 
            Width="400px" VisibleStatusbar="False">
            <ContentTemplate>
                <div style="text-align:center;padding:10px;">
                    Bạn có chắc chắn muốn xóa dữ liệu logger?
                </div>
                <div style="text-align:center;padding:10px;">
                    <telerik:RadButton ID="btnOK" runat="server" Text="OK"
                        OnClick="btnOK_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel" 
                        AutoPostBack="False" onclientclicked="btnCancelLogger_Clicked">
                    </telerik:RadButton>
                </div>
            </ContentTemplate>
        </telerik:RadWindow>
        <telerik:RadWindow ID="winFileLogger" runat="server" style="display:none; z-index:7001" 
            VisibleStatusbar="False" Width="600px" 
             Height="400px" 
            Modal="True">
        </telerik:RadWindow>
    </Windows>
</telerik:RadWindowManager>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="cboSerials">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cboSerials" />
                <telerik:AjaxUpdatedControl ControlID="Serial_DataSource" />
                <telerik:AjaxUpdatedControl ControlID="dtmReceipt" />
                <telerik:AjaxUpdatedControl ControlID="cboProviders" />
                <telerik:AjaxUpdatedControl ControlID="cboMarks" />
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
                <telerik:AjaxUpdatedControl ControlID="Serial_DataSource" />
                <telerik:AjaxUpdatedControl ControlID="dtmReceipt" />
                <telerik:AjaxUpdatedControl ControlID="cboProviders" />
                <telerik:AjaxUpdatedControl ControlID="cboMarks" />
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
                <telerik:AjaxUpdatedControl ControlID="Serial_DataSource" />
                <telerik:AjaxUpdatedControl ControlID="dtmReceipt" />
                <telerik:AjaxUpdatedControl ControlID="cboProviders" />
                <telerik:AjaxUpdatedControl ControlID="cboMarks" />
                <telerik:AjaxUpdatedControl ControlID="cboModels" />
                <telerik:AjaxUpdatedControl ControlID="cboStatus" />
                <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                <telerik:AjaxUpdatedControl ControlID="chkInstalled" />
                <telerik:AjaxUpdatedControl ControlID="ntf" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
