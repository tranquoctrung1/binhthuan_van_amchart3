<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="Daily_Monthly.aspx.cs" Inherits="Supervisor_Logger_Daily_Monthly" %>

<%@ Register Src="~/Controls/ucDailyReport.ascx" TagPrefix="uc1" TagName="ucDailyReport" %>
<%@ Register Src="~/Controls/ucMonthlyReport.ascx" TagPrefix="uc1" TagName="ucMonthlyReport" %>
<%@ Register Src="~/Controls/ucDailyReport_rev1.ascx" TagPrefix="uc1" TagName="ucDailyReport_rev1" %>
<%@ Register Src="~/Controls/ucMonthlyReport_rev1.ascx" TagPrefix="uc1" TagName="ucMonthlyReport_rev1" %>
<%@ Register Src="~/Controls/ucHourlyReport.ascx" TagPrefix="uc1" TagName="ucHourlyReport" %>

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
            <telerik:RadTab runat="server" Text="Dữ liệu giờ">
            </telerik:RadTab>
            <telerik:RadTab runat="server" Text="Dữ liệu ngày">
            </telerik:RadTab>
            <telerik:RadTab runat="server" Text="Dữ liệu tháng">
            </telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="RadMultiPage1" runat="server">
        <telerik:RadPageView ID="RadPageView1" runat="server" Selected="true">
            <br />
            <uc1:ucHourlyReport runat="server" id="ucHourlyReport" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="RadPageView3" runat="server">
            <br />
            <uc1:ucDailyReport_rev1 runat="server" ID="ucDailyReport_rev1" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="RadPageView4" runat="server">
            <br />
            <uc1:ucMonthlyReport_rev1 runat="server" id="ucMonthlyReport_rev1" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>

