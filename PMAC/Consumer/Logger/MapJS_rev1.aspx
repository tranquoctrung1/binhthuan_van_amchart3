<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MapJS_rev1.aspx.cs" Inherits="Consumer_Logger_MapJS_rev1" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.master" AutoEventWireup="true" CodeFile="MapJS_rev1.aspx.cs" Inherits="Consumer_Logger_MapJS_rev1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <head>
        <title></title>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAXcBIH-8x-fgsegv6OedGZmh7g0JZyGr0&sensor=false"></script>
        <script src="../../js/markerwithlabel.js"></script>
        <script src="../../js/ContextMenu.js"></script>
        <script src="../../js/jquery-1.7.2.min.js"></script>
        <script src="../../js/amcharts/amcharts.js"></script>
        <script src="../../js/amcharts/serial.js"></script>
        <script src="../../js/amcharts/exporting/amexport.js"></script>
        <script src="../../js/amcharts/exporting/canvg.js"></script>
        <script src="../../js/amcharts/exporting/filesaver.js"></script>
        <script src="../../js/amcharts/exporting/jspdf.js"></script>
        <script src="../../js/amcharts/exporting/jspdf.plugin.addimage.js"></script>
        <script src="../../js/amcharts/exporting/rgbcolor.js"></script>
        <script src="../../js/randomColor.js"></script>
        <script src="../../js/arcgislink.js"></script>
        <link href="../../App_Themes/common.css" rel="stylesheet" />
        <style type="text/css">
            html, body, form, #content, #map_canvas {
                padding: 0;
                margin: 0;
                height: 100%;
            }

            .auto-style1 {
                width: 50%;
            }

            .auto-style2 {
                width: 18px;
            }

            .tCenter {
                text-align: center
            }

            .tBold {
                font-weight: bold
            }

            .myRadWindow {
                position: fixed !important;
                top: auto !important;
                bottom: 0;
                margin: 0 auto;
            }

            #chart_table_MinMax table {
                width: 96%;
                padding-left: 15px;
            }


                #chart_table_MinMax table th, #chart_table_MinMax table td {
                    text-align: center;
                    padding: 5px 7px;
                }

                #chart_table_MinMax table th {
                    background: #999;
                    color: #fff;
                }

                #chart_table_MinMax table td {
                    border-bottom: 1px solid #eee;
                }

                    #chart_table_MinMax table td.row-title {
                        font-weight: bold;
                    }

            .gm-style-iw-d {
                overflow: hidden !important;
            }

            .main-wrapper2 {
                width: 100%;
                height: 100%;
                overflow-y: auto;
                overflow-x: hidden;
            }

            .gg-map {
                position: relative;
            }


            .control-field {
                position: absolute;
                max-height: 80vh;
                width: 250px;
                top: 10px;
                right: 60px;
                background: white;
                overflow-y: auto;
                overflow-x: hidden;
                z-index: 99;
                padding: 10px;
                border: 1px solid darkgrey;
                border-radius: 10px;
            }

            .chart-control-field {
                position: absolute;
                max-height: 80vh;
                width: 250px;
                top: 10px;
                right: 60px;
                background: white;
                overflow-y: auto;
                overflow-x: hidden;
                z-index: 100;
                padding-left: 5px;
                border: 1px solid darkgrey;
                border-radius: 10px
            }

            .warning-control-field {
                position: absolute;
                max-height: 80vh;
                width: 550px;
                top: 10px;
                right: 60px;
                background: white;
                overflow-y: auto;
                overflow-x: hidden;
                z-index: 100;
                padding-left: 5px;
                border: 1px solid darkgrey;
                border-radius: 10px
            }

            .control-button {
                background-color: rgb(255, 255, 255);
                border: 2px solid rgb(255, 255, 255);
                border-radius: 3px;
                box-shadow: rgba(0, 0, 0, 0.3) 0px 2px 6px;
                cursor: pointer;
                margin: 10px;
                text-align: center;
                height: 40px;
                width: 40px;
                z-index: 0;
                position: absolute;
            }
        </style>

    </head>
    <body>
        <form id="form1">


            <div id="wrapper">
                <div class="main-wrapper2">
                    <div class="app" id="app">
                        <header class="header">
                    <div class="header-block header-block-collapse d-lg-none d-xl-none">
                        <button class="collapse-btn" id="sidebar-collapse-btn">
                            <i class="fa fa-bars"></i>
                        </button>
                    </div>
    
                    <div class="header-block header-block-buttons">
                        <a href="#" id="MenuCollapse">
                            <i class="fa fa-bars"></i>
                        </a>
                          <asp:Label ID="lbPageTitle" runat="server" Text="Viwater hệ thống SCADA quản lý mạng lưới cấp nước"></asp:Label>                        
                    </div>

                    <div class="header-block header-block-nav">
                        <ul class="nav-profile">
                            <asp:DropDownList ID="DropDownList_Language" runat="server"
                                    onselectedindexchanged="DropDownList_Language_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Text="Vietnamese" Value="vi"></asp:ListItem>
                                    <asp:ListItem Text="English" Value="en"></asp:ListItem>
                                    <asp:ListItem Text="Other" Value="other"></asp:ListItem>
                                </asp:DropDownList>

                                <li class="profile dropdown HeaderLogout">
                                <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="true">
                                    <i class="fa fa-user" style="font-size:24px"></i>
                                    <span class="name"> 
                                        <asp:Label ID="lbUserName" runat="server" Text="User's name"></asp:Label>
                                    </span>
                                </a>
                                <div id="LogoutRegion" class="dropdown-menu profile-dropdown-menu" aria-labelledby="dropdownMenu1" style="position: absolute; transform: translate3d(-87px, 25px, 0px); top: 0px; left: 0px; will-change: transform;">                                                     
                                    <a class="dropdown-item" href="/Consumer/Account/ChangePassword.aspx">
                                        <i class="fa fa-gear icon"></i> 
                                        <asp:Label ID="lbChangePassword" runat="server" Text="Đổi Mật Khẩu"></asp:Label>                    
                                    </a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" id="btnLogout" href="#">
                                        <i class="fa fa-power-off icon"></i> Logout </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </header>

                        <aside class="sidebar">
                    <div class="sidebar-container">
                        <div class="sidebar-header">
                            <div class="brand">
                                <img src="#" alt="Smiley face" height="25" width="45" runat="server" id="imgLogo">
                                 <asp:Label ID="lbCompany" runat="server" Text="TAWACO"></asp:Label> </div>
                        </div>
                        <nav class="menu">
                            <ul class="sidebar-menu metismenu" id="sidebar-menu">
                                 <li class="active" id="MapJS_rev1_DMA">
                                    <a href="/Consumer/Logger/MapJS_rev1.aspx" class="privilege" id="lnkMapJS" runat="server"> 
                                        <i class="fa fa-home"></i> 
                                        <asp:Label ID="lbGeneralMap" runat="server" Text="Bản Đồ Tổng Thể"></asp:Label>                    
                                    </a>
                                       <ul class="sidebar-nav collapse in" aria-expanded="true">
                                        
                                    <li>
                                           
                                    <telerik:RadTreeView ID="radTreeViewSite" runat="server" EnableDragAndDrop="true" EnableDragAndDropBetweenNodes="false" OnClientNodeDropping="radTreeViewSite_NodeDropping" OnClientNodeClicked="radTreeViewSite_NodeClicked">
                                    </telerik:RadTreeView>


                                    </li>
                                    </ul>

                                </li>
                                <li>
                                            <a href="/Consumer/Logger/Complex.aspx"> 
                                                <asp:Label ID="lbDataTable" runat="server" Text="Bảng Giá Trị"></asp:Label>                    
                                            </a>
                                        </li>
                                
                                <li>
                                            <a href="/Consumer/Logger/Daily_Monthly.aspx"> 
                                                <asp:Label ID="lbLoggerData" runat="server" Text="Dữ Liệu Logger"></asp:Label>                     

                                            </a>
                                        </li>
                                    
                                
                            </ul>
                        </nav>
                        <asp:HiddenField ID="hidListMenu" runat="server" Value="" />
                    </div>
                    
                </aside>

                        <div class="sidebar-overlay" id="sidebar-overlay"></div>
                        <div class="sidebar-mobile-menu-handle" id="sidebar-mobile-menu-handle"></div>
                        <div class="mobile-menu-handle"></div>

                        <div id="content" style="height: 100%; padding: 60px 10px 10px 10px">

                            <telerik:RadScriptManager ID="RadScriptManager1">
                            </telerik:RadScriptManager>

                            <telerik:RadSplitter ID="RadSplitter1" runat="server" Height="470px" Width="100%">
                                <%-- Pi-Solution Developer --%>
                                <telerik:RadPane ID="RadPane1" runat="server" Width="0px" Height="100%">
                                    <telerik:RadSlidingZone ID="RadSlidingZone1" runat="server" DockedPaneId="RadSlidingPane1" ExpandedPaneId="RadSlidingPane1">
                                        <telerik:RadSlidingPane ID="RadSlidingPane1" runat="server" Width="0px" Title="Sites">
                                        </telerik:RadSlidingPane>
                                        <telerik:RadSlidingPane Visible="false" ID="RadSlidingPane2" runat="server" Width="0px" Title="Menu">
                                            <telerik:RadTreeView ID="radTreeViewSiteMap" runat="server" DataSourceID="SiteMapDataSource1" OnClientLoad="radTreeViewSiteMap_Load">
                                            </telerik:RadTreeView>
                                            <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" ShowStartingNode="False" />
                                            <asp:LoginName ID="LoginName1" runat="server" Width="0" ForeColor="White" />
                                            <asp:LoginStatus ID="LoginStatus1" runat="server" />
                                        </telerik:RadSlidingPane>
                                    </telerik:RadSlidingZone>
                                </telerik:RadPane>
                                <telerik:RadPane ID="RadPane2" runat="server" Height="100%" CssClass="gg-map">
                                    <div class="control-button" id="setting-control" data-toggle="collapse" data-target="#site-filter-option" aria-expanded="false" aria-controls="option-list" title="Options">
                                        <i class="fa fa-filter fa-3x m-t-3 text-success"></i>
                                    </div>
                                     <div class="control-button" id="layer-control" data-toggle="collapse" data-target="#layer-option" aria-expanded="false" aria-controls="option-list" title="Options">
                                         <img src="../../App_Themes/layer.png" alt="layer" style="width: 100%" />
                                    </div>
                                    <div class="control-field collapse" id="site-filter-option">
                                        
                                    </div>
                                    <div class="control-field collapse" id="layer-option">
                                        <div class="custom-control custom-checkbox">
                                            <input type="checkbox" class="custom-control-input" id="areaKML"  onchange="return turnOnAreaKML(this);"/>
                                            <label class="custom-control-label" for="areaKML">Vùng</label>
                                        </div>
                                    </div>
                                    <div id="map_canvas">
                                    </div>
                                </telerik:RadPane>
                            </telerik:RadSplitter>


                            <telerik:RadWindow ID="radminmaxPress" runat="server" Height="640px" VisibleStatusbar="False" Width="970px" Title="Chart">
                                <ContentTemplate>
                                    <div class="rowGrid">
                                        &nbsp;Start Date: &nbsp;
                                        <telerik:RadDateTimePicker ID="radDateTimePicker5" runat="server" Culture="en-GB" Height="25px">
                                            <TimeView CellSpacing="-1" Culture="en-GB">
                                            </TimeView>
                                            <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                            <Calendar EnableWeekends="True" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
                                            </Calendar>
                                            <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" Height="25px" LabelWidth="40%">
                                                <EmptyMessageStyle Resize="None" />
                                                <ReadOnlyStyle Resize="None" />
                                                <FocusedStyle Resize="None" />
                                                <DisabledStyle Resize="None" />
                                                <InvalidStyle Resize="None" />
                                                <HoveredStyle Resize="None" />
                                                <EnabledStyle Resize="None" />
                                            </DateInput>
                                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                        </telerik:RadDateTimePicker>

                                        &nbsp; End Date:&nbsp;
                                        <telerik:RadDateTimePicker ID="radDateTimePicker6" runat="server" Culture="en-GB" Height="25px">
                                            <TimeView CellSpacing="-1" Culture="en-GB">
                                            </TimeView>
                                            <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                            <Calendar EnableWeekends="True" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
                                            </Calendar>
                                            <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" Height="25px" LabelWidth="40%">
                                                <EmptyMessageStyle Resize="None" />
                                                <ReadOnlyStyle Resize="None" />
                                                <FocusedStyle Resize="None" />
                                                <DisabledStyle Resize="None" />
                                                <InvalidStyle Resize="None" />
                                                <HoveredStyle Resize="None" />
                                                <EnabledStyle Resize="None" />
                                            </DateInput>
                                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                        </telerik:RadDateTimePicker>

                                        <input id="btnUpdateChartMinMax" type="button" value="Update" onclick="btnUpdateChartMinMax_Clicked(); return false;" />

                                        <input id="btnClearChartMinMax" type="button" value="Clear" onclick="btnClearChartMinMax_Clicked(); return false;" />


                                    </div>
                                    <div id="chart_canvas_MinMax" style="width: 100%; height: 55%"></div>
                                    <div id="summary_MinMax" style="width: 38%; height: 20%; border: dotted; float: left;">
                                        <div style="float: left; width: 100%; margin: 5px;"><b>Summary</b> </div>
                                        <div style="float: left; width: 100%; margin: 5px;">
                                            <div style="float: left;">Minimum Press Day: </div>
                                            <div id="minPress" style="float: left; color: blue"></div>
                                            <div style="float: left; color: blue">(m)</div>
                                        </div>
                                        <div style="float: left; width: 100%; margin: 5px;">
                                            <div style="float: left;">Maximum Press Day: </div>
                                            <div id="maxPress" style="float: left; color: blue"></div>
                                            <div style="float: left; color: blue">(m)</div>
                                        </div>

                                    </div>
                                    <div id="chart_table_MinMax" style="width: 60%; height: 35%; float: left"></div>



                                </ContentTemplate>
                            </telerik:RadWindow>

                            <telerik:RadWindow ID="radWindowChart" runat="server" Height="540px" VisibleStatusbar="False" Width="960px" Title="Chart">
                                <ContentTemplate>
                                    <div class="rowGrid ">
                                        &nbsp;Start Date: &nbsp;
                                        

                                        <telerik:RadDateTimePicker ID="radDateTimePickerStart" runat="server" Culture="en-GB" Height="25px">
                                            <TimeView CellSpacing="-1" Culture="en-GB">
                                            </TimeView>
                                            <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                            <Calendar EnableWeekends="True" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
                                            </Calendar>
                                            <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" Height="25px" LabelWidth="40%">
                                                <EmptyMessageStyle Resize="None" />
                                                <ReadOnlyStyle Resize="None" />
                                                <FocusedStyle Resize="None" />
                                                <DisabledStyle Resize="None" />
                                                <InvalidStyle Resize="None" />
                                                <HoveredStyle Resize="None" />
                                                <EnabledStyle Resize="None" />
                                            </DateInput>
                                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                        </telerik:RadDateTimePicker>
                                        &nbsp; End Date:&nbsp;
                                        <telerik:RadDateTimePicker ID="radDateTimePickerEnd" runat="server" Culture="en-GB" Height="25px">
                                            <TimeView CellSpacing="-1" Culture="en-GB">
                                            </TimeView>
                                            <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                            <Calendar EnableWeekends="True" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
                                            </Calendar>
                                            <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" Height="25px" LabelWidth="40%">
                                                <EmptyMessageStyle Resize="None" />
                                                <ReadOnlyStyle Resize="None" />
                                                <FocusedStyle Resize="None" />
                                                <DisabledStyle Resize="None" />
                                                <InvalidStyle Resize="None" />
                                                <HoveredStyle Resize="None" />
                                                <EnabledStyle Resize="None" />
                                            </DateInput>
                                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                        </telerik:RadDateTimePicker>

                                        <input id="btnUpdateChart" type="button" value="Update" onclick="btnUpdateChart_Clicked(); return false;" />
                                        <input id="btnClearChart" type="button" value="Clear" onclick="btnClearChart_Clicked(); return false;" />


                                    </div>
                                    <div id="chart_canvas" style="width: 100%; height: 90%"></div>



                                </ContentTemplate>
                            </telerik:RadWindow>

                            <telerik:RadWindow ID="winAlarm" runat="server" Height="100px" Width="940px" VisibleOnPageLoad="true" VisibleStatusbar="false" CssClass="myRadWindow" InitialBehaviors="Minimize"
                                Title="Alarm Bar" NavigateUrl="~/Consumer/Logger/Alarming.aspx" OnClientBeforeClose="OnClientBeforeClose">
                            </telerik:RadWindow>

                            <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                                <script type="text/javascript">
                                    function OnClientBeforeClose(sender, args) {
                                        args.set_cancel(!confirm("Are you sure that you want to close alarm bar?"));
                                    }
                                </script>
                                <script type="text/javascript" id="telerikClientEvents1">
                                    //<![CDATA[

                                    function radTreeViewSite_NodeDropping(sender, args) {
                                        //Add JavaScript handler code here
                                        if (args.get_htmlElement().toString() == "[object SVGPathElement]") {
                                            //alert()
                                            var channelInfo = args.get_sourceNode().get_value();
                                            var cDtStart = $find("<%=radDateTimePickerStart.ClientID %>");
                                var cDtEnd = $find("<%=radDateTimePickerEnd.ClientID %>");
                                var treeViewSite = $find("<%= radTreeViewSite.ClientID %>");
                                            var flag = false;
                                            var info = channelInfo.split('|');
                                            var channel = { id: info[0], namePath: (info[1] + " | " + info[2]), unit: info[3] }
                                            for (var i = 0; i < channels.length; i++) {
                                                if (channels[i].id == channel.id) {
                                                    flag = true;
                                                }
                                            }
                                            if (flag == false) channels.push(channel);
                                            if (cDtStart.get_selectedDate() == null || cDtStart.get_selectedDate() == 'undefined') {
                                                end = new Date();
                                                start = new Date();
                                                start = new Date(start.setDate(start.getDate() - 1));
                                                start = toOADate(start);
                                                end = toOADate(end);
                                                start = start.toString().replace('.', '_');
                                                end = end.toString().replace('.', '_');
                                                updateChart(start, end);
                                            }
                                            else {
                                                updateChart(toOADate(new Date(cDtStart.get_selectedDate())).toString().replace('.', '_'), toOADate(new Date(cDtEnd.get_selectedDate())).toString().replace('.', '_'));
                                            }
                                        }
                                    }
                //]]>
                                </script>
                                <script type="text/javascript" id="telerikClientEvents2">
                                    //<![CDATA[

                                    function btnUpdateChart_Clicked(sender, args) {
                                        var cDtStart = $find("<%=radDateTimePickerStart.ClientID %>");
                            var cDtEnd = $find("<%=radDateTimePickerEnd.ClientID %>");
                                        if (cDtStart.get_selectedDate() == null || cDtEnd.get_selectedDate() == null) {
                                            alert("Chưa nhập ngày!");
                                            return false;
                                        }
                                        updateChart(toOADate(new Date(cDtStart.get_selectedDate())).toString().replace('.', '_'), toOADate(new Date(cDtEnd.get_selectedDate())).toString().replace('.', '_'));
                                        return false;
                                    }

                                    function btnClearChart_Clicked(sender, args) {
                                        while (chart.graphs.length != 0) {
                                            chart.removeGraph(chart.graphs[0]);
                                        }
                                        colors = [];
                                        mreds = [];
                                        mblues = [];
                                        channels = [];
                                        chartData = [];
                                        chart.dataProvider = chartData;
                                        chart.validateData();
                                        chart.validateNow();
                                        return false;
                                    }
                //]]>
                                </script>
                                <%-- <script type="text/javascript" id="telerikClientEvents5">
                 //<![CDATA[
                 function btnUpdateChartFlow_Clicked(sender, args) {
                   
                    var cDtStart = $find("<%=radDateTimePicker1.ClientID %>");
                    var cDtEnd = $find("<%=radDateTimePicker2.ClientID %>");
                    if (cDtStart.get_selectedDate() == null || cDtEnd.get_selectedDate() == null) {
                        alert("Chưa nhập ngày!");
                    
                        return false;
                    }
                    updateChartFlow(toOADate(new Date(cDtStart.get_selectedDate())).toString().replace('.', '_'), toOADate(new Date(cDtEnd.get_selectedDate())).toString().replace('.', '_'));
                    return false;
                     //]]>
                 }
            </script>--%>
                                <%-- <script type="text/javascript" id="telerikClientEvents6">
                 //<![CDATA[
                 function btnUpdateChartMNF_Clicked(sender, args) {
                   
                    var cDtStart = $find("<%=radDateTimePicker3.ClientID %>");
                    var cDtEnd = $find("<%=radDateTimePicker4.ClientID %>");
                    if (cDtStart.get_selectedDate() == null || cDtEnd.get_selectedDate() == null) {
                        alert("Chưa nhập ngày!");
                    
                        return false;
                    }
                    updateChartMNF(toOADate(new Date(cDtStart.get_selectedDate())).toString().replace('.', '_'), toOADate(new Date(cDtEnd.get_selectedDate())).toString().replace('.', '_'));
                    return false;
                     //]]>
                 }
            </script>--%>
                                <script type="text/javascript" id="telerikClientEvents7">
                                    //<![CDATA[
                                    function btnUpdateChartMinMax_Clicked(sender, args) {
                                        // alert("aa");
                                        var cDtStart = $find("<%=radDateTimePicker5.ClientID %>");
                            var cDtEnd = $find("<%=radDateTimePicker6.ClientID %>");
                                        if (cDtStart.get_selectedDate() == null || cDtEnd.get_selectedDate() == null) {
                                            alert("Chưa nhập ngày!");

                                            return false;
                                        }
                                        updateChartMinMax(toOADate(new Date(cDtStart.get_selectedDate())).toString().replace('.', '_'), toOADate(new Date(cDtEnd.get_selectedDate())).toString().replace('.', '_'));
                                        return false;
                                        //]]>
                                    }
                                </script>
                                <script type="text/javascript" id="telerikClientEvents3">
                                    //<![CDATA[

                                    function radTreeViewSiteMap_Load(sender, args) {
                                        var treeViewSiteMap = $find("<%= radTreeViewSiteMap.ClientID %>");
                                        var nodes = treeViewSiteMap.get_allNodes();
                                        for (var i = 0; i < nodes.length; i++) {
                                            if (nodes[i].get_nodes() != null) {
                                                //nodes[i].expand();
                                                nodes[i].collapse();
                                            }
                                        }
                                    }
                //]]>
                                </script>
                                <script type="text/javascript" id="telerikClientEvents4">
                                    //<![CDATA[

                                    function radTreeViewSite_NodeClicked(sender, args) {
                                        //Add JavaScript handler code here
                                        var node = args.get_node();
                                        openWin(node.get_value());
                                    }
                //]]>
                                </script>
                                <script type="text/javascript">
                                    var url;

                                    var hostname = window.location.origin;
                                    if (hostname.indexOf("localhost") < 0)
                                        hostname = hostname + "/VivaServices/";
                                    else
                                        hostname = "http://localhost:63111";

                                    var urlGetSites = hostname + '/Service1.svc/GetSites';
                                    var urlGetSitesByUid = hostname + '/Service1.svc/GetSitesByUid/';
                                    var urlGetChannels = hostname + '/Service1.svc/GetChannels/';
                                    var urlGetChannelData = hostname + '/Service1.svc/GetChannelData/';
                                    var urlGetMultipleChannelsData = hostname + '/Service1.svc/GetMultipleChannelsData/';
                                    var urlGetDailyComplexData = hostname + '/Service1.svc/GetDailyComplexData/';
                                    var urlGetDisplayGroup = hostname + '/Service1.svc/getdisplaygroup';
                                    var urlGetSiteByDisplayGroup = hostname + '/Service1.svc/getsitebydisplaygroup/';

                                    //var urlMRed = 'http://i748.photobucket.com/albums/xx123/bttrung1988/mRed_zpscf7a64f6.png';
                                    var urlMRed = ' ~/App_Themes/red.png';
                                    var urlMGreen = 'http://i748.photobucket.com/albums/xx123/bttrung1988/mGreen_zpsf28ed33c.png';
                                    var urlMYellow = 'http://i748.photobucket.com/albums/xx123/bttrung1988/mYellow_zps26e7a5c5.png';
                                    var urlMOrange = 'http://i748.photobucket.com/albums/xx123/bttrung1988/mOrange_zpsacadba43.png';
                                    var map;
                                    var markers = [];
                                    var omarkers = [];
                                    var infowindow = new google.maps.InfoWindow({
                                        content: ''
                                    });

                                    var infoHtml;
                                    var dInfoHtml;
                                    var labelHtml;
                                    var dLabelHtml;
                                    var index;
                                    var strDate;
                                    var val;
                                    var parsedDate;
                                    var jsDate;

                                    var reds = ['orange', 'deeppink', 'darkviolet', 'brown', 'magenta'];
                                    var blues = ['green', 'cyan', 'darkblue', 'limegreen', 'teal'];
                                    var mreds = [];
                                    var mblues = [];

                                    var image_nor = {
                                        url: '../../App_Themes/green5.png',
                                        size: new google.maps.Size(20, 20),
                                        origin: new google.maps.Point(0, 0),
                                        //anchor: new google.maps.Point(-6, 45)
                                    };

                                    var image_err_low_press = {
                                        url: '../../App_Themes/red5.png',
                                        //url:'#',
                                        size: new google.maps.Size(20, 20),
                                        origin: new google.maps.Point(0, 0),
                                        //anchor: new google.maps.Point(-6, 45)
                                    };

                                    var image_err_sig_delay = {
                                        url: '../../App_Themes/orange5.png',
                                        size: new google.maps.Size(20, 20),
                                        origin: new google.maps.Point(0, 0),
                                        //anchor: new google.maps.Point(-6, 45)
                                    };

                                    var image_err_previous = {
                                        url: '../../App_Themes/yellow5.png',
                                        size: new google.maps.Size(20, 20),
                                        origin: new google.maps.Point(0, 0),
                                        //anchor: new google.maps.Point(-6, 45)
                                    };

                                    var img_van =
                                    {
                                        url: '../../App_Themes/bom.png',
                                        size: new google.maps.Size(30, 30),
                                        origin: new google.maps.Point(0, 0),
                                        //anchor: new google.maps.Point(-6, 45)
                                    }


                                    var chart;
                                    var end;
                                    var start;
                                    var channels = [];
                                    var chartData = [];
                                    var sites = [];
                                    var valueAxisPress;
                                    var valueAxisFlow;
                                    var colorRed = [];
                                    var colorBlue = [];
                                    var img = image_nor;
                                    var colors = [];

                                    let areaKMLFile = "https://112.78.4.162:2211/kml/LayerDMA.kmz";
                                    let kml_area;

                                    function getQueryStrings() {
                                        var assoc = {};
                                        var decode = function (s) { return decodeURIComponent(s.replace(/\+/g, " ")); };
                                        var queryString = location.search.substring(1);
                                        var keyValues = queryString.split('&');

                                        for (var i in keyValues) {
                                            var key = keyValues[i].split('=');
                                            if (key.length > 1) {
                                                assoc[decode(key[0])] = decode(key[1]);
                                            }
                                        }

                                        return assoc;
                                    }

                                    function window_init() {
                                        //MAP
                                        var qs = getQueryStrings();
                                        var uid = qs["uid"];

                                        zoom = 15;
                                        center = new google.maps.LatLng(10.934852, 108.102696);
                                        var myOptions = {
                                            zoom: zoom,
                                            center: center,
                                            mapTypeId: google.maps.MapTypeId.ROADMAP,
                                            streetViewControl: true
                                        };
                                        map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

                                        //SETTING CONTROL
                                        var settingControl = document.getElementById("setting-control");
                                        map.controls[google.maps.ControlPosition.RIGHT_TOP].push(settingControl);
                                        var layerControl = document.getElementById("layer-control");
                                        map.controls[google.maps.ControlPosition.RIGHT_TOP].push(layerControl);

                                        var url = 'https://trungangis.capnuoctrungan.vn/arcgis/rest/services/mangluoi/mapserver';
                                        //var url = 'http://113.161.76.112:6080/arcgis/rest/services/KHAWASSCOMapService/MapServer';
                                        var cpc = new gmaps.ags.CopyrightControl(map);
                                        var dynamap = new gmaps.ags.MapOverlay(url, {});
                                        dynamap.setMap(map);


                                        //TREEVIEW & MAP CONTENT
                                        var treeViewSite = $find("<%= radTreeViewSite.ClientID %>");
                                        url = urlGetSitesByUid + uid;
                                        $.getJSON(url, function (ds) {
                                            var displayGroup;
                                            $.each(ds.GetSitesByUidResult, function (i, s) {
                                                //TREEVIEW SITE NODE
                                                sites.push(s);
                                                var gpNode = treeViewSite.findNodeByText(s.DisplayGroup);
                                                if (gpNode == 'undefined' || gpNode == null) {
                                                    var gNode = new Telerik.Web.UI.RadTreeNode();
                                                    gNode.set_text(s.DisplayGroup);
                                                    gNode.set_allowDrag(false);
                                                    gNode.set_allowDrop(false);
                                                    //gNode.expand();--nghiavt for collape at loading time
                                                    treeViewSite.get_nodes().add(gNode);

                                                }


                                                var sNode = new Telerik.Web.UI.RadTreeNode();
                                                sNode.set_text(s.Location);
                                                sNode.set_value(s.SiteId);
                                                sNode.set_allowDrag(false);
                                                sNode.set_allowDrop(false);



                                                var gpNode = treeViewSite.findNodeByText(s.DisplayGroup);
                                                gpNode.get_nodes().add(sNode);
                                                if (s.LoggerId != '') url = urlGetChannels + s.LoggerId;
                                                else url = urlGetChannels + 'nothing';
                                                $.getJSON(url, function (dc) {

                                                    //MAP CONTENT
                                                    labelHtml = '<table cellspacing="0" cellpadding="10" style="border: solid gray 1px;font-size:1em"><tr><td colspan="2" style="text-align:center;font-weight:bold;color:blue;background-color:white"><span>' + s.SiteAliasName + '</span></td></tr>';
                                                    infoHtml = '<span style="font-weight:bold">Vị trí: ' + s.Location + '</span>'
                                                        + '<br/><span>Logger Id: ' + s.LoggerId + '</span>'
                                                        + '</br><span>Index: ';
                                                    index = 0;
                                                    dLabelHtml = '';
                                                    dInfoHtml = '';





                                                    $.each(dc.GetChannelsResult, function (j, c) {
                                                        //ICON
                                                        if (c.Press1 == true || c.Press2 == true) {
                                                            switch (c.Status) {
                                                                case 1:
                                                                    img = image_nor;
                                                                    break;
                                                                case 2:
                                                                    img = image_err_previous;
                                                                    break;
                                                                case 3:
                                                                    img = image_err_sig_delay;
                                                                    break;
                                                                case 4:
                                                                    img = image_err_low_press;
                                                                    break;
                                                                default:
                                                                    img = image_nor;
                                                                    break;
                                                            }
                                                        }
                                                        if (c.ChannelId[0] === "V") {
                                                            img = img_van;
                                                        }
                                                        //TREEVIEW CHANNEL NODE
                                                        var cNode = new Telerik.Web.UI.RadTreeNode();
                                                        cNode.set_text(c.ChannelName);
                                                        cNode.set_value(c.ChannelId + '|' + s.Location + '|' + c.ChannelName + '|' + c.Unit);
                                                        cNode.set_allowDrag(true);
                                                        cNode.set_allowDrop(true);
                                                        var spNode = treeViewSite.findNodeByText(s.Location);
                                                        spNode.get_nodes().add(cNode);
                                                        //MAP INFOWINDOW CONTENT
                                                        if (c.LastIndex != null && c.LastIndex != 'undefined') {
                                                            index -= c.LastIndex;
                                                        }
                                                        if (c.Timestamp != null && c.Timestamp != 'undefined') {
                                                            parsedDate = new Date(parseInt(c.Timestamp.substr(6)));
                                                            jsDate = new Date(parsedDate);
                                                            strDate = jsDate.getDate() + "/" + (jsDate.getMonth() + 1) + "/" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes();
                                                        }
                                                        else {
                                                            strDate = 'NO DATA';
                                                        }
                                                        if (c.Value != null && c.Value != 'undefined') {
                                                            val = c.Value;
                                                        }
                                                        else {
                                                            val = 'NO DATA';
                                                        }
                                                        dInfoHtml += "<tr><td><a href=\"#\" onclick=\"openChart('" + c.ChannelId + "','" + s.Location + " | " + c.ChannelName + "','" + c.Unit + "');\">" + c.ChannelName + "</a></td>"
                                                            + "<td>" + strDate + "</td>"
                                                            + '<td style="text-align:right;font-weight:bold;color:blue">' + val + "</td>"
                                                            + '<td style="font-weight:bold;color:blue">' + c.Unit + "</td></tr>";
                                                        //MAP LABEL CONTENT
                                                        if (c.Press1 == true || c.Press2 == true) {
                                                            var htmlImg = "";
                                                            if (c.Status2 == true && img != image_err_sig_delay) {
                                                                htmlImg += '<img alt="" border="0" src="' + urlMOrange + '"></img>';
                                                            }
                                                            if (c.Status3 == true && img != image_err_previous) {
                                                                htmlImg += '<img alt="" border="0" src="' + urlMYellow + '"></img>';
                                                            }
                                                            if (c.Status4 == true && img != image_err_low_press) {
                                                                htmlImg += '<img alt="" border="0" src="' + urlMRed + '"></img>';
                                                            }

                                                            //dLabelHtml = '<tr style="background-color:black"><td style="text-align:center;font-weight:bold;color:yellow;"><span>' + val + ' (' + c.Unit + ')' + '</span></td><td style="text-align:right">' + htmlImg + '</td></tr></table>';
                                                        }
                                                        if (c.DisplayOnLable == true || c.DisplayOnLable == 1) {
                                                            dLabelHtml += '<tr style="background-color:black"><td style="text-align:center;font-weight:bold;color:yellow; padding: 2px; border: none">' + c.ChannelName + '</td><td style="text-align:center;font-weight:bold;color:yellow;  padding: 2px; border: none"><span>' + val + ' (' + c.Unit + ')' + '</span></td></tr>';
                                                        }
                                                    });
                                                    dLabelHtml += '<tr style="background-color:black"><td colspan="2" style="text-align:center;font-weight:bold;color:yellow; padding: 2px; border: none"><span>' + Math.round(Math.abs(index)) + '</span></td></tr></table>';
                                                    labelHtml += dLabelHtml;
                                                    infoHtml += '<span style="font-weight:bold;color:blue;">' + Math.round(Math.abs(index)) + '</span></span>';
                                                    infoHtml += '<br/><table cellpadding="5" cellspacing="5">';
                                                    infoHtml += dInfoHtml;
                                                    //infoHtml += "<tr><td><a href=\"#\" onclick=\"openChartFlow('" + s.LoggerId + "');\">Total Flow</a></td></tr>"
                                                    //infoHtml += "<tr><td><a href=\"#\" onclick=\"openChartMNF('" + s.LoggerId + "','" + s.BaseLine + "');\">MinMax Flow Day</a></td></tr>"
                                                    if (s.LoggerId[0] != "V") {
                                                        infoHtml += "<tr><td><a href=\"#\" onclick=\"openChartMinMaxPre('" + s.LoggerId + "');\">MinMax Pressure Day</a></td></tr>"
                                                    }

                                                        + '</table>';
                                                    //LOAD TO MAP
                                                    var latlng = new google.maps.LatLng(s.Latitude, s.Longitude);
                                                    var anchor = new google.maps.Point(s.LabelAnchorX = null ? 40 : s.LabelAnchorX, s.LabelAnchorY = null ? 0 : s.LabelAnchorY);
                                                    var omarker = new google.maps.Marker({
                                                        id: 'om_' + s.SiteId,
                                                        position: latlng,
                                                        map: map,
                                                        icon: img,
                                                        html: infoHtml
                                                    });
                                                    var marker = new MarkerWithLabel({
                                                        id: 'm_' + s.SiteId,
                                                        position: latlng,
                                                        map: map,
                                                        icon: img,
                                                        draggable: false,
                                                        raiseOnDrag: true,
                                                        labelContent: labelHtml,
                                                        labelAnchor: anchor,
                                                        labelClass: "labels", // the CSS class for the label
                                                        labelInBackground: false,
                                                        html: infoHtml,
                                                        visible: true
                                                    });
                                                    google.maps.event.addListener(marker, 'click', function () {
                                                        infowindow.setContent(this.html);
                                                        infowindow.open(map, this);
                                                    });
                                                    google.maps.event.addListener(omarker, 'click', function () {
                                                        infowindow.setContent(this.html);
                                                        infowindow.open(map, this);
                                                    });
                                                    markers.push(marker);
                                                    omarkers.push(omarker);
                                                });
                                            })
                                        });
                                        //treeViewSite.commitChanges();
                                        //CONTEXT MENU
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
                                                    for (var i = 0; i < markers.length; i++) {
                                                        markers[i].setVisible(false);
                                                    }
                                                    break;
                                                case 'show_click':
                                                    for (var i = 0; i < markers.length; i++) {
                                                        markers[i].setVisible(true);
                                                    }
                                                    break;
                                            }
                                        });
                                    }

                                    function updateMap() {
                                        $.each(sites, function (i, s) {
                                            if (s.LoggerId != '') url = urlGetChannels + s.LoggerId;
                                            else url = urlGetChannels + 'nothing';
                                            $.getJSON(url, function (dc) {

                                                //MAP CONTENT
                                                labelHtml = '<table cellspacing="0" cellpadding="10" style="border: solid gray 1px;font-size:1em"><tr><td colspan="2" style="text-align:center;font-weight:bold;color:blue;background-color:white"><span>' + s.SiteAliasName + '</span></td></tr>';
                                                infoHtml = '<span style="font-weight:bold">Vị trí: ' + s.Location + '</span>'
                                                    + '<br/><span>Logger Id: ' + s.LoggerId + '</span>'
                                                    + '</br><span>Index: ';
                                                index = 0;
                                                dLabelHtml = '';
                                                dInfoHtml = '';
                                                $.each(dc.GetChannelsResult, function (j, c) {
                                                    //ICON
                                                    if (c.Press1 == true || c.Press2 == true) {
                                                        switch (c.Status) {
                                                            case 1:
                                                                img = image_nor;
                                                                break;
                                                            case 2:
                                                                img = image_err_previous;
                                                                break;
                                                            case 3:
                                                                img = image_err_sig_delay;
                                                                break;
                                                            case 4:
                                                                img = image_err_low_press;
                                                                break;
                                                            default:
                                                                img = image_nor;
                                                                break;
                                                        }
                                                    }
                                                    //MAP INFOWINDOW CONTENT
                                                    if (c.LastIndex != null && c.LastIndex != 'undefined') {
                                                        index -= c.LastIndex;
                                                    }
                                                    if (c.Timestamp != null && c.Timestamp != 'undefined') {
                                                        parsedDate = new Date(parseInt(c.Timestamp.substr(6)));
                                                        jsDate = new Date(parsedDate);
                                                        strDate = jsDate.getDate() + "/" + (jsDate.getMonth() + 1) + "/" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes();
                                                    }
                                                    else {
                                                        strDate = 'NO DATA';
                                                    }
                                                    if (c.Value != null && c.Value != 'undefined') {
                                                        val = c.Value;
                                                    }
                                                    else {
                                                        val = 'NO DATA';
                                                    }
                                                    dInfoHtml += "<tr><td><a href=\"#\" onclick=\"openChart('" + c.ChannelId + "','" + s.Location + " | " + c.ChannelName + "','" + c.Unit + "');\">" + c.ChannelName + "</a></td>"
                                                        + "<td>" + strDate + "</td>"
                                                        + '<td style="text-align:right;font-weight:bold;color:blue">' + val + "</td>"
                                                        + '<td style="font-weight:bold;color:blue">' + c.Unit + "</td></tr>";
                                                    //MAP LABEL CONTENT
                                                    if (c.Press1 == true || c.Press2 == true) {

                                                        var htmlImg = "";
                                                        if (c.Status2 == true && img != image_err_sig_delay) {
                                                            htmlImg += '<img alt="" border="0" src="' + urlMOrange + '"></img>';
                                                        }
                                                        if (c.Status3 == true && img != image_err_previous) {
                                                            htmlImg += '<img alt="" border="0" src="' + urlMYellow + '"></img>';
                                                        }
                                                        if (c.Status4 == true && img != image_err_low_press) {
                                                            htmlImg += '<img alt="" border="0" src="' + urlMRed + '"></img>';
                                                        }

                                                        //dLabelHtml = '<tr style="background-color:black"><td style="text-align:center;font-weight:bold;color:yellow;"><span>' + val + ' (' + c.Unit + ')' + '</span></td><td style="text-align:right">' + htmlImg + '</td></tr></table>';

                                                    }
                                                    if (c.DisplayOnLable == true || c.DisplayOnLable == 1) {
                                                        dLabelHtml += '<tr style="background-color:black"><td style="text-align:center;font-weight:bold;color:yellow; padding: 2px; border: none">' + c.ChannelName + '</td><td style="text-align:center;font-weight:bold;color:yellow;  padding: 2px; border: none"><span>' + val + ' (' + c.Unit + ')' + '</span></td></tr>';
                                                    }
                                                });
                                                dLabelHtml += '<tr style="background-color:black"><td colspan="2" style="text-align:center;font-weight:bold;color:yellow; padding: 2px; border: none"><span>' + Math.round(Math.abs(index)) + '</span></td></tr></table>';
                                                labelHtml += dLabelHtml;
                                                infoHtml += '<span style="font-weight:bold;color:blue;">' + Math.round(Math.abs(index)) + '</span></span>';
                                                infoHtml += '<br/><table cellpadding="5" cellspacing="5">';
                                                infoHtml += dInfoHtml;
                                                //infoHtml += "<tr><td><a href=\"#\" onclick=\"openChartFlow('" + s.LoggerId + "');\">Total Flow</a></td></tr>"
                                                //infoHtml += "<tr><td><a href=\"#\" onclick=\"openChartMNF('" + s.LoggerId + "','" + s.BaseLine + "');\">MinMax Flow Day</a></td></tr>"
                                                if (s.LoggerId[0] != "V") {
                                                    infoHtml += "<tr><td><a href=\"#\" onclick=\"openChartMinMaxPre('" + s.LoggerId + "');\">MinMax Pressure Day</a></td></tr>"
                                                }

                                                    + '</table>';
                                                //LOAD TO MAP
                                                loop_m:
                                                for (var k = 0; k < markers.length; k++) {
                                                    if (markers[k].id == ('m_' + s.SiteId)) {

                                                        markers[k].setIcon(img);
                                                        markers[k].html = infoHtml;
                                                        markers[k].labelContent = labelHtml;
                                                        markers[k].label.setContent();
                                                        break loop_m;
                                                    }
                                                }
                                                loop_om:
                                                for (var k = 0; k < omarkers.length; k++) {
                                                    if (omarkers[k].id == ('om_' + s.SiteId)) {
                                                        omarkers[k].setIcon(img);
                                                        break loop_om;
                                                    }
                                                }
                                            });
                                        });

                                    }

                                    function openWin(id) {
                                        loop_ow:
                                        for (var i = 0; i < markers.length; i++) {
                                            if (markers[i].id == ('m_' + id)) {
                                                map.setZoom(17);
                                                map.panTo(markers[i].getPosition());
                                                google.maps.event.trigger(markers[i], 'click');
                                                break loop_ow;
                                            }
                                        }
                                    };

                                    function dtToString(d) {
                                        var u = d.getFullYear() + "|" + (d.getMonth() + 1) + "|" + d.getDate() + "|" + d.getHours() + "|" + d.getMinutes() + "|" + d.getSeconds();
                                        return u;
                                    }

                                    var toOADate = (function () {
                                        var epoch = new Date(1899, 11, 30);
                                        var msPerDay = 8.64e7;

                                        return function (d) {
                                            var v = -1 * (epoch - d) / msPerDay;

                                            // Deal with dates prior to 1899-12-30 00:00:00
                                            var dec = v - Math.floor(v);

                                            if (v < 0 && dec) {
                                                v = Math.floor(v) - dec;
                                            }

                                            return v;
                                        }
                                    }());


                                    var fromOADate = (function () {
                                        var epoch = new Date(1899, 11, 30);
                                        var msPerDay = 8.64e7;

                                        return function (n) {
                                            // Deal with -ve values
                                            var dec = n - Math.floor(n);

                                            if (n < 0 && dec) {
                                                n = Math.floor(n) - dec;
                                            }

                                            return new Date(n * msPerDay + +epoch);
                                        }
                                    }());

                                    /////////////////////chart minmax Press///////////////////////////////////////////////////////////////////////////////////
                                    function openChartMinMaxPre(loggerId) {
                                        var window = $find("<%= radminmaxPress.ClientID %>");
                            window.show();
                            window.center();
                            end = new Date();
                            start = new Date();
                            start = new Date(start.setDate(start.getDate() - 30));
                            var cDtStart = $find("<%=radDateTimePicker5.ClientID %>");
                            var cDtEnd = $find("<%=radDateTimePicker6.ClientID %>");
                                        cDtStart.set_selectedDate(start);
                                        cDtEnd.set_selectedDate(end);
                                        start = toOADate(start);
                                        end = toOADate(end);
                                        start = start.toString().replace('.', '_');
                                        end = end.toString().replace('.', '_');
                                        console.log(start);
                                        console.log(end);
                                        var channel = { id: loggerId, max: "_max" };
                                        channels = [];
                                        channels.push(channel);
                                        colors = [];
                                        mreds = [];
                                        mblues = [];
                                        drawChartMinMax(channels[0], start, end);
                                    };
                                    // this method is called when chart is first inited as we listen for "dataUpdated" event
                                    function zoomchartMinMax() {
                                        // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
                                        chartMinMax.zoomToIndexes(chartDataMinMax.length - chartDataMinMax.length, chartDataMinMax.length - 1); urlGetDailyComplexData
                                    }


                                    function drawChartMinMax(channel, start, end) {
                                        //alert(channel.sum);

                                        var url = urlGetDailyComplexData + channel.id + "/" + start + "/" + end;
                                        $.getJSON(url, function (d) {
                                            chartDataMinMax = [];
                                            //alert(channel.base);
                                            $.each(d.GetDailyComplexDataResult, function (i, val) {
                                                var parsedDate = new Date(parseInt(val.TimeStamp.substr(6)));
                                                var jsDate = new Date(parsedDate);
                                                chartDataMinMax.push({
                                                    TimeStamp: jsDate
                                                });
                                                if (val.MinFlowRate != null && val.MinFlowRate != 'undefined') {
                                                    chartDataMinMax[i]["'" + channel.id + "'"] = val.MinPressure;
                                                    chartDataMinMax[i]["'" + channel.max + "'"] = val.MaxPressure;

                                                }

                                            });


                                            //SERIAL CHART
                                            chartMinMax = new AmCharts.AmSerialChart();
                                            chartMinMax.pathToImages = "../../js/amcharts/images/";
                                            chartMinMax.dataProvider = chartDataMinMax;
                                            chartMinMax.type = "serial";
                                            chartMinMax.dataTableId = "chart_table_MinMax";
                                            chartMinMax.categoryField = "TimeStamp";
                                            chartMinMax.balloon.bulletSize = 5;
                                            //ZOOM
                                            chartMinMax.addListener("dataUpdated", zoomchartMinMax);
                                            //AXES
                                            //X

                                            var categoryAxis = chartMinMax.categoryAxis;
                                            categoryAxis.parseDates = true;
                                            categoryAxis.minPeriod = "DD";
                                            categoryAxis.dashLength = 1;
                                            categoryAxis.minorGridEnabled = true;
                                            categoryAxis.twoLineMode = true;
                                            categoryAxis.dateFormats = [{
                                                period: 'fff',
                                                format: 'JJ:NN:SS'
                                            }, {
                                                period: 'ss',
                                                format: 'JJ:NN:SS'
                                            }, {
                                                period: 'mm',
                                                format: 'JJ:NN'
                                            }, {
                                                period: 'hh',
                                                format: 'JJ:NN'
                                            }, {
                                                period: 'DD',
                                                format: 'DD'
                                            }, {
                                                period: 'WW',
                                                format: 'DD'
                                            }, {
                                                period: 'MM',
                                                format: 'YYYY'
                                            }, {
                                                period: 'YYYY',
                                                format: 'YYYY'
                                            }];

                                            categoryAxis.axisColor = "#DADADA";
                                            categoryAxis.gridAlpha = 0.15;
                                            //AXE
                                            //Y1
                                            valueAxisSum = new AmCharts.ValueAxis();
                                            valueAxisSum.axisColor = 'blue';
                                            valueAxisSum.axisThickness = 1;
                                            valueAxisSum.title = 'MinMax Pressure';
                                            valueAxisSum.position = 'left';
                                            valueAxisSum.titleColor = 'blue';
                                            chartMinMax.addValueAxis(valueAxisSum);

                                            //GRAPH COLOR


                                            // GRAPH
                                            var graph1 = new AmCharts.AmGraph();
                                            //alert("a");
                                            graph1.id = "MNF";
                                            graph1.valueAxis = valueAxisSum;
                                            graph1.title = "Min Press";
                                            graph1.valueField = "'" + channel.id + "'";
                                            graph1.bullet = "round";
                                            graph1.bulletBorderColor = "#FFFFFF";
                                            // graph.negativeBase = baseLine;
                                            // graph.negativeLineColor = "red";                        
                                            graph1.bulletBorderThickness = 2;
                                            graph1.bulletBorderAlpha = 1;
                                            graph1.bulletSize = 8;
                                            graph1.lineThickness = 1;
                                            graph1.lineColor = "yellow";
                                            graph1.hideBulletsCount = 50;
                                            //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                            chartMinMax.addGraph(graph1);

                                            // GRAPH                       
                                            var graph2 = new AmCharts.AmGraph();
                                            //alert("a");
                                            graph2.id = "MNFSUM";
                                            graph2.valueAxis = valueAxisSum;
                                            graph2.title = "Max Press";
                                            graph2.valueField = "'" + channel.max + "'";
                                            graph2.bullet = "round";
                                            graph2.bulletBorderColor = "#FFFFFF";
                                            // graph.negativeBase = 25;
                                            // graph.negativeLineColor = "green";                        
                                            graph2.bulletBorderThickness = 2;
                                            graph2.bulletBorderAlpha = 1;
                                            graph2.bulletSize = 8;
                                            graph2.lineThickness = 1;
                                            graph2.lineColor = "blue";
                                            graph2.hideBulletsCount = 50;
                                            //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                            chartMinMax.addGraph(graph2);


                                            //add table

                                            var total = 0;
                                            var min = 100000;
                                            var max = 0;
                                            // get chart data
                                            var data = chartMinMax.dataProvider;
                                            // create a table
                                            var holder = document.getElementById(chartMinMax.dataTableId);
                                            holder.innerHTML = "";
                                            // if (holder.childElementCount == 0) {
                                            var table = document.createElement("table");
                                            holder.appendChild(table);
                                            var tr, td;

                                            // add first row
                                            for (var x = 0; x < chartMinMax.dataProvider.length; x++) {

                                                // first row
                                                if (x == 0) {
                                                    tr = document.createElement("tr");
                                                    table.appendChild(tr);
                                                    td = document.createElement("th");
                                                    //td.innerHTML = chartMinMax.categoryAxis.title;
                                                    td.innerHTML = "Timestamp";
                                                    tr.appendChild(td);
                                                    for (var i = 0; i < chartMinMax.graphs.length; i++) {
                                                        td = document.createElement('th');
                                                        td.innerHTML = chartMinMax.graphs[i].title;
                                                        tr.appendChild(td);
                                                    }
                                                }

                                                // add rows
                                                tr = document.createElement("tr");
                                                table.appendChild(tr);
                                                td = document.createElement("td");
                                                td.className = "row-title";

                                                // td.innerHTML = chartMinMax.dataProvider[x][chartMinMax.categoryField].toUTCString();
                                                var todayTime = new Date(chartMinMax.dataProvider[x][chartMinMax.categoryField]);
                                                var month = todayTime.getMonth() + 1;
                                                var day = todayTime.getDate();
                                                var year = todayTime.getFullYear();
                                                var dt = day + "/" + month + "/" + year;
                                                // alert(dt + "aaaa");
                                                // var dt = chartMinMax.dataProvider[x][chartMinMax.categoryField].substr(14);
                                                td.innerHTML = dt;
                                                tr.appendChild(td);
                                                var valuetotal;
                                                for (var i = 0; i < chartMinMax.graphs.length; i++) {
                                                    td = document.createElement('td');
                                                    valuetotal = chartMinMax.dataProvider[x][chartMinMax.graphs[i].valueField];
                                                    td.innerHTML = valuetotal;
                                                    tr.appendChild(td);
                                                    if (valuetotal > max) {
                                                        max = valuetotal;
                                                    }
                                                    if (valuetotal < min) {
                                                        min = valuetotal;
                                                    }
                                                    //if (i == 1)
                                                    //   {
                                                    //    total += chartMinMax.dataProvider[x][chartMinMax.graphs[i].valueField];
                                                    //   }
                                                }
                                            }
                                            //document.getElementById("totalMinMax").innerHTML = Math.round(total);
                                            document.getElementById("minPress").innerHTML = min;
                                            document.getElementById("maxPress").innerHTML = max;
                                            // $("#totalflow").load("total");
                                            //  }//end if


                                            // CURSOR
                                            var chartCursor = new AmCharts.ChartCursor();
                                            chartCursor.categoryBalloonDateFormat = "MMM DD, YYYY ";
                                            chartMinMax.addChartCursor(chartCursor);
                                            // SCROLLBAR
                                            var chartScrollbar = new AmCharts.ChartScrollbar();
                                            chartScrollbar.autoGridCount = true;
                                            chartScrollbar.scrollbarHeight = 20;
                                            chartMinMax.addChartScrollbar(chartScrollbar);
                                            // LEGEND
                                            var legend = new AmCharts.AmLegend();
                                            legend.marginLeft = 110;
                                            legend.useGraphSettings = true;
                                            chartMinMax.addLegend(legend);
                                            //MOUSE
                                            chartMinMax.mouseWheelZoomEnabled = true;
                                            chartMinMax.mouseWheelScrollEnabled = true;
                                            chartMinMax.creditsPosition = "bottom-right";
                                            //EXPORT
                                            chartMinMax.amExport = {
                                                top: 21,
                                                right: 21,
                                                buttonColor: '#EFEFEF',
                                                buttonRollOverColor: '#DDDDDD',
                                                exportPNG: true,
                                                exportJPG: true,
                                                exportPDF: true,
                                                exportSVG: true
                                            }
                                            // WRITE
                                            chartMinMax.write("chart_canvas_MinMax");
                                        });
                                    };
                                    ////////////////////////////////////////////////////////////////////////
                                    function openChart(channelId, namePath, unit) {
                                        var window = $find("<%= radWindowChart.ClientID %>");
                            window.show();
                            window.center();
                            end = new Date();
                            start = new Date();
                            start = new Date(start.setDate(start.getDate() - 3));
                            var cDtStart = $find("<%=radDateTimePickerStart.ClientID %>");
                            var cDtEnd = $find("<%=radDateTimePickerEnd.ClientID %>");
                                        cDtStart.set_selectedDate(start);
                                        cDtEnd.set_selectedDate(end);
                                        if (channelId[0] != "V") {
                                            start = toOADate(start);
                                            end = toOADate(end);
                                            start = start.toString().replace('.', '_');
                                            end = end.toString().replace('.', '_');
                                        }
                                        console.log(start);
                                        console.log(end);
                                        var channel = { id: channelId, namePath: namePath, unit: unit };
                                        channels = [];
                                        channels.push(channel);
                                        colors = [];
                                        mreds = [];
                                        mblues = [];
                                        drawChart(channels[0], start, end);
                                    };

                                    // this method is called when chart is first inited as we listen for "dataUpdated" event
                                    function zoomChart() {
                                        // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
                                        chart.zoomToIndexes(chartData.length - chartData.length, chartData.length - 1);
                                    }

                                    // changes cursor mode from pan to select
                                    function setPanSelect() {
                                        if (document.getElementById("rb1").checked) {
                                            chartCursor.pan = false;
                                            chartCursor.zoomable = true;
                                        } else {
                                            chartCursor.pan = true;
                                        }
                                        chart.validateNow();
                                    }

                                    function drawChart(channel, start, end) {
                                        var url;
                                        if (channel.id[0] === "V") {
                                            console.log(channel.id)
                                            let urlHostNameVan = `http://117.2.130.229:3341/api/datachart`;

                                            start = Math.ceil(start.getTime() / 1000);
                                            end = Math.ceil(end.getTime() / 1000);

                                            url = `${urlHostNameVan}/${channel.id}/${start}/${end}`;
                                        }
                                        else {
                                            url = urlGetChannelData + channel.id + "/" + start + "/" + end;
                                        }



                                        $.getJSON(url, function (d) {
                                            chartData = [];
                                            if (channel.id[0] === "V") {
                                                for (let i = 0; i < d.length; i++) {
                                                    let obj = {};
                                                    obj.Timestamp = ConverDate(d[i].TimeStamp)
                                                    if (d[i].length != 0) {
                                                        if (d[i] != undefined)
                                                            if (d[i].Value != null && d[i].Value != undefined) {
                                                                obj[`'${channel.id}'`] = d[i].Value == 0 ? 0 : d[i].Value;
                                                            }
                                                    }
                                                    chartData.push(obj);
                                                }

                                            }
                                            else {
                                                $.each(d.GetChannelDataResult, function (i, val) {
                                                    var parsedDate = new Date(parseInt(val.Timestamp.substr(6)));
                                                    var jsDate = new Date(parsedDate);
                                                    chartData.push({
                                                        Timestamp: jsDate
                                                    });
                                                    if (val.Value != null && val.Value != 'undefined')
                                                        chartData[i]["'" + channel.id + "'"] = val.Value;
                                                });
                                            }

                                            chartData.sort(function (a, b) {
                                                return a.Timestamp.getTime() - b.Timestamp.getTime()
                                            })

                                            //SERIAL CHART
                                            chart = new AmCharts.AmSerialChart();
                                            chart.pathToImages = "../../js/amcharts/images/";
                                            chart.dataProvider = chartData;
                                            chart.categoryField = "Timestamp";
                                            chart.balloon.bulletSize = 5;
                                            //ZOOM
                                            chart.addListener("dataUpdated", zoomChart);
                                            //AXES
                                            //X
                                            var categoryAxis = chart.categoryAxis;
                                            categoryAxis.parseDates = true;
                                            categoryAxis.minPeriod = "mm";
                                            categoryAxis.dashLength = 1;
                                            categoryAxis.minorGridEnabled = true;
                                            categoryAxis.twoLineMode = true;
                                            categoryAxis.dateFormats = [{
                                                period: 'fff',
                                                format: 'JJ:NN:SS'
                                            }, {
                                                period: 'ss',
                                                format: 'JJ:NN:SS'
                                            }, {
                                                period: 'mm',
                                                format: 'JJ:NN'
                                            }, {
                                                period: 'hh',
                                                format: 'JJ:NN'
                                            }, {
                                                period: 'DD',
                                                format: 'DD'
                                            }, {
                                                period: 'WW',
                                                format: 'DD'
                                            }, {
                                                period: 'MM',
                                                format: 'YYYY'
                                            }, {
                                                period: 'YYYY',
                                                format: 'YYYY'
                                            }];

                                            categoryAxis.axisColor = "#DADADA";
                                            categoryAxis.gridAlpha = 0.15;
                                            //AXE
                                            //Y1
                                            valueAxisPress = new AmCharts.ValueAxis();
                                            valueAxisPress.axisColor = 'red';
                                            valueAxisPress.axisThickness = 1;
                                            valueAxisPress.title = 'm';
                                            valueAxisPress.titleColor = 'red';
                                            chart.addValueAxis(valueAxisPress);
                                            //Y2 
                                            valueAxisFlow = new AmCharts.ValueAxis();
                                            valueAxisFlow.axisColor = 'blue';
                                            valueAxisFlow.axisThickness = 1;
                                            valueAxisFlow.position = 'right';
                                            valueAxisFlow.title = 'm3/h';
                                            valueAxisFlow.titleColor = 'blue';
                                            chart.addValueAxis(valueAxisFlow);
                                            //GRAPH COLOR
                                            var type;
                                            var color;
                                            switch (channel.unit) {
                                                case "m":
                                                    type = valueAxisPress;
                                                    color = '#ff0000';
                                                    colors.push(color);
                                                    break;
                                                case "m3/h":
                                                    type = valueAxisFlow;
                                                    color = '#0000ff';
                                                    colors.push(color);
                                                    break;
                                                default:
                                                    type = valueAxisPress;
                                                    break;
                                            }
                                            // GRAPH
                                            var graph = new AmCharts.AmGraph();
                                            graph.id = channel.namePath;
                                            graph.valueAxis = type;
                                            graph.title = channel.namePath;
                                            graph.valueField = "'" + channel.id + "'";
                                            graph.bullet = "round";
                                            graph.bulletBorderColor = "#FFFFFF";
                                            graph.bulletBorderThickness = 2;
                                            graph.bulletBorderAlpha = 1;
                                            graph.bulletSize = 8;
                                            graph.lineThickness = 1;
                                            graph.lineColor = color;
                                            graph.hideBulletsCount = 50;
                                            //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";
                                            chart.addGraph(graph);
                                            // CURSOR
                                            var chartCursor = new AmCharts.ChartCursor();
                                            chartCursor.categoryBalloonDateFormat = "MMM DD, YYYY JJ:NN";
                                            chart.addChartCursor(chartCursor);
                                            // SCROLLBAR
                                            var chartScrollbar = new AmCharts.ChartScrollbar();
                                            chartScrollbar.autoGridCount = true;
                                            chartScrollbar.scrollbarHeight = 20;
                                            chart.addChartScrollbar(chartScrollbar);
                                            // LEGEND
                                            var legend = new AmCharts.AmLegend();
                                            legend.marginLeft = 110;
                                            legend.useGraphSettings = true;
                                            chart.addLegend(legend);
                                            //MOUSE
                                            chart.mouseWheelZoomEnabled = true;
                                            chart.mouseWheelScrollEnabled = true;
                                            chart.creditsPosition = "bottom-right";
                                            //EXPORT
                                            chart.amExport = {
                                                top: 21,
                                                right: 21,
                                                buttonColor: '#EFEFEF',
                                                buttonRollOverColor: '#DDDDDD',
                                                exportPNG: true,
                                                exportJPG: true,
                                                exportPDF: true,
                                                exportSVG: true
                                            }
                                            // WRITE
                                            chart.write("chart_canvas");
                                        });
                                    };

                                    function ConverDate(date) {
                                        let stringSplit = date.toString().split("-");
                                        let year = parseInt(stringSplit[0]);
                                        let month = parseInt(stringSplit[1]) < 10 ? `0${parseInt(stringSplit[1])}` : parseInt(stringSplit[1]);
                                        let stringSplit2 = stringSplit[2].split("T");
                                        let day = parseInt(stringSplit2[0]) < 10 ? `0${parseInt(stringSplit2[0])}` : parseInt(stringSplit2[0]);
                                        let stringSplit3 = stringSplit2[1].split(":");
                                        let hours = parseInt(stringSplit3[0]) < 10 ? `0${parseInt(stringSplit3[0])}` : parseInt(stringSplit3[0]);
                                        let minutes = parseInt(stringSplit3[1]) < 10 ? `0${parseInt(stringSplit3[1])}` : parseInt(stringSplit3[1]);
                                        let seconds = parseInt(stringSplit3[2]) < 10 ? `0${parseInt(stringSplit3[2])}` : parseInt(stringSplit3[2]);

                                        return new Date(year, month - 1, day, hours, minutes, seconds);
                                    }

                                    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////              
                                    function updateChartMinMax(start, end) {
                                        //alert("a");
                                        var url = urlGetDailyComplexData + channels[0].id + "/" + start + "/" + end;
                                        //var baseLine = channels[0].base;
                                        $.getJSON(url, function (d) {
                                            chartDataMinMax = [];
                                            $.each(d.GetDailyComplexDataResult, function (i, val) {
                                                var parsedDate = new Date(parseInt(val.TimeStamp.substr(6)));
                                                var jsDate = new Date(parsedDate);
                                                chartDataMinMax.push({
                                                    TimeStamp: jsDate
                                                });
                                                if (val.Output != null && val.Output != 'undefined') {

                                                    chartDataMinMax[i]["'" + channels[0].id + "'"] = val.MinPressure;
                                                    chartDataMinMax[i]["'" + channels[0].max + "'"] = val.MaxPressure;

                                                }

                                            });

                                            $.each(channels, function (k, c) {

                                                var m_f = false;
                                                // alert(chart_flow.graphs.length);
                                                for (var i = 0; i < chartMinMax.graphs.length; i++) {

                                                    if (chartMinMax.graphs[i].valueField == ("'" + c.id + "'")) {
                                                        // alert(c.id);
                                                        m_f = true;
                                                    }
                                                }
                                                if (m_f == false) {

                                                    // GRAPH
                                                    var graph1 = new AmCharts.AmGraph();
                                                    //alert("a");
                                                    graph1.id = "MNF";
                                                    graph1.valueAxis = valueAxisSum;
                                                    graph1.title = "Min Press";
                                                    graph1.valueField = "'" + channels[0].id + "'";
                                                    graph1.bullet = "round";
                                                    graph1.bulletBorderColor = "#FFFFFF";
                                                    graph1.bulletBorderThickness = 2;
                                                    graph1.bulletBorderAlpha = 1;
                                                    graph1.bulletSize = 8;
                                                    graph1.lineThickness = 1;
                                                    graph1.lineColor = "yellow";
                                                    graph1.hideBulletsCount = 50;
                                                    //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                                    chartMinMax.addGraph(graph1);

                                                    // GRAPH                       
                                                    var graph2 = new AmCharts.AmGraph();
                                                    //alert("a");
                                                    graph2.id = "MNFSUM";
                                                    graph2.valueAxis = valueAxisSum;
                                                    graph2.title = "Max Press";
                                                    graph2.valueField = "'" + channels[0].max + "'";
                                                    graph2.bullet = "round";
                                                    graph2.bulletBorderColor = "#FFFFFF";
                                                    graph2.bulletBorderThickness = 2;
                                                    graph2.bulletBorderAlpha = 1;
                                                    graph2.bulletSize = 8;
                                                    graph2.lineThickness = 1;
                                                    graph2.lineColor = "blue";
                                                    graph2.hideBulletsCount = 50;
                                                    //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                                    chartMinMax.addGraph(graph2);


                                                }
                                            });

                                            //SERIAL CHART
                                            chartMinMax.dataTableId = "chart_table_MinMax";
                                            chartMinMax.dataProvider = chartDataMinMax;
                                            chartMinMax.validateData();
                                            chartMinMax.validateNow();

                                            //add table
                                            var total = 0;
                                            var min = 1000000;
                                            var max = 0;
                                            // get chart data
                                            var data = chartMinMax.dataProvider;
                                            // create a table
                                            var holder = document.getElementById(chartMinMax.dataTableId);
                                            holder.innerHTML = "";
                                            // if (holder.childElementCount == 0) {
                                            var table = document.createElement("table");
                                            holder.appendChild(table);
                                            var tr, td;
                                            // add first row
                                            for (var x = 0; x < chartMinMax.dataProvider.length; x++) {
                                                // first row
                                                if (x == 0) {
                                                    tr = document.createElement("tr");
                                                    table.appendChild(tr);
                                                    td = document.createElement("th");
                                                    //td.innerHTML = chartMinMax.categoryAxis.title;
                                                    td.innerHTML = "Timestamp";
                                                    tr.appendChild(td);
                                                    for (var i = 0; i < chartMinMax.graphs.length; i++) {
                                                        td = document.createElement('th');
                                                        td.innerHTML = chartMinMax.graphs[i].title;
                                                        tr.appendChild(td);
                                                    }
                                                }
                                                // add rows
                                                tr = document.createElement("tr");
                                                table.appendChild(tr);
                                                td = document.createElement("td");
                                                td.className = "row-title";

                                                // td.innerHTML = chartMinMax.dataProvider[x][chartMinMax.categoryField].toUTCString();
                                                var todayTime = new Date(chartMinMax.dataProvider[x][chartMinMax.categoryField]);
                                                var month = todayTime.getMonth() + 1;
                                                var day = todayTime.getDate();
                                                var year = todayTime.getFullYear();
                                                var dt = day + "/" + month + "/" + year;
                                                td.innerHTML = dt;
                                                tr.appendChild(td);
                                                // alert(chartMinMax.graphs.length);
                                                var valuetotal;
                                                for (var i = 0; i < chartMinMax.graphs.length; i++) {
                                                    td = document.createElement('td');
                                                    td.innerHTML = chartMinMax.dataProvider[x][chartMinMax.graphs[i].valueField];
                                                    tr.appendChild(td);
                                                    valuetotal = chartMinMax.dataProvider[x][chartMinMax.graphs[i].valueField];
                                                    if (valuetotal > max) {
                                                        max = valuetotal;
                                                    }
                                                    if (valuetotal < min) {
                                                        min = valuetotal;
                                                    }
                                                    //if (i == 1) {
                                                    //    total += chartMinMax.dataProvider[x][chartMinMax.graphs[i].valueField];
                                                    //}
                                                }
                                            }
                                            document.getElementById("minPress").innerHTML = min;
                                            document.getElementById("maxPress").innerHTML = max;
                                            // document.getElementById("totalMinMax").innerHTML = Math.round(total);
                                            // $("#totalflow").load("total");
                                            //  }//end if

                                        });
                                    };
                                    //////////////////////////////////////////////////////////////////////////////////////////////////////////
                                    ///////////////////////////////////////////////////////////////////
                                    function updateChart(start, end) {
                                        var multipleChannelId = "";
                                        for (var i = 0; i < channels.length; i++) {
                                            if (i != channels.length - 1)
                                                multipleChannelId += channels[i].id + "|";
                                            else multipleChannelId += channels[i].id;
                                        }
                                        var url = urlGetMultipleChannelsData + multipleChannelId + "/" + start + "/" + end;
                                        //alert(url);
                                        $.getJSON(url, function (d) {
                                            chartData = [];
                                            $.each(d.GetMultipleChannelsDataResult, function (i, val) {
                                                var parsedDate = new Date(parseInt(val.Timestamp.substr(6)));
                                                var jsDate = new Date(parsedDate);

                                                chartData.push({
                                                    Timestamp: jsDate
                                                });

                                                for (var j = 0; j < channels.length; j++) {
                                                    if (val.Values[j] != null && val.Values[j] != 'undefined')
                                                        chartData[i]["'" + channels[j].id + "'"] = val.Values[j];
                                                }
                                            });

                                            $.each(channels, function (k, c) {
                                                var m_f = false;
                                                for (var i = 0; i < chart.graphs.length; i++) {
                                                    if (chart.graphs[i].valueField == ("'" + c.id + "'")) {
                                                        m_f = true;
                                                    }
                                                }
                                                if (m_f == false) {
                                                    var type;
                                                    var color = "";
                                                    switch (c.unit) {
                                                        case "m":
                                                            type = valueAxisPress;
                                                            var fr = false;
                                                            for (var i = 0; i < colors.length; i++) {
                                                                if (colors[i] == '#ff0000') fr = true;
                                                            }
                                                            if (fr == true) {
                                                                if (mreds.length == 0) {
                                                                    mreds.push(reds[0]);
                                                                    color = mreds[0];
                                                                }
                                                                else if (mreds.length != reds.length) {
                                                                    mreds.push(reds[mreds.length]);
                                                                    color = mreds[mreds.length - 1];
                                                                }
                                                                else {
                                                                    color = randomColor();
                                                                }
                                                                //color = randomColor({
                                                                //    luminosity: 'bright',
                                                                //    hue: 'orange'
                                                                //});
                                                            }
                                                            else color = '#ff0000';
                                                            colors.push(color);
                                                            break;
                                                        case "m3/h":
                                                            type = valueAxisFlow;
                                                            var fb = false;
                                                            for (var i = 0; i < colors.length; i++) {
                                                                if (colors[i] == '#0000ff') fb = true;
                                                            }
                                                            if (fb == true) {
                                                                if (mblues.length == 0) {
                                                                    mblues.push(blues[0]);
                                                                    color = mblues[0];
                                                                }
                                                                else if (mblues.length != blues.length) {
                                                                    mblues.push(blues[mblues.length]);
                                                                    color = mblues[mblues.length - 1];
                                                                }
                                                                else {
                                                                    color = randomColor();
                                                                }
                                                                //color = randomColor({
                                                                //    luminosity: 'bright',
                                                                //    hue: 'purple'
                                                                //});
                                                            }
                                                            else color = '#0000ff';
                                                            colors.push(color);
                                                            break;
                                                        default:
                                                            type = valueAxisPress;

                                                            break;
                                                    }
                                                    // GRAPH
                                                    var graph = new AmCharts.AmGraph();
                                                    graph.id = c.namePath;
                                                    graph.valueAxis = type;
                                                    graph.title = c.namePath;
                                                    graph.valueField = "'" + c.id + "'";
                                                    graph.bullet = "round";
                                                    graph.bulletBorderColor = "#FFFFFF";
                                                    graph.bulletBorderThickness = 2;
                                                    graph.bulletBorderAlpha = 1;
                                                    graph.bulletSize = 8;
                                                    graph.lineThickness = 1;
                                                    graph.lineColor = color;
                                                    graph.hideBulletsCount = 50;
                                                    //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";
                                                    chart.addGraph(graph);
                                                }
                                            });
                                            chart.dataProvider = chartData;
                                            chart.validateData();
                                            chart.validateNow();

                        <%--var tableView = $find("<%= grvTable.ClientID %>").get_masterTableView();
                        tableView.set_dataSource(chartData);
                        tableView.dataBind();--%>
                                        });
                                    }
                                    window.onload = window_init;
                                    setInterval(updateMap, 5000);

                                    function FillDisplayGroup() {
                                        let siteFilterOption = document.getElementById('site-filter-option');

                                        let url = urlGetDisplayGroup;
                                        $.getJSON(url, function (d) {
                                            console.log(d)
                                            let content = "";
                                            if (d.GetDisplayGroupsResult.length > 0) {
                                                for (let item of d.GetDisplayGroupsResult) {
                                                    if (item != null && item != undefined) {
                                                        if (item.Group != null && item.Group != undefined && item.Group.toString().trim() != "") {
                                                            content += `<div class="custom-control custom-checkbox">
                                                                        <input type="checkbox" class="custom-control-input" id="${item.Group}" data-group="${item.Group}" onchange="return filterSite(this);" checked />
                                                                        <label class="custom-control-label" for="${item.Group}">${item.Group}</label>
                                                                    </div>`;
                                                        }
                                                    }
                                                }
                                            }
                                            siteFilterOption.innerHTML = content;
                                        })
                                    }

                                    FillDisplayGroup();

                                    function filterSite(e) {
                                        let displayGroup = e.dataset.group;

                                        let url = urlGetSiteByDisplayGroup + displayGroup;

                                        $.getJSON(url, function (d) {
                                            if (d.GetSiteByDisplayGroupResult.length > 0) {
                                                if (e.checked == true) {
                                                    for (let marker of markers) {
                                                        for (let item of d.GetSiteByDisplayGroupResult) {
                                                            if (item.SiteId == marker.id.slice(2)) {
                                                                marker.setVisible(true);
                                                            }
                                                        }
                                                    }
                                                    for (let ommarker of omarkers) {
                                                        for (let item of d.GetSiteByDisplayGroupResult) {
                                                            if (item.SiteId == ommarker.id.slice(3)) {
                                                                ommarker.setVisible(true);
                                                            }
                                                        }
                                                    }
                                                }
                                                else {
                                                    for (let marker of markers) {
                                                        for (let item of d.GetSiteByDisplayGroupResult) {
                                                            if (item.SiteId == marker.id.slice(2)) {
                                                                marker.setVisible(false);
                                                            }
                                                        }
                                                    }
                                                    for (let ommarker of omarkers) {
                                                        for (let item of d.GetSiteByDisplayGroupResult) {
                                                            if (item.SiteId == ommarker.id.slice(3)) {
                                                                ommarker.setVisible(false);
                                                            }
                                                        }
                                                    }
                                                }

                                            }
                                        })
                                    }

                                    // turn on or turn off kml area 
                                    function turnOnAreaKML(e) {

                                        if (e.checked == true) {
                                            kml_area = new google.maps.KmlLayer({
                                                url: areaKMLFile,
                                                map: map,
                                            });
                                        }
                                        else {
                                            kml_area.setMap(null);
                                            let reCenter = new google.maps.LatLng(10.919935, 108.089190);
                                            map.panTo(reCenter);
                                            map.setZoom(15);
                                        }
                                    }

                                </script>
                            </telerik:RadScriptBlock>
                        </div>


                    </div>
                </div>
            </div>

        </form>







        <script type="text/javascript" src="/js/Pi-solution/vendor.js"></script>
        <script type="text/javascript" src="/js/Pi-solution/app.js"></script>

        <script type="text/javascript"> 


            function pageLoad(sender, args) {
                $(function () {
                    //resize menu + map by screen
                    var screenheight = $(document).height();
                    var screenwidth = $(document).width();
                    var strh = (screenheight - 70);
                    var strw = (screenwidth - 220);
                    if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                        strw = (screenwidth - 20);
                        $("#<%=lbPageTitle.ClientID%>").html("VIWATER SCADA SYSTEM");
                        $("#MenuCollapse").attr("style", "display:none");
                    }
                    $("#RAD_SPLITTER_PANE_CONTENT_ctl00_ContentPlaceHolder1_RadPane2").css("height", strh);//resize map height
                    $("#RAD_SPLITTER_PANE_CONTENT_ctl00_ContentPlaceHolder1_RadPane2").css("width", strw);//resize map width

                    $("#RAD_SPLITTER_PANE_CONTENT_ctl00_ContentPlaceHolder1_RadPane1").css("width", "0px");//hide menu in radslide
                    // height of screen
                    if (screenwidth > 768) {
                        $("#sidebar-menu").attr("style", "height:" + (screenheight - 50) + "px ; overflow-y:scroll; overflow-x:hidden"); // leftmenu scroll for >ipad 
                    }
                    $(".SiteSubMenu").click(function (e) {
                        e.preventDefault();
                        alert($(this).attr("href"));
                        return false;
                    }
                    );
                    $("li").click(function () {
                        if ($(this).hasClass('active')) {
                            $(this).removeClass('active');
                        }
                        else {
                            $(this).addClass('active');
                        }
                        $("#MapJS_rev1_DMA").addClass("open active ");
                    });

                    $(".HeaderLogout").click(function () {
                        var abc = $(this).find("#LogoutRegion");
                        if (abc.hasClass("show")) {
                            $(this).find("#LogoutRegion").removeClass("show");

                        }
                        else {
                            $(this).find("#LogoutRegion").addClass("show");
                        }

                    });

                    setInterval(function () { $(".rwControlButtons").css("width", "auto"); }, 100);
                    $("#btnLogout").click(function () {
                        $.ajax({
                            type: "POST",
                            url: "/Pi-solution/Pi1.asmx/Logout_pi",
                            data: "{}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (result) {
                                window.location.href = result.d;
                            },
                            error: function (error) {
                                alert("The system is under maintenance. Please come back later");
                            }
                        });
                    });
                    // active when click menu
                    var pathname = window.location.pathname;
                    $(".sidebar-nav a").each(function () {
                        if ($(this).attr("href") == pathname) {
                            $(this).addClass("subMenuActive");
                            $(this).parent().parent().parent().addClass("open active");
                            $(this).closest("ul").attr("aria-expanded", "true");
                            $(this).closest("ul").removeClass("collapse");
                            $(this).closest("ul").addClass("sidebar-nav collapse in");
                        }
                        //privilege sub menu

                        var substring = '@' + $(this).attr("href") + '@';
                        if ($("#ContentPlaceHolder1_hidListMenu").val().indexOf(substring) == -1) {

                            $(this).parent().attr("style", "display:none !important");
                        }
                    });
                    //privilege  menu
                    //$(".privilege").each(function () {
                    //    var substring = '@' + $(this).attr("href") + '@';
                    //    if ($("#ContentPlaceHolder1_hidListMenu").val().indexOf(substring) == -1) {
                    //        $(this).parent().attr("style","display:none !important");
                    //    }
                    //});
                    //active when click menu
                    $(".sidebar-menu a").each(function () {
                        if ($(this).attr("href") == pathname) {
                            $(this).parent().addClass("open active");
                        }
                    });

                    $(".rfdRoundedCorners, .form-control").each(function () {
                        $(this).removeClass("rfdDecorated");
                    });


                    $(".rwControlButtons, .rbDecorated").each(function () {
                        $(this).removeAttr("style");
                        $(this).parent().removeClass("rfdSkinnedButton");

                    });
                    $(".rfdDecorated").each(function () {
                        $(this).parent().removeClass("rfdSkinnedButton");

                    });
                    $("#MenuCollapse").click(function () {
                        $(".sidebar").toggle(500);
                        $(".header").toggleClass('headerHide');
                        $(".app").toggleClass('headerHide');
                        //resize menu + map by screen
                        var screenwidth = $(document).width();
                        if ($(".header").hasClass("headerHide")) {
                            var strw = (screenwidth - 35);
                        }
                        else {
                            var strw = (screenwidth - 220);
                        }
                        $("#RAD_SPLITTER_PANE_CONTENT_ctl00_ContentPlaceHolder1_RadPane2").css("width", strw);//resize map width
                    });

                })
            }


        </script>

    </body>

</asp:Content>
