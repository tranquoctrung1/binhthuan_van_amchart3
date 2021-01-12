<%@ control language="C#" autoeventwireup="true" inherits="_controls_transmitter, App_Web_owkpbb31" %>
<%@ Register src="_upload_transmitter.ascx" tagname="_upload_transmitter" tagprefix="uc1" %>
<style type="text/css">
    .auto-style1 {
        width: 100%;
    }
    .auto-style3 {
        width: 500px;
    }
    .auto-style4 {
        width: 250px;
    }
</style>

<table class="auto-style1">
    <tr>
        <td>Số serie</td>
        <td>
            <telerik:RadComboBox ID="cboTSeries" Runat="server" AllowCustomText="True" DataSourceID="TSeriesDS" DataTextField="Serial" DataValueField="Serial" EmptyMessage="Nhập ở đây" Filter="StartsWith" HighlightTemplatedItems="True" DropDownWidth="525px">
                <HeaderTemplate>
                    <table cellpadding="0" cellspacing="0" class="auto-style3">
                        <tr>
                            <td style="width: 180px">Số serie</td>
                            <td style="width: 120px">Nhà sản xuất</td>
                            <td style="width: 120px">Hiệu</td>
                            <td style="width: 80px">Cỡ</td>
                        </tr>
                    </table>
                </HeaderTemplate>
                <ItemTemplate>
                    <table cellpadding="0" cellspacing="0" class="auto-style3">
                        <tr>
                            <td style="width: 180px"><%#DataBinder.Eval(Container.DataItem,"Serial") %></td>
                            <td style="width: 120px"><%#DataBinder.Eval(Container.DataItem,"Provider") %></td>
                            <td style="width: 120px"><%#DataBinder.Eval(Container.DataItem,"Marks") %></td>
                            <td style="width: 80px"><%#DataBinder.Eval(Container.DataItem,"Size") %></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="TSeriesDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT [Serial], [Provider], [Marks], [Size] FROM [t_Transmitters] ORDER BY [Serial]"></asp:SqlDataSource>
        </td>
        <td>Giấy kiểm định</td>
        <td>
            <asp:TextBox ID="txtTAccreditation" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>Ngày nhập kho</td>
        <td>
            <telerik:RadDatePicker ID="dtmTReceipt" Runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
            </telerik:RadDatePicker>
        </td>
        <td>Giấy phê duyệt</td>
        <td>
            <asp:TextBox ID="txtTApproval" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>Nhà sản xuất</td>
        <td>
            <telerik:RadComboBox ID="cboTProvider" Runat="server" AllowCustomText="True" DataSourceID="TProvidersDS" DataTextField="Provider" DataValueField="Provider" EmptyMessage="Nhập ở đây" Filter="StartsWith">
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="TProvidersDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Provider] FROM [t_Transmitters] ORDER BY [Provider]"></asp:SqlDataSource>
        </td>
        <td>Ngày phê duyệt</td>
        <td>
            <telerik:RadDatePicker ID="dtmTApproval" Runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
            </telerik:RadDatePicker>
        </td>
    </tr>
    <tr>
        <td>Hiệu</td>
        <td>
            <telerik:RadComboBox ID="cboTMarks" Runat="server" AllowCustomText="True" DataSourceID="TMarksDS" DataTextField="Marks" DataValueField="Marks" EmptyMessage="Nhập ở đây" Filter="StartsWith">
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="TMarksDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Marks] FROM [t_Transmitters] ORDER BY [Marks]"></asp:SqlDataSource>
        </td>
        <td>Đã phê duyệt</td>
        <td>
            <asp:CheckBox ID="chkTApproved" runat="server" />
        </td>
    </tr>
    <tr>
        <td>Cỡ</td>
        <td>
            <telerik:RadComboBox ID="cboTSizes" Runat="server" AllowCustomText="True" DataSourceID="TSizesDS" DataTextField="Size" DataValueField="Size" EmptyMessage="Nhập ở đây" Filter="StartsWith">
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="TSizesDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Size] FROM [t_Transmitters] ORDER BY [Size]"></asp:SqlDataSource>
        </td>
        <td colspan="2">
            <asp:LinkButton ID="LinkButton1" runat="server">Upload/Download Tài liệu bộ hiển thị</asp:LinkButton>
        </td>
    </tr>
    <tr>
        <td>Model</td>
        <td>
            <telerik:RadComboBox ID="cboTModels" Runat="server" AllowCustomText="True" DataSourceID="TModelsDS" DataTextField="Model" DataValueField="Model" EmptyMessage="Nhập ở đây" Filter="StartsWith">
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="TModelsDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Model] FROM [t_Transmitters] ORDER BY [Model]"></asp:SqlDataSource>
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>Tình trạng</td>
        <td>
            <telerik:RadComboBox ID="cboStatus" Runat="server" DataSourceID="StatusDS" DataTextField="Status" DataValueField="Status" DropDownWidth="275" AllowCustomText="True" EmptyMessage="Nhập ở đây" Filter="StartsWith" HighlightTemplatedItems="true" MarkFirstMatch="True">
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
            <asp:CheckBox ID="chkTInstalled" runat="server" />
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td class="auto-style2">Ghi chú</td>
        <td class="auto-style2" colspan="2">
            <asp:TextBox ID="txtTDescription" runat="server" Height="50px" TextMode="MultiLine" Width="225px"></asp:TextBox>
        </td>
        <td class="auto-style2"></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>
            <telerik:RadButton ID="btnTAdd" runat="server" Text="Thêm mới">
            </telerik:RadButton>
        </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
