<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="CreateUser.aspx.cs" Inherits="Supervisor_Admin_CreateUser" %>

<%@ Register src="../../Controls/ucConsumer.ascx" tagname="ucConsumer" tagprefix="uc1" %>
<%@ Register Src="~/Controls/ucStaff.ascx" TagPrefix="uc1" TagName="ucStaff" %>
<%@ Register Src="~/Controls/ucConsumer.ascx" TagPrefix="uc2" TagName="ucConsumer" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function btnAddConsumer_Click() {
                var win = $find('<%= winAddConsumer.ClientID %>');
                win.show();
            }

            function btnAddStaff_Click() {
                var win = $find('<%= winAddStaff.ClientID %>');
                win.show();
            }

            function winAddConsumer_Close() {
                var m = $find("<%=RadAjaxManager.GetCurrent(Page).ClientID %>");
                m.ajaxRequest("winAddConsumer_Close");
            }

            function winAddStaff_Close() {
                var m = $find("<%=RadAjaxManager.GetCurrent(Page).ClientID %>");
                m.ajaxRequest("winAddStaff_Close");
            }

            function btnCancel_Click() {
                var win = $find('<%= winConfirmDelete.ClientID %>');
                win.close();
                
            }

            function btnDelete_Click() {
                var win = $find('<%= winConfirmDelete.ClientID %>');
                win.show();
            }
        </script>
    </telerik:RadCodeBlock>
    <%--<div id="title">
        <div id="title_name">Tạo mới người dùng</div>
    </div>--%>
    <h2>
        <asp:Label ID="lbTitle" runat="server" Text="Tạo mới người dùng"></asp:Label>
    </h2>
    <div id="main">
        <div id="grid_2_columns">
            <ul class="multiple_columns">
                <li class="text_grid_2_columns"><asp:Label ID="lbAliasName" runat="server" Text="Ký danh"></asp:Label>:
                </li>
                <li class="control_grid_2_columns">
                    <telerik:RadComboBox ID="cboUsers" runat="server" AllowCustomText="True" 
                        AutoPostBack="True" Filter="StartsWith" HighlightTemplatedItems="True" 
                        DataSourceID="UsersDataSource" DataTextField="Username" 
                        DataValueField="Username" 
                        onselectedindexchanged="cboUsers_SelectedIndexChanged">
                    </telerik:RadComboBox>
                    <asp:ObjectDataSource ID="UsersDataSource" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetUsers" 
                        TypeName="PMAC.BLL.UserBL">
                        <SelectParameters>
                            <asp:Parameter Name="filterConsumerID" Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </li>
                <li class="text_grid_2_columns"><asp:Label ID="lbPassword" runat="server" Text="Mật khẩu"></asp:Label>:
                </li>
                <li class="control_grid_2_columns">
                    <telerik:RadTextBox ID="txtPassword" runat="server">
                    </telerik:RadTextBox>
                </li>
                <li class="text_grid_2_columns"><asp:Label ID="lbEmail" runat="server" Text="Email"></asp:Label>:
                </li>
                <li class="control_grid_2_columns">
                    <telerik:RadTextBox ID="txtEmail" runat="server">
                    </telerik:RadTextBox>
                </li>
                <li class="text_grid_2_columns"><asp:Label ID="lbRole" runat="server" Text="Quyền"></asp:Label>:
                </li>
                <li class="control_grid_2_columns">
                    <telerik:RadComboBox ID="cboRoles" runat="server" 
                        DataSourceID="RolesDataSource" DataTextField="Role" DataValueField="Role" 
                        DropDownWidth="250px" HighlightTemplatedItems="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 160px">
                                        <asp:Label ID="role_header" runat="server" Text="Quyền"></asp:Label>
                                    </td>
                                    <td style="width: 160px">
                                        <asp:Label ID="description_header" runat="server" Text="Mô tả"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width:75px"><%#DataBinder.Eval(Container.DataItem,"Role") %></td>
                                    <td style="width:175px"><%#DataBinder.Eval(Container.DataItem,"Description") %></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    <asp:EntityDataSource ID="RolesDataSource" runat="server" 
                        ConnectionString="name=DBEntities" 
                        DefaultContainerName="DBEntities" EnableFlattening="False" 
                        EntitySetName="t_Roles">
                    </asp:EntityDataSource>
                </li>
                <li class="text_grid_2_columns">
                    <asp:LinkButton ID="btnAddConsumer" runat="server"
                        onclientclick="btnAddConsumer_Click();return false;">
                        <asp:Label ID="lbCustomerId" runat="server" Text="Mã khách hàng"></asp:Label>:
                    </asp:LinkButton>
                </li>
                <li class="control_grid_2_columns">
                    <telerik:RadComboBox ID="cboConsumers" runat="server"  
                        DataSourceID="ConsumersDataSource" DataTextField="ConsumerId" 
                        DataValueField="ConsumerId" HighlightTemplatedItems="True" DropDownWidth="385px">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 160px">
                                        <asp:Label ID="customerId_header" runat="server" Text="Mã KH"></asp:Label>
                                    </td>
                                    <td style="width: 160px">
                                        <asp:Label ID="customer_header" runat="server" Text="Khách hàng"></asp:Label>
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
                <li class="text_grid_2_columns">
                    <asp:LinkButton ID="btnAddStaff" runat="server" CausesValidation="False" 
                        onclientclick="btnAddStaff_Click();return false;">
                        <asp:Label ID="lbStaffId" runat="server" Text="Mã nhân viên"></asp:Label>:
                    </asp:LinkButton>
                </li>
                <li class="control_grid_2_columns">
                    <telerik:RadComboBox ID="cboStaffs" runat="server" 
                        HighlightTemplatedItems="True" DataSourceID="StaffsDataSource" 
                        DataTextField="StaffId" DataValueField="StaffId" DropDownWidth="350">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 160px">
                                        <asp:Label ID="staffID_header" runat="server" Text="Mã NV"></asp:Label>
                                    </td>
                                    <td style="width: 160px">
                                        <asp:Label ID="staff_firstname_header" runat="server" Text="Tên"></asp:Label>
                                    </td>
                                    <td style="width: 160px">
                                        <asp:Label ID="staff_lastname_header" runat="server" Text="Họ"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width:100px"><%#DataBinder.Eval(Container.DataItem,"StaffId") %>
                                    </td>
                                    <td style="width:75px"><%#DataBinder.Eval(Container.DataItem,"FirstName") %>
                                    </td>
                                    <td style="width:150px"><%#DataBinder.Eval(Container.DataItem,"LastName") %>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    
                    <asp:ObjectDataSource ID="StaffsDataSource" runat="server" 
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetStaffs" 
                        TypeName="PMAC.BLL.StaffBL"></asp:ObjectDataSource>
                </li>
                <li class="text_grid_2_columns">
                </li>
                <li class="control_grid_2_columns">
                    <telerik:RadButton ID="btnAdd" runat="server" Text="Thêm/Sửa [A]" AccessKey="A" 
                        onclick="btnAdd_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Xóa" AutoPostBack="false"
                        OnClientClicked="btnDelete_Click">
                    </telerik:RadButton>
                </li>
               
            </ul>
        </div>
          <table style="width:900px">
        <tr>
            <td rowspan="2">
                <telerik:RadListBox ID="listBoxSites" CssClass="RadListBox1" runat="server" Width="250px" Height="160px"

                SelectionMode="Multiple" AllowTransfer="True" TransferToID="listBoxSelectedSites" AutoPostBackOnTransfer="True"

                AllowReorder="True" AutoPostBackOnReorder="True" EnableDragAndDrop="True" DataSourceID="SitesDataSource" DataTextField="SiteAliasName" DataValueField="SiteId">

            </telerik:RadListBox>
                <asp:ObjectDataSource ID="SitesDataSource" runat="server" 
                            OldValuesParameterFormatString="original_{0}" 
                            SelectMethod="GetSitesByDisplayGroup" TypeName="PMAC.BLL.SiteBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="mnuDisplayGroup" Name="displayGroup" 
                                    PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                </asp:ObjectDataSource>
            <telerik:RadListBox ID="listBoxSelectedSites" CssClass="RadListBox2" runat="server" Width="250px" Height="160px"

                SelectionMode="Multiple" AllowReorder="True" AutoPostBackOnReorder="True" EnableDragAndDrop="True"

               >

