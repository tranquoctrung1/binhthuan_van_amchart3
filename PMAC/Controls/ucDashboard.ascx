<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucDashboard.ascx.cs" Inherits="Controls_ucDashboard" %>

<style>
    /*Cố định header*/
    div.haha {
        width: 100%;
        height: 200px;
        overflow: scroll;
        overflow-x: hidden
    }

        div.haha table th {
            background: #1BACE1;
            font-family: Arial;
            color: #fff;
            position: -webkit-sticky;
            position: sticky;
            top: -1px;
            font-size: small;
        }

        div.haha tfoot tr td {
            background: #1BACE1;
            font-family: Arial;
            color: #fff;
            position: -webkit-sticky;
            position: sticky;
            bottom: 0;
        }

        div.haha table th, div.haha table td {
            text-align: center;
            padding: 5px 7px;
        }

    a.xlsExportBtn {
        color: white !important;
        margin: auto;
        max-width: 100px;
        display: block;
    }

    .chart-container {
        height: 250px;
    }
</style>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
<%--<link href="/fonts/css/all.min.css" rel="stylesheet" />--%>

<script src="../../js/jquery-3.4.1.min.js"></script>
<script src="../../js/amcharts/amcharts.js"></script>
<script src="../../js/amcharts/serial.js"></script>
<script src="../../js/amcharts/exporting/amexport.js"></script>
<script src="../../js/amcharts/exporting/canvg.js"></script>
<script src="../../js/amcharts/exporting/filesaver.js"></script>
<script src="../../js/amcharts/exporting/jspdf.js"></script>
<script src="../../js/amcharts/exporting/jspdf.plugin.addimage.js"></script>
<script src="../../js/amcharts/exporting/rgbcolor.js"></script>
<script src="../../js/randomColor.js"></script>
<%--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>--%>
<link href="../../App_Themes/common.css" rel="stylesheet" />
<link href="/css/bootstrap/bootstrap.min.css" rel="stylesheet" />
<%--    <link href="/css/bootstrap/sb-admin-2.min.css" rel="stylesheet" />
    <script src="/js/sb-admin-2.min.js"></script>--%>

<div id="wait" style="display: none; width: 100%; height: 100%; position: absolute; padding: 2px; z-index: 9999; background-color: white">
    <img src='/_imgs/ajax-loader.gif' width="64" height="64" style="margin: auto; display: block" /><br>
</div>
<div class="row">
    <div class="col-sm-2">
        <asp:Label ID="lbSites" runat="server" Text="Điểm đo"></asp:Label>:
    </div>
    <div class="col-sm-6">
        <telerik:RadComboBox ID="cboSites" runat="server" OnClientSelectedIndexChanging="cboSites_OnClientSelectedIndexChanged"
            DataSourceID="SitesDataSource" DataTextField="SiteId" EnableLoadOnDemand="true" Filter="Contains"
            DataValueField="SiteId" MarkFirstMatch="true" AllowCustomText="false" OnClientBlur="cboSites_OnClientBlur"
            HighlightTemplatedItems="True">
        </telerik:RadComboBox>
        <asp:ObjectDataSource ID="SitesDataSource" runat="server"
            OldValuesParameterFormatString="original_{0}" SelectMethod="GetSites"
            TypeName="PMAC.BLL.SiteBL"></asp:ObjectDataSource>
    </div>
</div>

