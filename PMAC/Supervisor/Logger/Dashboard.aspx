<%@ Page Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Supervisor_Logger_Dashboard" %>

<%@ Register Src="~/Controls/ucDashboard.ascx" TagPrefix="uc1" TagName="ucDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:ucDashboard runat="server" ID="ucDashboard" />
</asp:Content>

