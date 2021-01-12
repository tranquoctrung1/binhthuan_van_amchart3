<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Local.aspx.cs" Inherits="Supervisor_Logger_Local" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
    <style>
 body {
     margin-left:5px !important;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
}
/* width */
/*::-webkit-scrollbar {
  width: 10px;
}*/

#chart_canvas {
  width: 62%;
  height: 500px;
  float:left;
}
#chart_table_MinMax table {
    width:100%;
  
}
         #chart_table_MinMax{
        text-align:center;
        width:38%;
        height:480px;
        overflow: scroll;
        position:relative;
    }
            #chart_table_MinMax table tr {
            }
             #chart_table_MinMax table tr :hover{
                 background-color:#0088d4;
            }

#chart_table_MinMax table th, #chart_table_MinMax table td {
  text-align: center;
  padding: 5px 7px;
 
}

#chart_table_MinMax table th {
  background: #0088d4;
  font-family:Arial;
  color: #fff;
  position: -webkit-sticky;
  position: sticky;
  top: 0; 
}

#chart_table_MinMax table td {
  border-bottom: 1px solid #eee;
border-right: 1px solid #eee;
   
}

#chart_table_MinMax table td.row-title {
    
     
 
}

</style>

<script src="../../js/jquery-1.7.2.min.js"></script>
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/material.js"></script>
    <script src="../../js/amcharts/amcharts.js"></script>
        <script src="../../js/amcharts/serial.js"></script>
        <script src="../../js/amcharts/exporting/amexport.js"></script>
        <script src="../../js/amcharts/exporting/canvg.js"></script>
        <script src="../../js/amcharts/exporting/filesaver.js"></script>
        <script src="../../js/amcharts/exporting/jspdf.js"></script>
        <script src="../../js/amcharts/exporting/jspdf.plugin.addimage.js"></script>
        <script src="../../js/amcharts/exporting/rgbcolor.js"></script>
        <script src="../../js/randomColor.js"></script>
<link href="../../css/bootstrap/sb-admin-2.min.css" rel="stylesheet" />
    <link href="../../App_Themes/common.css" rel="stylesheet" />
