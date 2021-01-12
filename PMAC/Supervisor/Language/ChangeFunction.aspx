<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="ChangeFunction.aspx.cs" Inherits="Supervisor_Language_ChangeFunction" %>

<%@ Register src="../../Controls/Language/ucLanguageFunction.ascx" tagname="ucLanguageFunction" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<div id="title"><div style="margin-left:10px; font-size:20px">Đổi mật khẩu</div>
    </div>--%>
    <h2>
        <asp:Label ID="lbTitle" runat="server" Text="Thay Đổi Ngôn Ngữ Về Tính Năng"></asp:Label>
    </h2>
    <div id="main">
        <uc1:ucLanguageFunction ID="ucLanguageFunction" runat="server" />
    </div>
</asp:Content>

