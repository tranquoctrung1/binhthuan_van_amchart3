<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.master" AutoEventWireup="true" CodeFile="Staff.aspx.cs" Inherits="Supervisor_Admin_Staff" %>

<%@ Register src="../../Controls/ucStaff.ascx" tagname="ucStaff" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <uc1:ucStaff ID="ucStaff1" runat="server" />

</asp:Content>

