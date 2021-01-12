<%@ page title="" language="C#" masterpagefile="~/_site.master" autoeventwireup="true" inherits="_supervisor__summary_devices, App_Web_wcmfxgph" theme="Default" %>

<%@ Register Src="~/_controls/_summary_meter.ascx" TagPrefix="uc1" TagName="_summary_meter" %>
<%@ Register Src="~/_controls/_summary_transmitter.ascx" TagPrefix="uc1" TagName="_summary_transmitter" %>
<%@ Register Src="~/_controls/_logger.ascx" TagPrefix="uc1" TagName="_logger" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Thống kê thiết bị
    </h2>
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
                <br />
                <uc1:_summary_meter runat="server" ID="_summary_meter" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView2" runat="server">
                <br />
                <uc1:_summary_transmitter runat="server" ID="_summary_transmitter" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView3" runat="server">
                <br />
                <uc1:_logger runat="server" ID="_logger" />
            </telerik:RadPageView>
        </telerik:RadMultiPage>
</asp:Content>

