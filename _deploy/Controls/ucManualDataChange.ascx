<%@ control language="C#" autoeventwireup="true" inherits="Controls_ucManualDataChange, App_Web_dmjolkrd" %>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript" id="telerikClientEvents1">
            function btnDelete_Clicked(sender, args) {
                var win = $find('<%=winConfirmDelete.ClientID %>');
                win.show();
            }
            function btnCancel_Clicked(sender, args) {
                var win = $find('<%=winConfirmDelete.ClientID %>');
                win.close();
            }
    </script>
    </telerik:RadCodeBlock>
<table class="auto-style1">
            <tr>
                <td>Mã vị trí (alias name):</td>
                <td>
                    <telerik:RadComboBox ID="cboSites" runat="server" OnDataBound="cboSites_DataBound"
                        DataTextField="SiteAliasName" DataValueField="SiteId"
                        DropDownWidth="685px" HighlightTemplatedItems="True" 
                        DataSourceID="SitesDataSource">
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
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetSites" 
                        TypeName="PMAC.BLL.SiteBL"></asp:ObjectDataSource>
                </td>
                <td>Từ ngày:</td>
                <td>

                    <telerik:RadDatePicker ID="dtmStart" runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl="" BackColor="White" TabIndex="-1"></DatePopupButton>
                    </telerik:RadDatePicker>

                </td>
                <td>
                    <telerik:RadButton ID="btnView" runat="server" Text="Xem" 
                        onclick="btnView_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnAdd" runat="server" Text="Sửa" 
                        onclick="btnUpdate_Click">
                    </telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>Đến ngày:&nbsp;</td>
                <td>
                    <telerik:RadDatePicker ID="dtmEnd" runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl="" BackColor="White" TabIndex="-1"></DatePopupButton>
                    </telerik:RadDatePicker>
                </td>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Xóa" 
                        AutoPostBack="False" onclientclicked="btnDelete_Clicked">
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
        <br />
        <telerik:RadGrid ID="grv" runat="server" AutoGenerateColumns="False" >
                <ClientSettings>
                    <Selecting CellSelectionMode="None" />
                </ClientSettings>
            <MasterTableView>
                <CommandItemSettings ExportToPdfText="Export to PDF" />
                <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" 
                    Visible="True">
                </RowIndicatorColumn>
                <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" 
                    Visible="True">
                </ExpandCollapseColumn>
                <Columns>
                    <telerik:GridTemplateColumn ItemStyle-Width="40%" HeaderText="Ghi chú" UniqueName="Description" >
                        <ItemTemplate>
                            <telerik:RadTextBox ID="txtDescription" runat="server" TextMode="MultiLine" TabIndex="-1" Width="100%" Height="44" Text='<%#Bind("Description") %>' ></telerik:RadTextBox>
                        </ItemTemplate>   
                        <ItemStyle Width="50%" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn ItemStyle-Width="20%" HeaderText="Ngày" UniqueName="TimeStamp">
                        <ItemTemplate>
                            <telerik:RadDatePicker ID="dtmTimeStamp" runat="server" Width="100%" Height="44" DbSelectedDate='<%# Bind("TimeStamp") %>'  DatePopupButton-TabIndex="-1" ShowAnimation-Duration="0" ShowAnimation-Type="Fade" HideAnimation-Type="Fade" HideAnimation-Duration="0">
                                <Calendar ID="Calendar1" runat="server" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" 
                                    ViewSelectorText="x">
                                </Calendar>
                                <DateInput ID="DateInput1"  runat="server" DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" 
                                    EnableSingleInputRendering="True" LabelWidth="64px">
                                </DateInput>
                                <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                    
                            </telerik:RadDatePicker>
                        </ItemTemplate>
                        <ItemStyle Width="25%" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn ItemStyle-Width="20%" HeaderText="Chỉ số" UniqueName="Index">
                        <ItemTemplate>
                            <telerik:RadNumericTextBox ID="nmrIndex" Runat="server" NumberFormat-DecimalDigits="0" Width="100%" Height="44"  DbValue='<%# Bind("Index") %>' 
                                 CausesValidation="false" >
                        </telerik:RadNumericTextBox>
                        </ItemTemplate>
                        <ItemStyle Width="25%" />
                    </telerik:GridTemplateColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
                <HeaderStyle BackColor="#25A0DA" BorderColor="#25A0DA" ForeColor="White" />
                <FilterMenu EnableImageSprites="False">
                </FilterMenu>
        </telerik:RadGrid>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow ID="winConfirmDelete" runat="server" Modal="True" 
                VisibleStatusbar="False" Height="150" Width="400" >
                <ContentTemplate>
                    <table style="text-align:center;width:100%" cellpadding="5">
                        <tr>
                            <td>
                                Bạn có chắc muốn xóa dữ liệu không?
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadButton ID="btnConfim" runat="server" OnClick="btnConfim_Click" Text="Xóa">
                                </telerik:RadButton>
                                <telerik:RadButton ID="btnCancel" runat="server" OnClientClicked="btnCancel_Clicked"
                                    Text="Hủy thao tác" AutoPostBack="False">
                                </telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadNotification ID="ntf" runat="server" Title="Message" >
    </telerik:RadNotification>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnView">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grv" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnConfim">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grv" />
                    <telerik:AjaxUpdatedControl ControlID="ntf" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>