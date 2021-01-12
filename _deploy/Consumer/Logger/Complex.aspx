<%@ page title="" language="C#" masterpagefile="~/Consumer/MasterPage.master" autoeventwireup="true" inherits="Consumer_Logger_Complex, App_Web_fhgam4td" theme="Default" %>
<asp:Content ID="Content3" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .bb {
            font-weight:bold;
            color: #0A5BC4;
        }
    </style>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Bảng giá trị</h2>
    <asp:ListView ID="ListView1" runat="server" GroupItemCount="4">
        <AlternatingItemTemplate>
            <td id="Td1" runat="server" style="background-color: #FFFFFF; color: #284775;">
                <table class="auto-style1">
                    <tr>
                        <td >Alias Name:</td>
                        <td>
                            <asp:Label ID="SiteAliasNameLabel" runat="server" Text='<%# Eval("SiteAliasName") %>' class="bb"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Site Id:</td>
                        <td>
                            <asp:Label ID="SiteIdLabel" runat="server" Text='<%# Eval("SiteId") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>TimeStamp:</td>
                        <td>
                            <asp:Label ID="TimeStampLabel" runat="server" Text='<%# Eval("TimeStamp", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Pressure 1:</td>
                        <td>
                            <asp:Label ID="Pressure1Label" runat="server" Text='<%# Eval("Pressure1", "{0:0.0}") %>' class="bb"></asp:Label>
                            <asp:Label ID="Pressure1UnitLabel" runat="server" Text="(m)"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Pressure 2:</td>
                        <td>
                            <asp:Label ID="Pressure2Label" runat="server" Text='<%# Eval("Pressure2", "{0:0.0}") %>' class="bb"></asp:Label>
                            <asp:Label ID="Pressure2UnitLabel" runat="server" Text="(m)"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Forward Flow:</td>
                        <td>
                            <asp:Label ID="ForwardFlowLabel" runat="server" Text='<%# Eval("ForwardFlow", "{0:0.0}") %>' class="bb"></asp:Label>
                            <asp:Label ID="ForwardFlowUnitLabel" runat="server" Text="(m3/h)"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Reverse Flow:</td>
                        <td>
                            <asp:Label ID="ReverseFlowLabel" runat="server" Text='<%# Eval("ReverseFlow", "{0:0.0}") %>' class="bb"></asp:Label>
                            <asp:Label ID="ReverseFlowUnitLabel" runat="server" Text="(m3/h)"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Forwar Index:</td>
                        <td>
                            <asp:Label ID="ForwardIndexLabel" runat="server" Text='<%# Eval("ForwardIndex", "{0:,0.0}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Reverse Index:</td>
                        <td>
                            <asp:Label ID="ReverseIndexLabel" runat="server" Text='<%# Eval("ReverseIndex", "{0:,0.0}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Net Index:</td>
                        <td>
                            <asp:Label ID="NetIndexLabel" runat="server" Text='<%#Eval("NetIndex", "{0:,0.0}") %>'></asp:Label>
                        </td>
                    </tr>
                </table>
                </td>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <EmptyItemTemplate>
<td id="Td2" runat="server" />
        </EmptyItemTemplate>
        <GroupTemplate>
            <tr id="itemPlaceholderContainer" runat="server">
                <td id="itemPlaceholder" runat="server"></td>
            </tr>
        </GroupTemplate>
        <InsertItemTemplate>
            
        </InsertItemTemplate>
        <ItemTemplate>
            <td id="Td3" runat="server" style="background-color: #E0FFFF;color: #333333;">
                <table class="auto-style1">
                    <tr>
                        <td>Alias Name:</td>
                        <td>
                            <asp:Label ID="SiteAliasNameLabel" runat="server" Text='<%# Eval("SiteAliasName") %>' class="bb"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Site Id:</td>
                        <td>
                            <asp:Label ID="SiteIdLabel" runat="server" Text='<%# Eval("SiteId") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>TimeStamp:</td>
                        <td>
                            <asp:Label ID="TimeStampLabel" runat="server" Text='<%# Eval("TimeStamp", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Pressure 1:</td>
                        <td>
                            <asp:Label ID="Pressure1Label" runat="server" Text='<%# Eval("Pressure1", "{0:0.0}") %>' class="bb"></asp:Label>
                            <asp:Label ID="Pressure1UnitLabel" runat="server" Text="(m)"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Pressure 2:</td>
                        <td>
                            <asp:Label ID="Pressure2Label" runat="server" Text='<%# Eval("Pressure2", "{0:0.0}") %>' class="bb"></asp:Label>
                            <asp:Label ID="Pressure2UnitLabel" runat="server" Text="(m)"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Forward Flow:</td>
                        <td>
                            <asp:Label ID="ForwardFlowLabel" runat="server" Text='<%# Eval("ForwardFlow", "{0:0.0}") %>' class="bb"></asp:Label>
                            <asp:Label ID="ForwardFlowUnitLabel" runat="server" Text="(m3/h)"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Reverse Flow:</td>
                        <td>
                            <asp:Label ID="ReverseFlowLabel" runat="server" Text='<%# Eval("ReverseFlow", "{0:0.0}") %>' class="bb"></asp:Label>
                            <asp:Label ID="ReverseFlowUnitLabel" runat="server" Text="(m3/h)"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Forward Index:</td>
                        <td>
                            <asp:Label ID="ForwardIndexLabel" runat="server" Text='<%# Eval("ForwardIndex", "{0:,0.0}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Reverse Index:</td>
                        <td>
                            <asp:Label ID="ReverseIndexLabel" runat="server" Text='<%# Eval("ReverseIndex", "{0:,0.0}") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Net Index:</td>
                        <td>
                            <asp:Label ID="NetIndexLabel" runat="server" Text='<%#Eval("NetIndex", "{0:,0.0}") %>'></asp:Label>
                        </td>
                    </tr>
                </table>
                </td>
        </ItemTemplate>
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td4" runat="server">
                        <table id="groupPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="groupPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="Tr2" runat="server">
                    <td id="Td5" runat="server" style="text-align: center;background-color: #5D7B9D;font-family: Verdana, Arial, Helvetica, sans-serif;color: #FFFFFF"></td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            
        </SelectedItemTemplate>
    </asp:ListView>
    <asp:ObjectDataSource ID="DataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCustomComplexDataForStaff" TypeName="PMAC.BLL.ComplexDataBL" OnSelecting="DataSource1_Selecting">
        <SelectParameters>
            <asp:Parameter Name="staffId" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="DataSource2" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCustomComplexDataForConsumer" TypeName="PMAC.BLL.ComplexDataBL" OnSelecting="DataSource2_Selecting">
        <SelectParameters>
            <asp:Parameter Name="consumerId" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Timer ID="Timer1" runat="server" Interval="600000" OnTick="Timer1_Tick">
    </asp:Timer>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Timer1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ListView1" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
</asp:Content>