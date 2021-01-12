<%@ control language="C#" autoeventwireup="true" inherits="Controls_ucLogin, App_Web_dmjolkrd" %>
<%--<div id="list_login_wrapper">
    <ul class="multiple_columns">
        <li class="text_login">Ký danh:</li>
        <li class="control_login">
            <telerik:RadTextBox ID="txtUsername" runat="server">
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtUsername" ErrorMessage="(*)" CssClass="text_validator" >
                </asp:RequiredFieldValidator>
        </li>
        <li class="text_login">Mật khẩu:</li>
        <li class="control_login">
            <telerik:RadTextBox ID="txtPassword" runat="server" TextMode="Password" 
                AutoPostBack="True" ontextchanged="txtPassword_TextChanged" >
            </telerik:RadTextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  
                ControlToValidate="txtPassword" ErrorMessage="(*)" CssClass="text_validator" >
                </asp:RequiredFieldValidator>
        </li>
        <li class="text_login">
        </li>
        <li class="control_login">
            <telerik:RadButton ID="btnLogin" runat="server" Text="Đăng nhập" 
                onclick="btnOk_Click">
            </telerik:RadButton>
        </li>
    </ul>
</div>--%>

<asp:Login ID="Login1" runat="server" LoginButtonText="Đăng nhập" PasswordLabelText="Mật khẩu:" RememberMeText="Ghi nhớ mật khẩu" TitleText="Đăng nhập" UserNameLabelText="Ký danh:" OnAuthenticate="Login1_Authenticate"></asp:Login>

<telerik:RadNotification ID="ntf" runat="server" Title="Message"  BackColor="Purple">
</telerik:RadNotification>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="txtPassword">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ntf"  />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnLogin">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ntf" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
