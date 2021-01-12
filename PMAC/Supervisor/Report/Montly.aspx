<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="Montly.aspx.cs" Inherits="Supervisor_Report_Montly" %>

<%--<%@ Register Src="~/Controls/Production/ucHourly.ascx" TagPrefix="uc1" TagName="ucHourly" %>--%>
<%@ Register Src="~/Controls/Production/ucMonthly.ascx" TagPrefix="uc1" TagName="ucMonthly" %>
<%--<%@ Register Src="~/Controls/Production/ucDaily.ascx" TagPrefix="uc1" TagName="ucDaily" %>--%>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>
        <asp:Label ID="lbTitle" runat="server" Text="Báo cáo sản lượng"></asp:Label>
    </h2>
     
    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" SelectedIndex="0">
        <Tabs>
            <%--<telerik:RadTab runat="server" Text="Sản lượng giờ">
            </telerik:RadTab>
            <telerik:RadTab runat="server" Text="Sản lượng ngày">
            </telerik:RadTab>--%>
            <telerik:RadTab runat="server" Text="Sản lượng tháng">
            </telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="RadMultiPage1" runat="server">
        <%--<telerik:RadPageView ID="RadPageView1" runat="server" Selected="true">
            <br />
            <uc1:ucHourly runat="server" id="ucHourly" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="RadPageView2" runat="server">
            <br />
            <uc1:ucDaily runat="server" ID="ucDaily" />
        </telerik:RadPageView>--%>
        <telerik:RadPageView ID="RadPageView3" runat="server" Selected="true">
            <br />
            <uc1:ucMonthly runat="server" id="ucMonthly" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>