</table>
<br />
<telerik:RadGrid ID="grvTransmitters" runat="server" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowPaging="True" AllowSorting="True" AutoGenerateDeleteColumn="True" AutoGenerateEditColumn="True" CellSpacing="0" DataSourceID="TransmittersDS" GridLines="None" PageSize="20" OnItemCommand="grvTransmitters_ItemCommand">
    <ExportSettings ExportOnlyData="True" FileName="Export_Bo_Hien_Thi" HideStructureColumns="True" IgnorePaging="True" OpenInNewWindow="True">
        <Excel AutoFitImages="True" Format="Biff" />
        <Csv ColumnDelimiter="VerticalBar" />
    </ExportSettings>
    <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True">
    </ClientSettings>
<MasterTableView AutoGenerateColumns="False" DataKeyNames="Serial" DataSourceID="TransmittersDS" CommandItemDisplay="Top">
<CommandItemSettings ExportToPdfText="Export to PDF" ShowExportToExcelButton="True" ShowExportToCsvButton="True" ></CommandItemSettings>

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
        <telerik:GridBoundColumn DataField="Size" DataType="System.Int16" FilterControlAltText="Filter Size column" HeaderText="Cỡ" SortExpression="Size" UniqueName="Size">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Model" FilterControlAltText="Filter Model column" HeaderText="Model" SortExpression="Model" UniqueName="Model">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="Status" FilterControlAltText="Filter Status column" HeaderText="Tình trạng" SortExpression="Status" UniqueName="Status">
        </telerik:GridBoundColumn>
        <telerik:GridCheckBoxColumn DataField="Installed" DataType="System.Boolean" FilterControlAltText="Filter Installed column" HeaderText="Đã lắp đặt" SortExpression="Installed" UniqueName="Installed">
        </telerik:GridCheckBoxColumn>
        <telerik:GridBoundColumn DataField="AccreditationDocument" FilterControlAltText="Filter AccreditationDocument column" HeaderText="Giấy kiểm định" SortExpression="AccreditationDocument" UniqueName="AccreditationDocument">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="ApprovalDecision" FilterControlAltText="Filter ApprovalDecision column" HeaderText="Giấy phê duyệt" SortExpression="ApprovalDecision" UniqueName="ApprovalDecision">
        </telerik:GridBoundColumn>
        <telerik:GridBoundColumn DataField="ApprovedDate" DataType="System.DateTime" FilterControlAltText="Filter ApprovedDate column" HeaderText="Ngày phê duyệt" SortExpression="ApprovedDate" UniqueName="ApprovedDate" DataFormatString="{0:dd/MM/yyyy}">
        </telerik:GridBoundColumn>
        <telerik:GridCheckBoxColumn DataField="Approved" DataType="System.Boolean" FilterControlAltText="Filter Approved column" HeaderText="Đã phê duyệt" SortExpression="Approved" UniqueName="Approved">
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
                    <asp:TextBox ID="txtTSerie1" runat="server" Text='<%#Bind("Serial") %>' Enabled='<%#(Container is GridEditFormInsertItem) ? true : false %>'></asp:TextBox>
                </td>
                <td>Giấy kiểm định</td>
                <td>
                    <asp:TextBox ID="txtTAccreditation1" runat="server" Text='<%#Bind("AccreditationDocument") %>'></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Ngày nhập kho</td>
                <td>
                    <telerik:RadDatePicker ID="dtmTReceipt1" Runat="server" DBSelectedDate='<%#Bind("ReceiptDate") %>' Culture="en-GB">
        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"></Calendar>

        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    </telerik:RadDatePicker>
                </td>
                <td>Giấy phê duyệt</td>
                <td>
                    <asp:TextBox ID="txtTApproval1" runat="server" Text='<%#Bind("ApprovalDecision") %>'></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Nhà sản xuất</td>
                <td>
                    <telerik:RadComboBox ID="cboTProvider1" Runat="server" Text='<%#Bind("Provider") %>' AllowCustomText="True" DataSourceID="TProvidersDS" DataTextField="Provider" DataValueField="Provider" EmptyMessage="Nhập ở đây" Filter="StartsWith">
                    </telerik:RadComboBox>
                </td>
                <td>Ngày phê duyệt</td>
                <td>
                    <telerik:RadDatePicker ID="dtmTApproval1" Runat="server" DBSelectedDate='<%#Bind("ApprovedDate") %>' Culture="en-GB">
        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"></Calendar>

        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td>Hiệu</td>
                <td>
                    <telerik:RadComboBox ID="cboTMarks1" Runat="server" Text='<%#Bind("Marks") %>' AllowCustomText="True" DataSourceID="TMarksDS" DataTextField="Marks" DataValueField="Marks" EmptyMessage="Nhập ở đây" Filter="StartsWith">
                    </telerik:RadComboBox>
                    
                </td>
                <td>Đã phê duyệt</td>
                <td>
                    <asp:CheckBox ID="chkTApproved1" runat="server" Checked='<%#Bind("Approved") %>' />
                </td>
            </tr>
            <tr>
                <td>Cỡ</td>
                <td>
                    <telerik:RadComboBox ID="cboTSizes1" Runat="server" Text='<%#Bind("Size") %>' AllowCustomText="True" DataSourceID="TSizesDS" DataTextField="Size" DataValueField="Size" EmptyMessage="Nhập ở đây" Filter="StartsWith">
                    </telerik:RadComboBox>
                    
                </td>
                <td colspan="2">
                    
                </td>
            </tr>
            <tr>
                <td>Model</td>
                <td>
                    <telerik:RadComboBox ID="cboTModels1" Runat="server" Text='<%#Bind("Model") %>' AllowCustomText="True" DataSourceID="TModelsDS" DataTextField="Model" DataValueField="Model" EmptyMessage="Nhập ở đây" Filter="StartsWith">
                    </telerik:RadComboBox>
                    
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Tình trạng</td>
                <td>
                    <telerik:RadComboBox ID="cboStatus1" Runat="server" Text='<%#Bind("Status") %>' DataSourceID="StatusDS" DataTextField="Status" DataValueField="Status" DropDownWidth="275" AllowCustomText="True" EmptyMessage="Nhập ở đây" Filter="StartsWith" HighlightTemplatedItems="true" MarkFirstMatch="True">
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
                    <asp:CheckBox ID="chkTInstalled1" runat="server" Checked='<%#Bind("Installed") %>' />
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2">Ghi chú</td>
                <td class="auto-style2" colspan="2">
                    <asp:TextBox ID="txtTDescription1" runat="server" Text='<%#Bind("Description") %>' Height="50px" TextMode="MultiLine" Width="225px"></asp:TextBox>
                </td>
                <td class="auto-style2"></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <telerik:RadButton ID="btnTAdd1" runat="server" Text='<%#(Container is GridEditFormInsertItem) ? "Thêm mới" : "Sửa" %>' CommandName='<%#(Container is GridEditFormInsertItem ) ? "PerformInsert" : "Update" %>'>
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnTCancel1" runat="server" Text="Cancel" CausesValidation="false">
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


