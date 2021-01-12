let isFirstLoad = false;
let showPopupDataViewer = document.getElementById('showPopupDataViewer');
var chart2;
var url;
var table;
var listChannel = ["Acquy", "Humidity", "P1", "P2", "P2Set", "Solar", "Temp"];
var hostname = window.location.origin;
if (hostname.indexOf("localhost") < 0)
    hostname = hostname + "/AdamServices/";
else
    hostname = "http://localhost:61403";

var urlGetMonitoringCardInfos = hostname + '/api/vansite/?valveId=';
var urlGetMonitoringChannelDataBySite = hostname + '/api/getdatachartviewer/?valveId=';

var dataForTable = [];
var isLoadDataWithTime = false;
var firstDataChart = [];
var dataUpdateChart = [];

showPopupDataViewer.addEventListener('click', function () {
    if (isFirstLoad == false) {
        var site = "V003";
        var start = GetUnixStartDate();
        var end = GetUnixEndDate();
        CardsLoad(site, start, end);

        AllowChangeCheckBox();
        drawChartDataViewer(site, start, end);
        $('#btnExportXls').off('click').on('click', function () {
            exportToXLS(site, table, "Export_Du_Lieu_" + site);
        })

        let timerIDLoadCard = setInterval(function () {

            if (isLoadDataWithTime == true) {
                clearInterval(timerIDLoadCard);
            }
            else {
                let start1 = GetUnixStartDate();
                let end1 = GetUnixEndDate();
                CardsLoad(site, start1, end1);
            }
        }, 5000)


        // set interval for update chart data and update table 
        let timerForUpdate = setInterval(function () {


            if (isLoadDataWithTime == true) {
                clearInterval(timerForUpdate);
            }
            else {
                updateChart(site);
                updateTable();
            }
        }, (60000 * 30))

        isFirstLoad = true;
    }
})

//Cards
function GetUnixStartDate() {
    var sd = document.getElementById("ctl00_ContentPlaceHolder1_dtmStart_dateInput_ClientState");
    let value = JSON.parse(sd.value);
    let date = value.valueAsString;

    let selected_sd;
    if (date != "") {
        selected_sd = createDate(date);
        if (selected_sd == null || selected_sd == 'undefined') {
            selected_sd = new Date();
        }
    } else {
        selected_sd = new Date();
        selected_sd.setHours(selected_sd.getHours() - 12)
    }

    return toUnixSeconds(selected_sd);
}

function createDate(date) {
    let re = date.split('-');
    let year = re[0];
    let month = re[1];
    let day = re[2];
    let hour = re[3];
    let minute = re[4];
    let second = re[5];

    return new Date(year, month -1, day, hour, minute, second);
}

function GetUnixEndDate() {
    var ed = document.getElementById("ctl00_ContentPlaceHolder1_dtmEnd_dateInput_ClientState");
    let value = JSON.parse(ed.value);
    let date = value.valueAsString;

    let selected_ed;
    if (date != "") {
        selected_ed = createDate(date);
        if (selected_ed == null || selected_ed == 'undefined') {
            selected_ed = new Date();
        }
    } else {
        selected_ed = new Date();
    }

    return toUnixSeconds(selected_ed);
}


