<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="RoleFunction.aspx.cs" Inherits="Supervisor_RoleFunction_Management" %>

<%@ Register src="../../Controls/System/ucRoleFunctionManagement.ascx" tagname="ucRoleFunctionManagement" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<div id="title"><div style="margin-left:10px; font-size:20px">Đổi mật khẩu</div>
    </div>--%>
    <h2>
        <asp:Label ID="lbTitle" runat="server" Text="Quản lý vai trò"></asp:Label>
    </h2>
    <div id="main">
        <uc1:ucRoleFunctionManagement ID="ucRoleFunctionManagement" runat="server" />
    </div>
</asp:Content>

