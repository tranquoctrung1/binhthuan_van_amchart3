<%@ page language="C#" autoeventwireup="true" inherits="Consumer_Logger_Map, App_Web_fhgam4td" theme="Default" %>
<%@ Register Assembly="GMaps" Namespace="Subgurim.Controles" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Công ty TNHH Một thành viên Cấp nước Trung An
    </title>
    <%--<script type="text/javascript" language="javascript">
        var scrl = " Công ty TNHH Một thành viên Cấp nước Trung An ";
        function scrlsts() {
            scrl = scrl.substring(1, scrl.length) + scrl.substring(0, 1);
            document.title = scrl;
            setTimeout("scrlsts()", 300);
        }
    </script>--%>
    <%--<style type="text/css">
        html, body, form {       
            margin: 0px;     
            padding: 0px;     
            height: 100%; 
            min-height:100%;
            }
            #GMap1Panel{height:100%;}
    </style>
    <style type="text/css">
        .style0{
            font-family:Segoe UI;
            font-weight:bold;
            color:blue;
            background-color:White;
        }
        .style1
        {
            font-family:Segoe UI;
        }
        .style2
        {
            color: #FFFFFF;
            font-weight: bold;
            background-color:#306EFF;
            text-align:center;
        }
        .style3
        {
            color: #FFFFFF;
            background-color:#306EFF;
            text-align:center;
        }
        .style4{
            color: #FFFFFF;
            background-color:#306EFF;
            text-align:left;
        }
        .style5{
            color: #FFFFFF;
            background-color:#306EFF;
            text-align:right;
        }
        .style6
        {
            color: #FFFFFF;
            font-weight: bold;
            background-color:#8C0095;
            text-align:center;
        }
    </style>--%>
    <style type="text/css">
        html, body, form {       
            margin: 0px;     
            padding: 0px;     
            height: 100%; 
            min-height:100%
            }
        .gm-style-iw {
            height: auto !important;
            width: auto !important;
        }
        .RadWindow
        {
            position: fixed !important; 
            top: auto !important;  
            bottom: 0;
            margin:0 auto;
        }
        #GMap1Panel{height:100%;}
        .lblSiteName {
        font-weight:bolder;
        color:blue;
        background-color:whitesmoke
        }
        .cellCenter, .cellLeft, .cellRight {

        }
        .cellCenter,.cellCenterLbl
        {
            text-align:center
        }
        .cellLeft{
            text-align:left
        }
        .cellRight, .cellRightLbl {
            text-align:right
        }
        .cellRightLbl, .cellCenterLbl {
            font-size:small;
            font-weight:bold;
            background-color:black;
            color:yellow;
        }
        .tblHeader
        {
            font-weight: bold;
            text-align:center
        }
        .context_menu {
            background-color: white;
            border: 1px solid gray;
        }
        .context_menu_item {
            padding: 3px 6px;
        }
        .context_menu_item:hover {
            background-color: #CCCCCC;
        }
        .context_menu_separator {
            background-color: gray;
            height: 1px;
            margin: 0;
            padding: 0;
        }
        .imp {
            color: blue;
            font-weight: bold;
        }
        
    </style>
</head>
<%--<body onload="scrlsts();">--%>
<body>
    <form id="form1" runat="server">
        <script src="../../js/markerwithlabel.js"></script>
        <script src="../../js/ContextMenu.js"></script>
        <script type="text/javascript">
            var markers = [];
            var lablelMarkers = [];
            var contextMenuOptions = {};
            var menuItems = [];
            var display = true;
            var center;

            function open_Window(i) {
                var map = markers[i].getMap();
                map.panTo(markers[i].getPosition());
                google.maps.event.trigger(markers[i], 'click');
            }

            //	create the ContextMenuOptions object
            var contextMenuOptions = {};
            contextMenuOptions.classNames = { menu: 'context_menu', menuSeparator: 'context_menu_separator' };

            var menuItems = [];
            menuItems.push({ className: 'context_menu_item', eventName: 'hide_click', label: 'Hide labels' });
            menuItems.push({ className: 'context_menu_item', eventName: 'show_click', label: 'Show labels' });
            contextMenuOptions.menuItems = menuItems;
        </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" ControlsToSkip="LoginControls" DecoratedControls="All" />
        <telerik:RadSplitter ID="RadSplitter1" runat="server"  Width="100%" Height="100%">
            <telerik:RadPane ID="RadPane1" runat="server" Width="22px" Scrolling="None">
                <telerik:RadSlidingZone ID="RadSlidingZone1" runat="server" SlideDuration="0">
                    <telerik:RadSlidingPane ID="RadSlidingPane1" runat="server" Title="DS Logger" Width="250px" EnableDock="true" >
                        <telerik:RadTreeView ID="trvSites" Runat="server">
                        </telerik:RadTreeView>
                    </telerik:RadSlidingPane>
                    <telerik:RadSlidingPane ID="RadSlidingPane2" runat="server" Title="Menu" Width="250px" >
                        <telerik:RadTreeView ID="RadTreeView1" Runat="server" OnDataBound="RadTreeView1_DataBound"
                            DataSourceID="SiteMapDataSource">
                            
                            <ExpandAnimation Duration="0" Type="None" />
                            <CollapseAnimation Duration="0" Type="None" />
                            
                        </telerik:RadTreeView>
                        <asp:SiteMapDataSource ID="SiteMapDataSource" runat="server" 
                            ShowStartingNode="False" SiteMapProvider="Consumer" />
                            <asp:LoginStatus ID="LoginStatus1" runat="server" style="margin-left:5px" 
                                        LogoutPageUrl="~/Login.aspx" />
                    </telerik:RadSlidingPane>
                </telerik:RadSlidingZone>
            </telerik:RadPane>
            <telerik:RadPane ID="RadPane2" runat="server">
                <%--<cc1:GMap runat="server" ID="GMap1" 
                    Key="AIzaSyCQ0Cx40GYoH4Kiqnen7TnuaLzpeavrWUk" Width="100%" Height="100%" 
                    onzoomend="GMap1_ZoomEnd" enableServerEvents="True" 
                    onmapload="GMap1_MapLoad">
                </cc1:GMap>--%>
                <cc1:GMap ID="GMap1" runat="server" Height="100%" Width="100%" ShowMapTypeControl="true" />
            </telerik:RadPane>
        </telerik:RadSplitter>
        <asp:Panel ID="Panel1" runat="server">
            <asp:Timer ID="Timer1" runat="server" Interval="300000" ontick="Timer1_Tick">
                </asp:Timer>
        </asp:Panel>
        <telerik:RadWindow ID="winAlarm" runat="server" Height="100px" Width="940px" VisibleOnPageLoad="true" VisibleStatusbar="false" 
            Title="Alarm Bar" NavigateUrl="~/Supervisor/Logger/Alarming.aspx" OnClientBeforeClose="OnClientBeforeClose" >
        </telerik:RadWindow>
        <script type="text/javascript">
            function OnClientBeforeClose(sender, args) {
                args.set_cancel(!confirm("Are you sure you want to close alarm bar?"));
            }
        </script>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting  AjaxControlID="Timer1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="GMap1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" 
        HorizontalAlign="Center">
    </telerik:RadAjaxLoadingPanel>
    </form>
</body>
</html>