function CardsLoad(siteID, start, end) {
    //var a = fromOADate(start);
    //var b = fromOADate(end);
    var url = urlGetMonitoringCardInfos + siteID + '&start=' + start + '&end=' + end;
    var html = '';

    axios.get(url).then(function (res) {
        console.log(res.data)
        for (let c of res.data) {
            if (CheckIsDisplay(c.ChannelId) > - 1) {
                html +=
                    '<div class="col-xl-3 col-md-6 mb-4" id="card-' + c.ChannelId + '">' +
                    '<div class="card border-left-primary shadow h-100" style="border-left: 5px solid #74b9ff">' +
                    '<div class="card-body">' +
                    '<div class="row no-gutters align-items-center">' +
                    '<div class="col-7 mr-2">' +
                    '<div class="h5 font-weight-bold text-primary mb-1">' + c.ChannelId + '</div>' +
                    '<div class="h6 font-weight-bold text-success mb-1">' + c.InstantValue + '</div>' +
                    '<div class="text-xs">' + parsedDateFormatted(c.InstantTime) + '</div>' +
                    '</div>' +
                    '<div class="col-4">' +
                    '<div class="row">' +
                    '<div class="col-12 text-xs text-primary text-center " style="font-weight: bold">MAX</div>' +
                    '<div class="col-12 text-center"  style="font-weight: bold">' + c.MaxValue + '</div>' +
                    '<div class="col-12 text-xs text-primary text-center"  style="font-weight: bold">MIN</div>' +
                    '<div class="col-12 text-center"  style="font-weight: bold">' + c.MinValue + '</div>' +
                    '</div></div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
            }
            else {
                html +=
                    '<div class="col-xl-3 col-md-6 mb-4 d-none" id="card-' + c.ChannelId + '">' +
                    '<div class="card border-left-primary shadow h-100" style="border-left: 5px solid #74b9ff">' +
                    '<div class="card-body">' +
                    '<div class="row no-gutters align-items-center">' +
                    '<div class="col-7 mr-2">' +
                    '<div class="h5 font-weight-bold text-primary mb-1">' + c.ChannelId + ' </div>' +
                    '<div class="h6 font-weight-bold text-success mb-1">' + c.InstantValue + '</div>' +
                    '<div class="text-xs">' + parsedDateFormatted(c.InstantTime) + '</div>' +
                    '</div>' +
                    '<div class="col-4">' +
                    '<div class="row">' +
                    '<div class="col-12 text-xs text-primary text-center " style="font-weight: bold">MAX</div>' +
                    '<div class="col-12 text-center"  style="font-weight: bold">' + c.MaxValue + '</div>' +
                    '<div class="col-12 text-xs text-primary text-center"  style="font-weight: bold">MIN</div>' +
                    '<div class="col-12 text-center"  style="font-weight: bold">' + c.MinValue + '</div>' +
                    '</div></div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
            }

        }
        document.getElementById('channel_cards').innerHTML = html;
    })
        .catch(err => console.log(err));

}
////Cards

function CheckIsDisplay(channelid) {
    return listChannel.indexOf(channelid);
}


