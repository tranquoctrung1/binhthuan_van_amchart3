<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.master" AutoEventWireup="true" CodeFile="Logger.aspx.cs" Inherits="Supervisor_File_Logger" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Files Logger</title>
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
                <asp:Label ID="winLinkUpload_MeterSeri" runat="server" Text="Số seri đồng hồ"></asp:Label>:
            </td>
            <td>
                <telerik:RadTextBox ID="txtSerial" runat="server">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <asp:Label ID="winLinkUpload_FileSelection" runat="server" Text="Chọn file"></asp:Label>:
            </td>
            <td>
                <telerik:RadAsyncUpload ID="asyncUpload" runat="server" Width="275px"
                    TargetFolder="~/App_Data/File/Logger" 
                    onfileuploaded="asyncUpload_FileUploaded" 
                    MultipleFileSelection="Automatic">
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
            FilterControlAltText="Filter column column" HeaderText="FileName" 
            UniqueName="FileName">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="LoggerSerial" 
            FilterControlAltText="Filter column1 column" HeaderText="Seri logger" 
            UniqueName="column1">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="MIMEType" 
            FilterControlAltText="Filter column2 column" HeaderText="MIME Type" 
            UniqueName="column2">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Size" 
            FilterControlAltText="Filter column3 column" HeaderText="Size" 
            UniqueName="column3">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="UploadDate" 
            FilterControlAltText="Filter column4 column" HeaderText="Upload Date" 
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

