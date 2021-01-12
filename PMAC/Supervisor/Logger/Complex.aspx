<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="Complex.aspx.cs" Inherits="Supervisor_Logger_Complex" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Tổng hợp</h2>

    <telerik:RadGrid ID="rGrid1" runat="server" AutoGenerateColumns="False" CellSpacing="0" DataSourceID="ComplexDataSource1" GridLines="None" HeaderStyle-HorizontalAlign="Center" OnItemDataBound="rGrid1_ItemDataBound">
        <MasterTableView DataSourceID="ComplexDataSource1">
            <Columns>
                <telerik:GridBoundColumn DataField="Nr" DataType="System.Int32" FilterControlAltText="Filter Nr column" HeaderText="STT" SortExpression="Nr" UniqueName="Nr" ItemStyle-HorizontalAlign="Center">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SiteId" FilterControlAltText="Filter SiteId column" HeaderText="SiteId" SortExpression="SiteId" UniqueName="SiteId" Visible="False">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SiteAliasName" FilterControlAltText="Filter SiteAliasName column" HeaderText="Alias Name" SortExpression="SiteAliasName" UniqueName="SiteAliasName" ItemStyle-HorizontalAlign="Center">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Location" FilterControlAltText="Filter Location column" HeaderText="Vị trí" SortExpression="Location" UniqueName="Location" ItemStyle-HorizontalAlign="Center">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LoggerId" FilterControlAltText="Filter LoggerId column" HeaderText="LoggerId" SortExpression="LoggerId" UniqueName="LoggerId" Visible="False">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TimeStamp" DataType="System.DateTime" FilterControlAltText="Filter TimeStamp column" HeaderText="TimeStamp" DataFormatString="{0:dd/MM/yyyy HH:mm}" ItemStyle-HorizontalAlign="Center" SortExpression="TimeStamp" UniqueName="TimeStamp">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Pressure1" DataType="System.Double" FilterControlAltText="Filter Pressure1 column" HeaderText="Áp lực 1" DataFormatString="{0:0.0}" SortExpression="Pressure1" UniqueName="Pressure1" ItemStyle-HorizontalAlign="Right">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Pressure2" DataType="System.Double" FilterControlAltText="Filter Pressure2 column" HeaderText="Áp lực 2" DataFormatString="{0:0.0}" SortExpression="Pressure2" UniqueName="Pressure2" ItemStyle-HorizontalAlign="Right">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ForwardFlow" DataType="System.Double" FilterControlAltText="Filter ForwardFlow column" HeaderText="Thuận" DataFormatString="{0:,0.0}" SortExpression="ForwardFlow" UniqueName="ForwardFlow" ItemStyle-HorizontalAlign="Right">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ReverseFlow" DataType="System.Double" FilterControlAltText="Filter ReverseFlow column" HeaderText="Nghịch" DataFormatString="{0:,0.0}" SortExpression="ReverseFlow" UniqueName="ReverseFlow" ItemStyle-HorizontalAlign="Right">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ForwardIndex" DataType="System.Double" FilterControlAltText="Filter ForwardIndex column" HeaderText="Tổng thuận" DataFormatString="{0:,0}" SortExpression="ForwardIndex" UniqueName="ForwardIndex" ItemStyle-HorizontalAlign="Right">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ReverseIndex" DataType="System.Double" FilterControlAltText="Filter ReverseIndex column" HeaderText="Tổng ngược" DataFormatString="{0:,0}" SortExpression="ReverseIndex" UniqueName="ReverseIndex" ItemStyle-HorizontalAlign="Right">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Alarm" FilterControlAltText="Filter Alarm column" HeaderText="Alarm" SortExpression="Alarm" UniqueName="Alarm">
                </telerik:GridBoundColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    <asp:ObjectDataSource ID="ComplexDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCustomComplexData" TypeName="PMAC.BLL.ComplexDataBL"></asp:ObjectDataSource>
    <asp:Timer ID="Timer1" runat="server" Interval="600000" OnTick="Timer1_Tick">
    </asp:Timer>
    <telerik:RadAjaxLoadingPanel ID="rAjaxLoadingPanel1" Runat="server" Skin="Metro">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server" >
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Timer1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrid1" UpdatePanelCssClass="" LoadingPanelID="rAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="ComplexDataSource1" UpdatePanelCssClass="" LoadingPanelID="rAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
</asp:Content>

