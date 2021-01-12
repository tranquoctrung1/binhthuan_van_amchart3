<%@ control language="C#" autoeventwireup="true" inherits="Controls_ucDisplayGroup, App_Web_dmjolkrd" %>
<div>
    <div id="popup_panel">
        <ul class="multiple_columns">
            <li class="text_grid_2_columns">Nhóm hiển thị:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadComboBox ID="cboDisplayGroups" runat="server" AllowCustomText="True" 
                    AutoPostBack="True" DataSourceID="DisplayGroupsDataSource" 
                    DataTextField="Group" DataValueField="Group" 
                    EnableLoadOnDemand="True" Filter="StartsWith" 
                    HighlightTemplatedItems="True" 
                    onselectedindexchanged="cboDisplayGroups_SelectedIndexChanged">
                </telerik:RadComboBox>
                <asp:ObjectDataSource ID="DisplayGroupsDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetDisplayGroups" 
                    TypeName="PMAC.BLL.DisplayGroupBL"></asp:ObjectDataSource>
            </li>
            <li class="text_grid_2_columns">Mô tả:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadTextBox ID="txtDescription" runat="server">
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
            <telerik:AjaxSetting AjaxControlID="cboDisplayGroups">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboDisplayGroups" />
                    <telerik:AjaxUpdatedControl ControlID="msg" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnDelete">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboDisplayGroups" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                    <telerik:AjaxUpdatedControl ControlID="msg" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
</div>