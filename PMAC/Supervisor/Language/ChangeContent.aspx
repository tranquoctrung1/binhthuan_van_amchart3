<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="ChangeContent.aspx.cs" Inherits="Supervisor_Language_ChangeContent" %>

<%@ Register src="../../Controls/Language/ucLanguageContent.ascx" tagname="ucLanguageContent" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<div id="title"><div style="margin-left:10px; font-size:20px">Đổi mật khẩu</div>
    </div>--%>
    <h2>
        <asp:Label ID="lbTitle" runat="server" Text="Thay Đổi Ngôn Ngữ - Nội Dung Chi Tiết"></asp:Label>
    </h2>
    <div id="main">
        <uc1:ucLanguageContent ID="ucLanguageContent" runat="server" />
    </div>
</asp:Content>

