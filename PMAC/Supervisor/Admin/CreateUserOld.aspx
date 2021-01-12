<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="CreateUserOld.aspx.cs" Inherits="Supervisor_Admin_CreateUser" %>

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
    <h2>Create user</h2>
    <div id="main">
        <div id="grid_2_columns">
            <ul class="multiple_columns">
                <li class="text_grid_2_columns">User:
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
                <li class="text_grid_2_columns">Password:
                </li>
                <li class="control_grid_2_columns">
                    <telerik:RadTextBox ID="txtPassword" runat="server">
                    </telerik:RadTextBox>
                </li>
                <li class="text_grid_2_columns">Email:
                </li>
                <li class="control_grid_2_columns">
                    <telerik:RadTextBox ID="txtEmail" runat="server">
                    </telerik:RadTextBox>
                </li>
                <li class="text_grid_2_columns">Role:
                </li>
                <li class="control_grid_2_columns">
                    <telerik:RadComboBox ID="cboRoles" runat="server" 
                        DataSourceID="RolesDataSource" DataTextField="Role" DataValueField="Role" 
                        DropDownWidth="250px" HighlightTemplatedItems="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width:75px">Role</td>
                                    <td style="width:175px">Description</td>
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
                        onclientclick="btnAddConsumer_Click();return false;">ConsumerId:</asp:LinkButton>
                </li>
                <li class="control_grid_2_columns">
                    <telerik:RadComboBox ID="cboConsumers" runat="server"  
                        DataSourceID="ConsumersDataSource" DataTextField="ConsumerId" 
                        DataValueField="ConsumerId" HighlightTemplatedItems="True" DropDownWidth="385px">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width:160px">ConsumerID
                                    </td>
                                    <td style="width:200px">Consumer name
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
                        onclientclick="btnAddStaff_Click();return false;">StaffId:</asp:LinkButton>
                </li>
                <li class="control_grid_2_columns">
                    <telerik:RadComboBox ID="cboStaffs" runat="server" 
                        HighlightTemplatedItems="True" DataSourceID="StaffsDataSource" 
                        DataTextField="StaffId" DataValueField="StaffId" DropDownWidth="350">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width:100px">Staff ID
                                    </td>
                                    <td style="width:75px">First Name
                                    </td>
                                    <td style="width:150px">Last Name
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
                    <telerik:RadButton ID="btnAdd" runat="server" Text="Add/Edit [A]" AccessKey="A" 
                        onclick="btnAdd_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" AutoPostBack="false"
                        OnClientClicked="btnDelete_Click">
                    </telerik:RadButton>
                </li>
            </ul>
        </div>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
        <Windows>
            <telerik:RadWindow ID="winAddConsumer" runat="server" 
                Height="400px" Modal="True" ReloadOnShow="True" style="display:none;" 
                Title="Add Consumer" VisibleStatusbar="False" Width="400px" OnClientClose="winAddConsumer_Close">
                <ContentTemplate>
                    <uc2:ucConsumer runat="server" ID="ucConsumer" />
                </ContentTemplate>
            </telerik:RadWindow>
            <telerik:RadWindow ID="winAddStaff" runat="server"
                Height="400px" Modal="True" style="display:none;" Title="Add Staff" 
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
                        Are you delete?
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
            <telerik:AjaxSetting AjaxControlID="cboUsers">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboUsers" />
                    <telerik:AjaxUpdatedControl ControlID="txtPassword" />
                    <telerik:AjaxUpdatedControl ControlID="txtEmail" />
                    <telerik:AjaxUpdatedControl ControlID="cboRoles" />
                    <telerik:AjaxUpdatedControl ControlID="cboConsumers" />
                    <telerik:AjaxUpdatedControl ControlID="cboStaffs" />
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
</asp:Content>

