// variable to dispose 
let chart;
// fucntion draw chart to
async function drawChart(deviceName) {
    am4core.ready(async function () {

        if (chart) {
            chart.dispose();
        }

        // for server
        //let hostname = 'http://112.78.4.162:9999'

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
                if(data1.data[i] != undefined)
                    if (data1.data[i].Value != null && data1.data[i].Value != undefined) {
                        obj['P2'] = data1.data[i].Value == 0 ? 0 : data1.data[i].Value;
                    }
            }
            if (data2.data.length != 0) {
                if (data2.data[i] != undefined)
                    if (data2.data[i].Value != null && data2.data[i].Value != undefined ) {
                        obj['P2set'] = data2.data[i].Value == 0 ? 0 : data2.data[i].Value;
                    }
            }

            chartData.push(obj);
        }

        chartData.sort(function (a, b) { return a.TimeStamp.getTime() - b.TimeStamp.getTime() });

        // Themes begin
        am4core.useTheme(am4themes_spiritedaway);
        am4core.useTheme(am4themes_animated);
        // Themes end

        chart = am4core.create("chart", am4charts.XYChart);
        chart.paddingRight = 20;

        chart.data = chartData;

        var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
        dateAxis.renderer.grid.template.location = 0;
        dateAxis.minZoomCount = 5;
        // format dateAxis
        dateAxis.dateFormats.setKey("second", "dd/MM/yyyy HH:mm:ss");
        dateAxis.dateFormats.setKey("minute", "dd/MM/yyyy HH:mm:ss");
        dateAxis.dateFormats.setKey("hour", "dd/MM/yyyy HH:mm:ss");
        dateAxis.dateFormats.setKey("day", "dd/MM/yyyy");
        dateAxis.dateFormats.setKey("month", "MM/yyyy");
        dateAxis.dateFormats.setKey("year", "MM/yyyy");


        // this makes the data to be grouped
        //dateAxis.groupData = true;
        //dateAxis.groupCount = 500;

        var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

        var series = chart.series.push(new am4charts.LineSeries());
        series.dataFields.dateX = "TimeStamp";
        series.dataFields.valueY = 'P2';
        series.name = 'P2';
        series.legendSettings.labelText = "{name}";
        series.legendSettings.valueText = "{valueY.close}";
        series.legendSettings.itemValueText = "[bold]{valueY}[/bold]";
        series.stroke = am4core.color("#74b9ff")

        var series2 = chart.series.push(new am4charts.LineSeries());
        series2.dataFields.dateX = "TimeStamp";
        series2.dataFields.valueY = 'P2set';
        series2.name = 'P2Set';
        series2.legendSettings.labelText = "{name}";
        series2.legendSettings.valueText = "{valueY.close}";
        series2.legendSettings.itemValueText = "[bold]{valueY}[/bold]";
        series2.stroke = am4core.color("#00b894")

        //series.tooltipText = "{dateX} {valueY}";
        //series.tooltip.pointerOrientation = "vertical";
        //series.tooltip.background.fillOpacity = 0.5;

        var bullet = series.bullets.push(new am4charts.Bullet());
        bullet.tooltipText = "{dateX.formatDate('dd/MM/yyyy')} Name: {name} Value: {valueY}"; //{ valueY.formatNumber('#.00') } ";

        bullet.adapter.add("fill", function (fill, target) {
            if (target.dataItem.valueY < 0.5) {
                return am4core.color("#e74c3c");
            }
            return fill;
        })
        var range = valueAxis.createSeriesRange(series);
        range.value = 0.5;
        range.endValue = -10000;
        range.contents.stroke = am4core.color("#e74c3c");
        range.contents.fill = range.contents.stroke;

        var bullet2 = series2.bullets.push(new am4charts.Bullet());
        bullet2.tooltipText = "{dateX.formatDate('dd/MM/yyyy')} Name: {name} Value: {valueY}"; //{ valueY.formatNumber('#.00') } ";

        bullet2.adapter.add("fill", function (fill, target) {
            if (target.dataItem.valueY < 0.5) {
                return am4core.color("#e74c3c");
            }
            return fill;
        })
        var range2 = valueAxis.createSeriesRange(series2);
        range2.value = 0.5;
        range2.endValue = -10000;
        range2.contents.stroke = am4core.color("#e74c3c");
        range2.contents.fill = range.contents.stroke;

        chart.legend = new am4charts.Legend();
        chart.legend.markers.template.disabled = true;
        chart.legend.labels.template.text = "Series: [bold {color}]{name}[/]";

        chart.cursor = new am4charts.XYCursor();
        chart.cursor.xAxis = dateAxis;

        chart.scrollbarX = new am4charts.XYChartScrollbar();
        chart.scrollbarX.series.push(series);
        // hide line series chart on the container zoom
        //chart.scrollbarX.scrollbarChart.seriesContainer.hide();

        chart.logo.disabled = true;
    }); // end am4core.ready()
}

