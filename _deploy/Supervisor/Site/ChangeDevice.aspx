<%@ page title="" language="C#" masterpagefile="~/Supervisor/MasterPage.master" autoeventwireup="true" inherits="Supervisor_Site_ChangeDevice, App_Web_pi0iyogq" theme="Default" %>

<%@ Register src="../../Controls/ucChangeMeter.ascx" tagname="ucChangeMeter" tagprefix="uc1" %>
<%@ Register src="../../Controls/ucChangeTransmitter.ascx" tagname="ucChangeTransmitter" tagprefix="uc2" %>
<%@ Register src="../../Controls/ucChangeLogger.ascx" tagname="ucChangeLogger" tagprefix="uc3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<div id="title">
        <div class="div_title_left">Thay thiết bị</div>
        <div class="div_center">
        </div>
    </div>--%>
    <h2>Thay thiết bị</h2>
    <div>
        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" 
            MultiPageID="RadMultiPage1" SelectedIndex="0">
            <Tabs>
                <telerik:RadTab runat="server" Text="Thay đồng hồ" Selected="True">
                </telerik:RadTab>
                <telerik:RadTab runat="server" Text="Thay bộ hiển thị">
                </telerik:RadTab>
                <telerik:RadTab runat="server" Text="Thay logger">
                </telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>
        <telerik:RadMultiPage ID="RadMultiPage1" runat="server">
            <telerik:RadPageView ID="RadPageView1" runat="server" Selected="True">
                <uc1:ucChangeMeter ID="ucChangeMeter1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView2" runat="server">
                <uc2:ucChangeTransmitter ID="ucChangeTransmitter1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView3" runat="server">
                <uc3:ucChangeLogger ID="ucChangeLogger1" runat="server" />
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </div>
</asp:Content>

