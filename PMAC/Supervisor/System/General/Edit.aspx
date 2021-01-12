<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="Edit.aspx.cs" Inherits="Supervisor_Language_Contents_Edit" %>

<%@ Register src="../../../Controls/System/General/Edit.ascx" tagname="ucSystemGeneralEdit" tagprefix="uc1" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>
        Thay Đổi Chi Tiết        
    </h2>
    <div id="main">
        <uc1:ucSystemGeneralEdit ID="ucSystemGeneralEdit" runat="server" />
    </div>
</asp:Content>

