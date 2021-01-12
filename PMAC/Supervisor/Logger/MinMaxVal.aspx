<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="MinMaxVal.aspx.cs" Inherits="Supervisor_Logger_MinMaxVal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>
        <asp:Label ID="lbTitle" runat="server" Text="Giá trị Max Min"></asp:Label></h2>
    <div class="row">

        <div class="col-sm-5">
            <div class="row">
                <div class="col-sm-5">
                    <telerik:RadListBox ID="listBoxSites" CssClass="RadListBox1" runat="server" Width="99%" Height="160px"
                        SelectionMode="Multiple" AllowTransfer="True" TransferToID="listBoxSelectedSites" AutoPostBackOnTransfer="True"
                        AllowReorder="True" AutoPostBackOnReorder="True" EnableDragAndDrop="True" DataSourceID="SqlDataSource1" DataTextField="SiteAliasName" DataValueField="SiteId" DataKeyField="SiteId">
                    </telerik:RadListBox>
                </div>
                <div class="col-sm-5">
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT [SiteId], [SiteAliasName], [Location] FROM [t_Sites] ORDER BY [SiteAliasName]"></asp:SqlDataSource>
                    <telerik:RadListBox ID="listBoxSelectedSites" CssClass="RadListBox2" runat="server" Width="99%" Height="160px"
                        SelectionMode="Multiple" AllowReorder="True" AutoPostBackOnReorder="True" EnableDragAndDrop="True">

                        <ButtonSettings TransferButtons="All"></ButtonSettings>

                    </telerik:RadListBox>
                </div>
            </div>
        </div>

        <div class="col-sm-4">
            <div class="row">
                <div class="col-sm-5">
                    <telerik:RadListBox ID="listBoxTypes" runat="server" Width="99%" Height="160px"
                        SelectionMode="Multiple" AllowTransfer="True" TransferToID="listBoxSelectedTypes" AutoPostBackOnTransfer="True"
                        AllowReorder="True" AutoPostBackOnReorder="True" EnableDragAndDrop="True">
                        <ButtonSettings TransferButtons="All"></ButtonSettings>
                        <Items>
                            <telerik:RadListBoxItem runat="server" Text="Áp lực trước valve" Value="0" />
                            <telerik:RadListBoxItem runat="server" Text="Áp lực sau valve" Value="1" />
                            <telerik:RadListBoxItem runat="server" Text="Lưu lượng thuận" Value="2" />
                            <telerik:RadListBoxItem runat="server" Text="Lưu lượng nghịch" Value="3" />
                            <telerik:RadListBoxItem runat="server" Text="Lưu lượng Net" Value="4" />
                        </Items>
                    </telerik:RadListBox>
                </div>
                <div class="col-sm-5">
                    <telerik:RadListBox ID="listBoxSelectedTypes" runat="server" Width="99%" Height="160px" SelectionMode="Multiple"
                        AllowReorder="True" AutoPostBackOnReorder="True" EnableDragAndDrop="True">
                    </telerik:RadListBox>
                </div>
            </div>
        </div>
            <div class="col-sm-3">
                <div class="rowGrid">
                    <div class="col-sm-12">
                        <asp:Label ID="lbFrom" runat="server" Text="Từ ngày giờ"></asp:Label>:</div>
                    <div class="col-sm-12">
                        <telerik:RadDateTimePicker ID="dtmStart" runat="server" Culture="en-GB">
                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

                            <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

                            <DatePopupButton ImageUrl="" HoverImageUrl="" ForeColor="White" BackColor="White"></DatePopupButton>
                        </telerik:RadDateTimePicker>
                    </div>
                </div>

                <div class="rowGrid">
                    <div class="col-sm-12">
                        <asp:Label ID="lbTo" runat="server" Text="Đến ngày giờ"></asp:Label>:
                    </div>
                    <div class="col-sm-12">
                        <telerik:RadDateTimePicker ID="dtmEnd" runat="server" Culture="en-GB">
                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

                            <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

                            <DatePopupButton ImageUrl="" HoverImageUrl="" ForeColor="White" BackColor="White"></DatePopupButton>
                        </telerik:RadDateTimePicker>
                    </div>
                </div>
                <div class="rowGrid Padding">
                    <div class="col-sm-12">
                        <telerik:RadButton ID="btnView" runat="server" Text="Xem" OnClick="btnView_Click">
                        </telerik:RadButton>
                        &nbsp;
                    <telerik:RadButton ID="btnExport" runat="server" Text="Export" OnClick="btnExport_Click">
                    </telerik:RadButton>
                    </div>
                </div>
            </div>
        </div>
        <div class="rowGridData">

            <telerik:RadGrid ID="grid" runat="server" AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnItemDataBound="grid_ItemDataBound">
                <MasterTableView>
                    <Columns>
                        <telerik:GridBoundColumn DataField="Type" FilterControlAltText="Filter column column" HeaderText="Kênh" UniqueName="Type">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TypeVal" FilterControlAltText="Filter column1 column" HeaderText="TK theo" UniqueName="TypeVal">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SiteId" FilterControlAltText="Filter column2 column" HeaderText="Site Id" UniqueName="SiteId">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SiteAliasName" FilterControlAltText="Filter column3 column" HeaderText="Site alias name" UniqueName="SiteAliasName">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Loc" FilterControlAltText="Filter column4 column" HeaderText="Địa điểm" UniqueName="Loc">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="LoggerId" FilterControlAltText="Filter column5 column" HeaderText="Logger Id" UniqueName="LoggerId">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ChnId" FilterControlAltText="Filter column6 column" HeaderText="Id kênh" UniqueName="ChnId">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ChnName" FilterControlAltText="Filter column7 column" HeaderText="Tên kênh" UniqueName="ChnName">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Tmstmp" FilterControlAltText="Filter column8 column" HeaderText="Ngày giờ" UniqueName="Tmstmp" DataFormatString="{0:dd/MM/yyyy HH:mm}">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Val" FilterControlAltText="Filter column9 column" HeaderText="Giá trị" UniqueName="Val" DataFormatString="{0:0.00}">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Unit" FilterControlAltText="Filter column10 column" HeaderText="Đơn vị" UniqueName="Unit">
                        </telerik:GridBoundColumn>
                    </Columns>
                    <HeaderStyle BackColor="#25A0DA" ForeColor="White" />

                </MasterTableView>
            </telerik:RadGrid>
        </div>
        <telerik:RadNotification ID="ntf" runat="server"></telerik:RadNotification>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Metro">
        </telerik:RadAjaxLoadingPanel>
        <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="listBoxSites">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="listBoxSelectedSites" UpdatePanelCssClass="" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="listBoxSelectedSites">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="listBoxSites" UpdatePanelCssClass="" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="listBoxTypes">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="listBoxSelectedTypes" UpdatePanelCssClass="" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="listBoxSelectedTypes">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="listBoxTypes" UpdatePanelCssClass="" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnView">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="grid" UpdatePanelCssClass="" />
                        <telerik:AjaxUpdatedControl ControlID="ntf" UpdatePanelCssClass="" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="grid">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="grid" UpdatePanelCssClass="" />
                        <telerik:AjaxUpdatedControl ControlID="ntf" UpdatePanelCssClass="" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManagerProxy>
</asp:Content>

