<%@ control language="C#" autoeventwireup="true" inherits="_controls_logger, App_Web_owkpbb31" %>
<%@ Register src="_upload_logger.ascx" tagname="_upload_logger" tagprefix="uc1" %>
<style type="text/css">
    .auto-style1 {
        width: 100%;
    }
    .auto-style2 {
        height: 23px;
    }
    .auto-style3 {
        width: 500px;
    }
</style>

<table class="auto-style1">
    <tr>
        <td>Số serie</td>
        <td>
            <telerik:RadComboBox ID="cboLSeries" Runat="server" AllowCustomText="True" DataSourceID="LSeriesDS" DataTextField="Serial" DataValueField="Serial" DropDownWidth="525px" EmptyMessage="Nhập ở đây" Filter="StartsWith" HighlightTemplatedItems="True">
                <HeaderTemplate>
                    <table cellpadding="0" cellspacing="0" class="auto-style3">
                        <tr>
                            <td style="width: 180px">Số serie</td>
                            <td style="width: 120px">Nhà sản xuất</td>
                            <td style="width: 120px">Hiệu</td>
                            <td style="width: 80px">Model</td>
                        </tr>
                    </table>
                </HeaderTemplate>
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" class="auto-style3">
                        <tr>
                            <td style="width: 180px"><%#DataBinder.Eval(Container.DataItem,"Serial") %></td>
                            <td style="width: 120px"><%#DataBinder.Eval(Container.DataItem,"Provider") %></td>
                            <td style="width: 120px"><%#DataBinder.Eval(Container.DataItem,"Marks") %></td>
                            <td style="width: 80px"><%#DataBinder.Eval(Container.DataItem,"Model") %></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="LSeriesDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT [Serial], [Provider], [Marks], [Model] FROM [t_Loggers] ORDER BY [Serial]"></asp:SqlDataSource>
        </td>
        <td colspan="2">
            <asp:LinkButton ID="LinkButton1" runat="server">Upload/Download Tài liệu Logger</asp:LinkButton>
        </td>
    </tr>
    <tr>
        <td>Ngày nhập kho</td>
        <td>
            <telerik:RadDatePicker ID="dtmLReceipt" Runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
            </telerik:RadDatePicker>
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Nhà sản xuất</td>
        <td>
            <telerik:RadComboBox ID="cboLProviders" Runat="server" AllowCustomText="True" DataSourceID="LProvidersDS" DataTextField="Provider" DataValueField="Provider" EmptyMessage="Nhập ở đây" Filter="StartsWith">
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="LProvidersDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Provider] FROM [t_Loggers] ORDER BY [Provider]"></asp:SqlDataSource>
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Hiệu</td>
        <td>
            <telerik:RadComboBox ID="cboLMarks" Runat="server" AllowCustomText="True" DataSourceID="LMarksDS" DataTextField="Marks" DataValueField="Marks" EmptyMessage="Nhập ở đây" Filter="StartsWith">
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="LMarksDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Marks] FROM [t_Loggers] ORDER BY [Marks]"></asp:SqlDataSource>
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Model</td>
        <td>
            <telerik:RadComboBox ID="cboLModels" Runat="server" AllowCustomText="True" DataSourceID="LModelsDS" DataTextField="Model" DataValueField="Model" EmptyMessage="Nhập ở đây" Filter="StartsWith">
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="LModelsDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Model] FROM [t_Loggers] ORDER BY [Model]"></asp:SqlDataSource>
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Tình trạng</td>
        <td>
            <telerik:RadComboBox ID="cboStatus" Runat="server" AllowCustomText="True" DataSourceID="StatusDS" DataTextField="Status" DataValueField="Status" DropDownWidth="275px" EmptyMessage="Nhập ở đây" Filter="StartsWith" HighlightTemplatedItems="true" MarkFirstMatch="True">
                <HeaderTemplate>
                    <table cellpadding="0" cellspacing="0" class="auto-style4">
                        <tr>
                            <td style="width: 100px">Tình trạng</td>
                            <td style="width: 150px">Mô tả</td>
                        </tr>
                    </table>
                </HeaderTemplate>
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" class="auto-style4">
                        <tr>
                            <td style="width: 100px"><%#DataBinder.Eval(Container.DataItem,"Status") %></td>
                            <td style="width: 150px"><%#DataBinder.Eval(Container.DataItem,"Description") %></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="StatusDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT * FROM [t_Device_Status] ORDER BY [Status]"></asp:SqlDataSource>
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Đã lắp đặt</td>
        <td>
            <asp:CheckBox ID="chkLInstalled" runat="server" />
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style2">Ghi chú</td>
        <td class="auto-style2" colspan="2">
            <asp:TextBox ID="txtLDescription" runat="server" Height="50px" TextMode="MultiLine" Width="225px"></asp:TextBox>
        </td>
        <td class="auto-style2"></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>
            <telerik:RadButton ID="btnLAdd" runat="server" Text="Thêm mới">
            </telerik:RadButton>
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
</table>
<telerik:RadGrid ID="grvLoggers" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateDeleteColumn="True" AutoGenerateEditColumn="True" CellSpacing="0" GridLines="None" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" DataSourceID="LoggersDS" PageSize="20" AllowAutomaticInserts="True" OnItemCommand="grvLoggers_ItemCommand">
    <ExportSettings FileName="Export_Logger" ExportOnlyData="True" HideStructureColumns="True" IgnorePaging="True" OpenInNewWindow="True">
        <Excel AutoFitImages="True" Format="Biff" />
        <Csv ColumnDelimiter="VerticalBar" />
    </ExportSettings>
    <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True">
    </ClientSettings>
