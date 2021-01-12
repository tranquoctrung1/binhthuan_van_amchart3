<%@ Page Language="C#" AutoEventWireup="true" CodeFile="chart.aspx.cs" Inherits="Supervisor_Logger_chart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
    <style>
 body {
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
}
/* width */
::-webkit-scrollbar {
  width: 10px;
}

#chartdiv {
  width: 82%;
  height: 500px;
  float:left;
}
#chartdivhour {
  width: 82%;
  height: 500px;
  float:left;
}
#chartdivmonth {
  width: 82%;
  height: 500px;
  float:left;

}

       
#chart_table_MinMax table {
  
}
         #chart_table_MinMax{
        text-align:center;
        width:18%;
        height:500px;
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

/*table hourly*/
#chart_table_hourly table {

  
}
  #chart_table_hourly{
        text-align:center;
        position: relative;
        width:18%;
        height:500px;
        overflow: scroll;
    }
 #chart_table_hourly table tr {
  }
  #chart_table_hourly table tr :hover{
                 background-color:#0088d4;
  }

#chart_table_hourly table th, #chart_table_hourly table td {
  text-align: center;
  padding: 5px 7px;
 
}

#chart_table_hourly table th {
  background: #0088d4;
  font-family:Arial;
  color: #fff;
  position: -webkit-sticky;
  position: sticky;
  top: 0;
}

#chart_table_hourly table td {
  border-bottom: 1px solid #eee;
border-right: 1px solid #eee;
   
}

#chart_table_hourly table td.row-title {
    
     
 
}
/*table monthly*/
#chart_table_monthly table {
  
}
 #chart_table_monthly{
        text-align:center;
        width:18%;
        height:500px;
        overflow: scroll;
        position:relative;
    }
  #chart_table_monthly table tr {
            }
 #chart_table_monthly table tr :hover{
      background-color:#0088d4;
   }

#chart_table_monthly table th, #chart_table_monthly table td {
  text-align: center;
  padding: 5px 7px;
 
}

#chart_table_monthly table th {
  background: #0088d4;
  font-family:Arial;
  color: #fff;
  position: -webkit-sticky;
  position: sticky;
  top: 0;
}

#chart_table_monthly table td {
  border-bottom: 1px solid #eee;
border-right: 1px solid #eee;
   
}

#chart_table_monthly table td.row-title {
    
     
 
}
</style>