//Charts
function drawChartDataViewer(siteId, start, end) {
    let channels = []

    am4core.ready(function () {
        let start = GetUnixStartDate();
        let end = GetUnixEndDate();
        var url = urlGetMonitoringChannelDataBySite + siteId + "&start=" + start + "&end=" + end;

        axios.get(url).then(function (res) {
            let tempData = res.data;
            if (tempData.length != 0) {
                let max = tempData[0].length;
                let index = 0;
                for (let i = 0; i < tempData.length; i++) {
                    if (max < tempData[i]) {
                        max = tempData[i].length;
                        index = i;
                    }
                    if (tempData[i][0] != undefined) {
                        channels.push(tempData[i][0].ChannelID);
                    }
                }

                let dataForChart = [];
                for (let i = 0; i < max; i++) {
                    let obj = {};
                    obj.TimeStamp = ConverDate(tempData[index][i].TimeStamp);
                    for (let j = 0; j < tempData.length; j++) {
                        if (tempData[j].length != 0) {
                            try {
                                if (tempData[j][i].Value != null && tempData[j][i].Value != undefined) {
                                    obj[`${tempData[j][i].ChannelID}`] = tempData[j][i].Value;
                                }
                            }
                            catch (err) {
                                obj[`${tempData[j][i].ChannelID}`] = 0;
                            }
                        }
                    }
                    dataForChart.push(obj);

                }

                dataForChart.sort(function (a, b) { return a.TimeStamp.getTime() - b.TimeStamp.getTime() });
                // Themes begin
                am4core.useTheme(am4themes_animated);
                // Themes end

                // Create chart instance
                chart2 = am4core.create("chart_canvas", am4charts.XYChart);

                let tempDataForCreateTable = [...dataForChart];

                firstDataChart = [...dataForChart];

                dataUpdateChart = [...dataForChart];

                // Add data
                chart2.data = dataForChart;

                // Create axes
                var dateAxis = chart2.xAxes.push(new am4charts.DateAxis());
                dateAxis.renderer.grid.template.location = 0;
                dateAxis.renderer.labels.template.fill = am4core.color("#e59165");

                var valueAxis = chart2.yAxes.push(new am4charts.ValueAxis());

                let color = ["#55efc4", "#81ecec", "#74b9ff", "#00b894", "#00cec9", "#0984e3", "#fab1a0", "#fd79a8", "#fdcb6e"]
                let iColor = 0;
                // Create series
                // Create series
                for (let channel of channels) {

                    var series = chart2.series.push(new am4charts.LineSeries());
                    series.dataFields.dateX = "TimeStamp";
                    series.dataFields.valueY = `${channel}`;
                    series.name = `${channel}`;
                    series.id = `${channel}`;
                    series.legendSettings.labelText = "{name}";
                    series.legendSettings.valueText = "{valueY.close}";
                    series.legendSettings.itemValueText = "[bold]{valueY}[/bold]";
                    series.stroke = am4core.color(color[iColor])
                    iColor++;

                    var bullet = series.bullets.push(new am4charts.Bullet());
                    bullet.tooltipText = "{dateX.formatDate('dd/MM/yyyy')} Name: {name} Value: {valueY}";

                    // Add scrollbar
                    chart2.scrollbarX = new am4charts.XYChartScrollbar();
                    chart2.scrollbarX.series.push(series);
                }

                chart2.legend = new am4charts.Legend();
                chart2.legend.markers.template.disabled = true;
                chart2.legend.labels.template.text = "[bold {color}]{name}[/]";

                // Add cursor
                chart2.cursor = new am4charts.XYCursor();
                chart2.cursor.xAxis = dateAxis;

                if (chart2 != null && chart2 != undefined) {
                    for (let channel of channels) {
                        if (listChannel.indexOf(channel) == -1) {
                            let series = chart2.map.getKey(channel);
                            series.hide();
                        }
                    }
                }

                chart2.logo.disabled = true;
                updateTable(listChannel.length, tempDataForCreateTable);
            }
        })
    })
};


function zoomChart() {
    // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
    //chart.zoomToIndexes(chartData.length - chartData.length, chartData.length - 1);
}
////Charts

//DataTable
function CreateDataTable(channelLength, chartData) {
    var header = "";
    var body = "";

    var descChartData = chartData.sort(function (a, b) {
        return new Date(b.TimeStamp) - new Date(a.TimeStamp)
    });

    if (descChartData.length > 0) {
        //Show Export Button
        $('#btnExportXls').show();
    }
    else $('#btnExportXls').hide();

    for (let i = 0; i < descChartData.length; i++) {
        if (i == 0) {
            for (let pro of Object.getOwnPropertyNames(descChartData[0])) {
                header += `<th>${pro}</th>`;
            }
        }
        else {
            body += `<tr>`;
            for (let pro in descChartData[i]) {
                if (pro == "TimeStamp") {
                    body += `<td>${dateToString(descChartData[i][pro])}</td>`
                }
                else {
                    body += `<td>${descChartData[i][pro]}</td>`;
                }
            }
            body += `</tr>`;
        }
    }
    table = '<table class="table table-bordered dataTable no-footer" id="dataTable" cellspacing="0" style="width: 100%;overflow-y:auto" role="grid" aria-describedby="dataTable_info">' +
        '<thead>' + header +
        '</thead>' +
        '<tbody>' + body +
        '</tbody>' +
        '</table > ';
    $('#data_table').html(table);
}
////DataTable

//Support
function toUnixSeconds(datetime) {
    return Math.floor(datetime.getTime() / 1000);
}

