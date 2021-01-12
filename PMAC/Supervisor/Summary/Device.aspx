<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="Device.aspx.cs" Inherits="Supervisor_Summary_Device" %>

<%@ Register src="../../Controls/ucSummaryMeter.ascx" tagname="ucSummaryMeter" tagprefix="uc1" %>
<%@ Register src="../../Controls/ucSummaryTransmitter.ascx" tagname="ucSummaryTransmitter" tagprefix="uc2" %>
<%@ Register src="../../Controls/ucSummaryLogger.ascx" tagname="ucSummaryLogger" tagprefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<div id="title">
        <div class="div_title_left">Thống kê thiết bị</div>
        <div class="div_center">
        </div>
    </div>--%>
    <h2><asp:Label ID="lbTitle" runat="server" Text="Thống kê thiết bị"></asp:Label></h2>
    <div>
        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" 
            MultiPageID="RadMultiPage1" SelectedIndex="0">
            <Tabs>
                <telerik:RadTab runat="server" Value="tab1" Text="Đồng hồ" Selected="True">
                </telerik:RadTab>
                <telerik:RadTab runat="server" Value="tab2" Text="Bộ hiển thị">
                </telerik:RadTab>
                <telerik:RadTab runat="server" Value="tab3" Text="Logger">
                </telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>
        <telerik:RadMultiPage ID="RadMultiPage1" runat="server">
            <telerik:RadPageView ID="RadPageView1" runat="server" Selected="True">
                <uc1:ucSummaryMeter ID="ucSummaryMeter1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView2" runat="server">
                <uc2:ucSummaryTransmitter ID="ucSummaryTransmitter1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView3" runat="server">
                <uc3:ucSummaryLogger ID="ucSummaryLogger1" runat="server" />
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>
</asp:Content>

