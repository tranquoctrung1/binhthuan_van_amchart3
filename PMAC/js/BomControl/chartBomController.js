// variable to dispose 
let chart;
// fucntion draw chart to
async function drawChart(deviceName) {

    let hostname = window.location.origin;
    if (hostname.indexOf("localhost") < 0)
        hostname = hostname + "/VanServices";
    else
        hostname = "http://localhost:61403";

    let urlGetTimeExistData = `${hostname}/api/charttime/`; // add channelID
    let urlGetChartData = `${hostname}/api/datachart/`; // add channnelID, start time and end time

    // load data two channel P2 and P2Set

    let url1 = `${urlGetTimeExistData}${deviceName}_P2`;
    let url2 = `${urlGetTimeExistData}${deviceName}_P2set`;
    let datetime1 = await axios.get(url1);
    let datetime2 = await axios.get(url2);
    let start;
    let end;


    if (datetime1.data[0] != null && datetime1.data[0] != undefined) {
        datetime1 = new Date(datetime1.data[0].TimeStamp);
    }
    else {
        datetime1 = new Date(1970, 1, 1);
    }
    if (datetime2.data[0] != null && datetime2.data[0] != undefined) {
        datetime2 = new Date(datetime2.data[0].TimeStamp)
    }
    else {
        datetime2 = new Date(1970, 1, 1);
    }

    if (datetime1.getTime() >= datetime2.getTime()) {
        end = new Date(datetime1.getFullYear(), datetime1.getMonth(), datetime1.getDate(), 23, 59, 59);
    }
    else {
        end = new Date(datetime2.getFullYear(), datetime2.getMonth(), datetime2.getDate(), 23, 59, 59);
    }


    document.getElementById('endDate').value = `${end.getFullYear()}-${end.getMonth() + 1 >= 10 ? end.getMonth() + 1 : '0' + (end.getMonth() + 1)}-${end.getDate() >= 10 ? end.getDate() : '0' + end.getDate()}T${end.getHours() >= 10 ? end.getHours() : '0' + end.getHours()}:${end.getMinutes() >= 10 ? end.getMinutes() : '0' + end.getMinutes()}`;
    let tmp = new Date(end.getFullYear(), end.getMonth(), end.getDate());
    document.getElementById('startDate').value = `${tmp.getFullYear()}-${tmp.getMonth() + 1 >= 10 ? tmp.getMonth() + 1 : '0' + (tmp.getMonth() + 1)}-${tmp.getDate() >= 10 ? tmp.getDate() : '0' + tmp.getDate()}T${tmp.getHours() >= 10 ? tmp.getHours() : '0' + tmp.getHours()}:${tmp.getMinutes() >= 10 ? tmp.getMinutes() : '0' + tmp.getMinutes()}`;

    end = (end.getTime() / 1000).toString();
    start = (end - 43200).toString(); // 3 days


    let urlGetDataForChart1 = `${urlGetChartData}${deviceName}_P2/${start}/${end}`;
    let urlGetDataForChart2 = `${urlGetChartData}${deviceName}_P2set/${start}/${end}`;

    let data1 = await axios.get(urlGetDataForChart1);
    let data2 = await axios.get(urlGetDataForChart2);

    let lengthMax = data1.data.length >= data2.data.length ? data1.data.length : data2.data.length;
    let chartData = [];

    for (let i = 0; i < lengthMax; i++) {
        let obj = {};
        obj.TimeStamp = new Date(data1.data[i].TimeStamp);
        if (data1.data.length != 0) {
            if (data1.data[i] != undefined)
                if (data1.data[i].Value != null && data1.data[i].Value != undefined) {
                    obj['P2'] = data1.data[i].Value == 0 ? 0 : data1.data[i].Value;
                }
        }
        if (data2.data.length != 0) {
            if (data2.data[i] != undefined)
                if (data2.data[i].Value != null && data2.data[i].Value != undefined) {
                    obj['P2set'] = data2.data[i].Value == 0 ? 0 : data2.data[i].Value;
                }
        }

        chartData.push(obj);
    }

    chartData.sort(function (a, b) { return a.TimeStamp.getTime() - b.TimeStamp.getTime() });

    chart = new AmCharts.AmSerialChart();
    chart.pathToImages = "../../js/amcharts/images/";
    chart.dataProvider = chartData;
    chart.categoryField = "TimeStamp";
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
    valueAxisPress.titleColor = 'red';
    chart.addValueAxis(valueAxisPress);
  
    //GRAPH COLOR
   
    // GRAPH
    var graph = new AmCharts.AmGraph();
    graph.id = `P2`;
    graph.title = `P2`;
    graph.valueAxis = valueAxisPress;
    graph.valueField = `P2`;
    graph.bullet = "round";
    graph.bulletBorderColor = "#FFFFFF";
    graph.bulletBorderThickness = 2;
    graph.bulletBorderAlpha = 1;
    graph.bulletSize = 8;
    graph.lineThickness = 1;
    graph.lineColor = '#0984e3';
    graph.hideBulletsCount = 50;
    chart.addGraph(graph);

    // GRAPH
    var graph2 = new AmCharts.AmGraph();
    graph2.id = `P2set`;
    graph2.title = `P2set`;
    graph2.valueField = `P2set`;
    graph.valueAxis = valueAxisPress;
    graph2.bullet = "round";
    graph2.bulletBorderColor = "#FFFFFF";
    graph2.bulletBorderThickness = 2;
    graph2.bulletBorderAlpha = 1;
    graph2.bulletSize = 8;
    graph2.lineThickness = 1;
    graph2.lineColor = '#00b894';
    graph2.hideBulletsCount = 50;
    chart.addGraph(graph2);

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
    chart.write("chart");
}

