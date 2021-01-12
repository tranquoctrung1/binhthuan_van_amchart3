<%@ page title="" language="C#" masterpagefile="~/Empty.master" autoeventwireup="true" inherits="Supervisor_Admin_DisplayGroup, App_Web_ayfbeluo" theme="Default" %>

<%@ Register src="../../Controls/ucDisplayGroup.ascx" tagname="ucDisplayGroup" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:ucDisplayGroup ID="ucDisplayGroup1" runat="server" />
</asp:Content>

