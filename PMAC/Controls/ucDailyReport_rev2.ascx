<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucDailyReport_rev2.ascx.cs" Inherits="Controls_ucDailyReport_rev2" %>

<div class="row">
    <div class="col-sm-3">
        <div class="row">
            <telerik:RadDropDownList RenderMode="Lightweight" ID="DropDownSite" runat="server" DropDownHeight="200px" Width="200px"
                DropDownWidth="200px" SelectionMode="Single" DefaultMessage="Chọn điểm đo" AllowReorder="True"
                AutoPostBackOnReorder="True" DataSourceID="SitesDataSource" DataTextField="SiteAliasName" DataValueField="LoggerId">
            </telerik:RadDropDownList>
            <asp:SqlDataSource ID="SitesDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:db %>"
                SelectCommand="SELECT [SiteAliasName], [SiteId], [LoggerId] FROM [t_Sites]"></asp:SqlDataSource>
        </div>
        <div class="row Padding">
            <telerik:RadDropDownList RenderMode="Lightweight" ID="DropDownChannel" runat="server" DropDownHeight="100px" Width="200px"
                DropDownWidth="200px" SelectionMode="Single" DefaultMessage="Chọn kênh" AllowReorder="True"
                AutoPostBackOnReorder="True" DataSourceID="ChannelDataSource" DataTextField="ChannelName" DataValueField="LoggerId">
            </telerik:RadDropDownList>
            <asp:SqlDataSource ID="ChannelDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:db %>"
                SelectCommand="SELECT [ChannelName], [ChannelId], [LoggerId] FROM [t_Channel_Configurations] WHERE LoggerId = '0142'">
            </asp:SqlDataSource>
        </div>
    </div>
    <div class="col-sm-6">
        <div class="row">
            <div class="col-sm-4">
                <asp:Label ID="lbFrom" runat="server" Text="Từ ngày"></asp:Label>:
            </div>
            <div class="col-sm-6">
                <telerik:RadDatePicker ID="dtmStart" runat="server" Culture="en-GB">
                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

                    <DatePopupButton ImageUrl="" HoverImageUrl="" ForeColor="White" BackColor="White"></DatePopupButton>
                </telerik:RadDatePicker>
            </div>
        </div>
        <div class="row Padding">
            <div class="col-sm-4">
                <asp:Label ID="lbTo" runat="server" Text="Đến ngày"></asp:Label>:
            </div>
            <div class="col-sm-4">
                <telerik:RadDatePicker ID="dtmEnd" runat="server" Culture="en-GB">
                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

                    <DatePopupButton ImageUrl="" HoverImageUrl="" ForeColor="White" BackColor="White"></DatePopupButton>
                </telerik:RadDatePicker>
            </div>
        </div>
    </div>
    <div class="row Padding">
        <div class="col-sm-6">
            <input id="btnUpdateChart" type="button" value="Update" onclick="btnUpdateChart_Clicked(); return false;" />
        </div>
        <div class="col-sm-6">
            <input id="btnClearChart" type="button" value="Clear" onclick="btnClearChart_Clicked(); return false;" />
        </div>
    </div>
</div>

<div id="myChart"></div>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
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
                //SERIAL CHART
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
                document.getElementById("myChart").innerHTML = Math.round(total);
                // });
            });
        };

        function btnUpdateChart_Clicked(sender, args) {
            var cDtStart = $find("<%=dtmStart.ClientID %>");
            var cDtEnd = $find("<%=dtmEnd.ClientID %>");
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
    </script>
</telerik:RadCodeBlock>