<asp:SqlDataSource ID="TransmittersDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" DeleteCommand="DELETE FROM [t_Transmitters] WHERE [Serial] = @Serial" InsertCommand="INSERT INTO [t_Transmitters] ([Serial], [ReceiptDate], [Provider], [Marks], [Size], [Model], [Status], [Description], [Installed], [AccreditationDocument], [ApprovalDecision], [ApprovedDate], [Approved]) VALUES (@Serial, @ReceiptDate, @Provider, @Marks, @Size, @Model, @Status, @Description, @Installed, @AccreditationDocument, @ApprovalDecision, @ApprovedDate, @Approved)" SelectCommand="SELECT * FROM [t_Transmitters] ORDER BY [Serial]" UpdateCommand="UPDATE [t_Transmitters] SET [ReceiptDate] = @ReceiptDate, [Provider] = @Provider, [Marks] = @Marks, [Size] = @Size, [Model] = @Model, [Status] = @Status, [Description] = @Description, [Installed] = @Installed, [AccreditationDocument] = @AccreditationDocument, [ApprovalDecision] = @ApprovalDecision, [ApprovedDate] = @ApprovedDate, [Approved] = @Approved WHERE [Serial] = @Serial">
    <DeleteParameters>
        <asp:Parameter Name="Serial" Type="String" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Serial" Type="String" />
        <asp:Parameter Name="ReceiptDate" Type="DateTime" />
        <asp:Parameter Name="Provider" Type="String" />
        <asp:Parameter Name="Marks" Type="String" />
        <asp:Parameter Name="Size" Type="Int16" />
        <asp:Parameter Name="Model" Type="String" />
        <asp:Parameter Name="Status" Type="String" />
        <asp:Parameter Name="Description" Type="String" />
        <asp:Parameter Name="Installed" Type="Boolean" />
        <asp:Parameter Name="AccreditationDocument" Type="String" />
        <asp:Parameter Name="ApprovalDecision" Type="String" />
        <asp:Parameter Name="ApprovedDate" Type="DateTime" />
        <asp:Parameter Name="Approved" Type="Boolean" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="ReceiptDate" Type="DateTime" />
        <asp:Parameter Name="Provider" Type="String" />
        <asp:Parameter Name="Marks" Type="String" />
        <asp:Parameter Name="Size" Type="Int16" />
        <asp:Parameter Name="Model" Type="String" />
        <asp:Parameter Name="Status" Type="String" />
        <asp:Parameter Name="Description" Type="String" />
        <asp:Parameter Name="Installed" Type="Boolean" />
        <asp:Parameter Name="AccreditationDocument" Type="String" />
        <asp:Parameter Name="ApprovalDecision" Type="String" />
        <asp:Parameter Name="ApprovedDate" Type="DateTime" />
        <asp:Parameter Name="Approved" Type="Boolean" />
        <asp:Parameter Name="Serial" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>

<script type="text/javascript">
    function lnkMFiles_OnClientClick() {
        var win = $find('<%= winTFiles.ClientID %>');
        var meter = $find('<%= cboTSeries.ClientID %>').get_text();
        win.show();
    }
</script>

<telerik:RadWindow ID="winTFiles" runat="server" Height="540px" Modal="True" Width="960px">
    <ContentTemplate>
        <uc1:_upload_transmitter ID="_upload_transmitter1" runat="server" />
    </ContentTemplate>
</telerik:RadWindow>




