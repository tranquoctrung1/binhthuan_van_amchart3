<%@ page title="" language="C#" masterpagefile="~/Empty.master" autoeventwireup="true" inherits="Supervisor_File_Transmitter, App_Web_ox5zq5ra" theme="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Files Bộ hiển thị</title>
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
                Số seri bộ hiển thị:
            </td>
            <td>
                <telerik:RadTextBox ID="txtSerial" runat="server">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td valign="top">
                Chọn file:
            </td>
            <td>
                <telerik:RadAsyncUpload ID="asyncUpload" runat="server" Width="275px"
                    TargetFolder="~/App_Data/File/Transmitter" 
                    MultipleFileSelection="Automatic" onfileuploaded="asyncUpload_FileUploaded">
                </telerik:RadAsyncUpload>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <telerik:RadButton ID="btnUpload" runat="server" Text="Upload">
                </telerik:RadButton>
                <telerik:RadButton ID="btnDownload" runat="server" Text="Download" 
                    onclick="btnDownload_Click">
                </telerik:RadButton>
                <telerik:RadButton ID="btnDelete" runat="server" onclick="btnDelete_Click" 
                    Text="Delete">
                </telerik:RadButton>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:Label ID="lblMessage" runat="server" style="font-style: italic" Text="msg"></asp:Label>
            </td>
        </tr>
    </table>
   <telerik:RadGrid ID="grv" runat="server" AutoGenerateColumns="False" AllowMultiRowSelection="true" 
        CellSpacing="0" GridLines="None">
        <ClientSettings>
<Selecting CellSelectionMode="None" AllowRowSelect="true"></Selecting>
</ClientSettings>
<MasterTableView>
<CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
<RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>

    <Columns>
        <telerik:GridBoundColumn DataField="FileName" 
            FilterControlAltText="Filter column column" HeaderText="Tên file" 
            UniqueName="FileName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="TransmitterSerial" 
            FilterControlAltText="Filter column1 column" HeaderText="Số seri BHT" 
            UniqueName="column1">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="MIMEType" 
            FilterControlAltText="Filter column2 column" HeaderText="MIME Type" 
            UniqueName="column2">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Size" 
            FilterControlAltText="Filter column3 column" HeaderText="Cỡ" 
            UniqueName="column3">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="UploadDate" 
            FilterControlAltText="Filter column4 column" HeaderText="Ngày upload" 
            UniqueName="column4" DataFormatString="{0:dd/MM/yyyy hh:mm:ss tt}">
        </telerik:GridBoundColumn>
    </Columns>

<EditFormSettings>
<EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
</EditFormSettings>
</MasterTableView>

<FilterMenu EnableImageSprites="False"></FilterMenu>
        </telerik:RadGrid>
</asp:Content>

