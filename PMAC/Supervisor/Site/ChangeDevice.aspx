<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="ChangeDevice.aspx.cs" Inherits="Supervisor_Site_ChangeDevice" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

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
    <h2>
        <asp:Label ID="lbTitle" runat="server" Text="Thay thiết bị"></asp:Label>
    </h2>
    <div>
        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" 
            MultiPageID="RadMultiPage1" SelectedIndex="0">
            <Tabs>
                <telerik:RadTab runat="server" Value="tab1" Text="Thay đồng hồ" Selected="True">
                </telerik:RadTab>
                <telerik:RadTab runat="server" Value="tab2" Text="Thay bộ hiển thị">
                </telerik:RadTab>
                <telerik:RadTab runat="server" Value="tab3" Text="Thay logger">
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
            <script type="text/javascript">
            function pageLoad(sender, args) {
                $(function () {
                    $(".riTextBox").each(function () {
                        $(this).removeClass("rfdDecorated");  
                    });
                })
            }
        </script>

</asp:Content>