// function draw chart when click view button
async function drawChartWithTime(deviceName, start, end) {
    am4core.ready(async function() {

        if (chart) {
            chart.dispose();
        }

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

        // Themes begin
        am4core.useTheme(am4themes_spiritedaway);
        am4core.useTheme(am4themes_animated);
        // Themes end

        chart = am4core.create("chart", am4charts.XYChart);
        chart.paddingRight = 20;

        chart.data = chartData;

        var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
        dateAxis.renderer.grid.template.location = 0;
        dateAxis.minZoomCount = 5;
        // format dateAxis
        dateAxis.dateFormats.setKey("second", "dd/MM/yyyy HH:mm:ss");
        dateAxis.dateFormats.setKey("minute", "dd/MM/yyyy HH:mm:ss");
        dateAxis.dateFormats.setKey("hour", "dd/MM/yyyy HH:mm:ss");
        dateAxis.dateFormats.setKey("day", "dd/MM/yyyy");
        dateAxis.dateFormats.setKey("month", "MM/yyyy");
        dateAxis.dateFormats.setKey("year", "MM/yyyy");


        // this makes the data to be grouped
        //dateAxis.groupData = true;
        //dateAxis.groupCount = 500;

        var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

        var series = chart.series.push(new am4charts.LineSeries());
        series.dataFields.dateX = "TimeStamp";
        series.dataFields.valueY = 'P2';
        series.legendSettings.labelText = "P2: [bold {color}]{name}[/]";
        series.legendSettings.valueText = "{valueY.close}";
        series.legendSettings.itemValueText = "[bold]{valueY}[/bold]";
        series.stroke = am4core.color("#74b9ff")

        var series2 = chart.series.push(new am4charts.LineSeries());
        series2.dataFields.dateX = "TimeStamp";
        series2.dataFields.valueY = 'P2set';
        series2.legendSettings.labelText = "P2set: [bold {color}]{name}[/]";
        series2.legendSettings.valueText = "{valueY.close}";
        series2.legendSettings.itemValueText = "[bold]{valueY}[/bold]";
        series2.stroke = am4core.color("#0984e3")

        //series.tooltipText = "{dateX} {valueY}";
        //series.tooltip.pointerOrientation = "vertical";
        //series.tooltip.background.fillOpacity = 0.5;

        var bullet = series.bullets.push(new am4charts.Bullet());
        bullet.tooltipText = "{dateX.formatDate('dd/MM/yyyy')} Value: {valueY}"; //{ valueY.formatNumber('#.00') } ";

        bullet.adapter.add("fill", function(fill, target) {
            if (target.dataItem.valueY < 0.5) {
                return am4core.color("#e74c3c");
            }
            return fill;
        })
        var range = valueAxis.createSeriesRange(series);
        range.value = 0.5;
        range.endValue = -10000;
        range.contents.stroke = am4core.color("#e74c3c");
        range.contents.fill = range.contents.stroke;

        var bullet2 = series2.bullets.push(new am4charts.Bullet());
        bullet2.tooltipText = "{dateX.formatDate('dd/MM/yyyy')} Value: {valueY}"; //{ valueY.formatNumber('#.00') } ";

        bullet2.adapter.add("fill", function(fill, target) {
            if (target.dataItem.valueY < 0.5) {
                return am4core.color("#e74c3c");
            }
            return fill;
        })
        var range2 = valueAxis.createSeriesRange(series2);
        range2.value = 0.5;
        range2.endValue = -10000;
        range2.contents.stroke = am4core.color("#e74c3c");
        range2.contents.fill = range.contents.stroke;

        chart.legend = new am4charts.Legend();
        chart.legend.markers.template.disabled = true;
        chart.legend.labels.template.text = "Series: [bold {color}]{name}[/]";

        chart.cursor = new am4charts.XYCursor();
        chart.cursor.xAxis = dateAxis;

        chart.scrollbarX = new am4charts.XYChartScrollbar();
        chart.scrollbarX.series.push(series);
        // hide line series chart on the container zoom
        //chart.scrollbarX.scrollbarChart.seriesContainer.hide();

        chart.logo.disabled = true;

    }); // end am4core.ready()
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
}