<MasterTableView AutoGenerateColumns="False" DataKeyNames="Serial" DataSourceID="LoggersDS" CommandItemDisplay="Top">
<CommandItemSettings ExportToPdfText="Export to PDF" ShowExportToExcelButton="True" ShowExportToCsvButton="True"></CommandItemSettings>

<RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column" Created="True">
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>

    <Columns>
        <telerik:GridBoundColumn DataField="Serial" FilterControlAltText="Filter Serial column" HeaderText="Số serie" ReadOnly="True" SortExpression="Serial" UniqueName="Serial">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="ReceiptDate" DataType="System.DateTime" FilterControlAltText="Filter ReceiptDate column" HeaderText="Ngày nhập kho" SortExpression="ReceiptDate" UniqueName="ReceiptDate" DataFormatString="{0:dd/MM/yyyy}">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Provider" FilterControlAltText="Filter Provider column" HeaderText="Nhà sản xuất" SortExpression="Provider" UniqueName="Provider">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Marks" FilterControlAltText="Filter Marks column" HeaderText="Hiệu" SortExpression="Marks" UniqueName="Marks">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Model" FilterControlAltText="Filter Model column" HeaderText="Model" SortExpression="Model" UniqueName="Model">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Status" FilterControlAltText="Filter Status column" HeaderText="Tình trạng" SortExpression="Status" UniqueName="Status">
        </telerik:GridBoundColumn>
        <telerik:GridCheckBoxColumn DataField="Installed" DataType="System.Boolean" FilterControlAltText="Filter Installed column" HeaderText="Đã lắp đặt" SortExpression="Installed" UniqueName="Installed">
        </telerik:GridCheckBoxColumn>
        <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Ghi chú" SortExpression="Description" UniqueName="Description">
        </telerik:GridBoundColumn>
    </Columns>

