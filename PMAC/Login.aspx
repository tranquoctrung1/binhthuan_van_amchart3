<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<%@ Register src="Controls/ucLogin.ascx" tagname="ucLogin" tagprefix="uc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Custom styles for this template -->
    <link href="https://getbootstrap.com/docs/3.3/examples/signin/signin.css" rel="stylesheet" />

<style type="text/css">
.RadNotification_Metro{border:1px solid #25a0da;background-color:#8C0095 !important}
.RadNotification_Metro .rnTitleBar{background-color:#8C0095 !important;}
.RadNotification_Metro .rnCommands a{
opacity:0;}

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <%-- Add javascript --%>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 


            <uc1:ucLogin ID="ucLogin1" runat="server" />        
    


</asp:Content>

