<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucHourly.ascx.cs" Inherits="Controls_Production_ucHourly" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-6">
            <div class="row">
                <div class="col-sm-4">
                    <asp:Label ID="lbAliasName1" runat="server" Text="Mã vị trí (alias name)"></asp:Label>:
                </div>
                <div class="col-sm-6">
                    <telerik:RadComboBox ID="cboSites1" runat="server" AutoPostBack="True" OnDataBound="cboSites_DataBound"
                        DataSourceID="SitesDataSource" DataTextField="SiteAliasName" DataValueField="SiteId"
                        OnSelectedIndexChanged="cboSites_SelectedIndexChanged" DropDownWidth="685px" HighlightTemplatedItems="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0" style="width: 660px">
                                <tr>
                                    <%--<td style="width:160px">Mã vị trí (tag name)</td>--%>
                                    <td style="width: 160px">
                                        <asp:Label ID="aliasname_header1" runat="server" Text="Alias name"></asp:Label>
                                    </td>
                                    <td style="width: 340px">
                                        <asp:Label ID="location_header1" runat="server" Text="Vị trí"></asp:Label>
                                    </td>
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
                    <asp:ObjectDataSource ID="SitesDataSource" runat="server"
                        OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetSitesByDisplayGroup" TypeName="PMAC.BLL.SiteBL">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="mnuDisplayGroup" Name="displayGroup"
                                PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-4">
                    <asp:Label ID="lbStaffId1" runat="server" Text="Mã khách hàng"></asp:Label>:
                </div>
                <div class="col-sm-6">
                    <telerik:RadComboBox ID="cboConsumers1" runat="server" DataSourceID="ConsumersDataSource" DataTextField="ConsumerId" DataValueField="ConsumerId" DropDownWidth="325px" HighlightTemplatedItems="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 100px">
                                        <asp:Label ID="customerId_header1" runat="server" Text="Mã KH"></asp:Label>
                                    </td>
                                    <td style="width: 200px">
                                        <asp:Label ID="customer_header1" runat="server" Text="Khách hàng"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 100px"><%#DataBinder.Eval(Container.DataItem,"ConsumerId") %>
                                    </td>
                                    <td style="width: 200px"><%#DataBinder.Eval(Container.DataItem,"Description") %>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    <asp:ObjectDataSource ID="ConsumersDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetConsumers" TypeName="PMAC.BLL.ConsumerBL"></asp:ObjectDataSource>
                </div>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="row">
                <div class="col-sm-4">

                    <asp:Label ID="lbHourFrom" runat="server" Text="Bắt đầu"></asp:Label>:
                </div>
                <div class="col-sm-6">

                    <telerik:RadDateTimePicker ID="myStart1" runat="server" Culture="en-GB">
                        <TimeView CellSpacing="-1" Culture="en-GB"></TimeView>
                        <TimePopupButton ImageUrl="" HoverImageUrl=""></TimePopupButton>
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True"></Calendar>
                        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                            <EmptyMessageStyle Resize="None"></EmptyMessageStyle>
                            <ReadOnlyStyle Resize="None"></ReadOnlyStyle>
                            <FocusedStyle Resize="None"></FocusedStyle>
                            <DisabledStyle Resize="None"></DisabledStyle>
                            <InvalidStyle Resize="None"></InvalidStyle>
                            <HoveredStyle Resize="None"></HoveredStyle>
                            <EnabledStyle Resize="None"></EnabledStyle>
                        </DateInput>
                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    </telerik:RadDateTimePicker>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-4">
                    <asp:Label ID="lbHourTo" runat="server" Text="Kết thúc"></asp:Label>:
                </div>

                <div class="col-sm-6">
                    <telerik:RadDateTimePicker ID="myEnd1" runat="server" Culture="en-GB">
                        <TimeView CellSpacing="-1" Culture="en-GB"></TimeView>
                        <TimePopupButton ImageUrl="" HoverImageUrl=""></TimePopupButton>
                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True"></Calendar>
                        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">
                            <EmptyMessageStyle Resize="None"></EmptyMessageStyle>
                            <ReadOnlyStyle Resize="None"></ReadOnlyStyle>
                            <FocusedStyle Resize="None"></FocusedStyle>
                            <DisabledStyle Resize="None"></DisabledStyle>
                            <InvalidStyle Resize="None"></InvalidStyle>
                            <HoveredStyle Resize="None"></HoveredStyle>
                            <EnabledStyle Resize="None"></EnabledStyle>
                        </DateInput>
                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    </telerik:RadDateTimePicker>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="rowGrid" style="padding: 20px 0px 0px 0px">

    <telerik:RadButton ID="btnView1" runat="server" Text="Xem"
        OnClick="btnView_Click" Width="60px">
    </telerik:RadButton>
    <telerik:RadButton ID="btnExport1" runat="server" OnClick="btnExport_Click" Text="Export" Width="60px">
    </telerik:RadButton>
    <telerik:RadButton ID="btnMail1" runat="server" AutoPostBack="False" OnClientClicked="btnMail_Click" Text="Mail">
    </telerik:RadButton>

