<%@ Page Title="" Language="C#" MasterPageFile="~/_site.master" AutoEventWireup="true" CodeFile="_all.aspx.cs" Inherits="_supervisor__device_all" %>

<%@ Register Src="~/_controls/_meter.ascx" TagPrefix="uc1" TagName="_meter" %>
<%@ Register Src="~/_controls/_transmitter.ascx" TagPrefix="uc1" TagName="_transmitter" %>
<%@ Register Src="~/_controls/_logger.ascx" TagPrefix="uc1" TagName="_logger" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Thiết bị
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
                <uc1:_meter runat="server" ID="_meter" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView2" runat="server">
                <br />
                <uc1:_transmitter runat="server" id="_transmitter" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="RadPageView3" runat="server">
                <br />
                <uc1:_logger runat="server" id="_logger" />
            </telerik:RadPageView>
        </telerik:RadMultiPage>
</asp:Content>

