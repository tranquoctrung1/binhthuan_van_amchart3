<%@ page title="" language="C#" masterpagefile="~/Empty.master" autoeventwireup="true" inherits="Supervisor_Admin_Consumer, App_Web_ayfbeluo" theme="Default" %>

<%@ Register src="../../Controls/ucConsumer.ascx" tagname="ucConsumer" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <uc1:ucConsumer ID="ucConsumer1" runat="server" />
    
</asp:Content>

