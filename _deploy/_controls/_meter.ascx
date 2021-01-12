<%@ control language="C#" autoeventwireup="true" inherits="_controls_meter, App_Web_owkpbb31" %>

<%@ Register src="_upload_meter.ascx" tagname="_upload_meter" tagprefix="uc1" %>
<script type="text/javascript">
    function lnkMFiles_OnClientClick(){
        var win = $find('<%= wMFiles.ClientID %>');
        var meter = $find('<%= cboMSeries.ClientID %>').get_text();
        win.show();
    }
</script>
<table style="width:100%">
    <tr>
        <td>Số serie</td>
        <td>
            <telerik:RadComboBox ID="cboMSeries" Runat="server" AllowCustomText="True" DataSourceID="MSeriesDS" DataTextField="Serial" DataValueField="Serial" EmptyMessage="Nhập ở đây" Filter="StartsWith" HighlightTemplatedItems="True" DropDownWidth="525px">
                <HeaderTemplate>
                    <table style="width:500px" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="width: 180px">Số serie</td>
                            <td style="width: 120px">Nhà sản xuất</td>
                            <td style="width: 120px">Hiệu</td>
                            <td style="width: 80px">Cỡ</td>
                        </tr>
                    </table>
                </HeaderTemplate>
                <ItemTemplate>
                    <table style="width:500px" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="width: 180px"><%# DataBinder.Eval(Container.DataItem,"Serial") %></td>
                            <td style="width: 120px"><%# DataBinder.Eval(Container.DataItem,"Provider") %></td>
                            <td style="width: 120px"><%# DataBinder.Eval(Container.DataItem,"Marks") %></td>
                            <td style="width: 80px"><%# DataBinder.Eval(Container.DataItem,"Size") %></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="MSeriesDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT [Serial], [Provider], [Marks], [Size] FROM [t_Meters] ORDER BY [Serial]"></asp:SqlDataSource>
        </td>
        <td>Giấy kiểm định</td>
        <td>
            <asp:TextBox ID="txtMAccreditation" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>Ngày nhập kho</td>
        <td>
            <telerik:RadDatePicker ID="dtmMReceipt" Runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
            </telerik:RadDatePicker>
        </td>
        <td>Phê duyệt mẫu</td>
        <td>
            <asp:TextBox ID="txtMApproval" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>Nhà sản xuất</td>
        <td>
            <telerik:RadComboBox ID="cboMProviders" Runat="server" AllowCustomText="True" DataSourceID="MProvidersDS" DataTextField="Provider" DataValueField="Provider" EmptyMessage="Nhập ở đây" Filter="StartsWith">
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="MProvidersDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Provider] FROM [t_Meters] ORDER BY [Provider]"></asp:SqlDataSource>
        </td>
        <td>Ngày phê duyệt</td>
        <td>
            <telerik:RadDatePicker ID="dtmMApproval" Runat="server" Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
            </telerik:RadDatePicker>
        </td>
    </tr>
    <tr>
        <td>Hiệu</td>
        <td>
            <telerik:RadComboBox ID="cboMMarks" Runat="server" AllowCustomText="True" DataSourceID="MMarksDS" DataTextField="Marks" DataValueField="Marks" EmptyMessage="Nhập ở đây" Filter="StartsWith">
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="MMarksDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Marks] FROM [t_Meters] ORDER BY [Marks]"></asp:SqlDataSource>
        </td>
        <td>Đã phê duyệt</td>
        <td>
            <asp:CheckBox ID="chkMApproval" runat="server" />
        </td>
    </tr>
    <tr>
        <td>Cỡ</td>
        <td>
            <telerik:RadComboBox ID="cboMSizes" Runat="server" AllowCustomText="True" DataSourceID="MSizesDS" DataTextField="Size" DataValueField="Size" EmptyMessage="Nhập ở đây" Filter="StartsWith">
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="MSizesDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Size] FROM [t_Meters] ORDER BY [Size]"></asp:SqlDataSource>
        </td>
        <td colspan="2">
            <asp:LinkButton ID="lnkMFiles" runat="server" CausesValidation="False" OnClientClick="lnkMFiles_OnClientClick();return false;">Upload/Download Tài liệu đồng hồ</asp:LinkButton>
        </td>
    </tr>
    <tr>
        <td>Model</td>
        <td>
            <telerik:RadComboBox ID="cboMModels" Runat="server" AllowCustomText="True" DataSourceID="MModelsDS" DataTextField="Model" DataValueField="Model" EmptyMessage="Nhập ở đây" Filter="StartsWith">
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="MModelsDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" SelectCommand="SELECT DISTINCT [Model] FROM [t_Meters] ORDER BY [Model]"></asp:SqlDataSource>
        </td>
        <td>
            &nbsp;</td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td>Tình trạng</td>
        <td>
            <telerik:RadComboBox ID="cboMStatus" Runat="server" AllowCustomText="True" DataSourceID="StatusDS" DataTextField="Status" DataValueField="Status" EmptyMessage="Nhập ở đây" Filter="StartsWith" HighlightTemplatedItems="True" DropDownWidth="275px" MarkFirstMatch="True">
                <HeaderTemplate>
                    <table style="width:250px" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="width: 100px">Tình trạng</td>
                            <td style="width: 150px">Mô tả</td>
                        </tr>
                    </table>
                </HeaderTemplate>
                <ItemTemplate>
                    <table style="width:250px" cellpadding="0" cellspacing="0">
                        <tr>
                            <td style="width: 100px"><%# DataBinder.Eval(Container.DataItem,"Status") %></td>
                            <td style="width: 150px"><%# DataBinder.Eval(Container.DataItem,"Description") %></td>
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
        <td class="auto-style2">Đã lắp đặt</td>
        <td class="auto-style2">
            <asp:CheckBox ID="chkMInstalled" runat="server" />
        </td>
        <td class="auto-style2"></td>
        <td class="auto-style2"></td>
    </tr>
    <tr>
        <td>Ghi chú</td>
        <td colspan="2">
            <asp:TextBox ID="txtMDescription" runat="server" Height="50px" TextMode="MultiLine" Width="225px"></asp:TextBox>
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="2">
            <telerik:RadButton ID="btnMAdd" runat="server" Text="Thêm mới">
            </telerik:RadButton>
        </td>
        <td>&nbsp;</td>
    </tr>