<!-- Cards -->
<div class="row" style="margin-top: 5px;">

    <!-- Today -->
    <div class="col-xl-2 col-md-6 mb-2">
        <div class="card border-primary shadow" style="max-width: 18rem;">
            <div class="text-xs font-weight-bold text-primary text-uppercase pl-2">Hôm nay(m<sup>3</sup>)</div>
            <div class="card-body py-0">
                <div class="row pt-1">
                    <div class="col-sm-3 col-3">
                        <i class="fa fa-tint fa-lg" style="color: aqua"></i>
                    </div>
                    <div class="col-sm-9 col-9">
                        <div class="h6 font-weight-bold text-gray-800" id="Today">0</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Yesterday -->
    <div class="col-xl-2 col-md-6 mb-2">
        <div class="card border-warning shadow" style="max-width: 18rem;">
            <div class="text-xs font-weight-bold text-warning text-uppercase pl-2">Hôm qua(m<sup>3</sup>)</div>
            <div class="card-body py-0">
                <div class="row pt-1">
                    <div class="col-sm-3 col-3">
                        <i class="fa fa-tint fa-lg" style="color: aqua"></i>
                    </div>
                    <div class="col-sm-9 col-9">
                        <div class="h6 font-weight-bold text-gray-800" id="Yesterday">0</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- This Month -->
    <div class="col-xl-2 col-md-6 mb-2">
        <div class="card border-success shadow" style="max-width: 18rem;">
            <div class="text-xs font-weight-bold text-success text-uppercase pl-2">Tháng nay(m<sup>3</sup>)</div>
            <div class="card-body py-0">
                <div class="row pt-1">
                    <div class="col-sm-3 col-3">
                        <i class="fa fa-tint fa-lg" style="color: aqua"></i>
                    </div>
                    <div class="col-sm-9 col-9">
                        <div class="h6 font-weight-bold text-gray-800" id="ThisMonth">0</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Last Month -->
    <div class="col-xl-2 col-md-6 mb-2">
        <div class="card border-primary shadow" style="min-width: 10rem; max-width: 18rem">
            <div class="text-xs font-weight-bold text-primary text-uppercase pl-1">Tháng trước(m<sup>3</sup>)</div>
            <div class="card-body py-0">
                <div class="row pt-1">
                    <div class="col-sm-3 col-3">
                        <i class="fa fa-tint fa-lg" style="color: aqua"></i>
                    </div>
                    <div class="col-sm-9 col-9">
                        <div class="h6 font-weight-bold text-gray-800" id="LastMonth">0</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- This year -->
    <div class="col-xl-2 col-md-6 mb-2">
        <div class="card border-warning shadow" style="max-width: 18rem;">
            <div class="text-xs font-weight-bold text-warning text-uppercase pl-2">Năm nay(m<sup>3</sup>)</div>
            <div class="card-body py-0">
                <div class="row pt-1">
                    <div class="col-sm-3 col-3">
                        <i class="fa fa-tint fa-lg" style="color: aqua"></i>
                    </div>
                    <div class="col-sm-9 col-9">
                        <div class="h6 font-weight-bold text-gray-800" id="ThisYear">0</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Last year -->
    <div class="col-xl-2 col-md-6 mb-2">
        <div class="card border-success shadow" style="max-width: 18rem;">
            <div class="text-xs font-weight-bold text-success text-uppercase pl-2">Năm trước(m<sup>3</sup>)</div>
            <div class="card-body py-0">
                <div class="row pt-1">
                    <div class="col-sm-3 col-3">
                        <i class="fa fa-tint fa-lg" style="color: aqua"></i>
                    </div>
                    <div class="col-sm-9 col-9">
                        <div class="h6 font-weight-bold text-gray-800" id="LastYear">0</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Charts and tables -->
