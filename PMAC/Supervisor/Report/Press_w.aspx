<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Press_w.aspx.cs" Inherits="Supervisor_Report_Press_w" %>

<%@ Register Src="~/Controls/ucPress.ascx" TagPrefix="uc1" TagName="ucPress" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link rel="stylesheet" href="/css/vendor.css" />
    <link rel="stylesheet" href="/css/app-blue.css" />
    <link rel="stylesheet" href="/css/language.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
        <uc1:ucPress runat="server" id="ucPress" />
    </div>
    </form>
</body>
</html>