</div>

<br />
<telerik:RadMenu ID="mnuDisplayGroup" runat="server" DataFieldID="Group"
    DataSourceID="DisplayGroupsDataSource" DataTextField="Description"
    DataValueField="Group" Flow="Vertical"
    OnItemClick="mnuDisplayGroup_ItemClick" Visible="False">
</telerik:RadMenu>
<asp:ObjectDataSource ID="DisplayGroupsDataSource" runat="server"
    OldValuesParameterFormatString="original_{0}" SelectMethod="GetDisplayGroups"
    TypeName="PMAC.BLL.DisplayGroupBL"></asp:ObjectDataSource>

<telerik:RadGrid ID="grv1" runat="server" AutoGenerateColumns="False"
    CellSpacing="0" GridLines="None">
    <ClientSettings>
        <Selecting CellSelectionMode="None" />
    </ClientSettings>
    <AlternatingItemStyle HorizontalAlign="Center" />
    <MasterTableView>
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
            <telerik:GridBoundColumn DataField="TimeStamp" DataFormatString="{0:dd-MM-yyyy HH:mm}"
                FilterControlAltText="Filter column3 column" HeaderText="Thời điểm"
                UniqueName="Time">
            </telerik:GridBoundColumn>

            <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn column"
                HeaderText="Chỉ số đầu" UniqueName="TemplateColumn">
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                        <tr style="width: 100%">
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "StartIndex", "{0:0.00}")%>
                            </td>
                        </tr>
                        <tr style="width: 100%">
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "TimeStamp", "{0:dd/MM/yyyy HH:mm}")%>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                HeaderText="Chỉ số cuối" UniqueName="TemplateColumn1">
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                        <tr style="width: 100%">
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "EndIndex", "{0:0.00}")%>
                            </td>
                        </tr>
                        <tr style="width: 100%">
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "EndTime", "{0:dd/MM/yyyy HH:mm}")%>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
            <telerik:GridBoundColumn
                FilterControlAltText="Filter column column" HeaderText="Sản lượng" DataFormatString="{0:0.00}"
                UniqueName="column" DataField="Value">
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

<telerik:RadNotification ID="ntf" runat="server">
</telerik:RadNotification>

<telerik:RadWindowManager ID="RadWindowManager1" runat="server">
    <Windows>
        <telerik:RadWindow ID="winChart" runat="server" Height="581px"
            Modal="True" ReloadOnShow="True" Style="display: none; z-index: 7001"
            Title="Chart" VisibleStatusbar="False" Width="1000px" ShowContentDuringLoad="False">
        </telerik:RadWindow>
        <telerik:RadWindow ID="winMail" runat="server" Height="540px"
            Modal="True" ReloadOnShow="True" Style="display: none; z-index: 7001" Title="Send mail"
            VisibleStatusbar="False" Width="960px">
        </telerik:RadWindow>
    </Windows>

</telerik:RadWindowManager>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="cboSites1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cboConsumers1" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnView1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="grv1" />
                <telerik:AjaxUpdatedControl ControlID="ntf" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="mnuDisplayGroup">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cboSites" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="grv1">
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
