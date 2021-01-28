<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucChannel.ascx.cs" Inherits="Controls_ucChannel" %>
<div>
    <div id="popup_panel">
        <ul class="multiple_columns">
            <li class="text_grid_2_columns">
                <asp:Label ID="winAddChannel_channelId" runat="server" Text="Channel ID"></asp:Label>:
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
            <li class="text_grid_2_columns">
                <asp:Label ID="winAddChannel_locationId" runat="server" Text="Mã vị trí (tag name)"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadTextBox ID="txtSiteID" runat="server" Enabled="False">
                </telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txtSiteID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAddChannel_loggerId" runat="server" Text="Logger ID"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadTextBox ID="txtLoggerID" runat="server" Enabled="False">
                </telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="txtLoggerID" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAddChannel_channelName" runat="server" Text="Tên Channel"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadTextBox ID="txtName" runat="server">
                </telerik:RadTextBox>
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAddChannel_channelUnit" runat="server" Text="Đơn vị"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadComboBox ID="cboUnits" runat="server" 
                    DataSourceID="UnitsDataSource" DataTextField="Unit" DataValueField="Unit" 
                    HighlightTemplatedItems="True">
                    <HeaderTemplate>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="width:80px">Unit:</td>
                                <td style="width:80px">Description:</td>s
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
            <li class="text_grid_2_columns">
                <asp:Label ID="winAddChannel_channelFront" runat="server" Text="Kênh áp lực trước"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <asp:RadioButton ID="rdoPressure1" runat="server" GroupName="channel" />
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAddChannel_channelBack" runat="server" Text="Kênh áp lực sau"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <asp:RadioButton ID="rdoPressure2" runat="server" GroupName="channel" />
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAddChannel_channelForward" runat="server" Text="Kênh thuận"></asp:Label>:</li>
            <li class="control_grid_2_columns">
                <asp:RadioButton ID="rdoForward" runat="server" GroupName="channel" />
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAddChannel_channelBackward" runat="server" Text="Kênh nghịch"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <asp:RadioButton ID="rdoReverse" runat="server" GroupName="channel" />
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="lbChannelOther" runat="server" Text="Kênh khác"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <asp:RadioButton ID="rdoChannelOther" runat="server" GroupName="channel" />
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAddChannel_isShowLable" runat="server" Text="Hiển thị trên map"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <asp:RadioButton ID="rdoIsShowLable" runat="server" GroupName="isShowMap" />
            </li>
             <li class="text_grid_2_columns">
                <asp:Label ID="winAddChannel_notShowLable" runat="server" Text=" Không hiển thị trên map"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <asp:RadioButton ID="rdonotShowLable" runat="server" GroupName="isShowMap" />
            </li>
            <li class="text_grid_2_columns">
                <asp:Label ID="winAddChannel_Note" runat="server" Text="Ghi chú"></asp:Label>:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadTextBox ID="txtDescription" runat="server">
                </telerik:RadTextBox>
            </li>
            <li class="text_grid_2_columns">
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadButton ID="btnAdd" runat="server" Text="Add/Update" 
                    onclick="btnAdd_Click">
                </telerik:RadButton>
                <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" 
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
                    <telerik:AjaxUpdatedControl ControlID="rdoIsShowLable" />
                    <telerik:AjaxUpdatedControl ControlID="rdonotShowLable" />
                    <telerik:AjaxUpdatedControl ControlID="rdoChannelOther" />
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
                    <telerik:AjaxUpdatedControl ControlID="rdoIsShowLable" />
                    <telerik:AjaxUpdatedControl ControlID="rdonotShowLable" />
                    <telerik:AjaxUpdatedControl ControlID="rdoChannelOther" />
                    <telerik:AjaxUpdatedControl ControlID="msg" />
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

</div>