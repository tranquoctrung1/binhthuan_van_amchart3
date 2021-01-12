<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="Expired.aspx.cs" Inherits="Supervisor_Summary_Expired" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="title">
        <div class="div_title_left">Đến hạn kiểm định</div>
        <div class="div_center">
        </div>
    </div>
    <div id="main">
        <ul class="multiple_columns" style="width:50%">
            <li class="text_grid_2_columns">Mốc thời gian:
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadDatePicker ID="dtmEnd" runat="server">
                </telerik:RadDatePicker>
            </li>
            <li class="text_grid_2_columns">
            </li>
            <li class="control_grid_2_columns">
                <telerik:RadButton ID="btnView" runat="server" Text="Xem">
                </telerik:RadButton>
                <telerik:RadButton ID="btnExport" runat="server" Text="Export">
                </telerik:RadButton>
            </li>
        </ul>
    </div>
</asp:Content>