<ButtonSettings TransferButtons="All"></ButtonSettings>

            </telerik:RadListBox>
            </td>
          
          
        </tr>
       
    </table>
    </div>

    <br />
        <telerik:RadGrid ID="grv" runat="server" AutoGenerateColumns="False" 
                            CellSpacing="0" GridLines="None"
                            AllowSorting="True" >
                            
                            <AlternatingItemStyle HorizontalAlign="Center" />
                            <MasterTableView DataKeyNames="SiteId" ClientDataKeyNames="SiteId">
                              
                           

                                <Columns>
                                  
                                    <telerik:GridBoundColumn DataField="SiteAliasName" 
                                        FilterControlAltText="Filter column13 column" HeaderText="Mã vị trí (alias name)" 
                                        UniqueName="column13">
                                        <ItemStyle HorizontalAlign="Left" />
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







     <telerik:RadMenu ID="mnuDisplayGroup" runat="server" DataFieldID="Group" 
                    DataSourceID="DisplayGroupsDataSource" DataTextField="Description" 
                    DataValueField="Group" Flow="Vertical" 
                    onitemclick="mnuDisplayGroup_ItemClick" Visible="False">
                </telerik:RadMenu>
                <asp:ObjectDataSource ID="DisplayGroupsDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetDisplayGroups" 
                    TypeName="PMAC.BLL.DisplayGroupBL"></asp:ObjectDataSource>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow ID="winAddConsumer" runat="server" 
                Height="400px" Modal="True" ReloadOnShow="True" style="display:none;" 
                Title="Thêm mới khách hàng" VisibleStatusbar="False" Width="400px" OnClientClose="winAddConsumer_Close">
                <ContentTemplate>
                    <uc2:ucConsumer runat="server" ID="ucConsumer" />
                </ContentTemplate>
            </telerik:RadWindow>
            <telerik:RadWindow ID="winAddStaff" runat="server"
                Height="400px" Modal="True" style="display:none;" Title="Thêm mới nhân viên" 
                VisibleStatusbar="False" Width="400px" OnClientClose="winAddStaff_Close">
                <ContentTemplate>
                    <uc1:ucStaff runat="server" ID="ucStaff" />
                </ContentTemplate>
            </telerik:RadWindow>
            <telerik:RadWindow ID="winConfirmDelete" runat="server"  
                Modal="True" ReloadOnShow="True" style="display:none;" Title="Confirm" 
                VisibleStatusbar="False" Height="135px" Width="400px">
                <ContentTemplate>
                    <div style="text-align:center;padding:10px;">
                        <asp:Label ID="lb_user_delete_confirm" runat="server" Text="Bạn có chắc chắn muốn xóa người dùng không?"></asp:Label>
                    </div>
                    <div style="text-align:center;padding:10px;">
                        <telerik:RadButton ID="btnOK" runat="server" Text="Confirm" onclick="btnConfirmDelete_Click">
                        </telerik:RadButton>
                        <telerik:RadButton ID="btnCancel" runat="server" Text="Cancel" AutoPostBack="False" OnClientClicked="btnCancel_Click">
                        </telerik:RadButton>
                    </div>
                </ContentTemplate>
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadNotification ID="ntf" runat="server"  style="clear:left">
    </telerik:RadNotification>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
             <telerik:AjaxSetting AjaxControlID="listBoxSites">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="listBoxSites" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="listBoxSelectedSites" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="listBoxSelectedSites">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="listBoxSites" UpdatePanelCssClass=""/>
                    <telerik:AjaxUpdatedControl ControlID="listBoxSelectedSites" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cboUsers">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboUsers" />
                    <telerik:AjaxUpdatedControl ControlID="txtPassword" />
                    <telerik:AjaxUpdatedControl ControlID="txtEmail" />
                    <telerik:AjaxUpdatedControl ControlID="cboRoles" />
                    <telerik:AjaxUpdatedControl ControlID="cboConsumers" />
                    <telerik:AjaxUpdatedControl ControlID="cboStaffs" />
                    <telerik:AjaxUpdatedControl ControlID="grv" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="ntf" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ntf" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnOK">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboUsers" />
                    <telerik:AjaxUpdatedControl ControlID="txtPassword" />
                    <telerik:AjaxUpdatedControl ControlID="txtEmail" />
                    <telerik:AjaxUpdatedControl ControlID="cboRoles" />
                    <telerik:AjaxUpdatedControl ControlID="cboConsumers" />
                    <telerik:AjaxUpdatedControl ControlID="cboStaffs" />
                    <telerik:AjaxUpdatedControl ControlID="XmlPanel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

           <script type="text/javascript">
            function pageLoad(sender, args) {
                $(function () {
                    $(".riTextBox").each(function () {
                        $(this).removeClass("rfdDecorated");  
                    });
                    $("#ctl00_ContentPlaceHolder1_dtmMeterChanged_dateInput").addClass("riTextBox riDisabled");
                    $("#ctl00$ContentPlaceHolder1$dtmLoggerChanged$dateInput").addClass("riTextBox riDisabled");
                })
            }
        </script>
</asp:Content>

