<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BlinkMNF.aspx.cs" Inherits="Supervisor_Logger_BlinkMNF" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <div>
        <table>
            <tr>
                <td>Tổng số Logger:</td>
                <td><telerik:RadTextBox ID="numLogger" runat="server" ReadOnly="true"></telerik:RadTextBox></td>
            </tr>
            <tr>
                <td>Số Logger bị sự cố:</td>
                <td><telerik:RadTextBox ID="numLoggerErr" runat="server" ReadOnly="true"></telerik:RadTextBox></td>
            </tr>
            <tr>
                <td>Số Logger Zero:</td>
                <td><telerik:RadTextBox ID="numLoggerZero" runat="server" ReadOnly="true"></telerik:RadTextBox></td>
            </tr>
            <tr>
                <td>MNF cao hơn hôm qua:</td>
                <td><telerik:RadTextBox ID="numMNFhigh" runat="server" ReadOnly="true"></telerik:RadTextBox></td>
            </tr>
              <tr>
                <td>MNF cao hơn Baseline:
                  </td>
                <td><telerik:RadTextBox ID="numMNFlow" runat="server" ReadOnly="true"></telerik:RadTextBox></td>
            </tr>
        </table>
    <asp:Timer ID="Timer1" runat="server" Interval="60000" OnTick="Timer1_Tick">
                    </asp:Timer>
    
        
    </div>
    </form>
</body>
</html>