<EditFormSettings>
<EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
    <FormTemplate>
        <table class="auto-style1">
            <tr>
                <td>Số serie</td>
                <td>
                    <asp:TextBox ID="txtLSerie1" runat="server" Text='<%#Bind("Serial") %>' Enabled='<%#(Container is GridEditFormInsertItem) ? true : false %>'></asp:TextBox>
                </td>
                <td colspan="2">
                </td>
            </tr>
            <tr>
                <td>Ngày nhập kho</td>
                <td>
                    <telerik:RadDatePicker ID="dtmLReceipt1" SelectedDate='<%#Bind("ReceiptDate") %>' Runat="server" Culture="en-GB">
        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"></Calendar>

        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    </telerik:RadDatePicker>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Nhà sản xuất</td>
                <td>
                    <telerik:RadComboBox ID="cboLProviders1" Runat="server" Text='<%# Bind("Provider") %>' AllowCustomText="True" DataSourceID="LProvidersDS" DataTextField="Provider" DataValueField="Provider" EmptyMessage="Nhập ở đây" Filter="StartsWith">
                    </telerik:RadComboBox>
                    
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Hiệu</td>
                <td>
                    <telerik:RadComboBox ID="cboLMarks1" Runat="server" Text='<%#Bind("Marks") %>' AllowCustomText="True" DataSourceID="LMarksDS" DataTextField="Marks" DataValueField="Marks" EmptyMessage="Nhập ở đây" Filter="StartsWith">
                    </telerik:RadComboBox>
                    
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Model</td>
                <td>
                    <telerik:RadComboBox ID="cboLModels1" Runat="server" Text='<%#Bind("Model") %>' AllowCustomText="True" DataSourceID="LModelsDS" DataTextField="Model" DataValueField="Model" EmptyMessage="Nhập ở đây" Filter="StartsWith">
                    </telerik:RadComboBox>
                    
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Tình trạng</td>
                <td>
                    <telerik:RadComboBox ID="cboStatus1" Runat="server" Text='<%#Bind("Status") %>' AllowCustomText="True" DataSourceID="StatusDS" DataTextField="Status" DataValueField="Status" DropDownWidth="275px" EmptyMessage="Nhập ở đây" Filter="StartsWith" HighlightTemplatedItems="true" MarkFirstMatch="True">
                        <HeaderTemplate>
                            <table cellpadding="0" cellspacing="0" class="auto-style4">
                                <tr>
                                    <td style="width: 100px">Tình trạng</td>
                                    <td style="width: 150px">Mô tả</td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table cellpadding="0" cellspacing="0" class="auto-style4">
                                <tr>
                                    <td style="width: 100px"><%#DataBinder.Eval(Container.DataItem,"Status") %></td>
                                    <td style="width: 150px"><%#DataBinder.Eval(Container.DataItem,"Description") %></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                    
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Đã lắp đặt</td>
                <td>
                    <asp:CheckBox ID="chkLInstalled1" runat="server" Checked='<%#Bind("Installed") %>' />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2">Ghi chú</td>
                <td class="auto-style2" colspan="2">
                    <asp:TextBox ID="txtLDescription" runat="server" Text='<%#Bind("Description") %>' Height="50px" TextMode="MultiLine" Width="225px"></asp:TextBox>
                </td>
                <td class="auto-style2"></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <telerik:RadButton ID="btnLAdd1" runat="server" Text='<%#(Container is GridEditFormInsertItem) ? "Thêm mới" : "Sửa" %>' CommandName='<%#(Container is GridEditFormInsertItem ) ? "PerformInsert" : "Update" %>'>
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnLCancel1" runat="server" Text="Cancel" CausesValidation="false">
                    </telerik:RadButton>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </FormTemplate>
</EditFormSettings>

<PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>
</MasterTableView>

    <HeaderStyle Font-Underline="True" />

<PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>

<FilterMenu EnableImageSprites="False"></FilterMenu>
</telerik:RadGrid>

<asp:SqlDataSource ID="LoggersDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" DeleteCommand="DELETE FROM [t_Loggers] WHERE [Serial] = @Serial" InsertCommand="INSERT INTO [t_Loggers] ([Serial], [ReceiptDate], [Provider], [Marks], [Model], [Status], [Description], [Installed]) VALUES (@Serial, @ReceiptDate, @Provider, @Marks, @Model, @Status, @Description, @Installed)" SelectCommand="SELECT * FROM [t_Loggers] ORDER BY [Serial]" UpdateCommand="UPDATE [t_Loggers] SET [ReceiptDate] = @ReceiptDate, [Provider] = @Provider, [Marks] = @Marks, [Model] = @Model, [Status] = @Status, [Description] = @Description, [Installed] = @Installed WHERE [Serial] = @Serial">
    <DeleteParameters>
        <asp:Parameter Name="Serial" Type="String" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Serial" Type="String" />
        <asp:Parameter Name="ReceiptDate" Type="DateTime" />
        <asp:Parameter Name="Provider" Type="String" />
        <asp:Parameter Name="Marks" Type="String" />
        <asp:Parameter Name="Model" Type="String" />
        <asp:Parameter Name="Status" Type="String" />
        <asp:Parameter Name="Description" Type="String" />
        <asp:Parameter Name="Installed" Type="Boolean" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="ReceiptDate" Type="DateTime" />
        <asp:Parameter Name="Provider" Type="String" />
        <asp:Parameter Name="Marks" Type="String" />
        <asp:Parameter Name="Model" Type="String" />
        <asp:Parameter Name="Status" Type="String" />
        <asp:Parameter Name="Description" Type="String" />
        <asp:Parameter Name="Installed" Type="Boolean" />
        <asp:Parameter Name="Serial" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>

<script type="text/javascript">
    function lnkMFiles_OnClientClick() {
        var win = $find('<%= winLFiles.ClientID %>');
        var meter = $find('<%= cboLSeries.ClientID %>').get_text();
        win.show();
    }
</script>

<telerik:RadWindow ID="winLFiles" runat="server" Height="540px" Modal="True" Width="960px">
    <ContentTemplate>
        <uc1:_upload_logger ID="_upload_logger1" runat="server" />
    </ContentTemplate>
</telerik:RadWindow>



