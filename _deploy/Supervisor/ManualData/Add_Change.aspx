<%@ page title="" language="C#" masterpagefile="~/Supervisor/MasterPage.master" autoeventwireup="true" inherits="Supervisor_ManualData_Add_Change, App_Web_pbfu3lyk" theme="Default" %>

<%@ Register Src="~/Controls/ucManualDataAdd.ascx" TagPrefix="uc1" TagName="ucManualDataAdd" %>
<%@ Register Src="~/Controls/ucManualDataChange.ascx" TagPrefix="uc1" TagName="ucManualDataChange" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Dữ liệu nhập tay</h2>
    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" SelectedIndex="0">
        <Tabs>
            <telerik:RadTab runat="server" Text="Nhập tay chỉ số">
            </telerik:RadTab>
            <telerik:RadTab runat="server" Text="Sửa dữ liệu nhập tay">
            </telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="RadMultiPage1" runat="server">
        <telerik:RadPageView ID="RadPageView1" runat="server" Selected="true">
            <br />
            <uc1:ucManualDataAdd runat="server" ID="ucManualDataAdd" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="RadPageView2" runat="server">
            <br />
            <uc1:ucManualDataChange runat="server" ID="ucManualDataChange" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>

