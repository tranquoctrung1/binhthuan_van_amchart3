<%@ page title="" language="C#" masterpagefile="~/Supervisor/MasterPage.master" autoeventwireup="true" inherits="Supervisor_Device_All, App_Web_ieo05ku5" theme="Default" %>

<%@ Register src="../../Controls/ucMeter.ascx" tagname="ucMeter" tagprefix="uc1" %>
<%@ Register src="../../Controls/ucLogger.ascx" tagname="ucLogger" tagprefix="uc2" %>
<%@ Register src="../../Controls/ucTransmitter.ascx" tagname="ucTransmitter" tagprefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<div id="title">
        <div class="div_title_left">
            <h2>Thiết bị</h2>
        </div>
        <div class="div_center">
        </div>
    </div>--%>
    <h2>Thiết bị</h2>
    <div>
        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" 
            MultiPageID="RadMultiPage1" SelectedIndex="0">
            <Tabs>
                <telerik:RadTab runat="server" Text="Đồng hồ" Selected="True">
                </telerik:RadTab>
                <telerik:RadTab runat="server" Text="Bộ hiển thị">
                </telerik:RadTab>
                <telerik:RadTab runat="server" Text="Logger">
                </telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>
        <telerik:RadMultiPage ID="RadMultiPage1" runat="server">
            <telerik:RadPageView ID="RadPageView1" runat="server" Selected="True">
                <uc1:ucMeter ID="ucMeter1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView2" runat="server">
                <uc3:ucTransmitter ID="ucTransmitter1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView3" runat="server">
                <uc2:ucLogger ID="ucLogger1" runat="server" />
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>
</asp:Content>