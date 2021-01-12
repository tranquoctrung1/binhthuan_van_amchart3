<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucChangeLogger.ascx.cs" Inherits="Controls_ucChangeLogger" %>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript" id="telerikClientEvents1">
    //<![CDATA[

        function btnDeleteLoggerHistory_Clicked(sender, args) {
            var win = $find('<%= winConfirmDeleteLoggerHistory.ClientID %>');
            win.show();
        }
    //]]>
    </script>
    <script type="text/javascript" id="telerikClientEvents2">
    //<![CDATA[

        function btnCancelDeleteLoggerHistory_Clicked(sender, args) {
            var win = $find('<%= winConfirmDeleteLoggerHistory.ClientID %>');
            win.close();
        }
    //]]>
    </script>
</telerik:RadCodeBlock>
<div class="tab_content" style="width:50%;">
    <ul class="multiple_columns">
        <li class="text_grid_2_columns">
            <asp:Label ID="lbAliasName" runat="server" Text="Mã vị trí (alias name)"></asp:Label>:
        </li>
        <li class="control_grid_2_columns">
            <telerik:RadComboBox ID="cboSiteID" runat="server" DropDownWidth="685px" OnDataBound="cboSiteID_DataBound"
                DataSourceID="SiteDataSource" DataTextField="SiteAliasName" DataValueField="SiteId" HighlightTemplatedItems="true">
                <HeaderTemplate>
                    <table cellpadding="0" cellspacing="0" style="width:660px">
                        <tr>
                            <%--<td style="width:160px">Mã vị trí (tag name)</td>--%>
                            <td style="width:160px">Alias name</td>
                            <td style="width:340px">Vị trí</td>
                        </tr>
                    </table>
                </HeaderTemplate>
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" style="width:660px">
                        <tr>
                            <%--<td style="width:160px"><%#DataBinder.Eval(Container.DataItem,"SiteId") %></td>--%>
                            <td style="width:160px"><%#DataBinder.Eval(Container.DataItem,"SiteAliasName") %></td>
                            <td style="width:340px"><%#DataBinder.Eval(Container.DataItem,"Location") %></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </telerik:RadComboBox>
            <asp:ObjectDataSource ID="SiteDataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetSites" 
                TypeName="PMAC.BLL.SiteBL"></asp:ObjectDataSource>
        </li>
        <li class="text_grid_2_columns">
            <asp:Label ID="lbDateReplacement" runat="server" Text="Ngày thay"></asp:Label>:
        </li>
        <li class="control_grid_2_columns">
            <telerik:RadDatePicker ID="dtmChange" runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
            </telerik:RadDatePicker>
        </li>
        <li class="text_grid_2_columns">
            <asp:Label ID="lbOldSeriId" runat="server" Text="Số seri cũ"></asp:Label>:
        </li>
        <li class="control_grid_2_columns">
            <telerik:RadComboBox ID="cboOldSerials" runat="server" DropDownWidth="445px"
                DataSourceID="LoggerDataSource" DataTextField="Serial" DataValueField="Serial" HighlightTemplatedItems="True">
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
        <li class="text_grid_2_columns">
            <asp:Label ID="lbNewSeriId" runat="server" Text="Số seri mới"></asp:Label>:
        </li>
        <li class="control_grid_2_columns">
            <telerik:RadComboBox ID="cboNewSerials" runat="server" DropDownWidth="445px"
                DataSourceID="LoggerDataSource" DataTextField="Serial" DataValueField="Serial" HighlightTemplatedItems="True">
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
        </li>
        <li class="text_grid_2_columns">
            <asp:Label ID="lbValueAsChanged" runat="server" Text="Chỉ số khi thay"></asp:Label>:
        </li>
        <li class="control_grid_2_columns">
            <telerik:RadNumericTextBox ID="nmrOldIndex" runat="server">
<NumberFormat ZeroPattern="n" DecimalDigits="0"></NumberFormat>
            </telerik:RadNumericTextBox>
        </li>
        <li class="text_grid_2_columns">
            <asp:Label ID="lbNote" runat="server" Text="Ghi chú"></asp:Label>:
        </li>
        <li class="control_grid_2_columns">
            <telerik:RadTextBox ID="txtDescription" runat="server" Height="50px" TextMode="MultiLine" Width="250px">
            </telerik:RadTextBox>
        </li>
        <li class="text_grid_2_columns">
        </li>
        <li class="control_grid_1_columns" style="padding-top:30px">
            <telerik:RadButton ID="btnView" runat="server" onclick="btnView_Click" 
                Text="Xem">
            </telerik:RadButton>
            <telerik:RadButton ID="btnConfirm" runat="server" Text="Thêm/Sửa" 
                onclick="btnAdd_Click">
            </telerik:RadButton>
            <telerik:RadButton ID="btnDelete" runat="server" Text="Xóa lịch sử" 
                AutoPostBack="False" onclientclicked="btnDeleteLoggerHistory_Clicked" 
                onclick="btnOK_Clicked">
            </telerik:RadButton>
        </li>
    </ul>
    <telerik:RadNotification ID="ntf" runat="server" >
    </telerik:RadNotification>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow ID="winConfirmDeleteLoggerHistory" runat="server"  
            Height="150px" Modal="True" style="display:none;" Title="Confirm" 
            Width="400px" VisibleStatusbar="False">
            <ContentTemplate>
                <div style="text-align:center;padding:10px;">
                    <asp:Label ID="lbconfirm_delete_user" runat="server" Text="Bạn có chắc chắn muốn xóa dữ liệu lịch sử?"></asp:Label>
                </div>
                <div style="text-align:center;padding:10px;">
                    <telerik:RadButton ID="btnOK" runat="server" Text="OK" OnClick="btnOK_Clicked">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel" 
                        AutoPostBack="False" onclientclicked="btnCancelDeleteLoggerHistory_Clicked">
                    </telerik:RadButton>
                </div>
            </ContentTemplate>
        </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnView">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboSiteID" />
                    <telerik:AjaxUpdatedControl ControlID="dtmChange" />
                    <telerik:AjaxUpdatedControl ControlID="cboOldSerials" />
                    <telerik:AjaxUpdatedControl ControlID="cboNewSerials" />
                    <telerik:AjaxUpdatedControl ControlID="nmrOldIndex" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                    <telerik:AjaxUpdatedControl ControlID="ntf" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnConfirm">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboSiteID" />
                    <telerik:AjaxUpdatedControl ControlID="dtmChange" />
                    <telerik:AjaxUpdatedControl ControlID="cboOldSerials" />
                    <telerik:AjaxUpdatedControl ControlID="cboNewSerials" />
                    <telerik:AjaxUpdatedControl ControlID="nmrOldIndex" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                    <telerik:AjaxUpdatedControl ControlID="ntf" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnOK">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboSiteID" />
                    <telerik:AjaxUpdatedControl ControlID="dtmChange" />
                    <telerik:AjaxUpdatedControl ControlID="cboOldSerials" />
                    <telerik:AjaxUpdatedControl ControlID="cboNewSerials" />
                    <telerik:AjaxUpdatedControl ControlID="nmrOldIndex" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                    <telerik:AjaxUpdatedControl ControlID="ntf" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
</div>