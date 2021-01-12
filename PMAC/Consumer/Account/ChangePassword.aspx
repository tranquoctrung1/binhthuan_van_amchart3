<%@ Page Title="" Language="C#" MasterPageFile="~/Consumer/MasterPage.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="Consumer_Account_ChangePassword" %>

<%@ Register src="../../Controls/ucChangePassword.ascx" tagname="ucChangePassword" tagprefix="uc1" %>
<%@ Register Src="~/Controls/ucChangePassword.ascx" TagPrefix="uc2" TagName="ucChangePassword" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Đổi mật khẩu</h2>
    <uc2:ucChangePassword runat="server" ID="ucChangePassword" />
</asp:Content>