</head>
<body>
     <div style="margin-top:1.5em" class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
            <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>
          </div>
     <div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">COD</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">37.5</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Flow</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800" id="flow">No Data</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                     <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">N-NH4+</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">45.8</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Pending Requests Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">PH</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">18</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-comments fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Content Row -->
      <div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">TSS</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">9.7</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">H2S</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">No Data</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                   <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">NTU</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">No Data</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Pending Requests Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Clo</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">No Data</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-comments fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
    <!--content2 row-->
    <form id="form1" runat="server">
         <telerik:RadScriptManager ID="RadScriptManager1" Runat="server">
        </telerik:RadScriptManager>
       
        <div>
                   
                    <table class="auto-style1">
                      
                        <tr>
                            <td>
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
                            </td>
                            <td class="auto-style2">
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
                            </td>
                            <td>
                                
                               <input id="btnUpdateChart" class="btn-info" type="button" value="Update" onclick="btnUpdateChart_Clicked(); return false;" />
                            </td>
                        </tr>
                    </table>
                  
         </div>
               
      
    <div id="chart_canvas"></div>
    <div id="chart_table_MinMax" ></div>

    

    </form>
     <script type="text/javascript">
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
        

         var url;       
          var   hostname = "http://localhost:63111";
         var urlGetSites = hostname + '/Service1.svc/GetSites';
         var urlGetSitesByUid = hostname + '/Service1.svc/GetSitesByUid/';
         var urlGetChannels = hostname + '/Service1.svc/GetChannels/';       
         var urlGetChannelData = hostname + '/Service1.svc/GetChannelData/';
        var urlGetChannelDataChart = hostname + '/Service1.svc/GetChannelDataChart/';
         var urlGetChannelDataDaily = hostname + '/Service1.svc/GetChannelDataDaily/';
         var urlGetChannelDataHourly = hostname + '/Service1.svc/GetChannelDataHourly/';
         var urlGetChannelDataMonthly = hostname + '/Service1.svc/GetChannelDataMonthly/';
     
         var urlGetMultipleChannelsData = hostname + '/Service1.svc/GetMultipleChannelsData/';
         var urlGetDailyComplexData = hostname + '/Service1.svc/GetDailyComplexData/';
         var chart;
         var end;
         var start;
         var channels = [];
         var valueAxisPress;
         var valueAxisFlow;
         var chartData = [];
         var chartDataDaily = [];        
         var val;           
         var colorRed = [];
         var colorBlue = [];
         var colors = [];
         var reds = ['orange', 'deeppink', 'darkviolet', 'brown', 'magenta'];
         var blues = ['green', 'cyan', 'darkblue', 'limegreen', 'teal'];
         var mreds = [];
         var mblues = [];
         var zoomIndex0;
         var zoomIndex1;
         var loggerId = '1001';
         var site = 'LA1001';
         function window_init() {
       
                            //MAP
            // openChart('1001_02', 'Hồ Cầu Mới | Ap Luc', 'LA1001');             end = new Date();
             start = new Date();
             start = new Date(start.setDate(start.getDate() - 7));
             end = new Date(end.setDate(end.getDate() - 6));             start = toOADate(start);
             end = toOADate(end);
             start = start.toString().replace('.', '_');
             end = end.toString().replace('.', '_');             url = urlGetChannels + loggerId;
             $.getJSON(url, function (oc) {
                 $.each(oc.GetChannelsResult, function (l, ic) {
                    // var channel = { id: ic.ChannelId, namePath: (site + " | " + ic.ChannelName), unit: ic.Unit }
                     var channel = { id: ic.ChannelId, namePath: ( ic.ChannelName), unit: ic.Unit }
                     channels.push(channel);
                 });
                 drawChart(start, end);
             });                          
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
                            //alert(multipleChannelId);
                            var url = urlGetMultipleChannelsData + multipleChannelId + "/" + start + "/" + end;
                            var length_channels = channels.length;
                            //alert(length_channels);
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
                                   // alert(channels[length_channels - 2].id);
                                    var value_flow = chartData[i]["'" + channels[length_channels - 2].id + "'"];
                                     document.getElementById("flow").innerHTML = value_flow;
                                });
                                
                                //SERIAL CHART
                                chart = new AmCharts.AmSerialChart();
                                chart.dataProvider = chartData;
                                chart.dataTableId = "chart_table_MinMax";
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
                                //alert('a');
                                categoryAxis.axisColor = "#DADADA";
                                categoryAxis.gridAlpha = 0.15;
                                //AXE
                                //Y1
                                valueAxisPress = new AmCharts.ValueAxis();
                                valueAxisPress.axisColor = 'red';
                                valueAxisPress.axisThickness = 1;
                                //valueAxisPress.title = 'm';
                                valueAxisPress.titleColor = 'red';
                                chart.addValueAxis(valueAxisPress);
                                //Y2 
                                valueAxisFlow = new AmCharts.ValueAxis();
                                valueAxisFlow.axisColor = 'blue';
                                valueAxisFlow.axisThickness = 1;
                                valueAxisFlow.position = 'right';
                                //valueAxisFlow.title = 'm3/h';
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
                               /* chart.amExport = {
                                    top: 21,
                                    right: 21,
                                    buttonColor: '#EFEFEF',
                                    buttonRollOverColor: '#DDDDDD',
                                    exportPNG: true,
                                    exportJPG: true,
                                    exportPDF: true,
                                    exportSVG: true
                                }
                                */
                                //alert('aa');
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
                                var total = 0;
                                // check if export to table is enabled
                               
                                // get chart data
                                var data = chartData;

                                // create a table
                                var holder = document.getElementById("chart_table_MinMax");
                                holder.innerHTML = "";
                                // if (holder.childElementCount == 0) {
                                var table = document.createElement("table");
                                table.id = "excelEX";
                                holder.appendChild(table);

                                // document.getElementById("chart_table").innerHTML(table);
                                var tr, td;

                                // add first row
                                //alert(chart.dataProvider.length);
                                for (var x = 0; x < chart.dataProvider.length; x++) {
                                    
                                    // first row
                                    if (x == 0) {
                                       // alert('aa');
                                        tr = document.createElement("tr");
                                        table.appendChild(tr);
                                        td = document.createElement("th");
                                        //td.innerHTML = chart.categoryAxis.title;
                                        td.innerHTML = "Timestamp";
                                        tr.appendChild(td);
                                        
                                        for (var i = 0; i < chart.graphs.length ; i++) {

                                            td = document.createElement('th');
                                            td.innerHTML = chart.graphs[i].title;
                                            //alert(chart.graphs[i].title);
                                            tr.appendChild(td);
                                        }
                                    }

                                    // add rows
                                    tr = document.createElement("tr");
                                    table.appendChild(tr);
                                    td = document.createElement("td");
                                    td.className = "row-title";

                                    // td.innerHTML = chart.dataProvider[x][chart.categoryField].toUTCString();
                                    var todayTime = new Date(chart.dataProvider[x][chart.categoryField]);
                                    // var month = todayTime.getMonth() + 1;
                                    //var day = todayTime.getDate();
                                    // var year = todayTime.getFullYear();
                                    // var dt = day + "/" + month + "/" + year;
                                    // alert(dt + "aaaa");
                                    // var dt = chart.dataProvider[x][chart.categoryField].substr(14);
                                    td.innerHTML = dtFormat2(todayTime);
                                    tr.appendChild(td);
                                    // alert(chart.graphs.length);
                                    for (var i = 0; i < chart.graphs.length ; i++) {

                                        td = document.createElement('td');
                                        td.innerHTML = chart.dataProvider[x][chart.graphs[i].valueField];
                                        //alert(chart.dataProvider[x][chart.graphs[i].valueField]);
                                        tr.appendChild(td);

                                        // total += chart.dataProvider[x][chart.graphs[i].valueField];

                                    }
                                }
                                //WRITE CHART
                                chart.write("chart_canvas");
                            });
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
                        function dtFormat2(d) {
                            var u = ("0" + d.getDate()).slice(-2) + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" +
           d.getFullYear() ;
                            
                           // var u = ("0" + d.getDate()).slice(-2) + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" +
          // d.getFullYear() + " " + ("0" + d.getHours()).slice(-2) + ":" + ("0" + d.getMinutes()).slice(-2);
                            // var u = d.getFullYear() + "/" + (d.getMonth() + 1) + "/" + d.getDate() + " " + d.getHours() + ":" + d.getMinutes();
                            return u;
                        }
                        function dtFormathourly(d) {
                            var u = ("0" + d.getDate()).slice(-2) + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" +
          + " " + ("0" + d.getHours()).slice(-2) + ":" + ("0" + d.getMinutes()).slice(-2);

                            // var u = ("0" + d.getDate()).slice(-2) + "-" + ("0" + (d.getMonth() + 1)).slice(-2) + "-" +
                            // d.getFullYear() + " " + ("0" + d.getHours()).slice(-2) + ":" + ("0" + d.getMinutes()).slice(-2);
                            // var u = d.getFullYear() + "/" + (d.getMonth() + 1) + "/" + d.getDate() + " " + d.getHours() + ":" + d.getMinutes();
                            return u;
                        }
                        window.onload = window_init;
     </script>
    <script type="text/javascript"> 


    function pageLoad(sender, args) {
        $(function () {
                //resize menu + map by screen
                var screenheight = $(document).height();
                var screenwidth = $(document).width();
               // alert(screenwidth);
                var strh = (screenheight - 70);
                var strw = (screenwidth - 220);
                if(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                    $("#chart_canvas").attr("style", "width:100%"); // leftmenu scroll for >ipad
                    $("#chart_table_MinMax").attr("style", "width:100%");
                }
                if (screenwidth < 768) {
                    $("#chart_canvas").attr("style", "width:100%"); // leftmenu scroll for >ipad
                    $("#chart_table_MinMax").attr("style", "width:100%");
                }
                
               
            })
            }
    

        </script>
</body>
</html>