<div class="row">
    <div class="col-xl-4 col-md-12 col-sm-12">
        <div class="row">
            <div class="col-xl-12 col-md-12 col-sm-12">
                <div class="row">
                    <span style="color: #1BACE1; font-size: 16px; width: 100%; float: left; text-align: center; cursor: pointer" id="Hourly Consumption" onclick="btntoggle_fullscreen('chart_today');">Sản lượng giờ</span>
                    <span style="color: #555555; width: 50%; float: left; text-align: center;" id="DATE">Ngày:</span>
                    <span style="color: #555555; fill: #555555; width: 50%; float: left; font-weight: bold; text-align: left;" id="tToday"></span>
                </div>
                <%--                <div class="row pt-0">
                    <span style="color: #f25d5d; width: 50%; float: left; text-align: center;" id="This Day TOTAL">Sản lượng hôm nay:</span>
                    <span id="totalhourly" style="color: #555555; width: 12%; font-weight: bold; float: left; text-align: left;"></span>
                    <span style="color: #555555; width: 38%; float: left; text-align: center;">(m3)</span>
                </div>--%>
            </div>
        </div>
        <div class="row" style="height: 250px">
            <div id="chart_today" class="col-xl-12 col-md-12 col-sm-12 col-12" style="width: 100%; height: 90%"></div>

        </div>
        <div class="row px-2">
            <div class="col-12">
                <div class="haha" id="table_today">
                </div>
            </div>
            <div class="col-12 mt-1">
                <a class="btn btn-success xlsExportBtn" id="btnXlsHourly"><i class="fa fa-file-excel-o"></i>Export</a>
            </div>

        </div>
    </div>

    <div class="col-xl-4 col-md-12 col-sm-12">
        <div class="row">
            <div class="col-xl-12 col-md-12 col-sm-12">
                <div class="row">
                    <span style="color: #1BACE1; font-size: 16px; width: 100%; float: left; text-align: center; cursor: pointer" id="Daily Consumption" onclick="btntoggle_fullscreen('chart_thisMonth')">Sản lượng ngày</span>
                    <span style="color: #555555; width: 50%; float: left; text-align: center;" id="MONTH">Tháng:</span>
                    <span style="color: #555555; fill: #555555; width: 50%; float: left; font-weight: bold; text-align: left;" id="tThisMonth"></span>
                </div>
                <%--                <div class="row pt-0">
                    <span style="color: #f25d5d; width: 50%; float: left; text-align: center;" id="This Month TOTAL">Sản lượng tháng này:</span>
                    <span id="totaldaily" style="color: #555555; width: 13%; font-weight: bold; float: left; text-align: left;"></span>
                    <span style="color: #555555; width: 37%; float: left; text-align: center;">(m3)</span>
                </div>--%>
            </div>
        </div>
        <div class="row" style="height: 250px">
            <div id="chart_thisMonth" class="col-xl-12 col-md-12 col-sm-12 col-12" style="width: 100%; height: 90%"></div>
        </div>
        <div class="row px-2">
            <div class="col-12">
                <div class="haha" id="table_thisMonth">
                </div>
            </div>
            <div class="col-12 mt-1">
                <a class="btn btn-success xlsExportBtn" id="btnXlsDaily"><i class="fa fa-file-excel-o"></i>Export</a>
            </div>

        </div>
    </div>

    <div class="col-xl-4 col-md-12 col-sm-12">
        <div class="row">
            <div class="col-xl-12 col-md-12 col-sm-12">
                <div class="row">
                    <span style="color: #e3cb20; font-size: 16px; width: 100%; float: left; text-align: center; cursor: pointer" id="Monthly Consumption" onclick="btntoggle_fullscreen('chart_thisYear')">Sản lượng tháng</span>
                    <span style="color: #555555; width: 50%; float: left; text-align: center;" id="YEAR">Năm:</span>
                    <span style="color: #555555; fill: #555555; width: 50%; float: left; font-weight: bold; text-align: left;" id="tThisYear"></span>
                </div>
                <%--                <div class="row pt-0">
                    <span style="color: #f25d5d; width: 50%; float: left; text-align: center;" id="This Year TOTAL">Sản lượng năm nay:</span>
                    <span id="totalmonthly" style="color: #555555; width: 15%; font-weight: bold; float: left; text-align: left;"></span>
                    <span style="color: #555555; width: 35%; float: left; text-align: center;">(m3)</span>
                </div>--%>
            </div>
        </div>
        <div class="row" style="height: 250px">
            <div id="chart_thisYear" class="col-xl-12 col-md-12 col-sm-12 col-12" style="width: 100%; height: 90%"></div>
        </div>
        <div class="row px-2">
            <div class="col-12">
                <div class="haha" id="table_thisYear">
                </div>
            </div>
            <div class="col-12 mt-1">
                <a class="btn btn-success xlsExportBtn" id="btnXlsMonthly"><i class="fa fa-file-excel-o"></i>Export</a>
            </div>

        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Biểu đồ</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="modal-chart"></div>
            </div>
        </div>
    </div>
</div>

