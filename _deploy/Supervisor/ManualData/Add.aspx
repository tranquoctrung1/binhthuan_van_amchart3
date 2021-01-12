<%@ page title="" language="C#" masterpagefile="~/Supervisor/MasterPage.master" autoeventwireup="true" inherits="Supervisor_ManualData_Add, App_Web_pbfu3lyk" theme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<div id="title">
        <div id="title_name">Nhập tay chỉ số
        </div>
        <div id="title_panel">
            <ul class="multiple_columns">
                <li class="text_grid_5_columns">Mã vị trí (tag name):
                </li>
                <li class="control_grid_5_columns">
                </li>
                <li class="text_grid_3_columns">
                </li>
            </ul>
        </div>
    </div>--%>
    <h2>Nhập tay chỉ số</h2>
    
        <table class="auto-style1">
            <tr>
                <td>Mã vị trí (alias name):</td>
                <td>
                    <telerik:RadComboBox ID="cboSites" runat="server" AutoPostBack="True" 
                        DataTextField="SiteAliasName" DataValueField="SiteId" OnDataBound="cboSites_DataBound"
                        DropDownWidth="685px" HighlightTemplatedItems="True" 
                        onselectedindexchanged="cboSites_SelectedIndexChanged">
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
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <telerik:RadButton ID="btnAdd" runat="server" Text="Cập nhật" 
                        onclick="btnAdd_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnClear" runat="server" Text="Xóa hiển thị" 
                        onclick="btnClear_Click">
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
                            <telerik:RadNumericTextBox ID="nmrIndex" Runat="server" NumberFormat-DecimalDigits="0" Width="100%" Height="44"  DbValue='<%# Bind("Index") %>' AutoPostBack="true"
                                OnTextChanged="nmrIndex_TextChanged" CausesValidation="false" >
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
    <telerik:RadNotification ID="ntf" runat="server"  Title="Message">
    </telerik:RadNotification>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ntf" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnClear">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grv" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
</asp:Content>

