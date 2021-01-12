<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="Roles.aspx.cs" Inherits="Supervisor_Roles_Management" %>

<%@ Register src="../../Controls/System/ucRoleManagement.ascx" tagname="ucRoleManagement" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<div id="title"><div style="margin-left:10px; font-size:20px">Đổi mật khẩu</div>
    </div>--%>
    <h2>
        <asp:Label ID="lbTitle" runat="server" Text="Quản lý vai trò"></asp:Label>
    </h2>
    <div id="main">
        <uc1:ucRoleManagement ID="ucRoleManagement" runat="server" />
    </div>
</asp:Content>

