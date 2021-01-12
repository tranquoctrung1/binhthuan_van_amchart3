<%@ control language="C#" autoeventwireup="true" inherits="Controls_ucChannel, App_Web_dmjolkrd" %>
<div>
    <div id="popup_panel">
        <ul class="multiple_columns">
            <li class="text_grid_2_columns">Channel ID:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadComboBox ID="cboChannels" runat="server" AllowCustomText="True" 
                    AutoPostBack="True" DataSourceID="ChannelsDataSource" DataTextField="ChannelId" 
                    DataValueField="ChannelId" EnableLoadOnDemand="True" Filter="StartsWith" 
                    HighlightTemplatedItems="True" 
                    onselectedindexchanged="cboChannels_SelectedIndexChanged">
                </telerik:RadComboBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="cboChannels" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:ObjectDataSource ID="ChannelsDataSource" runat="server" 
                    OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetChannelConfigurationsByLoggerID" 
                    TypeName="PMAC.BLL.ChannelConfigurationBL">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtLoggerID" Name="loggerID" 
                            PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </li>
            <li class="text_grid_2_columns">Mã vị trí (tag name):
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadTextBox ID="txtSiteID" runat="server" Enabled="False">
                </telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txtSiteID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            </li>
            <li class="text_grid_2_columns">Logger ID:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadTextBox ID="txtLoggerID" runat="server" Enabled="False">
                </telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="txtLoggerID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            </li>
            <li class="text_grid_2_columns">Tên channel:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadTextBox ID="txtName" runat="server">
                </telerik:RadTextBox>
            </li>
            <li class="text_grid_2_columns">Đơn vị:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadComboBox ID="cboUnits" runat="server" 
                    DataSourceID="UnitsDataSource" DataTextField="Unit" DataValueField="Unit" 
                    HighlightTemplatedItems="True">
                    <HeaderTemplate>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="width:80px">Đơn vị:</td>
                                <td style="width:80px">Mô tả:</td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="width:80px"><%#DataBinder.Eval(Container.DataItem,"Unit") %></td>
                                <td style="width:80px"><%#DataBinder.Eval(Container.DataItem,"Description") %></td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </telerik:RadComboBox>
                <asp:EntityDataSource ID="UnitsDataSource" runat="server" 
                    ConnectionString="name=DBEntities" 
                    DefaultContainerName="DBEntities" EnableFlattening="False" 
                    EntitySetName="t_Units">
                </asp:EntityDataSource>
            </li>
            <li class="text_grid_2_columns">Kênh áp lực trước:
            </li>
            <li class="control_grid_2_columns">
                <asp:RadioButton ID="rdoPressure1" runat="server" GroupName="channel" />
            </li>
            <li class="text_grid_2_columns">Kênh áp lực sau:
            </li>
            <li class="control_grid_2_columns">
                <asp:RadioButton ID="rdoPressure2" runat="server" GroupName="channel" />
            </li>
            <li class="text_grid_2_columns">Kênh thuận:</li>
            <li class="control_grid_2_columns">
                <asp:RadioButton ID="rdoForward" runat="server" GroupName="channel" />
            </li>
            <li class="text_grid_2_columns">Kênh nghịch:
            </li>
            <li class="control_grid_2_columns">
                <asp:RadioButton ID="rdoReverse" runat="server" GroupName="channel" />
            </li>
            <li class="text_grid_2_columns">Ghi chú:
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
            <telerik:AjaxSetting AjaxControlID="cboChannels">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboChannels" />
                    <telerik:AjaxUpdatedControl ControlID="txtSiteID" />
                    <telerik:AjaxUpdatedControl ControlID="txtLoggerID" />
                    <telerik:AjaxUpdatedControl ControlID="txtName" />
                    <telerik:AjaxUpdatedControl ControlID="cboUnits" />
                    <telerik:AjaxUpdatedControl ControlID="rdoPressure1" />
                    <telerik:AjaxUpdatedControl ControlID="rdoPressure2" />
                    <telerik:AjaxUpdatedControl ControlID="rdoForward" />
                    <telerik:AjaxUpdatedControl ControlID="rdoReverse" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                    <telerik:AjaxUpdatedControl ControlID="msg" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboChannels" />
                    <telerik:AjaxUpdatedControl ControlID="ChannelsDataSource" />
                    <telerik:AjaxUpdatedControl ControlID="msg" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnDelete">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboChannels" />
                    <telerik:AjaxUpdatedControl ControlID="ChannelsDataSource" />
                    <telerik:AjaxUpdatedControl ControlID="txtSiteID" />
                    <telerik:AjaxUpdatedControl ControlID="txtLoggerID" />
                    <telerik:AjaxUpdatedControl ControlID="txtName" />
                    <telerik:AjaxUpdatedControl ControlID="cboUnits" />
                    <telerik:AjaxUpdatedControl ControlID="rdoPressure1" />
                    <telerik:AjaxUpdatedControl ControlID="rdoPressure2" />
                    <telerik:AjaxUpdatedControl ControlID="rdoForward" />
                    <telerik:AjaxUpdatedControl ControlID="rdoReverse" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                    <telerik:AjaxUpdatedControl ControlID="msg" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
</div>