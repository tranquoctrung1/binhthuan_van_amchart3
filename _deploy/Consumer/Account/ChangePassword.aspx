<%@ page title="" language="C#" masterpagefile="~/Consumer/MasterPage.master" autoeventwireup="true" inherits="Consumer_Account_ChangePassword, App_Web_n4zysxo4" theme="Default" %>

<%@ Register src="../../Controls/ucChangePassword.ascx" tagname="ucChangePassword" tagprefix="uc1" %>
<%@ Register Src="~/Controls/ucChangePassword.ascx" TagPrefix="uc2" TagName="ucChangePassword" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Đổi mật khẩu</h2>
    <uc2:ucChangePassword runat="server" ID="ucChangePassword" />
</asp:Content>