// function draw chart when click view button
async function drawChartWithTime(deviceName, start, end) {

    let hostname = window.location.origin;
    if (hostname.indexOf("localhost") < 0)
        hostname = hostname + '/VanServices';
    else
        hostname = "http://localhost:61403";

    let urlGetChartData = `${hostname}/api/datachart/`; // add channnelID, start time and end time


    // load data two channel P2 and P2Set

    end = (end.getTime() / 1000).toString();
    start = (start.getTime() / 1000).toString(); // 3 days

    let urlGetDataForChart1 = `${urlGetChartData}${deviceName}_P2/${start}/${end}`;
    let urlGetDataForChart2 = `${urlGetChartData}${deviceName}_P2set/${start}/${end}`;

    let data1 = await axios.get(urlGetDataForChart1);
    let data2 = await axios.get(urlGetDataForChart2);

    let lengthMax = data1.data.length >= data2.data.length ? data1.data.length : data2.data.length;
    let chartData = [];

    for (let i = 0; i < lengthMax; i++) {
        let obj = {};
        obj.TimeStamp = new Date(data1.data[i].TimeStamp);
        if (data1.data.length != 0) {
            if (data1.data[i] != undefined)
                if (data1.data[i].Value != null && data1.data[i].Value != undefined) {
                    obj['P2'] = data1.data[i].Value == 0 ? 0 : data1.data[i].Value;
                }
        }
        if (data2.data.length != 0) {
            if (data2.data[i] != undefined)
                if (data2.data[i].Value != null && data2.data[i].Value != undefined) {
                    obj['P2set'] = data2.data[i].Value == 0 ? 0 : data2.data[i].Value;
                }
        }

        chartData.push(obj);
    }

    chartData.sort(function (a, b) { return a.TimeStamp.getTime() - b.TimeStamp.getTime() });

    chart = new AmCharts.AmSerialChart();
    chart.pathToImages = "../../js/amcharts/images/";
    chart.dataProvider = chartData;
    chart.categoryField = "TimeStamp";
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
    valueAxisPress.titleColor = 'red';
    chart.addValueAxis(valueAxisPress);

    //GRAPH COLOR

    // GRAPH
    var graph = new AmCharts.AmGraph();
    graph.id = `P2`;
    graph.title = `P2`;
    graph.valueAxis = valueAxisPress;
    graph.valueField = `P2`;
    graph.bullet = "round";
    graph.bulletBorderColor = "#FFFFFF";
    graph.bulletBorderThickness = 2;
    graph.bulletBorderAlpha = 1;
    graph.bulletSize = 8;
    graph.lineThickness = 1;
    graph.lineColor = '#0984e3';
    graph.hideBulletsCount = 50;
    chart.addGraph(graph);

    // GRAPH
    var graph2 = new AmCharts.AmGraph();
    graph2.id = `P2set`;
    graph2.title = `P2set`;
    graph2.valueField = `P2set`;
    graph.valueAxis = valueAxisPress;
    graph2.bullet = "round";
    graph2.bulletBorderColor = "#FFFFFF";
    graph2.bulletBorderThickness = 2;
    graph2.bulletBorderAlpha = 1;
    graph2.bulletSize = 8;
    graph2.lineThickness = 1;
    graph2.lineColor = '#00b894';
    graph2.hideBulletsCount = 50;
    chart.addGraph(graph2);

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
    chart.write("chart");

    
}

function zoomChart() {
    // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
    chart.zoomToIndexes(chart.dataProvider.length - chart.dataProvider.length, chart.dataProvider.length - 1);
}


async function updateDataChart(deviceName, start, end) {

    // for server
    //let hostname = 'http://112.78.4.162:9999'

    let hostname = window.location.origin;
    if (hostname.indexOf("localhost") < 0)
        hostname = hostname + "/VanServices";
    else
        hostname = "http://localhost:61403";

    let urlGetChartData = `${hostname}/api/datachart/`; // add channnelID, start time and end time

    end = (end.getTime() / 1000).toString();
    start = (start.getTime() / 1000).toString(); // 3 days

    let urlGetDataForChart1 = `${urlGetChartData}${deviceName}_P2/${start}/${end}`;
    let urlGetDataForChart2 = `${urlGetChartData}${deviceName}_P2set/${start}/${end}`;

    let data1 = await axios.get(urlGetDataForChart1);
    let data2 = await axios.get(urlGetDataForChart2);

    let lengthMax = data1.data.length >= data2.data.length ? data1.data.length : data2.data.length;
    let chartData = [];

    for (let i = 0; i < lengthMax; i++) {
        let obj = {};
        obj.TimeStamp = new Date(data1.data[i].TimeStamp);
        if (data1.data.length != 0) {
            if (data1.data[i] != undefined)
                if (data1.data[i].Value != null && data1.data[i].Value != undefined) {
                    obj['P2'] = data1.data[i].Value == 0 ? 0 : data1.data[i].Value;
                }
        }
        if (data2.data.length != 0) {
            if (data2.data[i] != undefined)
                if (data2.data[i].Value != null && data2.data[i].Value != undefined) {
                    obj['P2set'] = data2.data[i].Value == 0 ? 0 : data2.data[i].Value;
                }
        }

        chartData.push(obj);
    }

    chartData.sort(function (a, b) { return a.TimeStamp.getTime() - b.TimeStamp.getTime() });

    chart.dataProvider = chartData;
    chart.validateData();
    chart.validateNow();
}