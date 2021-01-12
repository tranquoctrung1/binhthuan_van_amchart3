<%@ page title="" language="C#" masterpagefile="~/Supervisor/MasterPage.master" autoeventwireup="true" inherits="Supervisor_Admin_ViewUsers, App_Web_ayfbeluo" theme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<div id="title"><div id="title_name">Giám sát người dùng</div>
    </div>--%>
    <h2>Xem người dùng</h2>
    <div id="main">
        <div id="view_user_filter_wrapper">
    <ul class="multiple_columns" >
        <li class="text_view_user_filter">
            Lọc theo mã khách hàng: 
        </li>
        <li class="control_view_user_filter">
            <telerik:RadComboBox ID="cboConsumers" Runat="server" DropDownWidth="385px" 
                DataSourceID="ConsumersDataSource" DataTextField="ConsumerId" 
                DataValueField="ConsumerId" AutoPostBack="True" HighlightTemplatedItems="True">
                <HeaderTemplate>
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="width:160px">Mã KH
                            </td>
                            <td style="width:200px">Khách hàng
                            </td>
                        </tr>
                    </table>
                </HeaderTemplate>
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="width:160px"><%#DataBinder.Eval(Container.DataItem,"ConsumerId") %>
                            </td>
                            <td style="width:200px"><%#DataBinder.Eval(Container.DataItem,"Description") %>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </telerik:RadComboBox>
            <asp:ObjectDataSource ID="ConsumersDataSource" runat="server" 
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetConsumers" 
                TypeName="PMAC.BLL.ConsumerBL"></asp:ObjectDataSource>
        </li>
    </ul>
</div>
<div style="clear:both">
    <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="0" 
    DataSourceID="UsersDataSource" GridLines="None" AutoGenerateColumns="False">
<MasterTableView DataSourceID="UsersDataSource">
<CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

<RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>

    <Columns>
        <telerik:GridBoundColumn DataField="Username" 
            FilterControlAltText="Filter Username column" HeaderText="Ký danh" 
            SortExpression="Username" UniqueName="Username">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="StaffId" 
            FilterControlAltText="Filter StaffId column" HeaderText="Mã nhân viên" 
            SortExpression="StaffId" UniqueName="StaffId">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="ConsumerId" 
            FilterControlAltText="Filter ConsumerId column" HeaderText="Mã khách hàng" 
            SortExpression="ConsumerId" UniqueName="ConsumerId">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Email" 
            FilterControlAltText="Filter Email column" HeaderText="Email" 
            SortExpression="Email" UniqueName="Email">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Role" 
            FilterControlAltText="Filter Role column" HeaderText="Quyền" 
            SortExpression="Role" UniqueName="Role">
        </telerik:GridBoundColumn>
        <telerik:GridCheckBoxColumn DataField="Active" DataType="System.Boolean" 
            FilterControlAltText="Filter Active column" HeaderText="Hoạt động" 
            SortExpression="Active" UniqueName="Active">
        </telerik:GridCheckBoxColumn>
        <telerik:GridBoundColumn DataField="TimeStamp" DataType="System.DateTime" DataFormatString="{0:dd/MM/yyyy hh:mm:ss tt}"
            FilterControlAltText="Filter TimeStamp column" HeaderText="Online" 
            SortExpression="TimeStamp" UniqueName="TimeStamp">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Ip" FilterControlAltText="Filter Ip column" 
            HeaderText="Ip" SortExpression="Ip" UniqueName="Ip">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="LoginTime" DataType="System.Int32" 
            FilterControlAltText="Filter LoginTime column" HeaderText="Số lần đăng nhập" 
            SortExpression="LoginTime" UniqueName="LoginTime">
        </telerik:GridBoundColumn>
    </Columns>

<EditFormSettings>
<EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
</EditFormSettings>
</MasterTableView>

<FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>
<asp:ObjectDataSource ID="UsersDataSource" runat="server" 
    OldValuesParameterFormatString="original_{0}" SelectMethod="GetUsers" 
    TypeName="PMAC.BLL.UserBL">
    <SelectParameters>
        <asp:ControlParameter ControlID="cboConsumers" Name="filterConsumerID" 
            PropertyName="SelectedValue" Type="String" />
    </SelectParameters>
    </asp:ObjectDataSource>
</div>
    </div>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cboConsumers">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
</asp:Content>

