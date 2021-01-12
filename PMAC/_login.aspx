<%@ Page Language="C#" AutoEventWireup="true" CodeFile="_login.aspx.cs" Inherits="_login" %>

<%@ Register Src="~/_controls/_footer.ascx" TagPrefix="uc1" TagName="_footer" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="App_Themes/_stylesheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" DecoratedControls="all" />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div id="login-container">
        <div id="login-header-wrapper">
            <div id="header">
                <div class="login_login_link">
                    <asp:LoginName ID="LoginName1" runat="server" />
                    <asp:LoginStatus ID="LoginStatus1" runat="server"/>
                </div>
                <div id="login-page-name">
                    WEBSITE DỮ LIỆU LOGGER
                </div>
                <div>
                    <telerik:RadMenu ID="RadMenu1" runat="server" DataNavigateUrlField="Url" DataTextField="Title" DataValueField="Title" DataSourceID="SiteMapDataSource1"></telerik:RadMenu>
                    <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" ShowStartingNode="False" SiteMapProvider="_all_sites" />
                </div>
            </div>
        </div>
        <div id="content-wrapper">
            <div id="content">
                <div class="box">
                    <asp:Login ID="Login1" runat="server"></asp:Login>
                </div>
            </div>
        </div>
            <uc1:_footer runat="server" ID="_footer" />
    </div>
    </form>
</body>
</html>
