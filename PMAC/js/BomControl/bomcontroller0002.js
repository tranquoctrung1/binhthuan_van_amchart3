$(document).ready(function () {
    // aos init to perform animation
    AOS.init({
        duration: 1000,
        startEvent: 'DOMContentLoaded',
        disable: true
    });

    // this statement is unnecessary
    /* $('#controllerMode').on('shown.bs.modal', function () {
            $('#showModal').trigger('focus')
        })*/

    // hide event modal 
    $('#modalSuccess').modal('hide');
    $('#modalFail').modal('hide');

    // this variable to get and set value of ValveID of Valve, value of ip and value of port
    let ValveID = "";
    let actionMode = "";

    // variavle to reload chart
    let countToReloadChart = 0;

    // variable to allow update 
    let isAllowUpdate = true;

    // get variable for load data
    let closeFull = document.getElementById('closeFull').parentElement;
    let closing = document.getElementById('closing').parentElement;
    let hold = document.getElementById('hold').parentElement;
    let opening = document.getElementById('opening').parentElement;
    let openFull = document.getElementById('openFull').parentElement;
    let m0Show = document.getElementById('m0Show');
    let p1Show = document.getElementById('p1Show');
    let p2Show = document.getElementById('p2Show');
    let solarShow = document.getElementById('solarShow');
    let tempShow = document.getElementById('tempShow');
    let humidityShow = document.getElementById('humidityShow');
    let acquyShow = document.getElementById('acquyShow');
    let historyTable = document.getElementById('historyTable');
    let remoteman = document.getElementById('remoteman');
    let remoteauto = document.getElementById('remoteauto');
    let remotelocal = document.getElementById('remotelocal');
    let rowErrorNumber = document.getElementById('rowErrorNumber');
    let timeToSendData = document.getElementById('timeToSenData');
    let buttonStatusConnect = document.getElementById('buttonStatusConnect');

    // variables to show a0-a23 
    let psetShow = document.getElementById('psetShow');
    let h0Show = document.getElementById('0hShow');
    let h1Show = document.getElementById('1hShow');
    let h2Show = document.getElementById('2hShow');
    let h3Show = document.getElementById('3hShow');
    let h4Show = document.getElementById('4hShow');
    let h5Show = document.getElementById('5hShow');
    let h6Show = document.getElementById('6hShow');
    let h7Show = document.getElementById('7hShow');
    let h8Show = document.getElementById('8hShow');
    let h9Show = document.getElementById('9hShow');
    let h10Show = document.getElementById('10hShow');
    let h11Show = document.getElementById('11hShow');
    let h12Show = document.getElementById('12hShow');
    let h13Show = document.getElementById('13hShow');
    let h14Show = document.getElementById('14hShow');
    let h15Show = document.getElementById('15hShow');
    let h16Show = document.getElementById('16hShow');
    let h17Show = document.getElementById('17hShow');
    let h18Show = document.getElementById('18hShow');
    let h19Show = document.getElementById('19hShow');
    let h20Show = document.getElementById('20hShow');
    let h21Show = document.getElementById('21hShow');
    let h22Show = document.getElementById('22hShow');
    let h23Show = document.getElementById('23hShow');
    // mode action status
    let action = document.getElementById('action');
    // ss
    let errorNumber = document.getElementById('errorNum');
    // m0
    let m0 = document.getElementById('m0');

    // variables to write
    let h0 = document.getElementById('0h');
    let h1 = document.getElementById('1h');
    let h2 = document.getElementById('2h');
    let h3 = document.getElementById('3h');
    let h4 = document.getElementById('4h');
    let h5 = document.getElementById('5h');
    let h6 = document.getElementById('6h');
    let h7 = document.getElementById('7h');
    let h8 = document.getElementById('8h');
    let h9 = document.getElementById('9h');
    let h10 = document.getElementById('10h');
    let h11 = document.getElementById('11h');
    let h12 = document.getElementById('12h');
    let h13 = document.getElementById('13h');
    let h14 = document.getElementById('14h');
    let h15 = document.getElementById('15h');
    let h16 = document.getElementById('16h');
    let h17 = document.getElementById('17h');
    let h18 = document.getElementById('18h');
    let h19 = document.getElementById('19h');
    let h20 = document.getElementById('20h');
    let h21 = document.getElementById('21h');
    let h22 = document.getElementById('22h');
    let h23 = document.getElementById('23h');

    // variables to get value in valve settings
    let settingData;
    let originErrorNum;
    let originM0;
    let originH0;
    let originH1;
    let originH2;
    let originH3;
    let originH4;
    let originH5;
    let originH6;
    let originH7;
    let originH8;
    let originH9;
    let originH10;
    let originH11;
    let originH12;
    let originH13;
    let originH14;
    let originH15;
    let originH16;
    let originH17;
    let originH18;
    let originH19;
    let originH20;
    let originH21;
    let originH22;
    let originH23;
    //let originSwitchmode;

    // variable to change mode into device and database
    //let switchManAuto = document.getElementById('switchMode');
    // for server
    //let hostname = 'http://112.78.4.162:9999'

    // for iis local

    var hostname = window.location.origin;
    if (hostname.indexOf("localhost") < 0)
        hostname = hostname + "/VanServices";
    else
        hostname = "http://localhost:61403";

    let urlGetStatusValveById = `${hostname}/api/t_valve_status/V002`; // add ValveID 
    //let urlSettingValveById = `${hostname}/api/t_valve_setting/V001`; // add valveID

    let isLoadingChart = false;
    let isUsingChartWithTime = false;

    // load data
    function reload() {
        axios.get(urlGetStatusValveById)
            .then(function (response) {
                // handle success
                const valve = response.data; // data all 

                ValveID = valve.ValveID;

                loadStatusValve(valve.Status);
                loadPAndWTableData(valve);
                loadDataPressWithHourTable(valve);
                loadStatusAction(valve.Mode);
                FillHostoryAlarmTable();
                fillDataTimeSend(valve.TimeStamp);
                setStatusConnect(valve.TimeStamp);
                if (isLoadingChart == false) {
                    drawChart(valve.ValveID.trim());
                    isLoadingChart = true;
                }

                if ((countToReloadChart == 900) && isUsingChartWithTime == false) {
                    let startt = document.getElementById('startDate').value;
                    let endt = document.getElementById('endDate').value;

                    let start = new Date(startt);
                    let end = new Date(endt);
                    end = new Date(end.getFullYear(), end.getMonth(), end.getDate(), end.getHours(), end.getMinutes() + 1, end.getSeconds());

                    document.getElementById('endDate').value = `${end.getFullYear()}-${end.getMonth() + 1 >= 10 ? end.getMonth() + 1 : '0' + (end.getMonth() + 1)}-${end.getDate() >= 10 ? end.getDate() : '0' + end.getDate()}T${end.getHours() >= 10 ? end.getHours() : '0' + end.getHours()}:${end.getMinutes() >= 10 ? end.getMinutes() : '0' + end.getMinutes()}`;
                    let tmp = new Date(end.getFullYear(), end.getMonth(), end.getDate() - 1, end.getHours(), end.getMinutes(), end.getSeconds());
                    document.getElementById('startDate').value = `${tmp.getFullYear()}-${tmp.getMonth() + 1 >= 10 ? tmp.getMonth() + 1 : '0' + (tmp.getMonth() + 1)}-${tmp.getDate() >= 10 ? tmp.getDate() : '0' + tmp.getDate()}T${tmp.getHours() >= 10 ? tmp.getHours() : '0' + tmp.getHours()}:${tmp.getMinutes() >= 10 ? tmp.getMinutes() : '0' + tmp.getMinutes()}`;


                    updateDataChart(valve.ValveID.trim(), start, end)
                    if (countToReloadChart == 900) {
                        countToReloadChart = 0;
                    }
                    else {
                        countToReloadChart++;
                    }

                }
                else {
                    countToReloadChart++;
                }

                loadErrorNumber(valve.SS);
                loadM0Value(valve.M0);
                loadValueToAutoModeTable(valve);
            })
            .catch(function (error) {
                // handle error
                console.log(error);
            })
            .then(function () {
                // always executed
            });


        function loadStatusValve(status) {
            if (status == 0) {
                closeFull.classList.add('active');
                closing.classList.remove('active');
                hold.classList.remove('active');
                opening.classList.remove('active');
                openFull.classList.remove('active');
            }
            else if (status == 1) {
                closeFull.classList.remove('active');
                closing.classList.add('active');
                hold.classList.remove('active');
                opening.classList.remove('active');
                openFull.classList.remove('active');
            }
            else if (status == 2) {
                closeFull.classList.remove('active');
                closing.classList.remove('active');
                hold.classList.add('active');
                opening.classList.remove('active');
                openFull.classList.remove('active');
            }
            else if (status == 3) {
                closeFull.classList.remove('active');
                closing.classList.remove('active');
                hold.classList.remove('active');
                opening.classList.add('active');
                openFull.classList.remove('active');
            }
            else if (status == 4) {
                closeFull.classList.remove('active');
                closing.classList.remove('active');
                hold.classList.remove('active');
                opening.classList.remove('active');
                openFull.classList.add('active');
            }
            else {
                closeFull.classList.remove('active');
                closing.classList.remove('active');
                hold.classList.remove('active');
                opening.classList.remove('active');
                openFull.classList.remove('active');
            }
        }
    }
    //load data mode modal
    /*function realoadMode() {
        axios.get(urlSettingValveById)
            .then(function (response) {
                // handle success
                const valve = response.data; // data all 

                settingData = valve;

                //ValveID = valve.ValveID;

                // load valve settings
                loadErrorNumber(valve.SS);
                loadM0Value(valve.M0);
                loadValueToAutoModeTable(valve);
                //loadValueManAuto(valve.Man_Auto);
            })
            .catch(function (error) {
                // handle error
                console.log(error);
            })
            .then(function () {
                // always executed
            });
    }*/

    // load data into history alarm
    async function FillHostoryAlarmTable() {
        let urlGetTimeExistData = `${hostname}/api/charttime/`;
        let urlGetChartData = `${hostname}/api/datachart/`;

        let url = `${urlGetTimeExistData}${ValveID.trim()}_Alarm`;
        let start;
        let end;

        let datetime = await axios.get(url);

        if (datetime.data[0] != null && datetime.data[0] != undefined) {
            datetime = new Date(datetime.data[0].TimeStamp);
        }
        else {
            datetime = new Date(1970, 1, 1);
        }
        end = new Date(datetime.getFullYear(), datetime.getMonth(), datetime.getDate(), 23, 59, 59);

        document.getElementById('endDateHistory').value = `${end.getFullYear()}-${end.getMonth() + 1 >= 10 ? end.getMonth() + 1 : '0' + (end.getMonth() + 1)}-${end.getDate() >= 10 ? end.getDate() : '0' + end.getDate()}`;
        let tmp = new Date(end.getFullYear(), end.getMonth(), end.getDate() - 3);
        document.getElementById('startDateHistory').value = `${tmp.getFullYear()}-${tmp.getMonth() + 1 >= 10 ? tmp.getMonth() + 1 : '0' + (tmp.getMonth() + 1)}-${tmp.getDate() >= 10 ? tmp.getDate() : '0' + tmp.getDate()}`;

        end = (end.getTime() / 1000).toString();
        start = (end - 259200).toString(); // 3 days

        let urlGetDataForTable = `${urlGetChartData}${ValveID.trim()}_Alarm/${start}/${end}`;

        const data = await axios.get(urlGetDataForTable);

        //let totalItems = data.data.length;
        //let itemsPerPage = 2;

        //let totalPages = Math.ceil(totalItems / itemsPerPage);
        //console.log(totalPages)

        let content = "";

        for (let i = data.data.length - 1; i >= 0; i--) {
            let date = new Date(data.data[i].TimeStamp);
            content += ` <tr><th scope="row">${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()} ${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}</th><td>${Number.parseFloat(data.data[i].Value).toFixed(2).toString()}</td></tr>`;
        }

        historyTable.innerHTML = content;
    }
    // load data into history alarm when click view button
    async function FillHostoryAlarmTableWithTime(deviceName, start, end) {
        let urlGetChartData = `${hostname}/api/datachart/`;

        end = (end.getTime() / 1000).toString();
        start = (start.getTime() / 1000).toString(); // 3 days

        let urlGetDataForTable = `${urlGetChartData}${deviceName}_Alarm/${start}/${end}`;

        const data = await axios.get(urlGetDataForTable);

        let content = "";

        for (let i = data.data.length - 1; i >= 0; i--) {
            let date = new Date(data.data[i].TimeStamp);
            content += ` <tr><th scope="row">${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()} ${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}</th><td>${Number.parseFloat(data.data[i].Value).toFixed(2).toString()}</td></tr>`;
        }

        historyTable.innerHTML = content;
    }
    // load data into press and voltage table 
    function loadPAndWTableData(valve) {
        m0Show.innerHTML = Number.parseFloat(valve.M0).toFixed(1).toString();
        p1Show.innerHTML = Number.parseFloat(valve.P1).toFixed(2).toString();
        p2Show.innerHTML = Number.parseFloat(valve.P2).toFixed(2).toString();
        solarShow.innerHTML = Number.parseFloat(valve.Solar).toFixed(2).toString();
        acquyShow.innerHTML = Number.parseFloat(valve.Acquy).toFixed(2).toString();
        tempShow.innerHTML = Number.parseFloat(valve.Temp).toFixed(2).toString();
        humidityShow.innerHTML = Number.parseFloat(valve.Humidity).toFixed(2).toString();
    }
    // load data into press and press by hours table 
    function loadDataPressWithHourTable(valve) {
        psetShow.innerHTML = Number.parseFloat(valve.P2set).toFixed(2).toString();
        h0Show.innerHTML = Number.parseFloat(valve.A0).toFixed(1).toString();
        h1Show.innerHTML = Number.parseFloat(valve.A1).toFixed(1).toString();
        h2Show.innerHTML = Number.parseFloat(valve.A2).toFixed(1).toString();
        h3Show.innerHTML = Number.parseFloat(valve.A3).toFixed(1).toString();
        h4Show.innerHTML = Number.parseFloat(valve.A4).toFixed(1).toString();
        h5Show.innerHTML = Number.parseFloat(valve.A5).toFixed(1).toString();
        h6Show.innerHTML = Number.parseFloat(valve.A6).toFixed(1).toString();
        h7Show.innerHTML = Number.parseFloat(valve.A7).toFixed(1).toString();
        h8Show.innerHTML = Number.parseFloat(valve.A8).toFixed(1).toString();
        h9Show.innerHTML = Number.parseFloat(valve.A9).toFixed(1).toString();
        h10Show.innerHTML = Number.parseFloat(valve.A10).toFixed(1).toString();
        h11Show.innerHTML = Number.parseFloat(valve.A11).toFixed(1).toString();
        h12Show.innerHTML = Number.parseFloat(valve.A12).toFixed(1).toString();
        h13Show.innerHTML = Number.parseFloat(valve.A13).toFixed(1).toString();
        h14Show.innerHTML = Number.parseFloat(valve.A14).toFixed(1).toString();
        h15Show.innerHTML = Number.parseFloat(valve.A15).toFixed(1).toString();
        h16Show.innerHTML = Number.parseFloat(valve.A16).toFixed(1).toString();
        h17Show.innerHTML = Number.parseFloat(valve.A17).toFixed(1).toString();
        h18Show.innerHTML = Number.parseFloat(valve.A18).toFixed(1).toString();
        h19Show.innerHTML = Number.parseFloat(valve.A19).toFixed(1).toString();
        h20Show.innerHTML = Number.parseFloat(valve.A20).toFixed(1).toString();
        h21Show.innerHTML = Number.parseFloat(valve.A21).toFixed(1).toString();
        h22Show.innerHTML = Number.parseFloat(valve.A22).toFixed(1).toString();
        h23Show.innerHTML = Number.parseFloat(valve.A23).toFixed(1).toString();

    }
    // load mode action status
    function loadStatusAction(mode) {

        if (mode == 1) {
            action.innerHTML = "Man";
            actionMode = 1;
            remoteauto.checked = false;
            remotelocal.checked = false;
            remoteman.checked = true;
            remoteman.disabled = false;
            remoteauto.disabled = false;

            // show table  man mode
            modeAuto.classList.remove('show');
            modeAuto.classList.add('hide');

            modeMan.classList.remove('hide'); 
            modeMan.classList.add('show');

            rowErrorNumber.classList.remove('hide');
            rowErrorNumber.classList.add('show');
        }
        else if (mode == 2) {
            action.innerHTML = "Auto";
            actionMode = 2;
            remoteman.checked = false;
            remotelocal.checked = false;
            remoteauto.checked = true;
            remoteman.disabled = false;
            remoteauto.disabled = false;

            // show table auto mode
            modeMan.classList.remove('show');
            modeMan.classList.add('hide');

            modeAuto.classList.remove('hide');
            modeAuto.classList.add('show');

            rowErrorNumber.classList.remove('hide');
            rowErrorNumber.classList.add('show');
        }
        else {
            action.innerHTML = "Local";
            actionMode = 0;
            remoteman.checked = false;
            remoteman.disabled = true;
            remoteauto.checked = false;
            remoteauto.disabled = true;
            remotelocal.checked = true;

            modeAuto.classList.remove('show');
            modeAuto.classList.add('hide');

            modeMan.classList.remove('show');
            modeMan.classList.add('hide');

            rowErrorNumber.classList.remove('show');
            rowErrorNumber.classList.add('hide');



        }
    }
    // load ss value
    function loadErrorNumber(number) {
        if (number != null && number != 0 && number != undefined) {
            errorNumber.value = number;
            originErrorNum = number;
        }
        else {
            errorNumber.value = 0;
            originErrorNum = 0;
        }
    }
    // load m0 value
    function loadM0Value(value) {
        if (value != null && value != 0 && value != undefined) {
            m0.value = value;
            originM0 = value;
        }
        else {
            m0.value = 0;
            originM0 = 0;
        }

    }
    // load value into mode auto modal table
    function loadValueToAutoModeTable(valve) {
        try {
            h0.value = valve.A0.toString();
            originH0 = valve.A0;
        }
        catch
        {
            h0.value = 0;
            originH0 = 0;
        }

        try {
            h1.value = valve.A1.toString();
            originH1 = valve.A1;
        }
        catch
        {
            h1.value = 0;
            originH1 = 0;
        }
        try {
            h2.value = valve.A2.toString();
            originH2 = valve.A2;
        }
        catch
        {
            h2.value = 0;
            originH2 = 0;
        }
        try {
            h3.value = valve.A3.toString();
            originH3 = valve.A3;
        }
        catch
        {
            h3.value = 0;
            originH3 = 0;
        }
        try {
            h4.value = valve.A4.toString();
            originH4 = valve.A4;
        }
        catch
        {
            h4.value = 0;
            originH4 = 0;
        }
        try {
            h5.value = valve.A5.toString();
            originH5 = valve.A5;
        }
        catch
        {
            h5.value = 0;
            originH5 = 0;
        }
        try {
            h6.value = valve.A6.toString();
            originH6 = valve.A6;
        }
        catch
        {
            h6.value = 0;
            originH6 = 0;
        }
        try {
            h7.value = valve.A7.toString();
            originH7 = valve.A7;
        }
        catch
        {
            h7.value = 0;
            originH7 = 0;
        }
        try {
            h8.value = valve.A8.toString();
            originH8 = valve.A8;
        }
        catch
        {
            h8.value = 0;
            originH8 = 0;
        }
        try {
            h9.value = valve.A9.toString();
            originH9 = valve.A9;
        }
        catch
        {
            h9.value = 0;
            originH9 = 0;
        }
        try {
            h10.value = valve.A10.toString();
            originH10 = valve.A10;
        }
        catch
        {
            h10.value = 0;
            originH10 = 0;
        }
        try {
            h11.value = valve.A11.toString();
            originH11 = valve.A11;
        }
        catch
        {
            h11.value = 0;
            originH11 = 0;
        }
        try {
            h12.value = valve.A12.toString();
            originH12 = valve.A12;
        }
        catch
        {
            h12.value = 0;
            originH12 = 0;
        }
        try {
            h13.value = valve.A13.toString();
            originH13 = valve.A13;
        }
        catch
        {
            h13.value = 0;
            originH13 = 0;
        }
        try {
            h14.value = valve.A14.toString();
            originH14 = valve.A14;
        }
        catch
        {
            h14.value = 0;
            originH14 = 0;
        }
        try {
            h15.value = valve.A15.toString();
            originH15 = valve.A15;
        }
        catch
        {
            h15.value = 0;
            originH15 = 0;
        }
        try {
            h16.value = valve.A16.toString();
            originH16 = valve.A16;
        }
        catch
        {
            h16.value = 0;
            originH16 = 0;
        }
        try {
            h17.value = valve.A17.toString();
            originH17 = valve.A17;
        }
        catch
        {
            h17.value = 0;
            originH17 = 0;
        }
        try {
            h18.value = valve.A18.toString();
            originH18 = valve.A18;
        }
        catch
        {
            h18.value = 0;
            originH18 = 0;
        }
        try {
            h19.value = valve.A19.toString();
            originH19 = valve.A19;
        }
        catch
        {
            h19.value = 0;
            originH19 = 0;
        }
        try {
            h20.value = valve.A20.toString();
            originH20 = valve.A20;
        }
        catch
        {
            h20.value = 0;
            originH20 = 0;
        }
        try {
            h21.value = valve.A21.toString();
            originH21 = valve.A21;
        }
        catch
        {
            h21.value = 0;
            originH21 = 0;
        }
        try {
            h22.value = valve.A22.toString();
            originH22 = valve.A22;
        }
        catch
        {
            h22.value = 0;
            originH22 = 0;
        }
        try {
            h23.value = valve.A23.toString();
            originH23 = valve.A23;
        }
        catch
        {
            h23.value = 0;
            originH23 = 0;
        }
    }

    // load value mode auto or man in settings table into database
    /* function loadValueManAuto(value) {
        try {
            switchManAuto.checked = value;
            originSwitchmode = value;
        }
        catch
        {
            switchManAuto.checked = false;
            originSwitchmode = false;
        }
    } */

    // function load data
    reload();
    // function load data
    // realoadMode();


    // catch focus and blur input element

    errorNumber.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    errorNumber.addEventListener('blur', function (e) {
        if (e.target.value != originErrorNum) {
            writeApi(ValveID.trim(), "SS", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "SS", e.target.value);
            originErrorNum = e.target.value;
            isAllowUpdate = true;
        }
    })

    m0.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    m0.addEventListener('blur', function (e) {
        if (e.target.value != originM0) {
            writeApi(ValveID.trim(), "M0", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "M0", e.target.value);
            originM0 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h0.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h0.addEventListener('blur', function (e) {
        if (e.target.value != originH0) {
            writeApi(ValveID.trim(), "A0", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A0", e.target.value);
            originH0 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h1.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h1.addEventListener('blur', function (e) {
        if (e.target.value != originH1) {
            writeApi(ValveID.trim(), "A1", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A1", e.target.value);
            originH1 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h2.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h2.addEventListener('blur', function (e) {
        if (e.target.value != originH2) {
            writeApi(ValveID.trim(), "A2", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A2", e.target.value);
            originH2 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h3.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h3.addEventListener('blur', function (e) {
        if (e.target.value != originH3) {
            writeApi(ValveID.trim(), "A3", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A3", e.target.value);
            originH3 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h4.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h4.addEventListener('blur', function (e) {
        if (e.target.value != originH4) {
            writeApi(ValveID.trim(), "A4", e.target.value);
            // writeApiToDevice(ValveID.trim(), ip, port, "A4", e.target.value);
            originH4 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h5.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h5.addEventListener('blur', function (e) {
        if (e.target.value != originH5) {
            writeApi(ValveID.trim(), "A5", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A5", e.target.value);
            originH5 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h6.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h6.addEventListener('blur', function (e) {
        if (e.target.value != originH6) {
            writeApi(ValveID.trim(), "A6", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A6", e.target.value);
            originH6 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h7.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h7.addEventListener('blur', function (e) {
        if (e.target.value != originH7) {
            writeApi(ValveID.trim(), "A7", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A7", e.target.value);
            originH7 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h8.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h8.addEventListener('blur', function (e) {
        if (e.target.value != originH8) {
            writeApi(ValveID.trim(), "A8", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A8", e.target.value);
            originH8 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h9.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h9.addEventListener('blur', function (e) {
        if (e.target.value != originH9) {
            writeApi(ValveID.trim(), "A9", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A9", e.target.value);
            originH9 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h10.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h10.addEventListener('blur', function (e) {
        if (e.target.value != originH10) {
            writeApi(ValveID.trim(), "A10", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A10", e.target.value);
            originH10 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h11.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h11.addEventListener('blur', function (e) {
        if (e.target.value != originH11) {
            writeApi(ValveID.trim(), "A11", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A11", e.target.value);
            originH11 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h12.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h12.addEventListener('blur', function (e) {
        if (e.target.value != originH12) {
            writeApi(ValveID.trim(), "A12", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A12", e.target.value);
            originH12 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h13.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h13.addEventListener('blur', function (e) {
        if (e.target.value != originH13) {
            writeApi(ValveID.trim(), "A13", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A13", e.target.value);
            originH13 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h14.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h14.addEventListener('blur', function (e) {
        if (e.target.value != originH14) {
            writeApi(ValveID.trim(), "A14", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A14", e.target.value);
            originH14 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h15.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h15.addEventListener('blur', function (e) {
        if (e.target.value != originH15) {
            writeApi(ValveID.trim(), "A15", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A15", e.target.value);
            originH15 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h16.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h16.addEventListener('blur', function (e) {
        if (e.target.value != originH16) {
            writeApi(ValveID.trim(), "A16", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A16", e.target.value);
            originH16 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h17.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h17.addEventListener('blur', function (e) {
        if (e.target.value != originH17) {
            writeApi(ValveID.trim(), "A17", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A17", e.target.value);
            originH17 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h18.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h18.addEventListener('blur', function (e) {
        if (e.target.value != originH18) {
            writeApi(ValveID.trim(), "A18", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A18", e.target.value);
            originH18 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h19.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h19.addEventListener('blur', function (e) {
        if (e.target.value != originH19) {
            writeApi(ValveID.trim(), "A19", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A19", e.target.value);
            originH19 = e.target.value;
            isAllowUpdate = true;

        }

    })

    h20.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h20.addEventListener('blur', function (e) {
        if (e.target.value != originH20) {
            writeApi(ValveID.trim(), "A20", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A20", e.target.value);
            originH20 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h21.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h21.addEventListener('blur', function (e) {
        if (e.target.value != originH21) {
            writeApi(ValveID.trim(), "A21", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A21", e.target.value);
            originH21 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h22.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h22.addEventListener('blur', function (e) {
        if (e.target.value != originH22) {
            writeApi(ValveID.trim(), "A22", e.target.value);
            // writeApiToDevice(ValveID.trim(), ip, port, "A22", e.target.value);
            originH22 = e.target.value;
            isAllowUpdate = true;
        }

    })

    h23.addEventListener('focus', function (e) {
        isAllowUpdate = false;
    })

    h23.addEventListener('blur', function (e) {
        if (e.target.value != originH23) {
            writeApi(ValveID.trim(), "A23", e.target.value);
            //writeApiToDevice(ValveID.trim(), ip, port, "A23", e.target.value);
            originH23 = e.target.value;
            isAllowUpdate = true;
        }

    })

    let urlPutData = `${hostname}/api/t_valve_setting`; // add valve id
    // function write api 
    async function writeApi(vavleId, fieldName, value) {

        settingData = {};
        settingData.ValveID = vavleId;
        settingData.ValveTag = fieldName;
        settingData.Value = value;
        settingData.Flag = "true";

        let jsonData = JSON.stringify(settingData);

        let url = `${urlPutData}`;
        let res = await axios.put(url, jsonData,
            {
                headers: {
                    'Content-Type': 'application/json'
                }
            });
        console.log(res.data);
        //if (res.status == 200) {
        //    alertify.success('Cập Nhật Vào CSDL Thành Công!!');
        //}
        //else {
        //    alertify.error('Cập Nhật Vào CSDL Thất Bại!!');

        //}
    }

    //let urlPostData = `${hostname}/api/t_takechangehistory/`;
    //let urlPutDataToDevice = `${hostname}/api/writetakesample/`

    // function write api to device and update database
    /* async function writeApiToDevice(valveId, ip, port, fieldName, value) {
        if (ip || port) {
            // change into device
            let urlPutData = `${urlPutDataToDevice}${ip}/${port}/${fieldName}/${value}`;

            let result = await axios.put(urlPutData);
            let count = 0;

            let check = false;

            do {
                if (check == false) {
                    result = await axios.put(urlPutData);

                    check = result.data;

                    count++;
                }
                else {
                    break;
                }

            } while (count <= 3 && check == false)

            // add a record into history change table in db
            let objectDataHistory = {};
            objectDataHistory.ValveID = valveId;
            objectDataHistory.TimeStamp = new Date(new Date(Date.now()).getTime() + (7 * 60 * 60 * 1000));
            objectDataHistory.Status = true;
            objectDataHistory.UserTake = "Bavitech";


            if (check == false) {
                objectDataHistory.Description = `changing ${fieldName} to device is fail`;
                objectDataHistory.Type = "Fail";
                objectDataHistory.IsNotified = false;
                alertify.error('Cập Nhật Vào Thiết Bị Thất Bại!!');
            }
            else {
                objectDataHistory.Description = `changing ${fieldName} to device is successful`;
                objectDataHistory.Type = "Successful";
                objectDataHistory.IsNotified = true;
                alertify.success('Cập Nhật Vào Thiết Bị Thành Công!!');
            }

            let jsonData = JSON.stringify(objectDataHistory);

            let urlPostHistory = `${urlPostData}`;
            let resHistory = await axios.post(urlPostHistory, jsonData,
                {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });

            if (resHistory.status == 201) {
                //alertify.success('Cập Nhật Vào CSDL Thành Công!!');
            }
            else {
                //alertify.error('Cập Nhật Vào CSDL Thất Bại!!');
            }
        }
        else {
            alertify.error('IP Hoặc Port Không Có Giá Trị !!');
        }
    } */

    // add view chart button click event 
    let btnView = document.getElementById('btnView');
    btnView.addEventListener('click', function () {
        let start = document.getElementById('startDate').value;
        let end = document.getElementById('endDate').value;

        start = new Date(start);
        end = new Date(end);
        end = new Date(end.getFullYear(), end.getMonth(), end.getDate() + 1)

        drawChartWithTime(ValveID.trim(), start, end);
        isUsingChartWithTime = true;
    })
    // add view alarm button click event
    let btnViewHistory = document.getElementById('btnViewHistory');
    btnViewHistory.addEventListener('click', function () {
        let start = document.getElementById('startDateHistory').value;
        let end = document.getElementById('endDateHistory').value;

        start = new Date(start);
        end = new Date(end);
        end = new Date(end.getFullYear(), end.getMonth(), end.getDate() + 1);

        FillHostoryAlarmTableWithTime(ValveID.trim(), start, end);
    })


    //auto update data on main page duration 10 seconds
    setInterval(function () {
        if (isAllowUpdate == true) {
            reload();
            //realoadMode();
        }
    }, 2000)

    // user profile

    let profile = document.getElementsByClassName('profile');
    let profileDropdown = document.getElementsByClassName('profile-dropdown-menu');

    function showProfile() {
        if (profileDropdown[0].classList.contains('show')) {
            profileDropdown[0].classList.remove('show');
        }
        else {
            profileDropdown[0].classList.add('show');
        }
    }

    profile[0].addEventListener('click', showProfile)


    // add event change for swtich mode checkbox 
    //switchManAuto.addEventListener('change', function (e) {

    //    let current = e.target.checked;
    //    if (current) {
    //        // update dom element
    //        //action.innerHTML = "Auto";
    //        // update databases and update device
    //        if (current != originSwitchmode) {
    //            writeApi(ValveID.trim(), "Man_Auto", true);
    //            writeApiToDevice(ValveID.trim(), ip, port, "Man_Auto", true);
    //            originSwitchmode = current;
    //        }
    //    }
    //    else {
    //        // update dom element
    //        //action.innerHTML = "Man";
    //        // update databases and update device
    //        if (current != originSwitchmode) {
    //            writeApi(ValveID.trim(), "Man_Auto", false);
    //            writeApiToDevice(ValveID.trim(), ip, port, "Man_Auto", false);
    //            originSwitchmode = current;
    //        }
    //    }
    //})

    // catch checkbox change event
    var checkboxElement = document.getElementsByClassName('remote');
    var modeMan = document.getElementById('modeMan');
    var modeAuto = document.getElementById('modeAuto');

    for (checkbox of checkboxElement) {
        if (checkbox.checked) {
            if (actionMode == 2) {
                //modeMan.classList.remove('show');
                //modeMan.classList.add('hide');

                //modeAuto.classList.remove('hide');
                //modeAuto.classList.add('show');

                //rowErrorNumber.classList.remove('hide');
                //rowErrorNumber.classList.add('show');
            }
            else if (actionMode == 1) {
                //modeAuto.classList.remove('show');
                //modeAuto.classList.add('hide');

                //modeMan.classList.remove('hide');
                //modeMan.classList.add('show');

                //rowErrorNumber.classList.remove('hide');
                //rowErrorNumber.classList.add('show');

            }
            else {
                //modeMan.classList.remove('show');
                //modeMan.classList.add('hide');

                //modeAuto.classList.remove('show');
                //modeAuto.classList.add('hide');

                //rowErrorNumber.classList.remove('show');
                //rowErrorNumber.classList.add('hide');
            }

        }

        checkbox.addEventListener('change', (e) => {
            isAllowUpdate = false;
            if (confirm("Đồng ý chuyển chế độ điều khiển")) {
                if (e.target.checked) {
                    if (e.target.value == 1) {
                        //modeMan.classList.remove('show');
                        //modeMan.classList.add('hide');

                        //modeAuto.classList.remove('hide');
                        //modeAuto.classList.add('show');

                        //rowErrorNumber.classList.remove('hide');
                        //rowErrorNumber.classList.add('show');
                        // update database and update device to mode auto
                        //writeApi(ValveID.trim(), "Man_Auto", true);
                        //writeApiToDevice(ValveID.trim(), ip, port, "Man_Auto", 1);
                        writeApi(ValveID.trim(), "Man_Auto", "1");
                    }
                    else if (e.target.value == 0) {
                        //modeAuto.classList.remove('show');
                        //modeAuto.classList.add('hide');

                        //modeMan.classList.remove('hide');
                        //modeMan.classList.add('show');

                        //rowErrorNumber.classList.remove('hide');
                        //rowErrorNumber.classList.add('show');
                        // update database and update device to mode man
                        //writeApi(ValveID.trim(), "Man_Auto", true);
                        //writeApiToDevice(ValveID.trim(), ip, port, "Man_Auto", 0);
                        writeApi(ValveID.trim(), "Man_Auto", "0");
                    }
                    else {
                        //modeMan.classList.remove('show');
                        //modeMan.classList.add('hide');
                        //modeAuto.classList.remove('show');
                        //modeAuto.classList.add('hide');
                        //rowErrorNumber.classList.remove('show');
                        //rowErrorNumber.classList.add('hide');
                    }
                }
            }
            isAllowUpdate = true;
        })
    }

    function fillDataTimeSend(date) {
        timeToSendData.innerHTML = parsedDateFormatted(date);
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

    function ConvertDate(date) {
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

    function setStatusConnect(date) {
        if (date != null && date != undefined) {
            // convert to connect
            let temp = ConvertDate(date);
            let now = new Date(Date.now()); 

            if (((now.getTime() / 1000) - (temp.getTime() / 1000)) >= 300) {
                if (buttonStatusConnect.classList.contains("connect")) {
                    buttonStatusConnect.classList.replace("connect", "disconnect");
                }
                buttonStatusConnect.innerHTML = "Disconnected";
            }
            // convert to disconnect
            else {
                if (buttonStatusConnect.classList.contains("disconnect")) {
                    buttonStatusConnect.classList.replace("disconnect", "connect");
                }
                buttonStatusConnect.innerHTML = "Connected";
            }
        }
        else {
            if (buttonStatusConnect.classList.contains("connect")) {
                buttonStatusConnect.classList.replace("connect", "disconnect");
            }
            buttonStatusConnect.innerHTML = "Disconnected";
        }
    }

})
