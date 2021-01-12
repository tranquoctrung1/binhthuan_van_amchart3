<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestGridClientBind.aspx.cs" Inherits="TestGridClientBind" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="js/jquery-1.7.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                function updateGrid() {
                    var url = 'https://viwater.pi-solution.vn/VivaServices/Service1.svc/GetAlarms';
                    $.getJSON(url, function (d) {
                        var tableView = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
                        tableView.set_dataSource(d.GetAlarmsResult);
                        tableView.dataBind();
                    });
                    
                }
            </script>
        </telerik:RadCodeBlock>
        <telerik:RadGrid runat="server" ID="RadGrid1" AutoGenerateColumns="false" AllowPaging="true" AllowSorting="true" PageSize="2"> 
          <MasterTableView >
              <Columns>
                <telerik:GridBoundColumn DataField="AlarmTme" FilterControlAltText="Filter AlarmTme column" HeaderText="AlarmTme" SortExpression="AlarmTme" UniqueName="AlarmTme">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="EntryTme" FilterControlAltText="Filter EntryTme column" HeaderText="EntryTme" SortExpression="EntryTme" UniqueName="EntryTme">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" SortExpression="Id" UniqueName="Id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SiteName" FilterControlAltText="Filter SiteName column" HeaderText="SiteName" SortExpression="SiteName" UniqueName="SiteName">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Descript" FilterControlAltText="Filter Descript column" HeaderText="Descript" SortExpression="Descript" UniqueName="Descript">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Priority" FilterControlAltText="Filter Priority column" HeaderText="Priority" SortExpression="Priority" UniqueName="Priority">
                </telerik:GridBoundColumn>
            </Columns>
          </MasterTableView>
          <ClientSettings>
            <ClientEvents OnCommand="function(){}" />
          </ClientSettings>
        </telerik:RadGrid>
        <input id="Button1" type="button" onclick="updateGrid()" value="button" />
    </div>
    </form>
</body>
</html>
