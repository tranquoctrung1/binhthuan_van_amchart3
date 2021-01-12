<%@ page title="" language="C#" masterpagefile="~/Empty.master" autoeventwireup="true" inherits="Supervisor_Admin_Staff, App_Web_ayfbeluo" theme="Default" %>

<%@ Register src="../../Controls/ucStaff.ascx" tagname="ucStaff" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <uc1:ucStaff ID="ucStaff1" runat="server" />

</asp:Content>

