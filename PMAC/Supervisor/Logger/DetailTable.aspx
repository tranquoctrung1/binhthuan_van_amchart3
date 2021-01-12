<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.master" AutoEventWireup="true" CodeFile="DetailTable.aspx.cs" Inherits="Supervisor_Logger_DetailTable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
        <div  class="rowGrid">

             &nbsp;    <asp:Label ID="lbFrom" runat="server" Text="Start Date"></asp:Label>: &nbsp;

                        <telerik:RadDatePicker ID="dtmStart" runat="server" Culture="en-GB">
                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                        </telerik:RadDatePicker>
         &nbsp; <asp:Label ID="lbTo" runat="server" Text="End Date"></asp:Label>: &nbsp;
                        <telerik:RadDatePicker ID="dtmEnd" runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                        </telerik:RadDatePicker>
               
                        <telerik:RadButton ID="btnView" runat="server" Text="Xem" 
                            onclick="btnView_Click">
                        </telerik:RadButton>
                        <telerik:RadButton ID="btnExport" runat="server" Text="Export" 
                            onclick="btnExport_Click">
                        </telerik:RadButton>

            
        </div>
        <div style="width:100%; text-align:center; clear:both">
            <asp:Label ID="lblTitle" runat="server" Text="" style="font-weight: 700"></asp:Label>
        </div>
        <div class="rowGrid ">
            <telerik:RadGrid ID="grv" runat="server" AutoGenerateColumns="False" 
                CellSpacing="0" GridLines="None">
                <ClientSettings>
                    <Selecting CellSelectionMode="None" />
                </ClientSettings>
                <AlternatingItemStyle HorizontalAlign="Center" />
                <MasterTableView>
                    <CommandItemSettings ExportToPdfText="Export to PDF" />
                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" 
                        Visible="True">
                        <HeaderStyle Width="20px" />
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" 
                        Visible="True">
                        <HeaderStyle Width="20px" />
                    </ExpandCollapseColumn>
                    <Columns>
                        <telerik:GridBoundColumn DataField="TimeStamp"
                            FilterControlAltText="Filter column3 column" HeaderText="Time" DataFormatString="{0:dd/MM/yyyy HH:mm:ss}"
                            UniqueName="column3">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="FlowRate" DataFormatString="{0:0.00}"
                            FilterControlAltText="Filter column column" HeaderText="Lưu lượng (m3/h)" 
                            UniqueName="column">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Pressure" DataFormatString="{0:0.00}"
                            FilterControlAltText="Filter column1 column" HeaderText="Áp lực (m)" 
                            UniqueName="column1">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ForwardIndex" DataFormatString="{0:0.00}"
                            FilterControlAltText="Filter column2 column" HeaderText="Chỉ số thuận (+)" 
                            UniqueName="column2">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ReverseIndex" DataFormatString="{0:0.00}"
                            FilterControlAltText="Filter column4 column" HeaderText="Chỉ số ngược (-)" 
                            UniqueName="column4">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NetIndex" DataFormatString="{0:0.00}"
                            FilterControlAltText="Filter column5 column" HeaderText="Chỉ số Net" 
                            UniqueName="column5">
                        </telerik:GridBoundColumn>
                    </Columns>
                    <EditFormSettings>
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
                <HeaderStyle BackColor="#25A0DA" ForeColor="White" HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                <FilterMenu EnableImageSprites="False">
                </FilterMenu>
            </telerik:RadGrid>
        </div>
    </div>
    <telerik:RadNotification ID="ntf" runat="server" >
    </telerik:RadNotification>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnView">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="lblTitle" />
                    <telerik:AjaxUpdatedControl ControlID="grv"/>
                    <telerik:AjaxUpdatedControl ControlID="ntf" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
</asp:Content>

