<%@ Page Title="" Language="C#" MasterPageFile="~/_site.master" AutoEventWireup="true" CodeFile="_about.aspx.cs" Inherits="_about" %>

<%@ Register Assembly="FlashControl" Namespace="Bewise.Web.UI.WebControls" TagPrefix="Bewise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Giới thiệu
    </h2>
    <p>
        The utility data service webpage is designed to capture, manage and retrieve data in an accurate and timely manner, to meet the needs of water supply companies in Vietnam.
    </p>

    <p>
        The data for water pressure, flow and quality are recorded by the data loggers distributed in the network. The data loggers send the recorded data to centres through a mobile phone network. The number of measurement points for each customer is unlimited. An overview of the system configuration is illustrated in the diagram below:
    </p>

    <div style="text-align:center">
    <Bewise:FlashControl ID="FlashControl1" runat="server" Height="500px" 
    Loop="True" MovieUrl="~/_imgs/System.swf" Width="930px" />
    </div>
    <p>
        Customers can access the system to view their data using a username and password. Each customer can subscribe to more than one username. In the system, the user can view the data points as a table of values, graphs or directly on the maps. The data can be exported to Excel spreadsheets for each individual measurement points or for all measurement points. Customers can also download the original database file to review and analyse.
    </p>

    <p>
        For further information, contact us on the address below.
    </p>
</asp:Content>

