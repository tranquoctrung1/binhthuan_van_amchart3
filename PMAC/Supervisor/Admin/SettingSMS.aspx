﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="SettingSMS.aspx.cs" Inherits="Supervisor_Admin_SettingSMS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>
        <asp:Label ID="lbTitle" runat="server" Text="Cài đặt tin nhắn"></asp:Label>
    </h2>

    <div class="row">
        <div class="col-sm-6">
            <div class="row">
                <div class="col-sm-6">
                    <asp:Label ID="lbInstallationPoint" runat="server" Text="Điểm lắp đặt"></asp:Label>
                    <telerik:RadListBox ID="listBoxSites" runat="server" AllowReorder="True" AllowTransfer="True" AutoPostBackOnReorder="True" AutoPostBackOnTransfer="True" CssClass="RadListBox1" DataSourceID="SitesDataSource" DataTextField="SiteAliasName" DataValueField="SiteId" EnableDragAndDrop="True" Height="160px" SelectionMode="Multiple" TransferToID="listBoxSelectedSites" Width="99%">
                    </telerik:RadListBox>
                    <asp:ObjectDataSource ID="SitesDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSites" TypeName="PMAC.BLL.SiteBL"></asp:ObjectDataSource>
                </div>
                <div class="col-sm-6">
                    <asp:Label ID="lbSelected" runat="server" Text="Selected"></asp:Label>
                    <telerik:RadListBox ID="listBoxSelectedSites" runat="server" AllowReorder="True" AutoPostBackOnReorder="True" CssClass="RadListBox2" EnableDragAndDrop="True" Height="160px" SelectionMode="Multiple" Width="99%">
                        <ButtonSettings TransferButtons="All" />
                    </telerik:RadListBox>
                </div>
            </div>
        </div>

        <div class="col-sm-3">
            <asp:Label ID="lbMobileNumber" runat="server" Text="Số điện thoại"></asp:Label>
            <telerik:RadTextBox ID="TextBoxPhoneNr" runat="server" Width="99%">
            </telerik:RadTextBox>
            <asp:Label ID="lbNote" runat="server" Text="Ghi chú"></asp:Label>
            <telerik:RadTextBox ID="TextBoxDescription" runat="server" TextMode="MultiLine" Width="99%">
            </telerik:RadTextBox>
        </div>

        <div class="col-sm-3">
            <asp:Label ID="lbEnable" runat="server" Text="Enable"></asp:Label>
            <asp:CheckBox ID="CheckBoxEnable" runat="server" Text="Enable SMS" Width="99%"/>
            <asp:CheckBox ID="CheckBoxEnableDelay" runat="server" Text="Enable SMS Delay" Width="99%"/>
            <asp:CheckBox ID="CheckBoxEnableDiff" runat="server" Text="Enable SMS Diff Value" Width="99%"/>
            <asp:CheckBox ID="CheckBoxEnablePress" runat="server" Text="Enable SMS Press" Width="99%"/> 
        </div>
        <div class="rowGrid">
            <div class="col-sm-6" >
            <telerik:RadButton ID="ButtonAdd" runat="server" OnClick="ButtonAdd_Click" Text="Thêm"></telerik:RadButton>
            </div>
        </div>
    </div>
    <div class="rowGrid">
    <div class="rowGridData">

        <telerik:RadGrid ID="grid" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AutoGenerateColumns="False" AutoGenerateDeleteColumn="True" AutoGenerateEditColumn="True" CellSpacing="0" DataSourceID="SqlDataSource1" GridLines="None"
            OnItemCommand="grid_ItemCommand" OnItemInserted="grid_ItemInserted" AllowSorting="True" OnItemDeleted="grid_ItemDeleted" OnItemUpdated="grid_ItemUpdated"
            OnItemDataBound="RadGrid1_ItemDataBound">
            <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True">
            </ClientSettings>
            <MasterTableView DataKeyNames="Id" DataSourceID="SqlDataSource1" CommandItemDisplay="Top">
                <Columns>
                    <telerik:GridCheckBoxColumn DataField="Ena" DataType="System.Boolean" FilterControlAltText="Filter Ena column" HeaderText="Enable SMS" SortExpression="Ena" UniqueName="Ena">
                    </telerik:GridCheckBoxColumn>
                    <telerik:GridBoundColumn DataField="Id" DataType="System.Int32" FilterControlAltText="Filter Id column" HeaderText="Id" ReadOnly="True" SortExpression="Id" UniqueName="Id" Visible="False">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SiteId" FilterControlAltText="Filter SiteId column" HeaderText="Điểm lắp đặt" SortExpression="SiteId" UniqueName="SiteId">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PhoneNr" FilterControlAltText="Filter PhoneNr column" HeaderText="Số ĐT" SortExpression="PhoneNr" UniqueName="PhoneNr">
                    </telerik:GridBoundColumn>
                    <telerik:GridCheckBoxColumn DataField="Ena2" DataType="System.Boolean" FilterControlAltText="Filter Ena2 column" HeaderText="Enable SMS Delay" SortExpression="Ena2" UniqueName="Ena2">
                    </telerik:GridCheckBoxColumn>
                    <telerik:GridCheckBoxColumn DataField="Ena3" DataType="System.Boolean" FilterControlAltText="Filter Ena3 column" HeaderText="Enable SMS DiffVal" SortExpression="Ena3" UniqueName="Ena3">
                    </telerik:GridCheckBoxColumn>
                    <telerik:GridCheckBoxColumn DataField="Ena4" DataType="System.Boolean" FilterControlAltText="Filter Ena4 column" HeaderText="Enable SMS Pres" SortExpression="Ena4" UniqueName="Ena4">
                    </telerik:GridCheckBoxColumn>
                    <telerik:GridBoundColumn DataField="Note" FilterControlAltText="Filter Note column" HeaderText="Ghi chú" SortExpression="Note" UniqueName="Note">
                    </telerik:GridBoundColumn>
                </Columns>
                <EditFormSettings EditFormType="Template">
                    <FormTemplate>
                        <table class="auto-style1">
                            <tr>
                                <td>
                                    <asp:Label ID="label_Ena" runat="server" Text="Enable SMS"></asp:Label></td>
                                <td>
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%#Bind("Ena") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="label_SiteId" runat="server" Text="Điểm lắp đặt"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="RadComboBox1" runat="server" Text='<%#Bind("SiteId") %>' DataSourceID="SqlDataSource2" DataTextField="SiteId" DataValueField="SiteId" DropDownAutoWidth="Enabled" AllowCustomText="True" HighlightTemplatedItems="True" MarkFirstMatch="True">
                                        <HeaderTemplate>
                                            <table cellpadding="0" cellspacing="0" class="auto-style2">
                                                <tr>
                                                    <td width="160">SiteId</td>
                                                    <td width="200">Vị trí</td>
                                                </tr>
                                            </table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table cellpadding="0" cellspacing="0" class="auto-style2">
                                                <tr>
                                                    <td width="160"><%#DataBinder.Eval(Container.DataItem,"SiteId") %></td>
                                                    <td width="200"><%#DataBinder.Eval(Container.DataItem,"Location") %></td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="label_PhoneNr" runat="server" Text="Số ĐT"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="RadComboBox2" runat="server" Text='<%#Bind("PhoneNr") %>' AllowCustomText="True" DataSourceID="SqlDataSource3" DataTextField="PhoneNr" DataValueField="PhoneNr">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="label_Ena2" runat="server" Text="Enable SMS Delay"></asp:Label>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%#Bind("Ena2") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="label_Ena3" runat="server" Text="Enable SMS DiffVal "></asp:Label>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBox3" runat="server" Checked='<%#Bind("Ena3") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="label_Ena4" runat="server" Text="Enable SMS Pres"></asp:Label>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBox4" runat="server" Checked='<%#Bind("Ena4") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="label_Note" runat="server" Text="Ghi chú"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="TextBox1" runat="server" TextMode="MultiLine" Text='<%#Bind("Note") %>'></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <telerik:RadButton ID="RadButton1" runat="server" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                        CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'>
                                    </telerik:RadButton>
                                    <telerik:RadButton ID="RadButton2" runat="server" CommandName="Cancel" Text="Cancel">
                                    </telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </FormTemplate>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" DeleteCommand="DELETE FROM [t_Alarm_Configurations] WHERE [Id] = @Id" InsertCommand="INSERT INTO [t_Alarm_Configurations] ([SiteId], [PhoneNr], [Ena2], [Ena4], [Ena3], [Ena], [Note]) VALUES (@SiteId, @PhoneNr, @Ena2, @Ena4, @Ena3, @Ena, @Note)" SelectCommand="SELECT [Id], [SiteId], [PhoneNr], [Ena2], [Ena4], [Ena3], [Ena], [Note] FROM [t_Alarm_Configurations] ORDER BY [SiteId], [PhoneNr]" UpdateCommand="UPDATE [t_Alarm_Configurations] SET [SiteId] = @SiteId, [PhoneNr] = @PhoneNr, [Ena2] = @Ena2, [Ena4] = @Ena4, [Ena3] = @Ena3, [Ena] = @Ena, [Note] = @Note WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="SiteId" Type="String" />
            <asp:Parameter Name="PhoneNr" Type="String" />
            <asp:Parameter Name="Ena2" Type="Boolean" />
            <asp:Parameter Name="Ena4" Type="Boolean" />
            <asp:Parameter Name="Ena3" Type="Boolean" />
            <asp:Parameter Name="Ena" Type="Boolean" />
            <asp:Parameter Name="Note" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="SiteId" Type="String" />
            <asp:Parameter Name="PhoneNr" Type="String" />
            <asp:Parameter Name="Ena2" Type="Boolean" />
            <asp:Parameter Name="Ena4" Type="Boolean" />
            <asp:Parameter Name="Ena3" Type="Boolean" />
            <asp:Parameter Name="Ena" Type="Boolean" />
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="Note" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT [SiteId], [SiteAliasName], [Location] FROM [t_Sites] ORDER BY [SiteAliasName]"></asp:SqlDataSource>
    <telerik:RadNotification ID="ntf" runat="server">
    </telerik:RadNotification>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [PhoneNr] FROM [t_Alarm_Configurations] ORDER BY [PhoneNr]"></asp:SqlDataSource>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Metro">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ButtonAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grid" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="ntf" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
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
            <telerik:AjaxSetting AjaxControlID="grid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grid" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="ntf" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <%-- Pi-Solution --%>
    <script type="text/javascript">
        $(function () {
            $("#ctl00_ContentPlaceHolder1_grid").css("width", "100%");
            $("#ctl00_ContentPlaceHolder1_grid").css("overflow-x", "auto");
        })
    </script>

</asp:Content>

