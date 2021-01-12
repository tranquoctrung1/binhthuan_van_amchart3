<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucDailyReportConsumer.ascx.cs" Inherits="Controls_ucDailyReportConsumer" %>
<table class="auto-style1">
    <tr>
        <td>
            <asp:Label ID="lbTagName" runat="server" Text="Mã vị trí (alias name)"></asp:Label>:
        </td>
        <td>
            <telerik:RadComboBox ID="cboSites" runat="server" AutoPostBack="True"
                DataTextField="SiteAliasName" DataValueField="SiteId" OnDataBound="cboSites_DataBound"
                OnSelectedIndexChanged="cboSites_SelectedIndexChanged" DropDownWidth="685px" HighlightTemplatedItems="True">
                <HeaderTemplate>
                    <table cellpadding="0" cellspacing="0" style="width: 660px">
                        <tr>
                            <%--<td style="width:160px">Mã vị trí (tag name)</td>--%>
                            <td style="width: 160px">Alias name</td>
                            <td style="width: 340px">Vị trí</td>
                        </tr>
                    </table>
                </HeaderTemplate>
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" style="width: 660px">
                        <tr>
                            <%--<td style="width:160px"><%#DataBinder.Eval(Container.DataItem,"SiteId") %></td>--%>
                            <td style="width: 160px"><%#DataBinder.Eval(Container.DataItem,"SiteAliasName") %></td>
                            <td style="width: 340px"><%#DataBinder.Eval(Container.DataItem,"Location") %></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </telerik:RadComboBox>

        </td>
        <td>
            <asp:Label ID="lbFrom" runat="server" Text="Từ ngày"></asp:Label>:
        </td>
        <td>
            <telerik:RadDatePicker ID="dtmStart" runat="server" Culture="en-GB">
                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

                <DatePopupButton ImageUrl="" HoverImageUrl="" ForeColor="White" BackColor="White"></DatePopupButton>
            </telerik:RadDatePicker>
        </td>
        <td>
            <telerik:RadButton ID="btnView" runat="server" Text="Xem"
                OnClick="btnView_Click" Width="60px">
            </telerik:RadButton>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lbLocation" runat="server" Text="Vị trí"></asp:Label>:
        </td>
        <td>
            <asp:TextBox ID="txtLocation" runat="server"></asp:TextBox>
        </td>
        <td>
            <asp:Label ID="lbTo" runat="server" Text="Đến ngày"></asp:Label>:
        </td>
        <td>
            <telerik:RadDatePicker ID="dtmEnd" runat="server" Culture="en-GB">
                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

                <DatePopupButton ImageUrl="" HoverImageUrl="" ForeColor="White" BackColor="White"></DatePopupButton>
            </telerik:RadDatePicker>
        </td>
        <td>
            <telerik:RadButton ID="btnExport" runat="server" Text="Export"
                Width="60px" OnClick="btnExport_Click">
            </telerik:RadButton>
        </td>
    </tr>
</table>
<br />
<telerik:RadGrid ID="grv" runat="server" AutoGenerateColumns="False"
    CellSpacing="0" GridLines="None" ShowFooter="True"
    OnItemDataBound="grv_ItemDataBound">
    <ClientSettings>
        <Selecting CellSelectionMode="None" />
    </ClientSettings>
    <ExportSettings>
        <Excel Format="Biff" />
    </ExportSettings>
    <AlternatingItemStyle HorizontalAlign="Center" />
    <MasterTableView DataKeyNames="SiteId" ClientDataKeyNames="SiteId">
        <CommandItemSettings ExportToPdfText="Export to PDF" />
        <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
            <HeaderStyle Width="20px" />
        </RowIndicatorColumn>
        <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column"
            Visible="True" Created="True">
            <HeaderStyle Width="20px" />
        </ExpandCollapseColumn>
        <Columns>
            <telerik:GridBoundColumn DataField="TimeStamp" DataFormatString="{0:dd/MM/yyyy}"
                FilterControlAltText="Filter column3 column" HeaderText="Ngày"
                UniqueName="Time">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="SiteAliasName"
                FilterControlAltText="Filter column13 column" HeaderText="Alias Name"
                UniqueName="column13">
                <ItemStyle HorizontalAlign="Left" />
            </telerik:GridBoundColumn>

            <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn column"
                HeaderText="Lưu lượng (m3/h)" UniqueName="TemplateColumn">
                <HeaderTemplate>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan="2">Lưu lượng (m3/h)
                            </td>
                        </tr>
                        <tr>
                            <td width="50%">Max
                            </td>
                            <td width="50%">Min
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
                UniqueName="Output" Aggregate="Sum" FooterAggregateFormatString="Tổng: {0:0.00} [m3]">
            </telerik:GridBoundColumn>
            <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                HeaderText="Áp lực (m)" UniqueName="TemplateColumn1">
                <HeaderTemplate>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan="2">Áp lực (m)
                            </td>
                        </tr>
                        <tr>
                            <td width="50%">Max
                            </td>
                            <td width="50%">Min
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
                HeaderText="Trending" UniqueName="lnkColumn">
                <ItemTemplate>
                    <asp:HyperLink ID="lnkChart" runat="server">Đồ thị</asp:HyperLink>
                    |
                                            <asp:HyperLink ID="lnkTable" runat="server">Bảng</asp:HyperLink>
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

        <PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>
    </MasterTableView>
    <HeaderStyle BackColor="#25A0DA" ForeColor="White" HorizontalAlign="Center" />
    <FooterStyle BackColor="#25A0DA" ForeColor="White" HorizontalAlign="Center" />
    <ItemStyle HorizontalAlign="Center" />

    <PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>

    <FilterMenu EnableImageSprites="False">
    </FilterMenu>
</telerik:RadGrid>

<telerik:RadNotification ID="ntf" runat="server">
</telerik:RadNotification>
<telerik:RadWindowManager ID="RadWindowManager1" runat="server">
    <Windows>
        <telerik:RadWindow ID="winTable" runat="server" Height="540px"
            Modal="True" ReloadOnShow="True" Style="display: none; z-index: 7001"
            Title="Bảng dữ liệu chi tiết" VisibleStatusbar="False" Width="960px" ShowContentDuringLoad="False">
        </telerik:RadWindow>
        <telerik:RadWindow ID="winChart" runat="server" Height="581px"
            Modal="True" ReloadOnShow="True" Style="display: none; z-index: 7001"
            Title="Chart" VisibleStatusbar="False" Width="1000px" ShowContentDuringLoad="False">
        </telerik:RadWindow>
    </Windows>
</telerik:RadWindowManager>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
        function ShowTableForm(si, dt, rowIndex) {
            var grid = $find("<%= grv.ClientID %>");
            var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
            grid.get_masterTableView().selectItem(rowControl, true);
            window.radopen("DetailTable.aspx?si=" + si + "&dt=" + dt, "winTable");
            return false;
        }
        function ShowChartFormDaily(si, dt, uid, rowIndex) {
            var grid = $find("<%= grv.ClientID %>");
            var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
            grid.get_masterTableView().selectItem(rowControl, true);
            window.radopen("DetailChart_rev1.aspx?si=" + si + "&dt=" + dt + "&uid=" + uid + "&ty=daily", "winChart");
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
                <telerik:AjaxUpdatedControl ControlID="grv" />
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
