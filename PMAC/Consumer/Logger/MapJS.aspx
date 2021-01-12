<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MapJS.aspx.cs" Inherits="Consumer_Logger_MapJS" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Công ty Cổ phần Cấp nước Trung An</title>
    <style>
            html, body, form, #map_canvas {
                padding: 0;
                margin: 0;
                height: 100%;
            }
        .label {
        }
        </style>
    <link href="../../App_Themes/common.css" rel="stylesheet" />
    
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script src="../../js/date.format.js"></script>
    <script src="../../js/jquery-1.2.3.min.js"></script>
    <script type="text/javascript"
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuGpAhCXz4igU2klwQqRmGVNC-b1Kc_ic&sensor=false">
    </script>
    <script src="../../js/arcgislink.js"></script>
    <script src="../../js/markerwithlabel.js"></script>
            <script src="../../js/ContextMenu.js"></script>
        
    
    <script type="text/javascript">

        var map;
        var ls;
        var is;
        var index1 = 0;
        var index2 = 0;
        var index = 0;

        $.ajaxSetup({ async: false });
        function callSvcGetLs(loggerId) {
            $.ajax({
                type: "POST",
                url: "../../Map.asmx/GetChannelConfigurationsByLoggerID",
                data: "{'loggerId':'" + loggerId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg1) {
                    getLs(msg1.d);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    //alert(errorThrown);
                }
            });
        }

        function getLs(msg1) {
            //ls = '<div>';
            ls = '';
            //ls += '<table cellpadding=\'0\' cellspacing=\'0\' style=\"border: solid gray 2px; width:auto; height:auto;\">';
            is = '<table cellpadding=\'3\' cellspacing=\'3\'>';

            is += "<tr>"
                    + "<td class=\"tblHeader\">"
                    + "Kênh"
                    + "</td>"
                    + "<td class=\"tblHeader\">"
                    + "Mô tả"
                    + "</td><td class=\"tblHeader\">"
                    + "Ngày giờ"
                    + "</td><td class=\"tblHeader\">"
                    + "Giá trị"
                    //+ "</td><td class=\"tblHeader\">"
                    //+ "Chỉ số"
                    + "</td><td class=\"tblHeader\">"
                    + "Đơn vị"
                    + "</td></tr>";

            index1 = 0;
            index2 = 0;

            for (var post1 in msg1) {
                ls += '<tr><td class=\'cellCenterLbl\'>' + msg1[post1].LastValue + ' (' + msg1[post1].Unit + ')' + '</td><tr>';
                is += "<tr>"
                        + "<td class=\"cellCenter\">"
                        + msg1[post1].ChannelId
                        + "</td>"
                        + "<td class=\"cellCenter\">"
                        + msg1[post1].ChannelName
                        + "</td><td class=\"cellCenter imp\">"
                        + msg1[post1].TimeStamp
                        + "</td><td class=\"cellRight imp\">"
                        + msg1[post1].LastValue
                        //+ "</td><td class=\"cellRight imp\" style=\"color:red\">"
                        //+ msg1[post1].LastIndex
                        + "</td><td class=\"cellLeft\">"
                        + msg1[post1].Unit
                        + "</td></tr>";

                if (msg1[post1].ForwardFlow == true) {
                    index1 = msg1[post1].LastIndex;

                }
                if (msg1[post1].ReverseFlow == true) {
                    index2 = msg1[post1].LastIndex;
                }
            }
            //ls += '<tr><td colspan=\"2\" class=\"lblSiteName\">' + msg1[post1].TimeStamp + '</td></tr>'
            //ls += '</table></div>';
            is += '</table>';
            //alert(ls);
        }

        function callSvcs() {
            $.ajax({
                type: "POST",
                url: "../../Map.asmx/GetSitesForMap",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    
                    createWin(msg.d);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    //alert("errorThrown: " + errorThrown + " | textStatus: " + textStatus + " | XMLHttpRequest: " + XMLHttpRequest);
                }
            });
        }

        var flag = false;
        var labelMarkers = [];
        var constMarkers = [];
        var displayGroup = [];
        var zoom;
        var center;
        var display = true;

        var infowindow = new google.maps.InfoWindow({
            content: ''
        });
        var image_nor = {
            url: 'http://i748.photobucket.com/albums/xx123/bttrung1988/bvt-cello/CELLO/nor_zpsc9fce0dc.png',
            //url:'#',
            size: new google.maps.Size(20, 20),
            origin: new google.maps.Point(0, 0),
            //anchor: new google.maps.Point(-6, 45)
        };
        var image_err = {
            url: 'http://i748.photobucket.com/albums/xx123/bttrung1988/bvt-cello/CELLO/err_zps6d9e1aee.png',
            //url:'#',
            size: new google.maps.Size(20, 20),
            origin: new google.maps.Point(0, 0),
            //anchor: new google.maps.Point(-6, 45)
        };

        function createWin(msg) {

            if (flag == true) {
                for (var i = 0; i < labelMarkers.length; i++) {
                    labelMarkers[i].setMap(null);
                }
                for (var i = 0; i < constMarkers.length; i++) {
                    constMarkers[i].setMap(null);
                }
                labelMarkers = [];
                constMarkers = [];
            }
            var bounds = new google.maps.LatLngBounds();
            for (var post in msg) {
                var myLatlng = new google.maps.LatLng(msg[post].Latitude, msg[post].Longitude);
                bounds.extend(myLatlng);
                callSvcGetLs(msg[post].LoggerId);
                var labelString = '<table cellpadding=\'0\' cellspacing=\'0\' style=\"border: solid gray 2px; width:auto; height:auto;\">' + '<tr><td colspan=\"2\"><div class=\'lblSiteName\'>' + msg[post].SiteAliasName + '</div></td></tr>' + ls + '</table>';
                index = Math.round(index1 - index2);
                var infoWindowsString = '<table cellpadding=\'0\' cellspacing=\'0\'>'
                    + '<tr><td>Site Id: </td><td>' + msg[post].SiteId + '</td></tr>'
                    + '<tr><td>Site Alias Name: </td><td>' + msg[post].SiteAliasName + '</td></tr>'
                    + '<tr><td>Vị trí: </td><td>' + msg[post].Location + '</td></tr>'
                    + '<tr><td>Logger Id: </td><td>' + msg[post].LoggerId + '</td></tr>'
                    + '<tr><td>Cỡ ống: </td><td>' + msg[post].PipeSize + '</td></tr>'
                    + '<tr><td>Index: </td><td style=\"color:red; font-weight:bold;\">' + index + '</td></tr>'
                    + '</table>'
                    + is;

                var myIcon;
                if (msg[post].Alarm) {
                    myIcon = image_err;
                }
                else {
                    myIcon = image_nor;
                }

                var marker = new MarkerWithLabel({
                    position: myLatlng,
                    map: map,
                    icon: myIcon,
                    draggable: false,
                    raiseOnDrag: true,
                    labelContent: labelString,
                    labelAnchor: new google.maps.Point(msg[post].LabelAnchorX = null ? 100 : msg[post].LabelAnchorX, msg[post].LabelAnchorY = null ? 0 : msg[post].LabelAnchorY),
                    labelClass: "labels", // the CSS class for the label
                    labelInBackground: false,
                    html: infoWindowsString,
                    visible: display
                });

                google.maps.event.addListener(marker, 'click', function () {
                    infowindow.setContent(this.html);
                    infowindow.open(map, this);
                });

                labelMarkers.push(marker);

                var constMarker = new google.maps.Marker({
                    position: myLatlng,
                    map: map,
                    icon: myIcon,
                    html: infoWindowsString
                });

                google.maps.event.addListener(constMarker, 'click', function () {
                    infowindow.setContent(this.html);
                    infowindow.open(map, this);
                });

                constMarkers.push(constMarker);

                if (flag == false) {
                    map.fitBounds(bounds);
                }
            }
            
            if (flag == false) {
                flag = true;
                var treeView = $find("<%= trvSites.ClientID %>");
                var parent = treeView.get_selectedNode() || treeView;
                for (var i = 0; i < labelMarkers.length; i++) {
                    if (displayGroup.indexOf(msg[i].DisplayGroup) == -1) {
                        displayGroup.push(msg[i].DisplayGroup);
                        var pNode = new Telerik.Web.UI.RadTreeNode();
                        pNode.set_text(msg[i].DisplayGroup);
                        pNode.set_value(msg[i].DisplayGroup);
                        pNode.set_expanded(true);
                        parent.get_nodes().add(pNode);
                    }

                    var node = new Telerik.Web.UI.RadTreeNode();
                    node.set_text(msg[i].Location);
                    node.set_value(msg[i].SiteId);
                    node.set_expanded(true);
                    node.set_navigateUrl('javascript:openWin(' + i + ');');
                    var mpNode = treeView.findNodeByText(msg[i].DisplayGroup);
                    mpNode.get_nodes().add(node);

                }
                treeView.commitChanges();
            }

        }

        function openWin(i) {
            map.panTo(labelMarkers[i].getPosition());
            google.maps.event.trigger(labelMarkers[i], 'click');
        }

        function init() {

            zoom = 6;
            center = new google.maps.LatLng(16.109833, 107.201294);
            var myOptions = {
                zoom: zoom,
                center: center,//35.23, -80.84),
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                streetViewControl: true
            };
            map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

            //
            var contextMenuOptions = {};
            contextMenuOptions.classNames = { menu: 'context_menu', menuSeparator: 'context_menu_separator' };

            var menuItems = [];
            menuItems.push({ className: 'context_menu_item', eventName: 'hide_click', label: 'Hide labels' });
            menuItems.push({ className: 'context_menu_item', eventName: 'show_click', label: 'Show labels' });
            contextMenuOptions.menuItems = menuItems;

            var contextMenu = new ContextMenu(map, contextMenuOptions);

            google.maps.event.addListener(map, 'rightclick', function (mouseEvent) {
                contextMenu.show(mouseEvent.latLng);
            });

            google.maps.event.addListener(contextMenu, 'menu_item_selected', function (latLng, eventName) {
                switch (eventName) {
                    case 'hide_click':
                        for (var i = 0; i < labelMarkers.length; i++) {
                            labelMarkers[i].setVisible(false);
                            display = false;
                        }
                        break;
                    case 'show_click':
                        for (var i = 0; i < labelMarkers.length; i++) {
                            labelMarkers[i].setVisible(true);
                            display = true;
                        }
                        break;
                }
            });

            var treeView = $find("<%= RadTreeView1.ClientID %>");
            var nodes = treeView.get_allNodes();
            for (var i = 0; i < nodes.length; i++) {
                if (nodes[i].get_nodes() != null) {
                    nodes[i].expand();
                }
            }

            callSvcs();
        }

        window.onload = init;
        setInterval(callSvcs, 60000);

    </script>
        </telerik:RadCodeBlock>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadSplitter ID="RadSplitter1" runat="server" Width="100%" Height="100%">
            <telerik:RadPane ID="RadPane1" Runat="server" Width="22px" Scrolling="None">
                <telerik:RadSlidingZone ID="RadSlidingZone1" Runat="server" SlideDuration="0" ExpandedPaneId="RadSlidingPane1" DockedPaneId="RadSlidingPane1">
                    <telerik:RadSlidingPane ID="RadSlidingPane1" Runat="server" Title="Sites" Width="250px" >
                        <%--<asp:Button ID="Button1" runat="server" Text="Center Map" OnClientClick="map.setZoom(13); map.setCenter(center);return false;" />--%>
                        <telerik:RadTreeView ID="trvSites" Runat="server">
                        </telerik:RadTreeView>
                        <ul id="sideContainer" style="list-style:square"></ul>
                    </telerik:RadSlidingPane>
                    <telerik:RadSlidingPane ID="RadSlidingPane2" runat="server" Title="Menu" Width="250px" >

                        <telerik:RadTreeView ID="RadTreeView1" Runat="server" 
                            DataSourceID="SiteMapDataSource">
                            
                            <ExpandAnimation Duration="0" Type="None" />
                            <CollapseAnimation Duration="0" Type="None" />
                            
                        </telerik:RadTreeView>
                        <asp:SiteMapDataSource ID="SiteMapDataSource" runat="server" SiteMapProvider="Consumer" 
                            ShowStartingNode="False"  />
                            <asp:LoginStatus ID="LoginStatus1" runat="server" style="margin-left:5px" 
                                        LogoutPageUrl="~/Login.aspx" />
                        
                    </telerik:RadSlidingPane>
                </telerik:RadSlidingZone>
            </telerik:RadPane>
            <telerik:RadPane ID="RadPane2" Runat="server" >
                <div id="map_canvas">
                </div>
            </telerik:RadPane>
        </telerik:RadSplitter>

        <telerik:RadWindow ID="winAlarm" runat="server" Height="100px" Width="940px" VisibleOnPageLoad="true" VisibleStatusbar="false" 
            Title="Alarm Bar" NavigateUrl="~/Supervisor/Logger/Alarming.aspx" OnClientBeforeClose="OnClientBeforeClose" >
        </telerik:RadWindow>
        <script type="text/javascript">
            function OnClientBeforeClose(sender, args) {
                args.set_cancel(!confirm("Are you sure you want to close alarm bar?"));
            }
        </script>
    </form>
</body>
</html>