<script src="../../js/jquery-1.7.2.min.js"></script>
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/material.js"></script>
<link href="../../css/bootstrap/sb-admin-2.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
         <telerik:RadScriptManager ID="RadScriptManager1" Runat="server">
        </telerik:RadScriptManager>
        <table class="auto-style1">
        <tr>
            <td style="color:#0088d4"> <b>Site name:</b></td>
            <td>
                        <telerik:RadComboBox ID="cboSites" runat="server"  OnDataBound="cboSites_DataBound"
                            DataSourceID="SitesDataSource" DataTextField="SiteAliasName" DataValueField="SiteId" 
                            onselectedindexchanged="cboSites_SelectedIndexChanged" DropDownWidth="265px" HighlightTemplatedItems="True">
                            <HeaderTemplate>
                                <table cellpadding="0" cellspacing="0" style="width:255px">
                                    <tr>
                                       
                                        <td style="width:100px">Alias name</td>
                                        <td style="width:150px">Location</td>
                                    </tr>
                                </table>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <table cellpadding="0" cellspacing="0" style="width:255px">
                                    <tr>
                                       
                                        <td style="width:100px"><%#DataBinder.Eval(Container.DataItem,"SiteAliasName") %></td>
                                        <td style="width:150px"><%#DataBinder.Eval(Container.DataItem,"Location") %></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </telerik:RadComboBox>
                        <asp:ObjectDataSource ID="SitesDataSource" runat="server" 
                            OldValuesParameterFormatString="original_{0}" 
                            SelectMethod="GetSitesByDisplayGroup" TypeName="PMAC.BLL.SiteBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="mnuDisplayGroup" Name="displayGroup" 
                                    PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </td>
                    <td>
                    <input class="btn-info" id="view"  type="button" value="View" onclick="btnview_Clicked(); return false;" />
                           
                    </td>
            
        </tr>
        
    </table>
         <telerik:RadMenu ID="mnuDisplayGroup" runat="server" DataFieldID="Group" 
                    DataSourceID="DisplayGroupsDataSource" DataTextField="Description" 
                    DataValueField="Group" Flow="Vertical"  Visible="False">
         </telerik:RadMenu>
         <asp:ObjectDataSource ID="DisplayGroupsDataSource" runat="server"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetDisplayGroups"
        TypeName="PMAC.BLL.DisplayGroupBL"></asp:ObjectDataSource>
        <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="cboSites">
               
            </telerik:AjaxSetting>
           
            <telerik:AjaxSetting AjaxControlID="mnuDisplayGroup">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cboSites" />
                </UpdatedControls>
            </telerik:AjaxSetting>
           
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
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
               
     <div style="margin:0 auto; width:100%; text-align:center;"> 
        <span style="color:greenyellow;"><b>Total Consumption daily :</b> </span><span  id="totaldaily" style=" color:blue;"></span><span style="color:blue;">(m3)</span>
     </div>   
    <div id="chartdiv"></div>
    <div id="chart_table_MinMax" ></div>

    <div style="margin:0 auto; width:100%; text-align:center;"> 
        <span style="color:greenyellow;"><b>Total Consumption hourly :</b> </span><span  id="totalhourly" style=" color:blue;"></span><span style="color:blue;">(m3)</span>
     </div> 

    <div id="chartdivhour"></div>
     <div id="chart_table_hourly" ></div>

     <div style="margin:0 auto; width:100%; text-align:center;"> 
        <span style="color:greenyellow;"><b>Total Consumption Monthly :</b> </span><span  id="totalmonthly" style=" color:blue;"></span><span style="color:blue;">(m3)</span>
     </div> 
        <div id="chartdivmonth"></div>
         <div id="chart_table_monthly"></div>

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
         function btnview_Clicked(sender, args) {
                            var cDtStart = $find("<%=radDateTimePickerStart.ClientID %>");
                            var cDtEnd = $find("<%=radDateTimePickerEnd.ClientID %>");
                            var siteID = $find('<%= cboSites.ClientID %>').get_value();
                            //alert(siteID);
                            if (cDtStart.get_selectedDate() == null || cDtEnd.get_selectedDate() == null) {
                                alert("Chưa nhập ngày!");
                                return false;
                            }
                            updateChartChoose(siteID, toOADate(new Date(cDtStart.get_selectedDate())).toString().replace('.', '_'), toOADate(new Date(cDtEnd.get_selectedDate())).toString().replace('.', '_'));
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
         var channels2 = [];
         var chartData = [];
         var chartDataDaily = [];        
         var val;    
         var parsedDate;
         var jsDate;
         //chart daily
         var hchart;
         var hend;
         var hstart;
         var hchannels = [];
         var hchartData = [];
         var chartDataHourly = [];
         var hval;
         //chart monthly
         var mchart;
         var mend;
         var mstart;
         var mchannels = [];       
         var mchartData = [];
         var chartDataMonthly = [];
         var mval;
         function window_init() {
                            //MAP
             openChart('1001_02', 'Hồ Cầu Mới | Ap Luc', 'LA1001');             openChartHourly('1001_02', 'Hồ Cầu Mới | Ap Luc', 'LA1001');             openChartMonthly('1001_02', 'Hồ Cầu Mới | Ap Luc', 'LA1001');                          
                        }
        function openChart(channelId, namePath, unit) {
            //alert(channelId);
                            end = new Date();
                            start = new Date();
                            start = new Date(start.setDate(start.getDate() - 30));
                            end = new Date(end.setDate(end.getDate() - 2));
                            var cDtStart = $find("<%=radDateTimePickerStart.ClientID %>");
                            var cDtEnd = $find("<%=radDateTimePickerEnd.ClientID %>");
                            cDtStart.set_selectedDate(start);
                            cDtEnd.set_selectedDate(end);
                            start = toOADate(start);
                            end = toOADate(end);
                            start = start.toString().replace('.', '_');
                            end = end.toString().replace('.', '_');
                            //console.log(start);
                            //console.log(end);
                            var channel = { id: channelId, namePath: namePath, unit: unit };
                            channels = [];
                            channels.push(channel);
                            colors = [];
                            mreds = [];
                            mblues = [];
                            drawChart(channels[0], start, end);
                        };
         function openChartHourly(channelId, namePath, unit) {
            //alert(channelId);
                            hend = new Date();
                            hstart = new Date();
                            hstart = new Date(hstart.setDate(hstart.getDate() - 20));
                            hend = new Date(hend.setDate(hend.getDate() - 19));
                            var cDtStart = $find("<%=radDateTimePickerStart.ClientID %>");
                            var cDtEnd = $find("<%=radDateTimePickerEnd.ClientID %>");
                            cDtStart.set_selectedDate(hstart);
                            cDtEnd.set_selectedDate(hend);
                            hstart = toOADate(hstart);
                            hend = toOADate(hend);
                            hstart = hstart.toString().replace('.', '_');
                            hend = hend.toString().replace('.', '_');
                            //console.log(start);
                            //console.log(end);
                            var channel = { id: channelId, namePath: namePath, unit: unit };
                            hchannels = [];
                            hchannels.push(channel);
                            colors = [];
                            mreds = [];
                            mblues = [];
                            drawChartHourly(hchannels[0], hstart, hend);
                    };
          function openChartMonthly(channelId, namePath, unit) {
            //alert(channelId);
                            mend = new Date();
                            mstart = new Date();
                            mstart = new Date(mstart.setDate(mstart.getDate() - 100));
                            mend = new Date(mend.setDate(mend.getDate() - 2));
                            var cDtStart = $find("<%=radDateTimePickerStart.ClientID %>");
                            var cDtEnd = $find("<%=radDateTimePickerEnd.ClientID %>");
                            cDtStart.set_selectedDate(mstart);
                            cDtEnd.set_selectedDate(mend);
                            mstart = toOADate(mstart);
                            mend = toOADate(mend);
                            mstart = mstart.toString().replace('.', '_');
                            mend = mend.toString().replace('.', '_');
                            //console.log(start);
                            //console.log(end);
                            var channel = { id: channelId, namePath: namePath, unit: unit };
                            mchannels = [];
                            mchannels.push(channel);
                            colors = [];
                            mreds = [];
                            mblues = [];
                            drawChartMonthly(mchannels[0], mstart, mend);
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
                        function drawChartMonthly(channel, start, end) {
                            var urldaily = urlGetChannelDataMonthly + channel.unit + "/" + start + "/" + end;
                            //alert(channel.unit);
                            $.getJSON(urldaily, function (daily) {
                                chartDataMonthly = [];
                                $.each(daily.GetChannelDataMonthlyResult, function (i, mval) {
                                    var parsedDate = new Date(parseInt(mval.Timestamp.substr(6)));
                                    var jsDate = new Date(parsedDate);
                                    //alert(val.Value);
                                    chartDataMonthly.push({
                                        Timestamp: jsDate
                                    });
                                    if (mval.Value != null && mval.Value != 'undefined')
                                        chartDataMonthly[i]["'" + channel.unit + "'"] = mval.Value;


                                });
                                /*
                                var url = urlGetChannelDataDaily + channel.unit + "/" + start + "/" + end;
                                //alert(channel.id);
                                $.getJSON(url, function (d) {
                                    mchartData = [];
                                    $.each(d.GetChannelDataDailyResult, function (i, val) {
                                        var parsedDate = new Date(parseInt(val.Timestamp.substr(6)));
                                        var jsDate = new Date(parsedDate);

                                        mchartData.push({
                                            Timestamp: jsDate
                                        });
                                        if (val.Value != null && val.Value != 'undefined')
                                            mchartData[i]["'" + channel.id + "'"] = val.Value;


                                    });
                                    */
                                    //SERIAL CHART
                                   // am4core.useTheme(am4themes_material);
                                    am4core.useTheme(am4themes_animated);
                                    // Themes end

                                    // Create chart instance
                                    var mchart = am4core.create("chartdivmonth", am4charts.XYChart);

                                    // Create daily series and related axes
                                    var dateAxis1 = mchart.xAxes.push(new am4charts.DateAxis());
                                    dateAxis1.renderer.grid.template.location = 0;
                                    dateAxis1.renderer.minGridDistance = 40;


                                    var valueAxis1 = mchart.yAxes.push(new am4charts.ValueAxis());


                                    var series1 = mchart.series.push(new am4charts.ColumnSeries());
                                    series1.dataFields.valueY = "'" + channel.unit + "'";
                                    series1.dataFields.dateX = "Timestamp";
                                    series1.data = chartDataMonthly;
                                    series1.xAxis = dateAxis1;
                                    series1.yAxis = valueAxis1;
                                    series1.tooltipText = "Sản lượng:{dateX.formatDate('yyyy-MM')}: [bold]{valueY}[/]";

                                // Create hourly series and related axes
                                /*
                                    var dateAxis2 = mchart.xAxes.push(new am4charts.DateAxis());
                                    dateAxis2.renderer.grid.template.location = 0;
                                    dateAxis2.renderer.minGridDistance = 40;
                                    dateAxis2.renderer.labels.template.disabled = true;
                                    dateAxis2.renderer.grid.template.disabled = true;
                                    dateAxis2.renderer.tooltip.disabled = true;

                                    var valueAxis2 = mchart.yAxes.push(new am4charts.ValueAxis());
                                    valueAxis2.renderer.opposite = true;
                                    valueAxis2.renderer.grid.template.disabled = true;
                                    valueAxis2.renderer.labels.template.disabled = true;
                                    valueAxis2.renderer.tooltip.disabled = true;

                                    var series2 = mchart.series.push(new am4charts.LineSeries());
                                    series2.dataFields.valueY = "'" + channel.id + "'";
                                    series2.dataFields.dateX = "Timestamp";
                                    series2.data = mchartData;
                                    series2.xAxis = dateAxis2;
                                    series2.yAxis = valueAxis2;
                                    series2.strokeWidth = 3;
                                    series2.tooltipText = "Lưu lượng:{dateX.formatDate('yyyy-MM-dd')}: [bold]{valueY}[/]";
                                    */
                                    // Add cursor
                                    mchart.cursor = new am4charts.XYCursor();

                                    var total = 0;
                                    // chart.dataTableId = "chart_table_MinMax";
                                    var data = series1.data;
                                    // create a table
                                    var holder = document.getElementById("chart_table_monthly");
                                    holder.innerHTML = "";
                                    // if (holder.childElementCount == 0) {
                                    var table = document.createElement("table");
                                    table.id = "excelEXmonthly";
                                    holder.appendChild(table);
                                    var tr, td;

                                    // add first row
                                    for (var x = 0; x < series1.data.length; x++) {
                                        //alert(series1.data.length);
                                        // first row
                                        if (x == 0) {
                                            tr = document.createElement("tr");
                                            table.appendChild(tr);
                                            td = document.createElement("th");
                                            td.className = "row-title2";
                                            //td.innerHTML = chartMinMax.categoryAxis.title;
                                            td.innerHTML = "Timestamp";
                                            tr.appendChild(td);
                                            // for (var i = 0; i < chart.graphs.length ; i++) {
                                            td = document.createElement('th');
                                            td.className = "row-title2";
                                            td.innerHTML = "Consumption";
                                            tr.appendChild(td);
                                            // }
                                           
                                        }

                                        // add rows
                                        tr = document.createElement("tr");
                                        table.appendChild(tr);
                                        td = document.createElement("td");
                                        td.className = "row-title";

                                        // td.innerHTML = chartMinMax.dataProvider[x][chartMinMax.categoryField].toUTCString();
                                        var todayTime = new Date(series1.data[x][series1.dataFields.dateX]);
                                        td.innerHTML = dtFormat2(todayTime);
                                        tr.appendChild(td);
                                        var valuetotal;
                                        // for (var i = 0; i < chart.graphs.length  ; i++) {
                                        td = document.createElement('td');
                                        valuetotal = series1.data[x][series1.dataFields.valueY];
                                        td.innerHTML = Math.round(valuetotal * 100) / 100;
                                        tr.appendChild(td);
                                        total += series1.data[x][series1.dataFields.valueY];
                                        //}

                                    }
                                    document.getElementById("totalmonthly").innerHTML = Math.round(total);

                               // });
                            });
                        };
                        function drawChartHourly(channel, start, end) {
                            var urldaily = urlGetChannelDataHourly + channel.unit + "/" + start + "/" + end;
                            //alert(channel.unit);
                            $.getJSON(urldaily, function (daily) {
                                chartDataHourly = [];
                                $.each(daily.GetChannelDataHourlyResult, function (i, hval) {
                                    var parsedDate = new Date(parseInt(hval.Timestamp.substr(6)));
                                    var jsDate = new Date(parsedDate);
                                    //alert(val.Value);
                                    chartDataHourly.push({
                                        Timestamp: jsDate
                                    });
                                    if (hval.Value != null && hval.Value != 'undefined')
                                        chartDataHourly[i]["'" + channel.unit + "'"] = hval.Value;
                                  

                                });

                                var url = urlGetChannelDataChart + channel.id + "/" + start + "/" + end;
                                //alert(channel.id);
                                $.getJSON(url, function (d) {
                                    hchartData = [];
                                    $.each(d.GetChannelDataChartResult, function (i, val) {
                                        var parsedDate = new Date(parseInt(val.Timestamp.substr(6)));
                                        var jsDate = new Date(parsedDate);

                                        hchartData.push({
                                            Timestamp: jsDate
                                        });
                                        if (val.Value != null && val.Value != 'undefined')
                                            hchartData[i]["'" + channel.id + "'"] = val.Value;


                                    });
                                    //SERIAL CHART
                                    //am4core.useTheme(am4themes_material);
                                    am4core.useTheme(am4themes_animated);
                                    // Themes end

                                    // Create chart instance
                                    var hchart = am4core.create("chartdivhour", am4charts.XYChart);

                                    // Create daily series and related axes
                                    var dateAxis1 = hchart.xAxes.push(new am4charts.DateAxis());
                                    dateAxis1.renderer.grid.template.location = 0;
                                    dateAxis1.renderer.minGridDistance = 40;


                                    var valueAxis1 = hchart.yAxes.push(new am4charts.ValueAxis());


                                    var series1 = hchart.series.push(new am4charts.ColumnSeries());
                                    series1.dataFields.valueY = "'" + channel.unit + "'";
                                    series1.dataFields.dateX = "Timestamp";
                                    series1.data = chartDataHourly;
                                    series1.xAxis = dateAxis1;
                                    series1.yAxis = valueAxis1;
                                    series1.tooltipText = "Sản lượng:{dateX.formatDate('yyyy-MM-dd hh:mm')}: [bold]{valueY}[/]";

                                    // Create hourly series and related axes
                                    var dateAxis2 = hchart.xAxes.push(new am4charts.DateAxis());
                                    dateAxis2.renderer.grid.template.location = 0;
                                    dateAxis2.renderer.minGridDistance = 40;
                                    dateAxis2.renderer.labels.template.disabled = true;
                                    dateAxis2.renderer.grid.template.disabled = true;
                                    dateAxis2.renderer.tooltip.disabled = true;

                                    var valueAxis2 = hchart.yAxes.push(new am4charts.ValueAxis());
                                    valueAxis2.renderer.opposite = true;
                                    valueAxis2.renderer.grid.template.disabled = true;
                                    valueAxis2.renderer.labels.template.disabled = true;
                                    valueAxis2.renderer.tooltip.disabled = true;

                                    var series2 = hchart.series.push(new am4charts.LineSeries());
                                    series2.dataFields.valueY = "'" + channel.id + "'";
                                    series2.dataFields.dateX = "Timestamp";
                                    series2.data = hchartData;
                                    series2.xAxis = dateAxis2;
                                    series2.yAxis = valueAxis2;
                                    series2.strokeWidth = 3;
                                    series2.tooltipText = "Lưu lượng:{dateX.formatDate('yyyy-MM-dd hh:mm')}: [bold]{valueY}[/]";

                                    // Add cursor
                                    hchart.cursor = new am4charts.XYCursor();

                                    var total=0;
                                    // chart.dataTableId = "chart_table_MinMax";
                                    var data = series1.data;
                                    // create a table
                                    var holder = document.getElementById("chart_table_hourly");
                                    holder.innerHTML = "";
                                    // if (holder.childElementCount == 0) {
                                    var table = document.createElement("table");
                                    table.id = "excelEXhourly";
                                    holder.appendChild(table);
                                    var tr, td;

                                    // add first row
                                    for (var x = 0; x < series1.data.length; x++) {
                                        //alert(series1.data.length);
                                        // first row
                                        if (x == 0) {
                                            tr = document.createElement("tr");
                                            table.appendChild(tr);
                                            td = document.createElement("th");
                                            td.className = "row-title2";
                                            //td.innerHTML = chartMinMax.categoryAxis.title;
                                            td.innerHTML = "Timestamp";
                                            tr.appendChild(td);
                                            // for (var i = 0; i < chart.graphs.length ; i++) {
                                            td = document.createElement('th');
                                            td.className = "row-title2";
                                            td.innerHTML = "Consumption";
                                            tr.appendChild(td);
                                            // }
                                        }

                                        // add rows
                                        tr = document.createElement("tr");
                                        table.appendChild(tr);
                                        td = document.createElement("td");
                                        td.className = "row-title";

                                        // td.innerHTML = chartMinMax.dataProvider[x][chartMinMax.categoryField].toUTCString();
                                        var todayTime = new Date(series1.data[x][series1.dataFields.dateX]);
                                        td.innerHTML = dtFormathourly(todayTime);
                                        tr.appendChild(td);
                                        var valuetotal;
                                        // for (var i = 0; i < chart.graphs.length  ; i++) {
                                        td = document.createElement('td');
                                        valuetotal = series1.data[x][series1.dataFields.valueY];
                                        td.innerHTML = Math.round(valuetotal * 100) / 100;
                                        tr.appendChild(td);
                                        total += series1.data[x][series1.dataFields.valueY];
                                        //}

                                    }
                                    document.getElementById("totalhourly").innerHTML = Math.round(total);
                                    //alert(total);
                                });
                            });
                        };
                        function drawChart(channel, start, end) {
                            var urldaily = urlGetChannelDataDaily + channel.unit + "/" + start + "/" + end;
                            //alert(channel.unit);
                            $.getJSON(urldaily, function (daily) {
                                chartDataDaily = [];
                                $.each(daily.GetChannelDataDailyResult, function (i, val) {
                                    var parsedDate = new Date(parseInt(val.Timestamp.substr(6)));
                                    var jsDate = new Date(parsedDate);
                                    //alert(val.Value);
                                    chartDataDaily.push({
                                        Timestamp: jsDate
                                    });
                                    if (val.Value != null && val.Value != 'undefined')
                                        chartDataDaily[i]["'" + channel.unit + "'"] = val.Value;


                                });
                                /*
                                var url = urlGetChannelDataHourly + channel.unit + "/" + start + "/" + end;
                                //alert(channel.id);
                                $.getJSON(url, function (d) {
                                    hchartData = [];
                                    $.each(d.GetChannelDataHourlyResult, function (i, val) {
                                        var parsedDate = new Date(parseInt(val.Timestamp.substr(6)));
                                        var jsDate = new Date(parsedDate);

                                        hchartData.push({
                                            Timestamp: jsDate
                                        });
                                        if (val.Value != null && val.Value != 'undefined')
                                            hchartData[i]["'" + channel.id + "'"] = val.Value;


                                    });
                                    */
                                    //SERIAL CHART
                                    am4core.useTheme(am4themes_animated);
                                    //am4core.useTheme(am4themes_material);
                                    // Themes end

                                    // Create chart instance
                                    var chart = am4core.create("chartdiv", am4charts.XYChart);

                                    // Create daily series and related axes
                                    var dateAxis1 = chart.xAxes.push(new am4charts.DateAxis());
                                    dateAxis1.renderer.grid.template.location = 0;
                                    dateAxis1.renderer.minGridDistance = 40;
                                    

                                    var valueAxis1 = chart.yAxes.push(new am4charts.ValueAxis());
                                    valueAxis1.calculateTotals = true;

                                    var series1 = chart.series.push(new am4charts.ColumnSeries());
                                    series1.dataFields.valueY = "'" + channel.unit + "'";
                                    series1.dataFields.dateX = "Timestamp";
                                    series1.data = chartDataDaily;
                                    series1.xAxis = dateAxis1;
                                    series1.yAxis = valueAxis1;
                                    series1.tooltipText = "[color='blue']Date:[/]{dateX}\n Consumption:[bold]{valueY}[/] m3";
                                /*
                                    // Create hourly series and related axes
                                    var dateAxis2 = chart.xAxes.push(new am4charts.DateAxis());
                                    dateAxis2.renderer.grid.template.location = 0;
                                    dateAxis2.renderer.minGridDistance = 40;
                                    dateAxis2.renderer.labels.template.disabled = true;
                                    dateAxis2.renderer.grid.template.disabled = true;
                                    dateAxis2.renderer.tooltip.disabled = true;

                                    var valueAxis2 = chart.yAxes.push(new am4charts.ValueAxis());
                                    valueAxis2.renderer.opposite = true;
                                    valueAxis2.renderer.grid.template.disabled = true;
                                    valueAxis2.renderer.labels.template.disabled = true;
                                    valueAxis2.renderer.tooltip.disabled = true;

                                    var series2 = chart.series.push(new am4charts.LineSeries());
                                    series2.dataFields.valueY = "'" + channel.id + "'";
                                    series2.dataFields.dateX = "Timestamp";
                                    series2.data = hchartData;
                                    series2.xAxis = dateAxis2;
                                    series2.yAxis = valueAxis2;
                                    series2.strokeWidth = 3;
                                    series2.tooltipText = "Hourly:{dateX.formatDate('yyyy-MM-dd hh:mm')}: [bold]{valueY}[/]";
                                */
                                    // Add cursor
                                    chart.cursor = new am4charts.XYCursor();

                                    var total = 0;
                                   // chart.dataTableId = "chart_table_MinMax";
                                    var data = series1.data;
                                    // create a table
                                    var holder = document.getElementById("chart_table_MinMax");
                                    holder.innerHTML = "";
                                    // if (holder.childElementCount == 0) {
                                    var table = document.createElement("table");
                                    table.id = "excelEX";
                                    holder.appendChild(table);
                                    var tr, td;

                                    // add first row
                                    for (var x = 0; x < series1.data.length; x++) {
                                        //alert(series1.data.length);
                                        // first row
                                        if (x == 0) {
                                            tr = document.createElement("tr");
                                            table.appendChild(tr);
                                            td = document.createElement("th");
                                            td.className = "row-title2";
                                            //td.innerHTML = chartMinMax.categoryAxis.title;
                                            td.innerHTML = "Timestamp";
                                            tr.appendChild(td);
                                           // for (var i = 0; i < chart.graphs.length ; i++) {
                                                td = document.createElement('th');
                                                td.className = "row-title2";
                                                td.innerHTML = "Consumption";
                                                tr.appendChild(td);
                                           // }
                                        }

                                        // add rows
                                        tr = document.createElement("tr");
                                        table.appendChild(tr);
                                        td = document.createElement("td");
                                        td.className = "row-title";

                                        // td.innerHTML = chartMinMax.dataProvider[x][chartMinMax.categoryField].toUTCString();
                                        var todayTime = new Date(series1.data[x][series1.dataFields.dateX]);
                                         td.innerHTML = dtFormat2(todayTime);
                                         tr.appendChild(td);
                                        var valuetotal;
                                       // for (var i = 0; i < chart.graphs.length  ; i++) {
                                            td = document.createElement('td');
                                            valuetotal = series1.data[x][series1.dataFields.valueY];
                                            td.innerHTML = Math.round(valuetotal * 100) / 100;
                                            tr.appendChild(td);
                                            total += series1.data[x][series1.dataFields.valueY];

                                        //}
                                        
                                    }
                                    document.getElementById("totaldaily").innerHTML = Math.round(total);
                               // });
                            });
                        };
                        function updateChart(start, end) {
                            var urldaily = urlGetChannelDataDaily + channels[0].unit + "/" + start + "/" + end;
                            //alert(channel.unit);
                            $.getJSON(urldaily, function (daily) {
                                chartDataDaily = [];
                                $.each(daily.GetChannelDataDailyResult, function (i, val) {
                                    var parsedDate = new Date(parseInt(val.Timestamp.substr(6)));
                                    var jsDate = new Date(parsedDate);
                                    //alert(val.Value);
                                    chartDataDaily.push({
                                        Timestamp: jsDate
                                    });
                                    if (val.Value != null && val.Value != 'undefined')
                                        chartDataDaily[i]["'" + channels[0].unit + "'"] = val.Value;


                                });
                                /*
                                var url = urlGetChannelDataHourly + channels[0].unit + "/" + start + "/" + end;
                                //alert(channel.id);
                                $.getJSON(url, function (d) {
                                    chartData = [];
                                    $.each(d.GetChannelDataHourlyResult, function (i, val) {
                                        var parsedDate = new Date(parseInt(val.Timestamp.substr(6)));
                                        var jsDate = new Date(parsedDate);

                                        chartData.push({
                                            Timestamp: jsDate
                                        });
                                        if (val.Value != null && val.Value != 'undefined')
                                            chartData[i]["'" + channels[0].unit + "'"] = val.Value;


                                    });
                                    */
                                    //SERIAL CHART
                                    am4core.useTheme(am4themes_animated);
                                    // Themes end

                                    // Create chart instance
                                    var chart = am4core.create("chartdiv", am4charts.XYChart);

                                    // Create daily series and related axes
                                    var dateAxis1 = chart.xAxes.push(new am4charts.DateAxis());
                                    dateAxis1.renderer.grid.template.location = 0;
                                    dateAxis1.renderer.minGridDistance = 40;


                                    var valueAxis1 = chart.yAxes.push(new am4charts.ValueAxis());


                                    var series1 = chart.series.push(new am4charts.ColumnSeries());
                                    series1.dataFields.valueY = "'" + channels[0].unit + "'";
                                    series1.dataFields.dateX = "Timestamp";
                                    series1.data = chartDataDaily;
                                    series1.xAxis = dateAxis1;
                                    series1.yAxis = valueAxis1;
                                    series1.tooltipText = "{dateX}: [bold]{valueY}[/]";
                                /*
                                    // Create hourly series and related axes
                                    var dateAxis2 = chart.xAxes.push(new am4charts.DateAxis());
                                    dateAxis2.renderer.grid.template.location = 0;
                                    dateAxis2.renderer.minGridDistance = 40;
                                    dateAxis2.renderer.labels.template.disabled = true;
                                    dateAxis2.renderer.grid.template.disabled = true;
                                    dateAxis2.renderer.tooltip.disabled = true;

                                    var valueAxis2 = chart.yAxes.push(new am4charts.ValueAxis());
                                    valueAxis2.renderer.opposite = true;
                                    valueAxis2.renderer.grid.template.disabled = true;
                                    valueAxis2.renderer.labels.template.disabled = true;
                                    valueAxis2.renderer.tooltip.disabled = true;

                                    var series2 = chart.series.push(new am4charts.LineSeries());
                                    series2.dataFields.valueY = "'" + channels[0].unit + "'";
                                    series2.dataFields.dateX = "Timestamp";
                                    series2.data = chartData;
                                    series2.xAxis = dateAxis2;
                                    series2.yAxis = valueAxis2;
                                    series2.strokeWidth = 3;
                                    series2.tooltipText = "Hourly:{dateX.formatDate('yyyy-MM-dd hh:mm')}: [bold]{valueY}[/]";
                                */
                                    // Add cursor
                                    chart.cursor = new am4charts.XYCursor();
                                // chart.dataTableId = "chart_table_MinMax";
                                    var total = 0;
                                    var data = series1.data;
                                    // create a table
                                    var holder = document.getElementById("chart_table_MinMax");
                                    holder.innerHTML = "";
                                    // if (holder.childElementCount == 0) {
                                    var table = document.createElement("table");
                                    table.id = "excelEX";
                                    holder.appendChild(table);
                                    var tr, td;

                                    // add first row
                                    for (var x = 0; x < series1.data.length; x++) {
                                        //alert(series1.data.length);
                                        // first row
                                        if (x == 0) {
                                            tr = document.createElement("tr");
                                            table.appendChild(tr);
                                            td = document.createElement("th");
                                            td.className = "row-title2";
                                            //td.innerHTML = chartMinMax.categoryAxis.title;
                                            td.innerHTML = "Timestamp";
                                            tr.appendChild(td);
                                            // for (var i = 0; i < chart.graphs.length ; i++) {
                                            td = document.createElement('th');
                                            td.className = "row-title2";
                                            td.innerHTML = "Consumption";
                                            tr.appendChild(td);
                                            // }
                                        }

                                        // add rows
                                        tr = document.createElement("tr");
                                        table.appendChild(tr);
                                        td = document.createElement("td");
                                        td.className = "row-title";

                                        // td.innerHTML = chartMinMax.dataProvider[x][chartMinMax.categoryField].toUTCString();
                                        var todayTime = new Date(series1.data[x][series1.dataFields.dateX]);
                                        td.innerHTML = dtFormat2(todayTime);
                                        tr.appendChild(td);
                                        var valuetotal;
                                        // for (var i = 0; i < chart.graphs.length  ; i++) {
                                        td = document.createElement('td');
                                        valuetotal = series1.data[x][series1.dataFields.valueY];
                                        td.innerHTML = Math.round(valuetotal * 100) / 100;
                                        tr.appendChild(td);
                                        total += series1.data[x][series1.dataFields.valueY];

                                        //}

                                    }
                                    document.getElementById("totaldaily").innerHTML = Math.round(total);

                                //});
                            });
                        };
                        
                        function updateChartChoose(siteID, start, end) {
                            var urldaily = urlGetChannelDataDaily + siteID + "/" + start + "/" + end;
                           // alert(channel);
                            $.getJSON(urldaily, function (daily) {
                                chartDataDaily = [];
                                $.each(daily.GetChannelDataDailyResult, function (i, val) {
                                    var parsedDate = new Date(parseInt(val.Timestamp.substr(6)));
                                    var jsDate = new Date(parsedDate);
                                    //alert(val.Value);
                                    chartDataDaily.push({
                                        Timestamp: jsDate
                                    });
                                    if (val.Value != null && val.Value != 'undefined')
                                        chartDataDaily[i]["'" + siteID + "'"] = val.Value;


                                });
                                /*
                                var url = urlGetChannelDataHourly + siteID + "/" + start + "/" + end;
                                //alert(channel.id);
                                $.getJSON(url, function (d) {
                                    chartData = [];
                                    $.each(d.GetChannelDataHourlyResult, function (i, val) {
                                        var parsedDate = new Date(parseInt(val.Timestamp.substr(6)));
                                        var jsDate = new Date(parsedDate);

                                        chartData.push({
                                            Timestamp: jsDate
                                        });
                                        if (val.Value != null && val.Value != 'undefined')
                                            chartData[i]["'" + siteID + "'"] = val.Value;


                                    });
                                    */
                                    //SERIAL CHART
                                    am4core.useTheme(am4themes_animated);
                                    // Themes end

                                    // Create chart instance
                                    var chart = am4core.create("chartdiv", am4charts.XYChart);

                                    // Create daily series and related axes
                                    var dateAxis1 = chart.xAxes.push(new am4charts.DateAxis());
                                    dateAxis1.renderer.grid.template.location = 0;
                                    dateAxis1.renderer.minGridDistance = 40;


                                    var valueAxis1 = chart.yAxes.push(new am4charts.ValueAxis());


                                    var series1 = chart.series.push(new am4charts.ColumnSeries());
                                    series1.dataFields.valueY = "'" + siteID + "'";
                                    series1.dataFields.dateX = "Timestamp";
                                    series1.data = chartDataDaily;
                                    series1.xAxis = dateAxis1;
                                    series1.yAxis = valueAxis1;
                                    series1.tooltipText = "{dateX}: [bold]{valueY}[/]";
                                /*
                                    // Create hourly series and related axes
                                    var dateAxis2 = chart.xAxes.push(new am4charts.DateAxis());
                                    dateAxis2.renderer.grid.template.location = 0;
                                    dateAxis2.renderer.minGridDistance = 40;
                                    dateAxis2.renderer.labels.template.disabled = true;
                                    dateAxis2.renderer.grid.template.disabled = true;
                                    dateAxis2.renderer.tooltip.disabled = true;

                                    var valueAxis2 = chart.yAxes.push(new am4charts.ValueAxis());
                                    valueAxis2.renderer.opposite = true;
                                    valueAxis2.renderer.grid.template.disabled = true;
                                    valueAxis2.renderer.labels.template.disabled = true;
                                    valueAxis2.renderer.tooltip.disabled = true;

                                    var series2 = chart.series.push(new am4charts.LineSeries());
                                    series2.dataFields.valueY = "'" + siteID + "'";
                                    series2.dataFields.dateX = "Timestamp";
                                    series2.data = chartData;
                                    series2.xAxis = dateAxis2;
                                    series2.yAxis = valueAxis2;
                                    series2.strokeWidth = 3;
                                    series2.tooltipText = "Hourly:{dateX.formatDate('yyyy-MM-dd hh:mm')}: [bold]{valueY}[/]";
                                */
                                    // Add cursor
                                    chart.cursor = new am4charts.XYCursor();
                                    // chart.dataTableId = "chart_table_MinMax";
                                    var data = series1.data;
                                    // create a table
                                    var holder = document.getElementById("chart_table_MinMax");
                                    holder.innerHTML = "";
                                    // if (holder.childElementCount == 0) {
                                    var table = document.createElement("table");
                                    table.id = "excelEX";
                                    holder.appendChild(table);
                                    var tr, td;

                                    // add first row
                                    for (var x = 0; x < series1.data.length; x++) {
                                        //alert(series1.data.length);
                                        // first row
                                        if (x == 0) {
                                            tr = document.createElement("tr");
                                            table.appendChild(tr);
                                            td = document.createElement("th");
                                            td.className = "row-title2";
                                            //td.innerHTML = chartMinMax.categoryAxis.title;
                                            td.innerHTML = "Timestamp";
                                            tr.appendChild(td);
                                            // for (var i = 0; i < chart.graphs.length ; i++) {
                                            td = document.createElement('th');
                                            td.className = "row-title2";
                                            td.innerHTML = "Consumption";
                                            tr.appendChild(td);
                                            // }
                                        }

                                        // add rows
                                        tr = document.createElement("tr");
                                        table.appendChild(tr);
                                        td = document.createElement("td");
                                        td.className = "row-title";

                                        // td.innerHTML = chartMinMax.dataProvider[x][chartMinMax.categoryField].toUTCString();
                                        var todayTime = new Date(series1.data[x][series1.dataFields.dateX]);
                                        td.innerHTML = dtFormat2(todayTime);
                                        tr.appendChild(td);
                                        var valuetotal;
                                        // for (var i = 0; i < chart.graphs.length  ; i++) {
                                        td = document.createElement('td');
                                        valuetotal = series1.data[x][series1.dataFields.valueY];
                                        td.innerHTML = Math.round(valuetotal * 100) / 100;
                                        tr.appendChild(td);

                                        //}

                                    }

                                //});
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
</body>
</html>
