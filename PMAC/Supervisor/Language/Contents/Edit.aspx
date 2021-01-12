<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="Edit.aspx.cs" Inherits="Supervisor_Language_Contents_Edit" %>

<%@ Register src="../../../Controls/Language/Contents/Edit.ascx" tagname="ucLanguageContentEdit" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<div id="title"><div style="margin-left:10px; font-size:20px">Đổi mật khẩu</div>
    </div>--%>
    <h2>
        Thay Đổi Chi Tiết        
    </h2>
    <div id="main">
        <uc1:ucLanguageContentEdit ID="ucLanguageContentEdit" runat="server" />
    </div>
</asp:Content>

