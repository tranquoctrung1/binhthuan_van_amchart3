<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.master" AutoEventWireup="true" CodeFile="DisplayGroup.aspx.cs" Inherits="Supervisor_Admin_DisplayGroup" %>

<%@ Register src="../../Controls/ucDisplayGroup.ascx" tagname="ucDisplayGroup" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:ucDisplayGroup ID="ucDisplayGroup1" runat="server" />
</asp:Content>

