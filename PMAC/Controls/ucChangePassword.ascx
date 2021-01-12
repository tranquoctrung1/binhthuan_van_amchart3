<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucChangePassword.ascx.cs" Inherits="Controls_ucChangePassword" %>
<div style="width:33%">
    <ul class="multiple_columns">
        <li class="text_grid_2_columns"><asp:Label ID="lbOldPassword" runat="server" Text="Label"></asp:Label>
        </li>
        <li class="control_grid_2_columns">
            <telerik:RadTextBox ID="txtOldPassword" runat="server" TextMode="Password">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtOldPassword" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
        </li>
        <li class="text_grid_2_columns"><asp:Label ID="lbNewPassword" runat="server" Text="Label"></asp:Label>
        </li>
        <li class="control_grid_2_columns">
            <telerik:RadTextBox ID="txtNewPassword" runat="server" TextMode="Password">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txtNewPassword" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
        </li>
        <li class="text_grid_2_columns"><asp:Label ID="lbConfirmNewPassword" runat="server" Text="Label"></asp:Label>
        </li>
        <li class="control_grid_2_columns" >
            <telerik:RadTextBox ID="txtConfirmNewPassword" runat="server" 
                TextMode="Password">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ControlToValidate="txtConfirmNewPassword" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
        </li>
        <li class="text_grid_2_columns">
        </li>
        <li class="control_grid_2_columns">
            <telerik:RadButton ID="btnOK" runat="server" Text="Thay đổi" 
                onclick="btnOK_Click">
            </telerik:RadButton>
        </li>
        <li class="text_grid_2_columns">
        </li>
        <li class="control_grid_2_columns">
            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                ErrorMessage="Mật khẩu xác nhận không khớp." ForeColor="Red" Font-Italic="True" 
                ControlToCompare="txtNewPassword" ControlToValidate="txtConfirmNewPassword"></asp:CompareValidator>
        </li>
    </ul>
</div>
<telerik:RadNotification ID="ntf" runat="server" >
</telerik:RadNotification>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnOK">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ntf" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

