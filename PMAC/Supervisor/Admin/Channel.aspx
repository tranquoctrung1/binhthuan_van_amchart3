<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.master" AutoEventWireup="true" CodeFile="Channel.aspx.cs" Inherits="Supervisor_Admin_Channel" %>

<%@ Register src="../../Controls/ucChannel.ascx" tagname="ucChannel" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:ucChannel ID="ucChannel1" runat="server" />
</asp:Content>

