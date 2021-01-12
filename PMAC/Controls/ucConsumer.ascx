<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucConsumer.ascx.cs" Inherits="Controls_ucConsumer" %>
<div>
    <div id="popup_panel">
        <ul class="multiple_columns">
            <li class="text_grid_2_columns">
                <asp:Label ID="winAddConsumer_customerId" runat="server" Text="Mã khách hàng"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadComboBox ID="cboConsumers" runat="server" AllowCustomText="True" 
                    AutoPostBack="True" DataSourceID="ConsumersDataSource"
                    DataTextField="ConsumerId" DataValueField="ConsumerId" 
                    EnableLoadOnDemand="True" Filter="StartsWith" 
                    HighlightTemplatedItems="True" 
                    onselectedindexchanged="cboConsumers_SelectedIndexChanged">
                </telerik:RadComboBox>
                <asp:ObjectDataSource ID="ConsumersDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" SelectMethod="GetConsumers" 
                    TypeName="PMAC.BLL.ConsumerBL"></asp:ObjectDataSource>
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAddConsumer_customerName" runat="server" Text="Khách hàng"></asp:Label>:
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
            <telerik:AjaxSetting AjaxControlID="cboConsumers">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboConsumers" />
                    <telerik:AjaxUpdatedControl ControlID="msg" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnDelete">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboConsumers" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                    <telerik:AjaxUpdatedControl ControlID="msg" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
</div>
