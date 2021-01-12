<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.master" AutoEventWireup="true" CodeFile="Mail.aspx.cs" Inherits="Supervisor_Report_Mail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
            table-layout:fixed;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <table class="style1">
        <tr>
            <td align="center" colspan="3">
                <telerik:RadButton ID="btnSend" runat="server" Text="Send" 
                    onclick="btnSend_Click">
                </telerik:RadButton>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="3">
                <asp:Label ID="lblMsg" runat="server" Font-Italic="True" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Người quản trị:</td>
            <td>
                Nhân viên:</td>
            <td>
                Khách hàng:</td>
        </tr>
        <tr>
            <td valign="top">
                <asp:CheckBoxList ID="chkListAdmins" runat="server">
                </asp:CheckBoxList>
            </td>
            <td valign="top">
                <asp:CheckBoxList ID="chkListStaffs" runat="server">
                </asp:CheckBoxList>
            </td>
            <td valign="top">
                <asp:CheckBoxList ID="chkListConsumers" runat="server">
                </asp:CheckBoxList>
            </td>
        </tr>
    </table>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSend">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnSend" />
                    <telerik:AjaxUpdatedControl ControlID="lblMsg" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
</asp:Content>

