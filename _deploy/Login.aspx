<%@ page title="" language="C#" masterpagefile="~/MasterPage.master" autoeventwireup="true" inherits="Login, App_Web_qbnwesdx" theme="Default" %>

<%@ Register src="Controls/ucLogin.ascx" tagname="ucLogin" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style type="text/css">
.RadNotification_Metro{border:1px solid #25a0da;background-color:#8C0095 !important}
.RadNotification_Metro .rnTitleBar{background-color:#8C0095 !important;}
.RadNotification_Metro .rnCommands a{
opacity:0;}

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Image ID="Image1" runat="server" ImageUrl="~/App_Themes/logota_150x106.png" style="margin:40px 0 0 40px" />
    <div style="color:#007FFF; font-size:40px; font-weight:bold; text-align:center;margin-top:-60px; ">CÔNG TY TNHH MTV CẤP NƯỚC TRUNG AN<br />HỆ THỐNG QUẢN LÝ DỮ LIỆU LOGGER</div>
    <div class="box">
        <uc1:ucLogin ID="ucLogin1" runat="server" />
    </div>
</asp:Content>

