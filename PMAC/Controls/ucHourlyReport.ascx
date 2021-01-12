<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucHourlyReport.ascx.cs" Inherits="Controls_ucHourlyReport" %>
<style type="text/css">
    .auto-style1 {
        width: 100%;
    }
</style>

<table class="auto-style1">
    <tr>
        <td>Mã vị trí (Alias name):</td>
        <td>
            <telerik:RadComboBox ID="cboSites" runat="server" DataSourceID="SitesDataSource1" DropDownWidth="685px" HighlightTemplatedItems="True" DataTextField="SiteAliasName" DataValueField="SiteId" OnSelectedIndexChanged="cboSites_SelectedIndexChanged">
                <HeaderTemplate>
                    <table cellpadding="0" cellspacing="0" class="auto-style1">
                        <tr>
                            <td style="width: 160px">Alias name</td>
                            <td style="width: 340px">Vị trí</td>
                        </tr>
                    </table>
                </HeaderTemplate>
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" class="auto-style1">
                        <tr>
                            <td style="width: 160px"><%#DataBinder.Eval(Container.DataItem,"SiteAliasName") %></td>
                            <td style="width: 340px"><%#DataBinder.Eval(Container.DataItem,"Location") %></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </telerik:RadComboBox>
        </td>
        <td>Từ:</td>
        <td>
            <telerik:RadDateTimePicker ID="dtStart" runat="server" Culture="en-GB">
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
        </td>
        <td>
            <asp:Button ID="btnView" runat="server" Text="Xem" Width="56px" OnClick="btnView_Click" />
        </td>
    </tr>
    <tr>
        <td>Mã khách hàng:</td>
        <td>
            <telerik:RadComboBox ID="cboConsumers" runat="server" DropDownWidth="325px" DataSourceID="ConsumersDataSource1" DataTextField="ConsumerId" DataValueField="ConsumerId">
                <HeaderTemplate>
                    <table cellpadding="0" cellspacing="0" class="auto-style1">
                        <tr>
                            <td style="width: 100px">Mã KH</td>
                            <td style="width: 200px">Khách hàng</td>
                        </tr>
                    </table>
                </HeaderTemplate>
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" class="auto-style1">
                        <tr>
                            <td style="width: 100px"><%#DataBinder.Eval(Container.DataItem,"ConsumerId") %></td>
                            <td style="width: 200px"><%#DataBinder.Eval(Container.DataItem,"Description") %></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </telerik:RadComboBox>
        </td>
        <td>Đến:</td>
        <td>
            <telerik:RadDateTimePicker ID="dtEnd" runat="server" Culture="en-GB">
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
        </td>
        <td>
            <asp:Button ID="btnExport" runat="server" Text="Export" OnClick="btnExport_Click" />
        </td>
    </tr>
</table>
<br />
<telerik:RadGrid ID="grv" runat="server" AutoGenerateColumns="False" CellSpacing="0" GridLines="None" ShowFooter="true">
    <MasterTableView>
        <Columns>
            <telerik:GridBoundColumn Visible="false" DataField="SiteID" FilterControlAltText="Filter column column" HeaderText="Mã vị trí" UniqueName="column">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="TimeStamp" DataFormatString="{0:dd/MM/yyyy HH:mm}" FilterControlAltText="Filter column4 column" HeaderText="Ngày giờ" UniqueName="column4" FooterText="Tổng sản lượng">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="SiteAliasName" FilterControlAltText="Filter column1 column" HeaderText="Alias Name" UniqueName="column1">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="Location" FilterControlAltText="Filter column2 column" HeaderText="Vị trí" UniqueName="column2">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn Visible="false" DataField="LoggerId" FilterControlAltText="Filter column3 column" HeaderText="LoggerId" UniqueName="column3">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn FilterControlAltText="Filter column4 column" HeaderText="" UniqueName="columnz" Visible="false">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="ForwardFlow" Aggregate="Sum" FooterAggregateFormatString="{0:0.00} [m3]" DataFormatString="{0:0.0}" FilterControlAltText="Filter column6 column" UniqueName="column6" HeaderText="Lưu lượng thuận">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="ReverseFlow" Aggregate="Sum" FooterAggregateFormatString="{0:0.00} [m3]" FilterControlAltText="Filter column7 column" HeaderText="Lưu lượng nghịch" UniqueName="column7" DataFormatString="{0:0.0}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="ForwardIndex" FilterControlAltText="Filter column8 column" HeaderText="Chỉ số thuận" UniqueName="column8" DataFormatString="{0:0,0}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="ReverseIndex" FilterControlAltText="Filter column9 column" HeaderText="Chỉ số nghịch" UniqueName="column9" DataFormatString="{0:0,0}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="Pressure1" FilterControlAltText="Filter column10 column" HeaderText="Áp lực 1" UniqueName="column10" DataFormatString="{0:0.0}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn DataField="Pressure2" FilterControlAltText="Filter column11 column" HeaderText="Áp lực 2" UniqueName="column11" DataFormatString="{0:0.0}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn Visible="false" DataField="MinForwardFlow" FilterControlAltText="Filter column12 column" HeaderText="Min LL Thuận" UniqueName="column12" DataFormatString="{0:0.0}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn Visible="false" DataField="MaxForwardFlow" FilterControlAltText="Filter column13 column" HeaderText="Max LL Thuận" UniqueName="column13" DataFormatString="{0:0.0}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn Visible="false" DataField="MinReverseFlow" FilterControlAltText="Filter column14 column" HeaderText="Min LL Nghịch" UniqueName="column14" DataFormatString="{0:0.0}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn Visible="false" DataField="MaxReverseFlow" FilterControlAltText="Filter column15 column" HeaderText="Max LL Nghịch" UniqueName="column15" DataFormatString="{0:0.0}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn Visible="false" DataField="MinPressure1" FilterControlAltText="Filter column16 column" HeaderText="Min Áp lực trước" UniqueName="column16" DataFormatString="{0:0.0}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn Visible="false" DataField="MaxPressure1" FilterControlAltText="Filter column17 column" HeaderText="Max Áp lực trước" UniqueName="column17" DataFormatString="{0:0.0}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn Visible="false" DataField="MinPressure2" FilterControlAltText="Filter column18 column" HeaderText="Min Áp lực sau" UniqueName="column18" DataFormatString="{0:0.0}">
            </telerik:GridBoundColumn>
            <telerik:GridBoundColumn Visible="false" DataField="MaxPressure2" FilterControlAltText="Filter column19 column" HeaderText="Max Áp lực sau" UniqueName="column19" DataFormatString="{0:0.0}">
            </telerik:GridBoundColumn>
        </Columns>
    </MasterTableView>
    <FooterStyle BackColor="#25A0DA" ForeColor="White" HorizontalAlign="Center" />
</telerik:RadGrid>

<asp:ObjectDataSource ID="SitesDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSites" TypeName="PMAC.BLL.SiteBL"></asp:ObjectDataSource>


<asp:ObjectDataSource ID="ConsumersDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetConsumers" TypeName="PMAC.BLL.ConsumerBL"></asp:ObjectDataSource>



<telerik:RadNotification ID="rNotification1" runat="server">
</telerik:RadNotification>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="cboSites">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="cboConsumers" UpdatePanelCssClass="" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnView">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="grv" UpdatePanelCssClass="" />
                <telerik:AjaxUpdatedControl ControlID="rNotification1" UpdatePanelCssClass="" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>



