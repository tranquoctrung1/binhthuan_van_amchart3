<%@ page title="" language="C#" masterpagefile="~/Supervisor/MasterPage.master" autoeventwireup="true" inherits="Supervisor_Report_Montly, App_Web_j4gak4mg" theme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
        function btnMail_Click() {
            var win = $find('<%= winMail.ClientID %>');
            var siteID = $find('<%= cboSites.ClientID %>').get_value();
            var consumerID = $find('<%= cboConsumers.ClientID %>').get_text();
            try {
                var startDate = $find('<%= myStart.ClientID %>').get_selectedDate().format("yyyy-MM");
            } catch (e) {
                alert("Chưa nhập tháng bắt đầu.");
                return;
            }
            try {
                var endDate = $find('<%= myEnd.ClientID %>').get_selectedDate().format("yyyy-MM");
            } catch (e) {
                alert("Chưa nhập tháng kết thúc.");
                return;
            }
            win.setUrl("Mail.aspx?si=" + siteID + "&co=" + consumerID + "&st=" + startDate + "&en=" + endDate);
            win.show();
        }
    </script>
    </telerik:RadCodeBlock>
    <h2>Báo cáo sản lượng tháng</h2>
    
    <table class="auto-style1">
        <tr>
            <td>Mã vị trí (alias name):</td>
            <td>
                        <telerik:RadComboBox ID="cboSites" runat="server" AutoPostBack="True" OnDataBound="cboSites_DataBound"
                            DataSourceID="SitesDataSource" DataTextField="SiteAliasName" DataValueField="SiteId" 
                            onselectedindexchanged="cboSites_SelectedIndexChanged" DropDownWidth="685px" HighlightTemplatedItems="True">
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
                        <asp:ObjectDataSource ID="SitesDataSource" runat="server" 
                            OldValuesParameterFormatString="original_{0}" 
                            SelectMethod="GetSitesByDisplayGroup" TypeName="PMAC.BLL.SiteBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="mnuDisplayGroup" Name="displayGroup" 
                                    PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </td>
            <td>Tháng bắt đầu:</td>
            <td>
                        <telerik:RadMonthYearPicker ID="myStart" runat="server" Culture="en-GB">
<DateInput DisplayDateFormat="MMMM yyyy" DateFormat="MMMM yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl="" BackColor="White"></DatePopupButton>
                        </telerik:RadMonthYearPicker>
                    </td>
            <td>
                        <telerik:RadButton ID="btnView" runat="server" Text="Xem" 
                            onclick="btnView_Click" Width="60px">
                        </telerik:RadButton>
                    </td>
        </tr>
        <tr>
            <td>Mã khách hàng:</td>
            <td>
                <telerik:RadComboBox ID="cboConsumers" runat="server" DataSourceID="ConsumersDataSource" DataTextField="ConsumerId" DataValueField="ConsumerId" DropDownWidth="325px" HighlightTemplatedItems="True">
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
                <asp:ObjectDataSource ID="ConsumersDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetConsumers" TypeName="PMAC.BLL.ConsumerBL"></asp:ObjectDataSource>
            </td>
            <td>Tháng kết thúc:</td>
            <td>
                        <telerik:RadMonthYearPicker ID="myEnd" runat="server" Culture="en-GB">
