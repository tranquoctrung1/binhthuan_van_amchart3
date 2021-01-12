<%@ page title="" language="C#" masterpagefile="~/Empty.master" autoeventwireup="true" inherits="Supervisor_File_Site, App_Web_ox5zq5ra" theme="Default" %>

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
            <td>
                Mã vị trí (tag name):
            </td>
            <td>
                <telerik:RadTextBox ID="txtSiteID" runat="server">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td valign="top">
                Chọn file:
            </td>
            <td>
                <telerik:RadAsyncUpload ID="asyncUpload" runat="server" Width="275px"
                    TargetFolder="~/App_Data/File/Site">
                </telerik:RadAsyncUpload>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <telerik:RadButton ID="btnUpload" runat="server" Text="Upload">
                </telerik:RadButton>
                <telerik:RadButton ID="btnDownload" runat="server" Text="Download">
                </telerik:RadButton>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:Label ID="lblMessage" runat="server" style="font-style: italic" Text="msg"></asp:Label>
            </td>
        </tr>
    </table>
    <telerik:RadGrid ID="grv" runat="server">
        </telerik:RadGrid>
</asp:Content>