</table>
<br />
<telerik:RadGrid ID="grvM" runat="server" CellSpacing="0" DataSourceID="SitesDS" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateDeleteColumn="True" AutoGenerateEditColumn="True" PageSize="20" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" OnItemCommand="grvM_ItemCommand">
    <ExportSettings ExportOnlyData="True" FileName="Export_Dong_Ho" HideStructureColumns="True" IgnorePaging="True" OpenInNewWindow="True">
        <Pdf PaperSize="A4" />
        <Excel AutoFitImages="True" Format="Biff" />
        <Csv ColumnDelimiter="VerticalBar" EncloseDataWithQuotes="False" />
    </ExportSettings>
    <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True">
    </ClientSettings>
<MasterTableView AutoGenerateColumns="False" DataKeyNames="Serial" DataSourceID="SitesDS" Width="100%" CommandItemDisplay="Top" AllowAutomaticInserts="False">
<CommandItemSettings ExportToPdfText="Export to PDF" ShowExportToExcelButton="True" ShowExportToCsvButton="True" AddNewRecordText="Thêm mới record"></CommandItemSettings>

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
        <telerik:GridCheckBoxColumn DataField="Installed" DataType="System.Boolean" FilterControlAltText="Filter Installed column" HeaderText="Lắp đặt" SortExpression="Installed" UniqueName="Installed">
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

<EditFormSettings EditFormType="Template">
<EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
    <FormTemplate>
        <table style="width:100%">
            <tr>
                <td>Số serie</td>
                <td>
                    <asp:TextBox ID="txtMSerie1" runat="server" Text='<%#Bind("Serial") %>' Enabled='<%#(Container is GridEditFormInsertItem) ? true : false %>'></asp:TextBox>
                </td>
                <td>Giấy kiểm định</td>
                <td>
                    <asp:TextBox ID="txtMAccreditation1" runat="server" Text='<%#Bind("AccreditationDocument") %>'></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Ngày nhập kho</td>
                <td>
                    <telerik:RadDatePicker ID="dtmMReceipt1" Runat="server" Culture="en-GB" DBSelectedDate='<%#Bind("ReceiptDate") %>'>
        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"></Calendar>

        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                    </telerik:RadDatePicker>
                </td>
                <td>
                    Phê duyệt mẫu
                </td>
                <td>
                     <asp:TextBox ID="txtMApproval1" runat="server" Text='<%#Bind("ApprovalDecision") %>'></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Nhà sản xuất</td>
                <td>
                    <telerik:RadComboBox ID="cboMProviders1" Runat="server" Text='<%#Bind("Provider") %>' AllowCustomText="True" DataSourceID="MProvidersDS" DataTextField="Provider" DataValueField="Provider" EmptyMessage="Nhập ở đây" Filter="StartsWith">
                    </telerik:RadComboBox>
                </td>
                <td>Ngày phê duyệt</td>
                <td>
                   <telerik:RadDatePicker ID="dtmMApproval1" Runat="server" DBSelectedDate='<%#Bind("ApprovedDate") %>' Culture="en-GB">
<Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"></Calendar>

<DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>