<DateInput DisplayDateFormat="MMMM yyyy" DateFormat="MMMM yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl="" BackColor="White"></DatePopupButton>
                        </telerik:RadMonthYearPicker>
                    </td>
            <td>
                <telerik:RadButton ID="btnExport" runat="server" onclick="btnExport_Click" Text="Export" Width="60px">
                </telerik:RadButton>
                <telerik:RadButton ID="btnMail" runat="server" AutoPostBack="False" onclientclicked="btnMail_Click" Text="Mail">
                </telerik:RadButton>
            </td>
        </tr>
    </table>
    
    <%--<div id="title" style="height:67px">
        <div id="title_name">Báo cáo sản lượng tháng</div>
        <div id="title_panel">
                <ul class="multiple_columns">
                    <li class="text_grid_5_columns">
                        Mã vị trí (tag name):
                    </li>
                    <li class="control_grid_5_columns">
                    </li>
                    <li class="text_grid_5_columns">Tháng bắt đầu:
                    </li>
                    <li class="control_grid_5_columns">
                    </li>
                    <li class="text_grid_5_columns">
                    </li>
                    <li class="text_grid_5_columns">Mã khách hàng:
                    </li>
                    <li class="control_grid_5_columns">
                        
                    </li>
                    <li class="text_grid_5_columns">Tháng kết thúc:
                    </li>
                    <li class="control_grid_5_columns">
                    </li>
                    <li class="text_grid_5_columns">
                        
                    </li>
                </ul>
            </div>
    </div>--%>
    <br />
                <telerik:RadMenu ID="mnuDisplayGroup" runat="server" DataFieldID="Group" 
                    DataSourceID="DisplayGroupsDataSource" DataTextField="Description" 
                    DataValueField="Group" Flow="Vertical" 
                    onitemclick="mnuDisplayGroup_ItemClick" Visible="False">
                </telerik:RadMenu>
                <asp:ObjectDataSource ID="DisplayGroupsDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetDisplayGroups" 
                    TypeName="PMAC.BLL.DisplayGroupBL"></asp:ObjectDataSource>
    <telerik:RadGrid ID="grv" runat="server" AutoGenerateColumns="False" 
                            CellSpacing="0" GridLines="None" >
                            <ClientSettings>
                                <Selecting CellSelectionMode="None" />
                            </ClientSettings>
                            <AlternatingItemStyle HorizontalAlign="Center" />
                            <MasterTableView DataKeyNames="SiteId" ClientDataKeyNames="SiteId">
                                <CommandItemSettings ExportToPdfText="Export to PDF" />
                                <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" 
                                    Visible="True">
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" 
                                    Visible="True">
                                    <HeaderStyle Width="20px" />
                                </ExpandCollapseColumn>
                                <Columns>
                                    <telerik:GridBoundColumn DataField="StartDate" DataFormatString="{0:MM-yyyy}"
                                        FilterControlAltText="Filter column3 column" HeaderText="Tháng" 
                                        UniqueName="Time">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SiteAliasName" 
                                        FilterControlAltText="Filter column13 column" HeaderText="Mã vị trí (alias name)" 
                                        UniqueName="column13">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </telerik:GridBoundColumn>
                                    <%--<telerik:GridBoundColumn DataField="Location" 
                                        FilterControlAltText="Filter column1 column" HeaderText="Vị trí" 
                                        UniqueName="column1">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </telerik:GridBoundColumn>--%>
                                    <telerik:GridBoundColumn DataField="SiteId" 
                                        FilterControlAltText="Filter SiteId column" HeaderText="SiteId" 
                                        UniqueName="SiteId" Visible="False">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn column"
                                        HeaderText="Chỉ số đầu" UniqueName="TemplateColumn">
                                        <ItemTemplate>
                                            <table cellpadding="0" cellspacing="0" style="width:100%">
                                                <tr style="width:100%">
                                                    <td>
                                                        <%# DataBinder.Eval(Container.DataItem, "StartIndex", "{0:0.00}")%>
                                                    </td>
                                                </tr>
                                                <tr style="width:100%">
                                                    <td>
                                                        <%# DataBinder.Eval(Container.DataItem, "StartDate", "{0:dd/MM/yyyy}")%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                        HeaderText="Chỉ số cuối" UniqueName="TemplateColumn1">
                                        <ItemTemplate>
                                            <table cellpadding="0" cellspacing="0" style="width:100%">
                                                <tr style="width:100%">
                                                    <td>
                                                        <%# DataBinder.Eval(Container.DataItem, "EndIndex", "{0:0.00}")%>
                                                    </td>
                                                </tr>
                                                <tr style="width:100%">
                                                    <td>
                                                        <%# DataBinder.Eval(Container.DataItem, "EndDate", "{0:dd/MM/yyyy}")%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn
                                        FilterControlAltText="Filter column column" HeaderText="Sản lượng" DataFormatString="{0:0.00}"
                                        UniqueName="column" DataField="Output">
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                            <HeaderStyle BackColor="#25A0DA" ForeColor="White" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                        </telerik:RadGrid>
    <%--<div style="clear:left;">
        <div id="main_left">
            <div style="padding:10px;color:White">
                Nhóm hiển thị
            </div>
            <div>
            </div>
        </div>
        <div id="main_right">
            
        </div>
    </div>--%>
    <telerik:RadNotification ID="ntf" runat="server" >
    </telerik:RadNotification>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow ID="winChart" runat="server"  Height="581px" 
                Modal="True" ReloadOnShow="True" style="display:none;z-index:7001" 
                Title="Đồ thị" VisibleStatusbar="False" Width="1000px" ShowContentDuringLoad="False">
            </telerik:RadWindow>
            <telerik:RadWindow ID="winMail" runat="server"  Height="540px" 
                Modal="True" ReloadOnShow="True" style="display:none;z-index:7001" Title="Send mail" 
                VisibleStatusbar="False" Width="960px">
            </telerik:RadWindow>
        </Windows>
        
    </telerik:RadWindowManager>
   <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cboSites">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboConsumers" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnView">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grv"/>
                    <telerik:AjaxUpdatedControl ControlID="ntf" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="mnuDisplayGroup">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboSites" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="grv">
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
</asp:Content>

