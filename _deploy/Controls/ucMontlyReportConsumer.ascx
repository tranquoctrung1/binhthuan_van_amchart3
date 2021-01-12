<%@ control language="C#" autoeventwireup="true" inherits="Controls_ucMontlyReportConsumer, App_Web_dmjolkrd" %>
<table class="auto-style1">
            <tr>
                <td>Mã vị trí (tag name):</td>
                <td>
                        <telerik:RadComboBox ID="cboSites" runat="server" AutoPostBack="True" 
                            DataTextField="SiteAliasName" DataValueField="SiteId" OnDataBound="cboSites_DataBound"
                            onselectedindexchanged="cboSites_SelectedIndexChanged" DropDownWidth="685px" HighlightTemplatedItems="True">
                            <HeaderTemplate>
                                <table cellpadding="0" cellspacing="0" style="width:660px">
                                    <tr>
                                        <%--<td style="width:160px">Mã vị trí (tag name)</td>--%>
                                        <td style="width:160px">Alias Name</td>
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
                <td>Mã vị trí (tag name):</td>
                <td>
                    <asp:TextBox ID="txtLocation" runat="server"></asp:TextBox>
                    </td>
                <td>Tháng kế thúc:</td>
                <td>
                        <telerik:RadMonthYearPicker ID="myEnd" runat="server" Culture="en-GB">
<DateInput DisplayDateFormat="MMMM yyyy" DateFormat="MMMM yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl="" BackColor="White"></DatePopupButton>
                        </telerik:RadMonthYearPicker>
                    </td>
                <td>
                    <telerik:RadButton ID="btnExport" runat="server" onclick="btnExport_Click" Text="Export" Width="60px">
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
    <%--<div id="title" style="height:67px">
        <table class="style1" cellpadding="0" cellspacing="0">
            <tr>
                <td width="25%" valign="top">
                    <div style="margin-left:10px; font-size:20px">Dữ liệu logger theo tháng</div></td>
                <td>
                    <div class="div_center">
            <div>
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
                        
                        </telerik:RadButton>
                    </li>
                </ul>
            </div>
        </div>
                </td>
            </tr>
        </table>
    </div>--%>

                <%--<telerik:RadMenu ID="mnuDisplayGroup" runat="server" DataFieldID="Group" 
                    DataSourceID="DisplayGroupsDataSource" DataTextField="Description" 
                    DataValueField="Group" Flow="Vertical" 
                    onitemclick="mnuDisplayGroup_ItemClick" Visible="False">
                </telerik:RadMenu>
                <asp:ObjectDataSource ID="DisplayGroupsDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetDisplayGroups" 
                    TypeName="PMAC.BLL.DisplayGroupBL"></asp:ObjectDataSource>--%>

    <div>
        <%--<div id="main_left">
            <div style="padding:10px;color:White">
                Nhóm hiển thị
            </div>
            <div>
            </div>
        </div>--%>
        <br />
        <telerik:RadGrid ID="grv" runat="server" AutoGenerateColumns="False" 
                            CellSpacing="0" GridLines="None"
                            onitemdatabound="grv_ItemDataBound">
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
                                    <telerik:GridBoundColumn DataField="TimeStamp" DataFormatString="{0:MM-yyyy}"
                                        FilterControlAltText="Filter column3 column" HeaderText="Tháng" 
                                        UniqueName="Time">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SiteAliasName" 
                                        FilterControlAltText="Filter column13 column" HeaderText="Alias Name" 
                                        UniqueName="column13">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </telerik:GridBoundColumn>
                                    <%--<telerik:GridBoundColumn DataField="Location" 
                                        FilterControlAltText="Filter column1 column" HeaderText="Vị trí" 
                                        UniqueName="column1">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </telerik:GridBoundColumn>--%>
                                    <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn column"
                                        HeaderText="Lưu lượng (m3/h)" UniqueName="TemplateColumn">
                                        <HeaderTemplate>
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td colspan="2">
                                                        Lưu lượng (m3/h)
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="50%">
                                                        Max
                                                    </td>
                                                    <td width="50%">
                                                        Min
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="50%">
                                                        <%# DataBinder.Eval(Container.DataItem,"MaxFlowRate", "{0:0.00}") %>
                                                    </td>
                                                    <td width="50%">
                                                        <%# DataBinder.Eval(Container.DataItem, "MinFlowRate", "{0:0.00}")%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="Output" DataFormatString="{0:0.00}"
                                        FilterControlAltText="Filter column2 column" HeaderText="Sản lượng (m3)" 
                                        UniqueName="column2">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                        HeaderText="Áp lực (m)" UniqueName="TemplateColumn1">
                                        <HeaderTemplate>
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td colspan="2">
                                                        Áp lực (m)
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="50%">
                                                        Max
                                                    </td>
                                                    <td width="50%">
                                                        Min
                                                    </td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="50%">
                                                        <%# DataBinder.Eval(Container.DataItem, "MaxPressure", "{0:0.00}")%>
                                                    </td>
                                                    <td width="50%">
                                                        <%# DataBinder.Eval(Container.DataItem, "MinPressure", "{0:0.00}")%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column" 
                                        HeaderText="Trending" UniqueName="lnkColumns">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="lnkChart" runat="server">Đồ thị</asp:HyperLink>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="SiteId" 
                                        FilterControlAltText="Filter SiteId column" HeaderText="SiteId" 
                                        UniqueName="SiteId" Visible="False">
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
        <%--<div id="main_right">
            
        </div>--%>
    </div>
    <telerik:RadNotification ID="ntf" runat="server" >
    </telerik:RadNotification>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow ID="winChart" runat="server"  Height="581px" 
                Modal="True" ReloadOnShow="True" style="display:none;z-index:7001" 
                Title="Đồ thị" VisibleStatusbar="False" Width="1000px" ShowContentDuringLoad="False">
            </telerik:RadWindow>
        </Windows>
        
    </telerik:RadWindowManager>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
        function ShowChartFormMonthly(si, dt, rowIndex) {
            var grid = $find("<%= grv.ClientID %>");
            var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
            grid.get_masterTableView().selectItem(rowControl, true);
            window.radopen("DetailChart.aspx?si=" + si + "&dt=" + dt + "&ty=monthly", "winChart");
            return false;
        }
    </script>
</telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cboSites">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtLocation" />
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