function parsedDateFormatted(date) {
    //var date = new Date(parseInt(strDate.substr(6)));
    if (date != null && date != undefined) {
        let stringSplit = date.toString().split("-");
        let year = parseInt(stringSplit[0]);
        let month = parseInt(stringSplit[1]) < 10 ? `0${parseInt(stringSplit[1])}` : parseInt(stringSplit[1]);
        let stringSplit2 = stringSplit[2].split("T");
        let day = parseInt(stringSplit2[0]) < 10 ? `0${parseInt(stringSplit2[0])}` : parseInt(stringSplit2[0]);
        let stringSplit3 = stringSplit2[1].split(":");
        let hours = parseInt(stringSplit3[0]) < 10 ? `0${parseInt(stringSplit3[0])}` : parseInt(stringSplit3[0]);
        let minutes = parseInt(stringSplit3[1]) < 10 ? `0${parseInt(stringSplit3[1])}` : parseInt(stringSplit3[1]);
        let seconds = parseInt(stringSplit3[2]) < 10 ? `0${parseInt(stringSplit3[2])}` : parseInt(stringSplit3[2]);

        return day + '/' + month + '/' + year + ' ' + hours + ':' + minutes + ':' + seconds;
    }
    return "";
}

function dateToString(date) {
    var dd = String(date.getDate()).padStart(2, '0');
    var MM = String(date.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = date.getFullYear();
    var hh = String(date.getHours()).padStart(2, '0');
    var mm = String(date.getMinutes()).padStart(2, '0');
    var ss = String(date.getSeconds()).padStart(2, '0');

    return dd + '/' + MM + '/' + yyyy + ' ' + hh + ':' + mm + ':' + ss;
}

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

function btnView_OnClientClick() {
    var cboSite = "V003";
    if (cboSite != "") {
        var start = GetUnixStartDate();
        var end = GetUnixEndDate();
        //Cards
        CardsLoad(cboSite, start, end);
        //Chart
        drawChartDataViewer(cboSite, start, end);
        //Event Export Button
        $('#btnExportXls').off('click').on('click', function () {
            exportToXLS(cboSite, table, "Export_Du_Lieu_" + cboSite);
        })

        isLoadDataWithTime = true;
    }
    else {
        alert('Chưa chọn site');
    }
}

function btnChannelViewConfig_Click() {
    var cboSite = $find('<%= cboMonitoringSites.ClientID %>');
    if (cboSite.get_value()) {
        var win = $find('<%= winChangeChannelView.ClientID %>');
        win.setUrl('ChannelViewer.aspx?ADAM_ID=' + cboSite.get_value());
        win.show();
    }
    else {
        alert('Chưa chọn site');
    }
}

function winChangeChannelView_OnClientClose(sender, args) {
    setTimeout(btnView_OnClientClick, 500);

}

function exportToXLS(title, table, fileName) {
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

//function LoadListChannel(siteid) {
//    let url = urlGetListChannel + siteid;

//    let bodyModal = document.getElementById('bodyModal');

//    bodyModal.innerHTML = "";
//    axios.get(url).then(function (res) {

//        let content = "";

//        for (let item of res.data) {
//            content += `<div class="custom-control custom-switch">
//                                      <input type="checkbox" class="custom-control-input" id="${item}" data-channel="${item}" checked>
//                                      <label class="custom-control-label" for="${item}">${item}</label>
//                                    </div>`;

//            listChannel.push(item);
//        }
//        bodyModal.innerHTML = content;
//        AllowChangeCheckBox();
//    }).catch(err => console.log(err))
//}

function AllowChangeCheckBox() {
    let checkBoxs = document.getElementsByClassName('custom-control-input');

    for (let checkbox of checkBoxs) {
        checkbox.addEventListener('change', function (e) {
            if (checkbox.checked == true) {
                let cardElement = document.getElementById(`card-${checkbox.dataset.channel}`);
                listChannel.push(checkbox.dataset.channel);
                if (cardElement.classList.contains('d-none')) {
                    cardElement.classList.remove('d-none');
                }
                if (chart2 != null && chart2 != undefined) {
                    let series = chart2.map.getKey(checkbox.dataset.channel);
                    series.show();
                }

                updateTable();

            }
            else {
                let cardElement = document.getElementById(`card-${checkbox.dataset.channel}`);
                if (!cardElement.classList.contains('d-none')) {
                    cardElement.classList.add('d-none');
                }

                if (chart2 != null && chart2 != undefined) {
                    let series = chart2.map.getKey(checkbox.dataset.channel);
                    series.hide();
                }


                let indexOfElement = listChannel.indexOf(checkbox.dataset.channel);
                if (indexOfElement > -1) {
                    listChannel.splice(indexOfElement, 1);
                }

                updateTable();
            }

        })
    }
}



//$(document).ready(function () {
//    var site = "V003";
//    var start = GetUnixStartDate();
//    var end = GetUnixEndDate();
//    CardsLoad(site, start, end);

//    AllowChangeCheckBox();
//    drawChartDataViewer(site, start, end);
//    $('#btnExportXls').off('click').on('click', function () {
//        exportToXLS(site, table, "Export_Du_Lieu_" + site);
//    })

//    let timerIDLoadCard = setInterval(function () {

//        if (isLoadDataWithTime == true) {
//            clearInterval(timerIDLoadCard);

//        }
//        else {
//            let start1 = GetUnixStartDate();
//            let end1 = GetUnixEndDate();
//            CardsLoad(site, start1, end1)
//        }
//    }, 5000)

//    let timerForUpdate = setInterval(function () {


//        if (isLoadDataWithTime == true) {
//            clearInterval(timerForUpdate);
//        }
//        else {
//            updateChart(site);
//            updateTable();
//        }
//    }, 60000)

//})

function GetStatus(InstantStatus) {
    var status = 'error';
    switch (InstantStatus) {
        case '00': status = 'success'; break;
        case '01': status = 'warning'; break;
    }
    return status;
}

function updateChart(siteId) {
    let start = GetUnixStartDate();
    let end = GetUnixEndDate();
    var url = urlGetMonitoringChannelDataBySite + siteId + "&start=" + start + "&end=" + end;
    let channels = [];

    axios.get(url).then(function (res) {
        let tempData = res.data;
        if (tempData.length != 0) {
            let max = tempData[0].length;
            let index = 0;
            for (let i = 0; i < tempData.length; i++) {
                if (max < tempData[i]) {
                    max = tempData[i].length;
                    index = i;
                }
                if (tempData[i][0] != undefined) {
                    channels.push(tempData[i][0].ChannelID);
                }
            }

            let dataForChart = [];
            for (let i = 0; i < max; i++) {
                let obj = {};
                obj.TimeStamp = ConverDate(tempData[index][i].TimeStamp);
                for (let j = 0; j < tempData.length; j++) {
                    if (tempData[j].length != 0) {
                        try {
                            if (tempData[j][i].Value != null && tempData[j][i].Value != undefined) {
                                obj[`${tempData[j][i].ChannelID}`] = tempData[j][i].Value;
                            }
                        }
                        catch (err) {
                            obj[`${tempData[j][i].ChannelID}`] = 0;
                        }
                    }
                }
                dataForChart.push(obj);

            }


            dataForChart.sort(function (a, b) { return a.TimeStamp.getTime() - b.TimeStamp.getTime() });

            dataUpdateChart = [...dataForChart];

            chart2.dataProvider = dataForChart;
            chart2.validateData();

        }
    })
}

function updateTable() {
    if (isLoadDataWithTime == true) {
        dataForTable = [...firstDataChart];
    }
    else {
        dataForTable = [...dataUpdateChart];
    }

    //validate input filter with enable or disable channel
    let temp = [];
    for (let item of dataForTable) {
        let obj = {};
        for (let pro in item) {
            if (pro == "TimeStamp") {
                obj.TimeStamp = item[pro];
            }
            else {
                if (listChannel.indexOf(pro) != -1) {
                    obj[pro] = item[pro];
                }
            }
        }
        temp.push(obj);
    }

    CreateDataTable(temp.length, temp);

}