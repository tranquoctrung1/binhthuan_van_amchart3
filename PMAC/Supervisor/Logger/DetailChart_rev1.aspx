<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DetailChart_rev1.aspx.cs" Inherits="Supervisor_Logger_DetailChart_rev1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
    <link href="../../App_Themes/common.css" rel="stylesheet" />
    <link href="../../css/app-blue.css" rel="stylesheet" />
    <style type="text/css">
        html, body, form, #content{
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="content">
    
        <telerik:RadScriptManager ID="RadScriptManager1" Runat="server">
        </telerik:RadScriptManager>
        
        <telerik:RadSplitter ID="RadSplitter1" Runat="server" Height="100%" Width="100%">
            <telerik:RadPane ID="RadPane1" Runat="server" Width="22px" Height="100%">
                <telerik:RadSlidingZone ID="RadSlidingZone1" Runat="server">
                    <telerik:RadSlidingPane ID="RadSlidingPane1" Runat="server" Width="250px" Title="Sites">
                        <telerik:RadTreeView ID="radTreeViewSite" Runat="server" EnableDragAndDrop="true" EnableDragAndDropBetweenNodes="false" OnClientNodeDropping="radTreeViewSite_NodeDropping">
                        </telerik:RadTreeView>
                    </telerik:RadSlidingPane>
                </telerik:RadSlidingZone>
            </telerik:RadPane>
            <telerik:RadPane ID="RadPane2" Runat="server" Height="100%">
                <div class="rowGrid">

                           &nbsp; <asp:Label ID="lbFrom" runat="server" Text="Start Date"></asp:Label>&nbsp;
                           
                         
  

                                <telerik:RadDateTimePicker ID="radDateTimePickerStart" Runat="server" Culture="en-GB" Height="25px">
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
                            &nbsp; <asp:Label ID="lbTo" runat="server" Text="End Date"></asp:Label>&nbsp;
                                <telerik:RadDateTimePicker ID="radDateTimePickerEnd" Runat="server" Culture="en-GB" Height="25px">
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

                                <input id="btnUpdateChart" type="button" runat="server" value="Update" class="rfdDecorated" onclick="btnUpdateChart_Clicked(); return false;" />
                                <input id="btnClearChart" type="button" runat="server" value="Clear"  class="rfdDecorated"  onclick="btnClearChart_Clicked(); return false;" />
                    

                </div>
                <div id="chart_canvas" style="width: 100%; height: 90%" />
            </telerik:RadPane>
        </telerik:RadSplitter>
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
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
                        updateChart(toOADate(new Date(cDtStart.get_selectedDate())).toString().replace('.', '_'), toOADate(new Date(cDtEnd.get_selectedDate())).toString().replace('.', '_'));
                        
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
                    while (chart.graphs.length !=0) {
                        chart.removeGraph(chart.graphs[0]);
                    }
                    color = [];
                    channels = [];
                    chartData = [];
                    chart.dataProvider = chartData;
                    chart.validateData();
                    chart.validateNow();
                    return false;
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
                    var urlGetSite = hostname + '/Service1.svc/GetSite/';
                    var urlGetChannels = hostname + '/Service1.svc/GetChannels/';
                    var urlGetChannelData = hostname + '/Service1.svc/GetChannelData/';
                    var urlGetMultipleChannelsData = hostname + '/Service1.svc/GetMultipleChannelsData/';

                var strDate;
                var val;
                var parsedDate;
                var jsDate;

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
                var colors = [];
                var reds = ['orange', 'deeppink', 'darkviolet', 'brown', 'magenta'];
                var blues = ['green', 'cyan', 'darkblue', 'limegreen', 'teal'];
                var mreds = [];
                var mblues = [];

                var zoomIndex0;
                var zoomIndex1;

                function window_init() {
                    var qs = getQueryStrings();
                    var type = qs["ty"];
                    var site = qs["si"];
                    var dt = qs["dt"];
                    var uid = qs["uid"];
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
                                gNode.expand();
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
                                $.each(dc.GetChannelsResult, function (j, c) {
                                    //TREEVIEW CHANNEL NODE
                                    var cNode = new Telerik.Web.UI.RadTreeNode();
                                    cNode.set_text(c.ChannelName);
                                    cNode.set_value(c.ChannelId + '|' + s.Location + '|' + c.ChannelName + '|' + c.Unit);
                                    cNode.set_allowDrag(true);
                                    cNode.set_allowDrop(true);
                                    var spNode = treeViewSite.findNodeByText(s.Location);
                                    spNode.get_nodes().add(cNode);
                                });
                            });
                        });
                        var nodes = treeViewSite.get_allNodes();
                        for (var i = 0; i < nodes.length; i++) {
                            if (nodes[i].get_nodes() != null) {
                                nodes[i].expand();
                            }
                        }
                    });
                    //ty: monthly | daily
                    //si: siteId
                    //dt: timestamp
                    
                    var jsDt = fromOADate(dt.replace('_', '.'))
                    start = fromOADate(dt.replace('_', '.'));
                    switch (type) {
                        case "daily":
                            end = new Date(jsDt.setDate(jsDt.getDate() + 1));
                            break;
                        case "monthly":
                            end = new Date(jsDt.setMonth(jsDt.getMonth() + 1));
                            break;
                        default:
                            break;
                    }
                    var cDtStart = $find("<%=radDateTimePickerStart.ClientID %>");
                    var cDtEnd = $find("<%=radDateTimePickerEnd.ClientID %>");
                    cDtStart.set_selectedDate(start);
                    cDtEnd.set_selectedDate(end);

                    url = urlGetSite + site;
                    var loggerId;
                   
                    $.getJSON(url, function (os) {
                        $.each(os.GetSiteResult, function (k, is) {
                            loggerId = is.LoggerId;
                        });

                        url = urlGetChannels + loggerId;
                        $.getJSON(url, function (oc) {
                            $.each(oc.GetChannelsResult, function (l, ic) {
                                var channel = { id: ic.ChannelId, namePath: (site + " | " + ic.ChannelName), unit: ic.Unit }
                                channels.push(channel);
                            });
                            drawChart((toOADate(start)).toString().replace('.','_'), (toOADate(end)).toString().replace('.','_'));
                        });
                    });
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

                function dtToString(d) {
                    var u = d.getFullYear() + "|" + (d.getMonth() + 1) + "|" + d.getDate() + "|" + d.getHours() + "|" + d.getMinutes() + "|" + d.getSeconds();
                    return u;
                }
                
                // this method is called when chart is first inited as we listen for "dataUpdated" event
                function zoomChart() {
                    // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
                    chart.zoomToIndexes(chartData.length - chartData.length, chartData.length - 1);
                }
                handleZoom
                function handleZoom(event) {
                    // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
                    zoomIndex0 = event.startIndex;
                    zoomIndex1 = event.endIndex;
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

                function drawChart(start, end) {
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
                                if (val.Values[j] != null && val.Values[j]!='undefined')
                                chartData[i]["'" + channels[j].id + "'"] = val.Values[j];
                            }
                        });

                        //SERIAL CHART
                        chart = new AmCharts.AmSerialChart();
                        chart.dataProvider = chartData;
                        chart.pathToImages = "../../js/amcharts/images/";
                        chart.categoryField = "Timestamp";
                        chart.balloon.bulletSize = 5;
                        //ZOOM
                        chart.addListener("dataUpdated", zoomChart);
                        chart.addListener("zoomed", handleZoom);
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
                        $.each(channels, function (k, c) {
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
                                    }
                                        //color = randomColor({
                                        //    luminosity: 'bright',
                                        //    hue: 'red'
                                        //});
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
                                    }
                                        //color = randomColor({
                                        //    luminosity: 'bright',
                                        //    hue: 'blue'
                                        //});
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
                        });
                        //WRITE CHART
                        chart.write("chart_canvas");
                    });
                };

                function updateChart(start, end) {
                    var multipleChannelId = "";
                    for (var i = 0; i < channels.length; i++) {
                        if(i!=channels.length-1)
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
                                if (val.Values[j] != null && val.Values[j]!= 'undefined')
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
                                        }
                                            //color = randomColor({
                                            //    luminosity: 'bright',
                                            //    hue: 'red'
                                            //});
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
                                        }
                                            //color = randomColor({
                                            //    luminosity: 'bright',
                                            //    hue: 'blue'
                                            //});
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
                    });
                }
                window.onload = window_init;

            </script>
        </telerik:RadScriptBlock>
    </div>
      <script type="text/javascript">
          $(function () {
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
          })

      </script>
        
    </form>
</body>
</html>