<script>
    //Properties
    var sites = [];
    var chartData = [];
    var sumToday = 0;
    var sumThisMonth = 0;
    var sumThisYear = 0;

    var chartToday;
    var chartThisMonth;
    var chartThisYear;

    var hostname = window.location.origin;
    if (hostname.indexOf("localhost") < 0)
        hostname = hostname + "/VivaServices/";
    else
        hostname = "http://localhost:63111";

    var urlGetChannelData = hostname + '/Service1.svc/GetChannelData/';
    var urlGetChannelDataDaily = hostname + '/Service1.svc/GetChannelDatadaily/';
    var urlGetChannelDataHourly = hostname + '/Service1.svc/GetChannelDataHourly/';
    var urlGetChannelDataMonthly = hostname + '/Service1.svc/GetChannelDataMonthly/';
    var urlGetChannelDataYearly = hostname + '/Service1.svc/GetChannelDataYearly/';

    //Định dạng hỗ trợ dd/mm/yyyy/hh/mm/ss
    function timeFormat(n) {
        if (n <= 9) {
            return "0" + n;
        }
        return n
    }

    $(document).ready(function () {
        var selected = $find("<%= cboSites.ClientID %>");
        var siteId = selected.get_selectedItem().get_value();
        load_Page(siteId);
    })

    function cboSites_OnClientSelectedIndexChanged(sender, eventArgs) {
        var selected = eventArgs.get_item();
        var siteId = selected.get_value();
        load_Page(siteId);

    }

    function load_Page(siteId) {
        //Labels
        console.time('Labels');
        var currentTime = new Date();
        document.getElementById('tToday').innerHTML = timeFormat(currentTime.getDate()) + "/" + timeFormat(currentTime.getMonth() + 1) + "/" + currentTime.getFullYear();
        document.getElementById('tThisMonth').innerHTML = timeFormat(currentTime.getMonth() + 1) + "/" + currentTime.getFullYear();
        document.getElementById('tThisYear').innerHTML = currentTime.getFullYear();
        console.timeEnd('Labels');
        //Tables and Charts
        console.time('Tables and Charts');
        Create_Table_Chart(siteId, 'Hour');
        Create_Table_Chart(siteId, 'Day')
        Create_Table_Chart(siteId, 'Month');
        console.timeEnd('Tables and Charts');
        //Cards
        console.time('Cards');
        CreateCards(siteId);
        console.timeEnd('Cards');
    }

    function CreateCards(siteId) {
        //sumToday, sumThisMonth, sumThisYear đã tìm trong khi tạo bảng
        //Còn các thông số sau
        var sumYesterday = 0;
        var sumLastMonth = 0;
        var sumLastYear = 0;

        var end = new Date();
        var start = new Date();
        //yesterday
        end.setHours(0, 0, 0, 0);
        start.setHours(0, 0, 0, 0);
        start.setDate(end.getDate() - 1);
        var url = urlGetChannelDataDaily + siteId + "/" + toUnixSeconds(start) + "/" + toUnixSeconds(start);
        $.getJSON(url, function (r) {
            $.each(r.GetChannelDataDailyResult, function (k, v) {
                sumYesterday += v.Value;
            })

            //$.ajax({
            //    url: url, async: false, success: function (r) {
            //        $.each(r.GetChannelDataDailyResult, function (k, v) {
            //            sumYesterday += v.Value;
            //        })
            //    }
            //})
            //LastMonth
            end.setDate(1);
            start.setMonth(end.getMonth() - 1, 1);
            url = urlGetChannelDataMonthly + siteId + "/" + toUnixSeconds(start) + "/" + toUnixSeconds(start);
            $.getJSON(url, function (r) {
                $.each(r.GetChannelDataMonthlyResult, function (k, v) {
                    sumLastMonth += v.Value;
                })

                //$.ajax({
                //    url: url, async: false, success: function (r) {
                //        $.each(r.GetChannelDataMonthlyResult, function (k, v) {
                //            sumLastMonth += v.Value;
                //        })
                //    }
                //})
                //LastYear
                end.setMonth(0);
                start.setFullYear(end.getFullYear() - 1, 0, 1);
                end.setSeconds(-1);
                url = urlGetChannelDataYearly + siteId + "/" + toUnixSeconds(start) + "/" + toUnixSeconds(end);
                $.getJSON(url, function (r) {
                    $.each(r.GetChannelDataYearlyResult, function (k, v) {
                        sumLastYear += v.Value;
                    })

                    //$.ajax({
                    //    url: url, async: false, success: function (r) {
                    //        $.each(r.GetChannelDataYearlyResult, function (k, v) {
                    //            sumLastYear += v.Value;
                    //        })
                    //    }
                    //})
                    //document.getElementById('Today').innerHTML = sumToday.toFixed(1);
                    document.getElementById('Yesterday').innerHTML = sumYesterday.toFixed(1);
                    //document.getElementById('ThisMonth').innerHTML = sumThisMonth.toFixed(1);
                    document.getElementById('LastMonth').innerHTML = sumLastMonth.toFixed(1);
                    //document.getElementById('ThisYear').innerHTML = sumThisYear.toFixed(0);
                    document.getElementById('LastYear').innerHTML = sumLastYear.toFixed(0);
                })
            })
        })
    }

    function Create_Table_Chart(siteId, time) {//time=[Hour; Day, Month]
        //console.time('GetRawData' + time);
        //var raw_data = GetRawData(siteId, time);
        //console.timeEnd('GetRawData' + time);

        var raw_data = [];
        var end = new Date();
        var start = new Date();
        var url = '';
        switch (time) {
            case 'Hour':
                start.setHours(0, 0, 0, 0);
                url = urlGetChannelDataHourly + siteId + "/" + toUnixSeconds(start) + "/" + toUnixSeconds(end);
                break;
            case 'Day':
                start.setDate(1);
                start.setHours(0, 0, 0, 0);
                url = urlGetChannelDataDaily + siteId + "/" + toUnixSeconds(start) + "/" + toUnixSeconds(end);
                break;
            case 'Month':
                start.setMonth(0, 1);
                start.setHours(0, 0, 0, 0);
                url = urlGetChannelDataMonthly + siteId + "/" + toUnixSeconds(start) + "/" + toUnixSeconds(end);
        }

        $.getJSON(url, function (r) {
            $.each(r, function (key, val) {
                raw_data = val;
            })
            switch (time) {
                case 'Hour':
                    console.time('create Table Today');
                    sumToday = createTable(raw_data, 'table_today', time);
                    document.getElementById('Today').innerHTML = sumToday.toFixed(1);
                    console.timeEnd('create Table Today');

                    console.time('draw Chart Today');
                    chartToday = drawChart(raw_data, 'chart_today');
                    console.timeEnd('draw Chart Today')
                    break;
                case 'Day':
                    console.time('create Table Month');
                    sumThisMonth = createTable(raw_data, 'table_thisMonth', time);
                    document.getElementById('ThisMonth').innerHTML = sumThisMonth.toFixed(1);
                    console.timeEnd('create Table Month');

                    console.time('draw Chart Month');
                    chartThisMonth = drawChart(raw_data, 'chart_thisMonth');
                    console.timeEnd('draw Chart Month');
                    break;
                case 'Month':
                    console.time('create Table Year');
                    sumThisYear = createTable(raw_data, 'table_thisYear', time);
                    document.getElementById('ThisYear').innerHTML = sumThisYear.toFixed(0);
                    console.timeEnd('create Table Year');

                    console.time('draw Chart Year');
                    chartThisYear = drawChart(raw_data, 'chart_thisYear');
                    console.timeEnd('draw Chart Year');
                    break;
            }
        })
    }

    function createTable(raw_data, table_id, time) {
        var sum = 0;
        var body = [];
        var footer = [];

        $.each(raw_data, function (key, val) {
            var parsedDate = new Date(parseInt(val.Timestamp.substr(6)));
            var jsDate = new Date(parsedDate);
            var temp = new Date();
            if (jsDate > temp) { return false; }
            switch (time) {
                case 'Hour':
                    var formattedDate = timeFormat(jsDate.getDate()) + "/" + timeFormat(jsDate.getMonth() + 1) + "/" + jsDate.getFullYear() + " " + timeFormat(jsDate.getHours()) + ":" + timeFormat(jsDate.getMinutes()) + ":" + timeFormat(jsDate.getSeconds());
                    break;
                case 'Day':
                    var formattedDate = timeFormat(jsDate.getDate()) + "/" + timeFormat(jsDate.getMonth() + 1) + "/" + jsDate.getFullYear();
                    break;
                case 'Month':
                    var formattedDate = timeFormat(jsDate.getMonth() + 1) + "/" + jsDate.getFullYear();
                    break;
            }

            body.push("<tr>");
            body.push("<td id =''" + key + "''>" + formattedDate + "</td>");
            body.push("<td id =''" + key + "''>" + val.Value + "</td>");
            body.push("</tr>");
            sum += val.Value;
        });

        footer.push("<tr>");
        footer.push("<td>Tổng (m<sup>3</sup>)</td>");
        footer.push("<td>" + sum.toFixed(2) + "</td>");
        footer.push("</td>");

        var table = '<table class="table-striped table-bordered col-xl-12 col-md-12 col-sm-12" >' +
            '<thead>' +
            '<tr>' +
            '<th>Thời điểm</th>' +
            '<th>Sản lượng</th>' +
            '</tr>' +
            '</thead>' +
            '<tbody>' + body.join("") + '</tbody>' +
            '<tfoot>' + footer.join("") + '</tfoot>' +
            '</table>';

        $('#' + table_id).html(table);

        //Export btn
        switch (table_id) {
            case "table_today": $('#btnXlsHourly').off('click').on('click', function () {
                exportToXLS('Sheet1', table, 'Report_' + $('#tToday').text().replace("/", "_"));
            })
                break;
            case "table_thisMonth": $('#btnXlsDaily').off('click').on('click', function () {
                exportToXLS('Sheet1', table, 'Report_' + $('#tThisMonth').text().replace("/", "_"));
            })
                break;
            case "table_thisYear": $('#btnXlsMonthly').off('click').on('click', function () {
                exportToXLS('Sheet1', table, 'Report_' + $('#tThisYear').text().replace("/", "_"));
            })
                break;
        }
        return sum;
    }



    function drawChart(raw_data, div_id) { //interval=[Hour; Day, Month]
        chartData = [];
        $.each(raw_data, function (k, val) {
            var jsDate = new Date(parseInt(val.Timestamp.substr(6)));
            var temp = new Date();
            if (jsDate > temp) { return false; }
            chartData.push({
                Timestamp: jsDate, Value: val.Value
            });
            //if (val.Value != null && val.Value != 'undefined')
            //    chartData[i]["'" + channel.id + "'"] = val.Value;
        });


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
            format: 'DD-MM'
        }, {
            period: 'WW',
            format: 'DD-MM'
        }, {
            period: 'MM',
            format: 'MM-YYYY'
        }, {
            period: 'YYYY',
            format: 'MM-YYYY'
        }];

        categoryAxis.axisColor = "#DADADA";
        categoryAxis.gridAlpha = 0.15;
        //AXE
        //Y1
        valueAxis = new AmCharts.ValueAxis();
        valueAxis.id = 'feed';
        valueAxis.axisColor = '#3BADF1';
        valueAxis.axisThickness = 1;
        valueAxis.title = 'm3';
        valueAxis.titleColor = '#3BADF1';
        chart.addValueAxis(valueAxis);

        //GRAPH COLOR
        //var type;
        //var color;
        //switch (channel.unit) {
        //    case "m":
        //        type = valueAxisPress;
        //        color = '#ff0000';
        //        colors.push(color);
        //        break;
        //    case "m3/h":
        //        type = valueAxisFlow;
        //        color = '#0000ff';
        //        colors.push(color);
        //        break;
        //    default:
        //        type = valueAxisPress;
        //        break;
        //}
        // GRAPH
        var graph = new AmCharts.AmGraph();
        graph.id = 'feed';
        graph.valueAxis = valueAxis;
        graph.title = "Sản lượng";
        graph.valueField = "Value";
        graph.bullet = "round";
        graph.bulletBorderColor = "#0149E8";
        graph.bulletBorderThickness = 2;
        graph.bulletBorderAlpha = 1;
        graph.bulletSize = 8;
        graph.lineThickness = 1;
        graph.lineColor = "#3BADF1";
        graph.hideBulletsCount = 50;

        chart.addGraph(graph);
        // CURSOR
        var chartCursor = new AmCharts.ChartCursor();
        chartCursor.categoryBalloonDateFormat = "MMM DD, YYYY JJ:NN";
        chart.addChartCursor(chartCursor);
        // SCROLLBAR
        //var chartScrollbar = new AmCharts.ChartScrollbar();
        //chartScrollbar.autoGridCount = true;
        //chartScrollbar.scrollbarHeight = 20;
        //chart.addChartScrollbar(chartScrollbar);
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
        chart.write("" + div_id + "");
        return chart;
    };

    function GetRawData(siteId, time) {
        var data = [];
        var end = new Date();
        var start = new Date();
        var url = '';
        switch (time) {
            case 'Hour':
                start.setHours(0, 0, 0, 0);
                url = urlGetChannelDataHourly + siteId + "/" + toUnixSeconds(start) + "/" + toUnixSeconds(end);
                break;
            case 'Day':
                start.setDate(1);
                start.setHours(0, 0, 0, 0);
                url = urlGetChannelDataDaily + siteId + "/" + toUnixSeconds(start) + "/" + toUnixSeconds(end);
                break;
            case 'Month':
                start.setMonth(0, 1);
                start.setHours(0, 0, 0, 0);
                url = urlGetChannelDataMonthly + siteId + "/" + toUnixSeconds(start) + "/" + toUnixSeconds(end);
        }

        $.getJSON(url, function (r) {
            $.each(r, function (key, val) {
                data = val;
            })
        })

        //$.ajax({
        //    url: url,
        //    async: false,
        //    success: function (r) {
        //        $.each(r, function (key, val) {
        //            data = val;
        //        })
        //    }
        //})
        return data;
    }

    function toUnixSeconds(datetime) {
        return Math.floor(datetime.getTime() / 1000);
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

    function zoomChart() {
        // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
        chart.zoomToIndexes(chartData.length - chartData.length, chartData.length - 1);
    }

    function cboSites_OnClientBlur(sender, eventArgs) {
        var textInTheCombo = sender.get_text();
        var item = sender.findItemByText(textInTheCombo);
        //if there is no item with that text
        if (!item) {
            sender.set_text("");
            setTimeout(function () {
                var inputElement = sender.get_inputDomElement();
                inputElement.focus();
                inputElement.style.backgroundColor = "red";
            }, 20);
        }
    }

    function exportToXLS(title, table, fileName = 'export.xls') {
        if (typeof fileName !== 'string' || Object.prototype.toString.call(fileName) !== '[object String]') {
            throw new Error('Invalid input type: exportToCSV(String)');
        }

        const TEMPLATE_XLS = `
                    <html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
                    <meta http-equiv="content-type" content="application/vnd.ms-excel; charset=UTF-8"/>
                    <head><!--[if gte mso 9]><xml>
                    <x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{title}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml>
                    <![endif]--></head>
                    <body>{table}</body></html>`;
        const MIME_XLS = 'application/vnd.ms-excel;base64,';

        const parameters = {
            title: title,
            table: table,
        };
        const computeOutput = TEMPLATE_XLS.replace(/{(\w+)}/g, (x, y) => parameters[y]);

        const computedXLS = new Blob([computeOutput], {
            type: MIME_XLS,
        });
        const xlsLink = window.URL.createObjectURL(computedXLS);
        downloadFile(xlsLink, fileName);
    }

    function downloadFile(output, fileName) {
        const link = document.createElement('a');
        document.body.appendChild(link);
        link.download = fileName;
        link.href = output;
        link.click();
    }

    function btntoggle_fullscreen(chart_id) {
        if (
            document.fullscreenElement ||
            document.webkitFullscreenElement ||
            document.mozFullScreenElement ||
            document.msFullscreenElement
        ) {
            if (document.exitFullscreen) {
                document.exitFullscreen();
            } else if (document.mozCancelFullScreen) {
                document.mozCancelFullScreen();
            } else if (document.webkitExitFullscreen) {
                document.webkitExitFullscreen();
            } else if (document.msExitFullscreen) {
                document.msExitFullscreen();
            }
        } else {
            element = $('#' + chart_id).get(0);
            if (element.requestFullscreen) {
                element.requestFullscreen();
            } else if (element.mozRequestFullScreen) {
                element.mozRequestFullScreen();
            } else if (element.webkitRequestFullscreen) {
                element.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
            } else if (element.msRequestFullscreen) {
                element.msRequestFullscreen();
            }
        }
    }
</script>
