<%@ Page Title="" Language="C#" MasterPageFile="~/Supervisor/MasterPage.master" AutoEventWireup="true" CodeFile="Complex_TA.aspx.cs" Inherits="Supervisor_Logger_Complex_TA" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }

        .bb {
            font-weight: bold;
            color: #0A5BC4;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>
        <asp:Label ID="lbTitle" runat="server" Text="Bảng giá trị"></asp:Label></h2>

    <div id="search" class="rowGrid">
        <asp:TextBox ID="txtSearchMaster" runat="server" CssClass="TextBox" placeholder="Keyword"></asp:TextBox>
        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"  />
    </div>

    <asp:Repeater ID="ListView1" runat="server">
        <ItemTemplate>
            <div class="col-sm-4 TACol_<%# Container.ItemIndex%3 %>">
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label ID="lbAliasName" runat="server" Text="Alias Name" />:
                    
                    </div>
                    <div class="col-sm-7 ColTABold2">
                        <asp:Label ID="SiteAliasNameLabel" runat="server" Text='<%# Eval("SiteAliasName") %>' class="bb"></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label ID="lbSiteId" runat="server" Text="Site Id"></asp:Label>:
                    </div>
                    <div class="col-sm-7 ColTABold">
                        <asp:Label ID="SiteIdLabel" runat="server" Text='<%# Eval("SiteId") %>'></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label ID="lbTimeStamp" runat="server" Text="TimeStamp"></asp:Label>:
                    </div>
                    <div class="col-sm-7 ">
                        <asp:Label ID="TimeStampLabel" runat="server" Text='<%# Eval("TimeStamp", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label ID="lbPressure1" runat="server" Text="Pressure 1"></asp:Label>:
                    </div>
                    <div class="col-sm-7 ">
                        <asp:Label ID="Pressure1Label" runat="server" Text='<%# Eval("Pressure1", "{0:0.0}") %>' class="bb"></asp:Label>
                        <asp:Label ID="Pressure1UnitLabel" runat="server" Text="(m)"></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label ID="lbPressure2" runat="server" Text="Pressure 2"></asp:Label>:
                    </div>
                    <div class="col-sm-7 ">
                        <asp:Label ID="Pressure2Label" runat="server" Text='<%# Eval("Pressure2", "{0:0.0}") %>' class="bb"></asp:Label>
                        <asp:Label ID="Pressure2UnitLabel" runat="server" Text="(m)"></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label ID="lbForwardFlow" runat="server" Text="Forward Flow"></asp:Label>:
                    </div>
                    <div class="col-sm-7 ">
                        <asp:Label ID="ForwardFlowLabel" runat="server" Text='<%# Eval("ForwardFlow", "{0:0.0}") %>' class="bb"></asp:Label>
                        <asp:Label ID="ForwardFlowUnitLabel" runat="server" Text="(m3/h)"></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label ID="lbReverseFlow" runat="server" Text="Reverse Flow"></asp:Label>:
                    </div>
                    <div class="col-sm-7 ">
                        <asp:Label ID="ReverseFlowLabel" runat="server" Text='<%# Eval("ReverseFlow", "{0:0.0}") %>' class="bb"></asp:Label>
                        <asp:Label ID="ReverseFlowUnitLabel" runat="server" Text="(m3/h)"></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label ID="lbForwardIndex" runat="server" Text="Forward Index"></asp:Label>:
                    </div>
                    <div class="col-sm-7 ">
                        <asp:Label ID="ForwardIndexLabel" runat="server" Text='<%# Eval("ForwardIndex", "{0:,0.0}") %>'></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label ID="lbReverseIndex" runat="server" Text="Reverse Index"></asp:Label>:
                    </div>
                    <div class="col-sm-7 ">
                        <asp:Label ID="ReverseIndexLabel" runat="server" Text='<%# Eval("ReverseIndex", "{0:,0.0}") %>'></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label ID="lbNetIndex" runat="server" Text="Net Index"></asp:Label>:
                    </div>
                    <div class="col-sm-7 ">
                        <asp:Label ID="NetIndexLabel" runat="server" Text='<%#Eval("NetIndex", "{0:,0.0}") %>'></asp:Label>
                    </div>
                </div>

            </div>
        </ItemTemplate>


    </asp:Repeater>


    <div>
        <td>
            <table cellpadding="0" border="0">
                <tr>
                    <td align="right">
                        <asp:LinkButton ID="lbtnFirst" runat="server" CausesValidation="false" OnClick="lbtnFirst_Click">First</asp:LinkButton>
                        &nbsp;</td>
                    <td align="right">
                        <asp:LinkButton ID="lbtnPrevious" runat="server" CausesValidation="false" OnClick="lbtnPrevious_Click">Previous</asp:LinkButton>&nbsp;&nbsp;</td>
                    <td align="center" valign="middle">
                        <asp:DataList ID="dlPaging" runat="server" RepeatDirection="Horizontal" OnItemCommand="dlPaging_ItemCommand"
                            OnItemDataBound="dlPaging_ItemDataBound">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnPaging" runat="server" CommandArgument='<%# Eval("PageIndex") %>'
                                    CommandName="Paging" Text='<%# Eval("PageText") %>'></asp:LinkButton>&nbsp;
                            </ItemTemplate>
                        </asp:DataList>
                    </td>
                    <td align="left">&nbsp;&nbsp;<asp:LinkButton ID="lbtnNext" runat="server" CausesValidation="false"
                        OnClick="lbtnNext_Click">Next</asp:LinkButton></td>
                    <td align="left">&nbsp;
                                <asp:LinkButton ID="lbtnLast" runat="server" CausesValidation="false" OnClick="lbtnLast_Click">Last</asp:LinkButton></td>
                </tr>
                <tr>
                    <td colspan="5" align="center" style="height: 30px" valign="middle">
                        <asp:Label ID="lblPageInfo" runat="server"></asp:Label></td>
                </tr>
            </table>
        </td>
    </div>


    <asp:ObjectDataSource ID="DataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCustomComplexData" TypeName="PMAC.BLL.ComplexDataBL"></asp:ObjectDataSource>
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

    <%-- Pi-Solution --%>
    <script type="text/javascript">
        $(function () {
            $("#ctl00_ctl00_ContentPlaceHolder1_ListView1Panel").css("display", "");
            $("#ctl00_ctl00_ContentPlaceHolder1_ListView1Panel").css("width", "100%");
            $("#ctl00_ctl00_ContentPlaceHolder1_ListView1Panel").css("overflow-x", "auto");
            $(".rowGrid .TextBox").keypress(function (e) {
                if (e.keyCode == 13) {
                    $("#ContentPlaceHolder1_btnSearch").click();
                    return false;
                }
            });
        })
    </script>

</asp:Content>


