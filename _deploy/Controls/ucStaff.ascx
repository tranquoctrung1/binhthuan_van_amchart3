<%@ control language="C#" autoeventwireup="true" inherits="Controls_ucStaff, App_Web_dmjolkrd" %>
<div>
    <div id="popup_panel">
        <ul class="multiple_columns">
            <li class="text_grid_2_columns">Mã nhân viên:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadComboBox ID="cboStaffs" runat="server" AllowCustomText="True"
                    AutoPostBack="True" DataSourceID="StaffsDataSource" DataTextField="StaffId" 
                    DataValueField="StaffId" EnableLoadOnDemand="True" Filter="StartsWith" 
                    HighlightTemplatedItems="True" 
                    onselectedindexchanged="cboStaffs_SelectedIndexChanged">
                </telerik:RadComboBox>
                <asp:ObjectDataSource ID="StaffsDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetStaffs" 
                    TypeName="PMAC.BLL.StaffBL"></asp:ObjectDataSource>
            </li>
            <li class="text_grid_2_columns">Tên:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadTextBox ID="txtFirstName" runat="server">
                </telerik:RadTextBox>
            </li>
            <li class="text_grid_2_columns">Họ:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadTextBox ID="txtLastName" runat="server">
                </telerik:RadTextBox>
            </li>
            <li class="text_grid_2_columns">Địa chỉ
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadTextBox ID="txtAddress" runat="server">
                </telerik:RadTextBox>
            </li>
            <li class="text_grid_2_columns">Số điện thoại:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadTextBox ID="txtTel" runat="server">
                </telerik:RadTextBox>
            </li>
            <li class="text_grid_2_columns">
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadButton ID="btnAdd" runat="server" Text="Thêm/Sửa"
                    onclick="btnAdd_Click">
                </telerik:RadButton>
                <telerik:RadButton ID="btnDelete" runat="server" Text="Xóa"
                    onclick="btnDelete_Click">
                </telerik:RadButton>
            </li>
        </ul>
    </div>
    <div align="center">
        <asp:Label ID="msg" runat="server" Text="" CssClass="msg" ></asp:Label>
    </div>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cboStaffs">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtFirstName" />
                    <telerik:AjaxUpdatedControl ControlID="txtLastName" />
                    <telerik:AjaxUpdatedControl ControlID="txtAddress" />
                    <telerik:AjaxUpdatedControl ControlID="txtTel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboStaffs" />
                    <telerik:AjaxUpdatedControl ControlID="msg" />
                    <telerik:AjaxUpdatedControl ControlID="StaffsDataSource" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnDelete">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboStaffs" />
                    <telerik:AjaxUpdatedControl ControlID="txtFirstName" />
                    <telerik:AjaxUpdatedControl ControlID="txtLastName" />
                    <telerik:AjaxUpdatedControl ControlID="txtAddress" />
                    <telerik:AjaxUpdatedControl ControlID="txtTel" />
                    <telerik:AjaxUpdatedControl ControlID="msg" />
                    <telerik:AjaxUpdatedControl ControlID="StaffsDataSource" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
</div>