<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
            </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td>Hiệu</td>
                <td>
                    <telerik:RadComboBox ID="cboMMarks1" Runat="server" Text='<%#Bind("Marks") %>' AlowCustomText="True" DataSourceID="MMarksDS" DataTextField="Marks" DataValueField="Marks" EmptyMessage="Nhập ở đây" Filter="StartsWith">
                    </telerik:RadComboBox>
                </td>
                <td>Đã phê duyệt</td>
                <td>
                    <asp:CheckBox ID="chkMApproval1" runat="server" Checked='<%#Bind("Approved") %>' />
                </td>
            </tr>
            <tr>
                <td>Cỡ</td>
                <td>
                    <telerik:RadComboBox ID="cboMSizes1" Runat="server" Text='<%#Bind("Size") %>' AllowCustomText="True" DataSourceID="MSizesDS" DataTextField="Size" DataValueField="Size" EmptyMessage="Nhập ở đây" Filter="StartsWith">
                    </telerik:RadComboBox>
                </td>
                <td></td>
                <td>
                    
                </td>
            </tr>
            <tr>
                <td>Model</td>
                <td>
                    <telerik:RadComboBox ID="cboMModels1" Runat="server" Text='<%#Bind("Model") %>' AllowCustomText="True" DataSourceID="MModelsDS" DataTextField="Model" DataValueField="Model" EmptyMessage="Nhập ở đây" Filter="StartsWith">
                    </telerik:RadComboBox>
                </td>
                <td colspan="2">
                    
                </td>
            </tr>
            <tr>
                <td>Tình trạng</td>
                <td>
                    <telerik:RadComboBox ID="cboMStatus1" Runat="server" Text='<%#Bind("Status") %>' AllowCustomText="True" DataSourceID="StatusDS" DataTextField="Status" DataValueField="Status" EmptyMessage="Nhập ở đây" Filter="StartsWith" HighlightTemplatedItems="True" DropDownWidth="275px" MarkFirstMatch="True">
                        <HeaderTemplate>
                            <table style="width:250px" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 100px">Tình trạng</td>
                                    <td style="width: 150px">Mô tả</td>
                                </tr>
                            </table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table style="width:250px" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 100px"><%# DataBinder.Eval(Container.DataItem,"Status") %></td>
                                    <td style="width: 150px"><%# DataBinder.Eval(Container.DataItem,"Description") %></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style2">Đã lắp đặt</td>
                <td class="auto-style2">
                    <asp:CheckBox ID="chkMInstalled1"  Checked='<%# Bind("Installed") %>' runat="server" />
                </td>
                <td class="auto-style2"></td>
                <td class="auto-style2"></td>
            </tr>
            <tr>
                <td>Ghi chú</td>
                <td colspan="2">
                    <asp:TextBox ID="txtMDescription1" runat="server" Text='<%#Bind("Description") %>' Height="50px" TextMode="MultiLine" Width="225px"></asp:TextBox>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td colspan="2">
                    <telerik:RadButton ID="btnMAdd1" runat="server" Text='<%#(Container is GridEditFormInsertItem) ? "Thêm mới" : "Sửa" %>' CommandName='<%#(Container is GridEditFormInsertItem ) ? "PerformInsert" : "Update" %>'>
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnMCancel1" runat="server" Text="Cancel" CausesValidation="false" CommandName="Cancel">
                    </telerik:RadButton>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </FormTemplate>
</EditFormSettings>

<PagerStyle PageSizeControlType="RadComboBox" AlwaysVisible="True"></PagerStyle>
</MasterTableView>

    <HeaderStyle Font-Underline="True" />

<PagerStyle PageSizeControlType="RadComboBox"></PagerStyle>

<FilterMenu EnableImageSprites="False"></FilterMenu>
</telerik:RadGrid>
<asp:SqlDataSource ID="SitesDS" runat="server" ConnectionString="<%$ ConnectionStrings:DbConnectionString %>" DeleteCommand="DELETE FROM [t_Meters] WHERE [Serial] = @Serial" InsertCommand="INSERT INTO [t_Meters] ([Serial], [ReceiptDate], [Provider], [Marks], [Size], [Model], [Status], [Description], [Installed], [AccreditationDocument], [ApprovalDecision], [ApprovedDate], [Approved]) VALUES (@Serial, @ReceiptDate, @Provider, @Marks, @Size, @Model, @Status, @Description, @Installed, @AccreditationDocument, @ApprovalDecision, @ApprovedDate, @Approved)" SelectCommand="SELECT * FROM [t_Meters] ORDER BY [Serial]" UpdateCommand="UPDATE [t_Meters] SET [ReceiptDate] = @ReceiptDate, [Provider] = @Provider, [Marks] = @Marks, [Size] = @Size, [Model] = @Model, [Status] = @Status, [Description] = @Description, [Installed] = @Installed, [AccreditationDocument] = @AccreditationDocument, [ApprovalDecision] = @ApprovalDecision, [ApprovedDate] = @ApprovedDate, [Approved] = @Approved WHERE [Serial] = @Serial">
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


<telerik:RadWindow ID="wMFiles" runat="server" Height="540px" Modal="True" Title="Upload file đồng hồ" Width="960px">
    <ContentTemplate>
        <uc1:_upload_meter ID="_upload_meter1" runat="server" />
    </ContentTemplate>
</telerik:RadWindow>



