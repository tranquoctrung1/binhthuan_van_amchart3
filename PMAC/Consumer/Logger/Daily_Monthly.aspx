<%@ Page Title="" Language="C#" MasterPageFile="~/Consumer/MasterPage.master" AutoEventWireup="true" CodeFile="Daily_Monthly.aspx.cs" Inherits="Consumer_Logger_Daily_Monthy" %>

<%@ Register Src="~/Controls/ucDailyReportConsumer.ascx" TagPrefix="uc1" TagName="ucDailyReportConsumer" %>
<%@ Register Src="~/Controls/ucMonthlyReportConsumer.ascx" TagPrefix="uc1" TagName="ucMonthlyReportConsumer" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        <asp:Label ID="lbTitle" runat="server" Text="Dữ liệu logger"></asp:Label>
    </h2>
    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" SelectedIndex="0">
        <Tabs>
            <telerik:RadTab runat="server" Text="Dữ liệu ngày">
            </telerik:RadTab>
            <telerik:RadTab runat="server" Text="Dữ liệu tháng">
            </telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="RadMultiPage1" runat="server">
        <telerik:RadPageView ID="RadPageView1" runat="server" Selected="true">
            <br />
            <uc1:ucDailyReportConsumer runat="server" id="ucDailyReportConsumer" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="RadPageView2" runat="server">
            <br />
            <uc1:ucMonthlyReportConsumer runat="server" id="ucMonthlyReportConsumer" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>

