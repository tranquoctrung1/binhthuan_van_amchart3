<%--<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MapJS_rev1_DMA.aspx.cs" Inherits="Supervisor_Logger_MapJS_rev1" %>--%>

<%@ Page Title="" Language="C#" MasterPageFile="~/Empty.master" AutoEventWireup="true" CodeFile="MapJS_rev1_DMA.aspx.cs" Inherits="Supervisor_Logger_MapJS_rev1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <head>
        <title></title>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDA3cP077EpuyzRQvX-Ec97n2x6Dm-fnTc&callback=initMap"></script>
        <script src="../../js/markerwithlabel.js"></script>
        <script src="../../js/ContextMenu.js"></script>
        <script src="../../js/jquery-1.7.2.min.js"></script>
        <script src="../../js/amcharts/amcharts.js"></script>
        <script src="../../js/amcharts/serial.js"></script>
        <script src="../../js/amcharts/exporting/amexport.js"></script>
        <script src="../../js/amcharts/exporting/canvg.js"></script>
        <script src="../../js/amcharts/exporting/filesaver.js"></script>
        <script src="../../js/amcharts/exporting/jspdf.js"></script>
        <script src="../../js/amcharts/exporting/jspdf.plugin.addimage.js"></script>
        <script src="../../js/amcharts/exporting/rgbcolor.js"></script>
        <script src="../../js/randomColor.js"></script>
        <script src="../../js/arcgislink.js"></script>
        <link href="../../App_Themes/common.css" rel="stylesheet" />
        <style type="text/css">
            html, body, form, #content, #map_canvas {
                padding: 0;
                margin: 0;
                height: 100%;
            }

            .auto-style1 {
                width: 50%;
            }

            .auto-style2 {
                width: 18px;
            }

            .tCenter {
                text-align: center
            }

            .tBold {
                font-weight: bold
            }

            .myRadWindowR {
                position: fixed !important;
                top: 0 !important;
                right: 0;
            }

            .myRadWindow {
                position: fixed !important;
                top: auto !important;
                bottom: 0;
                margin: 0 auto;
            }

            #chart_table table {
                width: 96%;
                padding-left: 15px;
            }

                #chart_table table th, #chart_table table td {
                    text-align: center;
                    padding: 5px 7px;
                }

                #chart_table table th {
                    background: #999;
                    color: #fff;
                }

                #chart_table table td {
                    border-bottom: 1px solid #eee;
                }

                    #chart_table table td.row-title {
                        font-weight: bold;
                    }

            #chart_table_MNF table {
                width: 96%;
                padding-left: 15px;
            }

                #chart_table_MNF table th, #chart_table_MNF table td {
                    text-align: center;
                    padding: 5px 7px;
                }

                #chart_table_MNF table th {
                    background: #999;
                    color: #fff;
                }

                #chart_table_MNF table td {
                    border-bottom: 1px solid #eee;
                }

                    #chart_table_MNF table td.row-title {
                        font-weight: bold;
                    }

            #chart_table_Flow table {
                width: 96%;
                padding-left: 15px;
            }


                #chart_table_Flow table th, #chart_table_Flow table td {
                    text-align: center;
                    padding: 5px 7px;
                }

                #chart_table_Flow table th {
                    background: #999;
                    color: #fff;
                }

                #chart_table_Flow table td {
                    border-bottom: 1px solid #eee;
                }

                    #chart_table_Flow table td.row-title {
                        font-weight: bold;
                    }




            #chart_table_MinMax table {
                width: 96%;
                padding-left: 15px;
            }


                #chart_table_MinMax table th, #chart_table_MinMax table td {
                    text-align: center;
                    padding: 5px 7px;
                }

                #chart_table_MinMax table th {
                    background: #999;
                    color: #fff;
                }

                #chart_table_MinMax table td {
                    border-bottom: 1px solid #eee;
                }

                    #chart_table_MinMax table td.row-title {
                        font-weight: bold;
                    }

            .gm-style-iw-d {
                overflow: hidden !important;
            }
        </style>

    </head>
    <body>
        <form id="form1">


            <div id="wrapper">
                <div class="main-wrapper">
                    <div class="app" id="app">
                        <header class="header">
                    <div class="header-block header-block-collapse d-lg-none d-xl-none">
                        <button class="collapse-btn" id="sidebar-collapse-btn">
                            <i class="fa fa-bars"></i>
                        </button>
                    </div>
    
                    <div class="header-block header-block-buttons">
                        <a href="#" id="MenuCollapse">
                            <i class="fa fa-bars"></i>
                        </a>
                          <asp:Label ID="lbPageTitle" runat="server" Text="Viwater hệ thống SCADA quản lý mạng lưới cấp nước"></asp:Label>                        
                    </div>

                    <div class="header-block header-block-nav">
                        <ul class="nav-profile">
                            <asp:DropDownList ID="DropDownList_Language" runat="server"
                                    onselectedindexchanged="DropDownList_Language_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Text="Vietnamese" Value="vi"></asp:ListItem>
                                    <asp:ListItem Text="English" Value="en"></asp:ListItem>
                                    <asp:ListItem Text="Other" Value="other"></asp:ListItem>
                                </asp:DropDownList>

                            <li class="profile dropdown HeaderLogout">
                                <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="true">
                                    <i class="fa fa-user" style="font-size:24px"></i>
                                    <span class="name"> 
                                        <asp:Label ID="lbUserName" runat="server" Text="User's name"></asp:Label>
                                    </span>
                                </a>
                                <div id="LogoutRegion" class="dropdown-menu profile-dropdown-menu" aria-labelledby="dropdownMenu1" style="position: absolute; transform: translate3d(-87px, 25px, 0px); top: 0px; left: 0px; will-change: transform;">                                                     
                                    <a class="dropdown-item" href="/Supervisor/Account/ChangePassword.aspx">
                                        <i class="fa fa-gear icon"></i> 
                                        <asp:Label ID="lbChangePassword" runat="server" Text="Đổi Mật Khẩu"></asp:Label>                    
                                    </a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" id="btnLogout" href="#">
                                        <i class="fa fa-power-off icon"></i> Logout </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </header>


                        <aside class="sidebar">
                    <div class="sidebar-container">
                        <div class="sidebar-header">
                            <div class="brand">
                                <img src="#" alt="Smiley face" height="25" width="45" runat="server" id="imgLogo">
                                 <asp:Label ID="lbCompany" runat="server" Text="TAWACO"></asp:Label> </div>
                        </div>

                            <nav class="menu" >
                                <ul class="sidebar-menu metismenu" id="sidebar-menu" >
                                    <li>
                                        <a href="/Supervisor/Logger/MapJS_rev1.aspx"  class="privilege">
                                            <i class="fa fa-home"></i> 
                                            <asp:Label ID="lbGeneralMap" runat="server" Text="Bản Đồ Tổng Thể"></asp:Label>                    
                                        </a>
                                    </li>
                                    <li class="active open" id="MapJS_rev1_DMA">
                                        <a href="/Supervisor/Logger/MapJS_rev1_DMA.aspx"  class="privilege">
                                            <i class="fa fa-home"></i> 
                                            <asp:Label ID="lbDMAMap" runat="server" Text="Bản Đồ DMA"></asp:Label>                    
                                        </a>
                                       <ul class="sidebar-nav collapse in" aria-expanded="true">                                      
                                        <li>                                          
                                            <telerik:RadTreeView ID="radTreeViewSite" Runat="server" EnableDragAndDrop="true" EnableDragAndDropBetweenNodes="false" OnClientNodeDropping="radTreeViewSite_NodeDropping" OnClientNodeClicked="radTreeViewSite_NodeClicked">
                                            </telerik:RadTreeView>
                                        </li>
                                        </ul>
                                    </li>
                                    <li >
                                    <a href="#DuLieu" class="privilege">
                                        <i class="fa fa-th-large"></i> 
                                        <asp:Label ID="lbData" runat="server" Text="Dữ Liệu"></asp:Label>                    
                                        <i class="fa arrow"></i>
                                    </a>
                                    <ul class="sidebar-nav">
                                        <li>
                                            <a href="/Supervisor/Logger/Complex_TA.aspx"> 
                                                <asp:Label ID="lbDataTable" runat="server" Text="Bảng Giá Trị"></asp:Label>                    
                                            </a>
                                        </li>
                                        <li>
                                            <a href="/Supervisor/Logger/Daily_Monthly.aspx"> 
                                                <asp:Label ID="lbLoggerData" runat="server" Text="Dữ Liệu Logger"></asp:Label>                     

                                            </a>
                                        </li>
                                        <li>
                                            <a href="/Supervisor/ManualData/Add_Change.aspx">  
                                                <asp:Label ID="lbManualData" runat="server" Text="Dữ Liệu Nhập Tay"></asp:Label>    
                                            </a>
                                        </li>
                                        <li>
                                            <a href="/Supervisor/Logger/MinMaxVal.aspx"> 
                                                <asp:Label ID="lbMinMaxValues" runat="server" Text="Giá Trị Min Max"></asp:Label>    
                                            </a>
                                        </li>
                                    </ul>
                                    </li>                                
                                <li >
                                    <a href="#BaoCao" class="privilege">
                                        <i class="fa fa-table"></i> 
                                        <asp:Label ID="lbReport" runat="server" Text="Báo Cáo"></asp:Label>    
                                        <i class="fa arrow"></i>
                                    </a>
                                    <ul class="sidebar-nav">
                                        <li>
                                            <a href="/Supervisor/Report/Press.aspx">  
                                                <asp:Label ID="lbPressure" runat="server" Text="Áp Lực"></asp:Label>    
                                            </a>
                                        </li>
                                        <li>
                                            <a href="/Supervisor/Report/Montly.aspx">  
                                                <asp:Label ID="lbVolume" runat="server" Text="Sản Lượng"></asp:Label>    
                                            </a>
                                        </li>
                                    </ul>
                                </li>                                
                                <li>
                                    <a href="#ThietBiVaViTriLapDat"  class="privilege">
                                        <i class="fa fa-desktop"></i> 
                                        <asp:Label ID="blEAndsL" runat="server" Text="T/Bị & V/Trí Lắp Đặt"></asp:Label>
                                        <i class="fa arrow"></i>
                                    </a>
                                    <ul class="sidebar-nav">
                                        <li>
                                            <a href="/Supervisor/Device/All.aspx">  
                                                <asp:Label ID="lbEquipments" runat="server" Text="Thiết Bị"></asp:Label>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="/Supervisor/Site/Config.aspx">  
                                                <asp:Label ID="lbInstallationPoints" runat="server" Text="Điểm Lắp Đặt"></asp:Label>
                                            </a>
                                        </li>                                        
                                    </ul>
                                </li>
                                
                                <li>
                                    <a href="#QuanLyNguoiDung" class="privilege">
                                        <i class="fa fa-sitemap"></i> 
                                        <asp:Label ID="lbAdminPanel" runat="server" Text="Admin Panel"></asp:Label>
                                        <i class="fa arrow"></i>
                                    </a>
                                    <ul class="sidebar-nav">                                        
                                        <li>
                                            <a href="/Supervisor/Admin/ViewUsers.aspx">  
                                                <asp:Label ID="lbViewUserDetails" runat="server" Text="Xem Người Dùng"></asp:Label>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="/Supervisor/Admin/CreateUser.aspx"> 
                                                <asp:Label ID="lbCreateUsers" runat="server" Text="Tạo Mới Người Dùng"></asp:Label>
                                            </a>                                                                                        
                                        </li>
                                        <li>
                                            <a href="/Supervisor/Admin/SettingSMS.aspx"> 
                                                <asp:Label ID="lbMessageSettings" runat="server" Text="Cài Đặt Tin Nhắn"></asp:Label>
                                            </a>                                                                                        
                                        </li>
                                    </ul>
                                </li>
                                
                                <li >
                                    <a href="#QuanLyNgonNgu" class="privilege">
                                        <i class="fa fa-sitemap"></i> 
                                        <asp:Label ID="lbLanguageManagement" runat="server" Text="Quản Lý Ngôn Ngữ"></asp:Label>
                                        <i class="fa arrow"></i>
                                    </a>
                                    <ul class="sidebar-nav">                                        
                                        <li>
                                            <a href="/Supervisor/Language/ChangeFunction.aspx">  
                                                <asp:Label ID="lbFunctions" runat="server" Text="Tính Năng"></asp:Label>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="/Supervisor/Language/ChangeContent.aspx"> 
                                                <asp:Label ID="lbContents" runat="server" Text="Nội Dung Chi Tiết"></asp:Label>
                                            </a>                                                                                        
                                        </li>
                                    </ul>
                                </li>
                                <li >
                                    <a href="#QuanLyHeThong" class="privilege">
                                        <i class="fa fa-sitemap"></i> 
                                        <asp:Label ID="lbConfigSystem" runat="server" Text="Quản Lý Hệ Thống"></asp:Label>
                                        <i class="fa arrow"></i>
                                    </a>
                                    <ul class="sidebar-nav">                                        
                                        <li>
                                            <a href="/Supervisor/System/General.aspx">  
                                                <asp:Label ID="lbGeneralSystem" runat="server" Text="Hệ Thống Chung"></asp:Label>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="/Supervisor/System/Users.aspx">  
                                                <asp:Label ID="lbUserManagement" runat="server" Text="Quản lý tài khoản"></asp:Label>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="/Supervisor/System/Roles.aspx">  
                                                <asp:Label ID="lbRoleManagement" runat="server" Text="Quản lý vai trò người dùng"></asp:Label>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="/Supervisor/System/RoleFunction.aspx">  
                                                <asp:Label ID="lbRoleFunctionManagement" runat="server" Text="Quản lý quyền truy cập"></asp:Label>
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </nav>
                        <asp:HiddenField ID="hidListMenu" runat="server" Value="" />
                    </div>
                    
                </aside>
                        <div class="sidebar-overlay" id="sidebar-overlay"></div>
                        <div class="sidebar-mobile-menu-handle" id="sidebar-mobile-menu-handle"></div>
                        <div class="mobile-menu-handle"></div>

                        <div id="content" style="height: 100%; padding: 60px 0px 0px 10px">
                            <telerik:RadScriptManager ID="RadScriptManager1">
                            </telerik:RadScriptManager>

                            <telerik:RadSplitter ID="RadSplitter1" runat="server" Height="470px" Width="100%">
                                <%-- Pi-Solution Developer --%>
                                <telerik:RadPane ID="RadPane1" runat="server" Width="0px" Height="100%">
                                    <telerik:RadSlidingZone ID="RadSlidingZone1" runat="server" DockedPaneId="RadSlidingPane1" ExpandedPaneId="RadSlidingPane1">
                                        <telerik:RadSlidingPane ID="RadSlidingPane1" runat="server" Width="0px" Title="Sites">
                                        </telerik:RadSlidingPane>
                                        <telerik:RadSlidingPane Visible="false" ID="RadSlidingPane2" runat="server" Width="0px" Title="Menu">
                                            <telerik:RadTreeView ID="radTreeViewSiteMap" runat="server" DataSourceID="SiteMapDataSource1" OnClientLoad="radTreeViewSiteMap_Load">
                                            </telerik:RadTreeView>
                                            <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" ShowStartingNode="False" />
                                            <asp:LoginName ID="LoginName1" runat="server" Width="0" ForeColor="White" />
                                            <asp:LoginStatus ID="LoginStatus1" runat="server" />
                                        </telerik:RadSlidingPane>
                                    </telerik:RadSlidingZone>
                                </telerik:RadPane>
                                <telerik:RadPane ID="RadPane2" runat="server" Height="99%">
                                    <div id="map_canvas">
                                    </div>
                                </telerik:RadPane>
                            </telerik:RadSplitter>
                            <telerik:RadWindow ID="radwindowFlow" runat="server" Height="640px" VisibleStatusbar="False" Width="960px" Title="Chart">
                                <ContentTemplate>
                                    <div>
                                        &nbsp;Start Date&nbsp;
                                                
                                             
                                                    

                                                    <telerik:RadDateTimePicker ID="radDateTimePicker1" runat="server" Culture="en-GB" Height="25px">
                                                        <TimeView CellSpacing="-1" Culture="en-GB">
                                                        </TimeView>
                                                        <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                                        <Calendar EnableWeekends="True" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
                                                        </Calendar>
                                                        <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" Height="25px" LabelWidth="40%">
                                                            <EmptyMessageStyle Resize="None" />
                                                            <ReadOnlyStyle Resize="None" />
                                                            <FocusedStyle Resize="None" />
                                                            <DisabledStyle Resize="None" />
                                                            <InvalidStyle Resize="None" />
                                                            <HoveredStyle Resize="None" />
                                                            <EnabledStyle Resize="None" />
                                                        </DateInput>
                                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                    </telerik:RadDateTimePicker>
                                        &nbsp;End Date&nbsp;
                                                    <telerik:RadDateTimePicker ID="radDateTimePicker2" runat="server" Culture="en-GB" Height="25px">
                                                        <TimeView CellSpacing="-1" Culture="en-GB">
                                                        </TimeView>
                                                        <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                                        <Calendar EnableWeekends="True" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
                                                        </Calendar>
                                                        <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" Height="25px" LabelWidth="40%">
                                                            <EmptyMessageStyle Resize="None" />
                                                            <ReadOnlyStyle Resize="None" />
                                                            <FocusedStyle Resize="None" />
                                                            <DisabledStyle Resize="None" />
                                                            <InvalidStyle Resize="None" />
                                                            <HoveredStyle Resize="None" />
                                                            <EnabledStyle Resize="None" />
                                                        </DateInput>
                                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                    </telerik:RadDateTimePicker>

                                        <input id="btnUpdateChartFlow" type="button" value="Update" onclick="btnUpdateChartFlow_Clicked(); return false;" />
                                        <input id="btnClearChartFlow" type="button" value="Clear" onclick="btnClearChartFlow_Clicked(); return false;" />


                                    </div>
                                    <div id="chart_canvas_Flow" style="width: 100%; height: 55%"></div>
                                    <div id="summary_flow" style="width: 38%; height: 20%; border: outset 1px; float: left;">
                                        <div style="float: left; width: 100%; margin: 5px;"><b>Summary</b> </div>
                                        <div style="float: left; width: 100%; margin: 5px;">
                                            <div style="float: left;">Minimum Total Flow: </div>
                                            <div id="mintotalFlow" style="float: left; color: blue;"></div>
                                            <div style="float: left; color: blue;">(m3)</div>
                                        </div>
                                        <div style="float: left; width: 100%; margin: 5px;">
                                            <div style="float: left;">Maximun Total Flow: </div>
                                            <div id="maxtotalFlow" style="float: left; color: blue;"></div>
                                            <div style="float: left; color: blue;">(m3)</div>
                                        </div>
                                        <div style="float: left; width: 100%; margin: 5px;">
                                            <div style="float: left;">Total Flow Within Range: </div>
                                            <div id="totalflow1" style="float: left; color: blue;"></div>
                                            <div style="float: left; color: blue;">(m3)</div>
                                        </div>
                                    </div>
                                    <div id="chart_table_Flow" style="width: 60%; height: 35%; float: left"></div>

                                </ContentTemplate>

                            </telerik:RadWindow>

                            <telerik:RadWindow ID="radwindowMNF" runat="server" Height="640px" VisibleStatusbar="False" Width="960px" Title="Chart">
                                <ContentTemplate>
                                    <div class="rowGrid">
                                        &nbsp;Start Date: &nbsp;
 
					
                                                    <telerik:RadDateTimePicker ID="radDateTimePicker3" runat="server" Culture="en-GB" Height="25px">
                                                        <TimeView CellSpacing="-1" Culture="en-GB">
                                                        </TimeView>
                                                        <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                                        <Calendar EnableWeekends="True" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
                                                        </Calendar>
                                                        <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" Height="25px" LabelWidth="40%">
                                                            <EmptyMessageStyle Resize="None" />
                                                            <ReadOnlyStyle Resize="None" />
                                                            <FocusedStyle Resize="None" />
                                                            <DisabledStyle Resize="None" />
                                                            <InvalidStyle Resize="None" />
                                                            <HoveredStyle Resize="None" />
                                                            <EnabledStyle Resize="None" />
                                                        </DateInput>
                                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                    </telerik:RadDateTimePicker>
                                        &nbsp;End Date: &nbsp;
                                                    <telerik:RadDateTimePicker ID="radDateTimePicker4" runat="server" Culture="en-GB" Height="25px">
                                                        <TimeView CellSpacing="-1" Culture="en-GB">
                                                        </TimeView>
                                                        <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                                        <Calendar EnableWeekends="True" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
                                                        </Calendar>
                                                        <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" Height="25px" LabelWidth="40%">
                                                            <EmptyMessageStyle Resize="None" />
                                                            <ReadOnlyStyle Resize="None" />
                                                            <FocusedStyle Resize="None" />
                                                            <DisabledStyle Resize="None" />
                                                            <InvalidStyle Resize="None" />
                                                            <HoveredStyle Resize="None" />
                                                            <EnabledStyle Resize="None" />
                                                        </DateInput>
                                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                    </telerik:RadDateTimePicker>

                                        <input id="btnUpdateChartMNF" type="button" value="Update" onclick="btnUpdateChartMNF_Clicked(); return false;" />
                                        <input id="btnClearChartMNF" type="button" value="Clear" onclick="btnClearChartMNF_Clicked(); return false;" />



                                    </div>
                                    <div id="chart_canvas_MNF" style="width: 100%; height: 55%"></div>
                                    <div id="summary_MNF" style="width: 38%; height: 30%; border: outset 1px; float: left;">
                                        <div style="float: left; width: 100%; margin: 5px;"><b>Summary</b> </div>
                                        <div style="float: left; width: 100%; margin: 5px;">
                                            <div style="float: left;">Minimum Flow : </div>
                                            <div id="minFlow" style="float: left; color: blue"></div>
                                            <div style="float: left; color: blue">(m3/h)</div>
                                        </div>
                                        <div style="float: left; width: 100%; margin: 5px;">
                                            <div style="float: left;">Maximum Flow : </div>
                                            <div id="maxFlow" style="float: left; color: blue"></div>
                                            <div style="float: left; color: blue">(m3/h)</div>
                                        </div>
                                        <div style="float: left; width: 100%; margin: 5px;">
                                            <div style="float: left;">Minimum MNF : </div>
                                            <div id="minMNFst" style="float: left; color: blue"></div>
                                            <div style="float: left; color: blue">(m3/h)</div>
                                        </div>
                                        <div style="float: left; width: 100%; margin: 5px;">
                                            <div style="float: left;">Maximum MNF : </div>
                                            <div id="maxMNFst" style="float: left; color: blue"></div>
                                            <div style="float: left; color: blue">(m3/h)</div>
                                        </div>

                                    </div>
                                    <div id="chart_table_MNF" style="width: 60%; height: 35%; float: left"></div>



                                </ContentTemplate>
                            </telerik:RadWindow>
                            <telerik:RadWindow ID="radminmaxPress" runat="server" Height="640px" VisibleStatusbar="False" Width="970px" Title="Chart">
                                <ContentTemplate>
                                    <div class="rowGrid">
                                        &nbsp;Start Date: &nbsp;
                                        <telerik:RadDateTimePicker ID="radDateTimePicker5" runat="server" Culture="en-GB" Height="25px">
                                            <TimeView CellSpacing="-1" Culture="en-GB">
                                            </TimeView>
                                            <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                            <Calendar EnableWeekends="True" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
                                            </Calendar>
                                            <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" Height="25px" LabelWidth="40%">
                                                <EmptyMessageStyle Resize="None" />
                                                <ReadOnlyStyle Resize="None" />
                                                <FocusedStyle Resize="None" />
                                                <DisabledStyle Resize="None" />
                                                <InvalidStyle Resize="None" />
                                                <HoveredStyle Resize="None" />
                                                <EnabledStyle Resize="None" />
                                            </DateInput>
                                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                        </telerik:RadDateTimePicker>

                                        &nbsp; End Date:&nbsp;
                                        <telerik:RadDateTimePicker ID="radDateTimePicker6" runat="server" Culture="en-GB" Height="25px">
                                            <TimeView CellSpacing="-1" Culture="en-GB">
                                            </TimeView>
                                            <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                            <Calendar EnableWeekends="True" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
                                            </Calendar>
                                            <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" Height="25px" LabelWidth="40%">
                                                <EmptyMessageStyle Resize="None" />
                                                <ReadOnlyStyle Resize="None" />
                                                <FocusedStyle Resize="None" />
                                                <DisabledStyle Resize="None" />
                                                <InvalidStyle Resize="None" />
                                                <HoveredStyle Resize="None" />
                                                <EnabledStyle Resize="None" />
                                            </DateInput>
                                            <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                        </telerik:RadDateTimePicker>

                                        <input id="btnUpdateChartMinMax" type="button" value="Update" onclick="btnUpdateChartMinMax_Clicked(); return false;" />

                                        <input id="btnClearChartMinMax" type="button" value="Clear" onclick="btnClearChartMinMax_Clicked(); return false;" />


                                    </div>
                                    <div id="chart_canvas_MinMax" style="width: 100%; height: 55%"></div>
                                    <div id="summary_MinMax" style="width: 38%; height: 20%; border: dotted; float: left;">
                                        <div style="float: left; width: 100%; margin: 5px;"><b>Summary</b> </div>
                                        <div style="float: left; width: 100%; margin: 5px;">
                                            <div style="float: left;">Minimum Press Day: </div>
                                            <div id="minPress" style="float: left; color: blue"></div>
                                            <div style="float: left; color: blue">(m)</div>
                                        </div>
                                        <div style="float: left; width: 100%; margin: 5px;">
                                            <div style="float: left;">Maximum Press Day: </div>
                                            <div id="maxPress" style="float: left; color: blue"></div>
                                            <div style="float: left; color: blue">(m)</div>
                                        </div>

                                    </div>
                                    <div id="chart_table_MinMax" style="width: 60%; height: 35%; float: left"></div>



                                </ContentTemplate>
                            </telerik:RadWindow>
                            <telerik:RadWindow ID="radWindowChart" runat="server" Height="640px" VisibleStatusbar="False" Width="960px" Title="Chart">
                                <ContentTemplate>
                                    <div class="rowGrid">
                                        &nbsp;Start Date: &nbsp;
                                                    

                                                    <telerik:RadDateTimePicker ID="radDateTimePickerStart" runat="server" Culture="en-GB" Height="25px">
                                                        <TimeView CellSpacing="-1" Culture="en-GB">
                                                        </TimeView>
                                                        <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                                        <Calendar EnableWeekends="True" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
                                                        </Calendar>
                                                        <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" Height="25px" LabelWidth="40%">
                                                            <EmptyMessageStyle Resize="None" />
                                                            <ReadOnlyStyle Resize="None" />
                                                            <FocusedStyle Resize="None" />
                                                            <DisabledStyle Resize="None" />
                                                            <InvalidStyle Resize="None" />
                                                            <HoveredStyle Resize="None" />
                                                            <EnabledStyle Resize="None" />
                                                        </DateInput>
                                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                    </telerik:RadDateTimePicker>
                                        &nbsp; End Date:&nbsp;
                                                    <telerik:RadDateTimePicker ID="radDateTimePickerEnd" runat="server" Culture="en-GB" Height="25px">
                                                        <TimeView CellSpacing="-1" Culture="en-GB">
                                                        </TimeView>
                                                        <TimePopupButton HoverImageUrl="" ImageUrl="" />
                                                        <Calendar EnableWeekends="True" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
                                                        </Calendar>
                                                        <DateInput DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" Height="25px" LabelWidth="40%">
                                                            <EmptyMessageStyle Resize="None" />
                                                            <ReadOnlyStyle Resize="None" />
                                                            <FocusedStyle Resize="None" />
                                                            <DisabledStyle Resize="None" />
                                                            <InvalidStyle Resize="None" />
                                                            <HoveredStyle Resize="None" />
                                                            <EnabledStyle Resize="None" />
                                                        </DateInput>
                                                        <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                                    </telerik:RadDateTimePicker>

                                        <input id="btnUpdateChart" type="button" value="Update" onclick="btnUpdateChart_Clicked(); return false;" />
                                        <input id="btnClearChart" type="button" value="Clear" onclick="btnClearChart_Clicked(); return false;" />


                                    </div>
                                    <div id="chart_canvas" style="width: 100%; height: 55%"></div>

                                    <div id="summary" style="width: 38%; height: 20%; border: outset 1px; float: left;">
                                        <div style="float: left; width: 100%;">Summary </div>
                                        <div style="float: left; width: 100%;">
                                            <div style="float: left;">Min: </div>
                                            <div id="minMNF" style="float: left;"></div>
                                            <div style="float: left;">(m3/h)</div>
                                        </div>
                                        <div style="float: left; width: 100%;">
                                            <div style="float: left;">Max: </div>
                                            <div id="dnzBaseline" style="float: left;"></div>
                                            <div style="float: left;">(m3/h)</div>
                                        </div>
                                        <div style="float: left;">Total Flow Within Range: </div>
                                        <div id="totalflow" style="float: left;"></div>
                                        <div style="float: left;">(m3/h)</div>

                                    </div>
                                    <div id="chart_table" style="width: 60%; height: 36%; float: left"></div>


                                </ContentTemplate>
                            </telerik:RadWindow>


                            <telerik:RadWindow ID="winRightAlarm" runat="server" Height="180px" Width="450px" VisibleOnPageLoad="true" VisibleStatusbar="false" CssClass="myRadWindowR" InitialBehaviors="Minimize"
                                Title="Alarm DMA" NavigateUrl="~/Supervisor/Logger/BlinkMNF.aspx" OnClientBeforeClose="OnClientBeforeClose" OnClientPageLoad="OnClientPageLoad"
                                AutoSize="true" OnClientCommand="OnClientCommand">
                            </telerik:RadWindow>

                            <telerik:RadWindow ID="winAlarm" runat="server" Height="100px" Width="940px" VisibleOnPageLoad="true" VisibleStatusbar="false" CssClass="myRadWindow" InitialBehaviors="Minimize"
                                Title="Alarm Bar" NavigateUrl="~/Supervisor/Logger/Alarming.aspx" OnClientBeforeClose="OnClientBeforeClose">
                            </telerik:RadWindow>

                            <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                                <script type="text/javascript" id="autoloadDMA">
                                    function auto_load() {
                                        $.ajax({
                                            url: "~/Supervisor/Logger/BlinkMNF.aspx",
                                            cache: false,
                                            success: function (data) {
                                                console.log(data);
                                                $("#winRightAlarm").html(data);
                                            }
                                        });
                                        //alert("a");
                                    }

                                    $(document).ready(function () {

                                        auto_load(); //Call auto_load() function when DOM is Ready

                                    });

                                    //Refresh auto_load() function after 10000 milliseconds
                                    setInterval(auto_load, 10000);
                                </script>
                                <script type="text/javascript">
                                    function OnClientBeforeClose(sender, args) {
                                        args.set_cancel(!confirm("Are you sure that you want to close alarm bar?"));
                                    }
                                    function OnClientPageLoad(sender, args) {

                                    }
                                    function OnClientCommand(sender, eventArgs) {
                                        if (eventArgs.get_commandName() == 'Minimize') {

                                        }
                                        else if (eventArgs.get_commandName() == 'Maximize') {

                                        }
                                        else if (eventArgs.get_commandName() == 'Restore') {

                                        }
                                    }
                                </script>
                                <script type="text/javascript" id="telerikClientEvents1">
                                    //<![CDATA[

                                    function radTreeViewSite_NodeDropping(sender, args) {
                                        //Add JavaScript handler code here
                                        if (args.get_htmlElement().toString() == "[object SVGPathElement]") {
                                            //alert()
                                            var channelInfo = args.get_sourceNode().get_value();
                                            var cDtStart = $find("<%=radDateTimePickerStart.ClientID %>");
                                            var cDtEnd = $find("<%=radDateTimePickerEnd.ClientID %>");
                                            var treeViewSite = $find("<%= radTreeViewSite.ClientID %>");
                                            var flag = false;
                                            var info = channelInfo.split('|');
                                            var channel = { id: info[0], namePath: (info[1] + " | " + info[2]), unit: info[3] }
                                            for (var i = 0; i < channels.length; i++) {
                                                if (channels[i].id == channel.id) {
                                                    flag = true;
                                                }
                                            }
                                            if (flag == false) channels.push(channel);
                                            if (cDtStart.get_selectedDate() == null || cDtStart.get_selectedDate() == 'undefined') {
                                                end = new Date();
                                                start = new Date();
                                                start = new Date(start.setDate(start.getDate() - 1));
                                                start = toOADate(start);
                                                end = toOADate(end);
                                                start = start.toString().replace('.', '_');
                                                end = end.toString().replace('.', '_');
                                                updateChart(start, end);
                                            }
                                            else {
                                                updateChart(toOADate(new Date(cDtStart.get_selectedDate())).toString().replace('.', '_'), toOADate(new Date(cDtEnd.get_selectedDate())).toString().replace('.', '_'));
                                            }
                                        }
                                    }
                //]]>
                                </script>
                                <script type="text/javascript" id="telerikClientEvents2">
                                    //<![CDATA[

                                    function btnUpdateChart_Clicked(sender, args) {
                                        var cDtStart = $find("<%=radDateTimePickerStart.ClientID %>");
                                        var cDtEnd = $find("<%=radDateTimePickerEnd.ClientID %>");
                                        if (cDtStart.get_selectedDate() == null || cDtEnd.get_selectedDate() == null) {
                                            alert("Chưa nhập ngày!");
                                            return false;
                                        }
                                        updateChart(toOADate(new Date(cDtStart.get_selectedDate())).toString().replace('.', '_'), toOADate(new Date(cDtEnd.get_selectedDate())).toString().replace('.', '_'));
                                        return false;
                                    }



                                    function btnClearChart_Clicked(sender, args) {
                                        while (chart.graphs.length != 0) {
                                            chart.removeGraph(chart.graphs[0]);
                                        }
                                        colors = [];
                                        mreds = [];
                                        mblues = [];
                                        channels = [];
                                        chartData = [];
                                        chart.dataProvider = chartData;
                                        chart.validateData();
                                        chart.validateNow();
                                        return false;
                                    }
                //]]>
                                </script>

                                <script type="text/javascript" id="telerikClientEvents5">
                                    //<![CDATA[
                                    function btnUpdateChartFlow_Clicked(sender, args) {

                                        var cDtStart = $find("<%=radDateTimePicker1.ClientID %>");
                                        var cDtEnd = $find("<%=radDateTimePicker2.ClientID %>");
                                        if (cDtStart.get_selectedDate() == null || cDtEnd.get_selectedDate() == null) {
                                            alert("Chưa nhập ngày!");

                                            return false;
                                        }
                                        updateChartFlow(toOADate(new Date(cDtStart.get_selectedDate())).toString().replace('.', '_'), toOADate(new Date(cDtEnd.get_selectedDate())).toString().replace('.', '_'));
                                        return false;
                                        //]]>
                                    }
                                </script>
                                <script type="text/javascript" id="telerikClientEvents6">
                                    //<![CDATA[
                                    function btnUpdateChartMNF_Clicked(sender, args) {

                                        var cDtStart = $find("<%=radDateTimePicker3.ClientID %>");
                                        var cDtEnd = $find("<%=radDateTimePicker4.ClientID %>");
                                        if (cDtStart.get_selectedDate() == null || cDtEnd.get_selectedDate() == null) {
                                            alert("Chưa nhập ngày!");

                                            return false;
                                        }
                                        updateChartMNF(toOADate(new Date(cDtStart.get_selectedDate())).toString().replace('.', '_'), toOADate(new Date(cDtEnd.get_selectedDate())).toString().replace('.', '_'));
                                        return false;
                                        //]]>
                                    }
                                </script>
                                <script type="text/javascript" id="telerikClientEvents7">
                                    //<![CDATA[
                                    function btnUpdateChartMinMax_Clicked(sender, args) {
                                        // alert("aa");
                                        var cDtStart = $find("<%=radDateTimePicker5.ClientID %>");
                                        var cDtEnd = $find("<%=radDateTimePicker6.ClientID %>");
                                        if (cDtStart.get_selectedDate() == null || cDtEnd.get_selectedDate() == null) {
                                            alert("Chưa nhập ngày!");

                                            return false;
                                        }
                                        updateChartMinMax(toOADate(new Date(cDtStart.get_selectedDate())).toString().replace('.', '_'), toOADate(new Date(cDtEnd.get_selectedDate())).toString().replace('.', '_'));
                                        return false;
                                        //]]>
                                    }
                                </script>

                                <script type="text/javascript" id="telerikClientEvents3">               
                                    //<![CDATA[
                                    function radTreeViewSiteMap_Load(sender, args) {
                                        var treeViewSiteMap = $find("<%= radTreeViewSiteMap.ClientID %>");
                                        var nodes = treeViewSiteMap.get_allNodes();
                                        for (var i = 0; i < nodes.length; i++) {
                                            if (nodes[i].get_nodes() != null) {
                                                nodes[i].expand();
                                            }
                                        }
                                    }
                //]]>
                                </script>

                                <script type="text/javascript" id="telerikClientEvents4">
                                    //<![CDATA[

                                    function radTreeViewSite_NodeClicked(sender, args) {
                                        //Add JavaScript handler code here
                                        var node = args.get_node();
                                        openWin(node.get_value());
                                    }
                //]]>
                                </script>
                                <script type="text/javascript">
                                    var svc = '/VivaServices/';
                                    var url;
                                    var urlGetSites = svc + 'Service1.svc/GetSites';
                                    var urlGetSitesByUid = svc + 'Service1.svc/GetSitesByUid/';
                                    var urlGetChannels = svc + 'Service1.svc/GetChannels/';
                                    var urlGetChannelData = svc + 'Service1.svc/GetChannelData/';
                                    var urlGetMultipleChannelsData = svc + 'Service1.svc/GetMultipleChannelsData/';
                                    var urlGetDailyComplexData = svc + 'Service1.svc/GetDailyComplexData/';


                                    //var urlMRed = 'http://i748.photobucket.com/albums/xx123/bttrung1988/mRed_zpscf7a64f6.png';
                                    var urlMRed = '../../App_Themes/mRed.png';
                                    // var urlMGreen = 'http://i748.photobucket.com/albums/xx123/bttrung1988/mGreen_zpsf28ed33c.png';
                                    //var urlMYellow = 'http://i748.photobucket.com/albums/xx123/bttrung1988/mYellow_zps26e7a5c5.png';
                                    //var urlMOrange = 'http://i748.photobucket.com/albums/xx123/bttrung1988/mOrange_zpsacadba43.png';
                                    var urlMGreen = '../../App_Themes/mGreen.png';
                                    var urlMYellow = '../../App_Themes/mYellow.png';
                                    var urlMOrange = '../../App_Themes/mOrange.png';
                                    var urlMBlack = '../../App_Themes/mBlack.png';
                                    var urlMPink = '../../App_Themes/mPink.png';
                                    var map;
                                    var markers = [];
                                    var omarkers = [];
                                    var infowindow = new google.maps.InfoWindow({
                                        content: ''
                                    });

                                    var infoHtml;
                                    var dInfoHtml;
                                    var labelHtml;
                                    var dLabelHtml;
                                    var index;
                                    var strDate;
                                    var val;
                                    var parsedDate;
                                    var jsDate;

                                    var reds = ['orange', 'deeppink', 'darkviolet', 'brown', 'magenta'];
                                    var blues = ['green', 'cyan', 'darkblue', 'limegreen', 'teal'];
                                    var mreds = [];
                                    var mblues = [];

                                    var image_nor = {
                                        url: '../../App_Themes/green5.png',
                                        size: new google.maps.Size(20, 20),
                                        origin: new google.maps.Point(0, 0),
                                        //anchor: new google.maps.Point(-6, 45)
                                    };

                                    var image_err_low_press = {
                                        url: '../../App_Themes/red5.png',
                                        //url:'#',
                                        size: new google.maps.Size(20, 20),
                                        origin: new google.maps.Point(0, 0),
                                        //anchor: new google.maps.Point(-6, 45)
                                    };

                                    var image_err_sig_delay = {
                                        url: '../../App_Themes/orange5.png',
                                        size: new google.maps.Size(20, 20),
                                        origin: new google.maps.Point(0, 0),
                                        //anchor: new google.maps.Point(-6, 45)
                                    };

                                    var image_err_previous = {
                                        url: '../../App_Themes/yellow5.png',
                                        size: new google.maps.Size(20, 20),
                                        origin: new google.maps.Point(0, 0),
                                        //anchor: new google.maps.Point(-6, 45)
                                    };

                                    var image_err_MNF_baseline = {
                                        url: '../../App_Themes/black5.png',
                                        size: new google.maps.Size(20, 20),
                                        origin: new google.maps.Point(0, 0),
                                        //anchor: new google.maps.Point(-6, 45)
                                    };
                                    var image_err_MNF_MNFhis = {
                                        url: '../../App_Themes/Pink5.png',
                                        size: new google.maps.Size(20, 20),
                                        origin: new google.maps.Point(0, 0),
                                        //anchor: new google.maps.Point(-6, 45)
                                    };

                                    var chart;
                                    var end;
                                    var start;
                                    var channels = [];
                                    var chartData = [];
                                    var sites = [];
                                    var valueAxisPress;
                                    var valueAxisFlow;
                                    var colorRed = [];
                                    var colorBlue = [];
                                    var img = image_nor;
                                    var colors = [];

                                    function getQueryStrings() {
                                        var assoc = {};
                                        var decode = function (s) { return decodeURIComponent(s.replace(/\+/g, " ")); };
                                        var queryString = location.search.substring(1);
                                        var keyValues = queryString.split('&');

                                        for (var i in keyValues) {
                                            var key = keyValues[i].split('=');
                                            if (key.length > 1) {
                                                assoc[decode(key[0])] = decode(key[1]);
                                            }
                                        }

                                        return assoc;
                                    }

                                    function window_init() {
                                        //MAP
                                        var qs = getQueryStrings();
                                        var uid = qs["uid"];

                                        zoom = 15;
                                        center = new google.maps.LatLng(10.838786, 106.656204);
                                        var myOptions = {
                                            zoom: zoom,
                                            center: center,
                                            mapTypeId: google.maps.MapTypeId.ROADMAP,
                                            streetViewControl: true
                                        };
                                        map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
                                        var url = 'https://trungangis.capnuoctrungan.vn/arcgis/rest/services/Test_DMA/DMA/Mapserver';
                                        //var url = 'http://113.161.76.112:6080/arcgis/rest/services/KHAWASSCOMapService/MapServer';
                                        var cpc = new gmaps.ags.CopyrightControl(map);
                                        var dynamap = new gmaps.ags.MapOverlay(url, {});
                                        dynamap.setMap(map);
                                        //TREEVIEW & MAP CONTENT
                                        var treeViewSite = $find("<%= radTreeViewSite.ClientID %>");
                                        url = urlGetSitesByUid + uid;
                                        $.getJSON(url, function (ds) {
                                            var displayGroup;
                                            $.each(ds.GetSitesByUidDMAResult, function (i, s) {
                                                //TREEVIEW SITE NODE
                                                sites.push(s);
                                                var gpNode = treeViewSite.findNodeByText(s.DisplayGroup);
                                                if (gpNode == 'undefined' || gpNode == null) {
                                                    var gNode = new Telerik.Web.UI.RadTreeNode();
                                                    gNode.set_text(s.DisplayGroup);
                                                    gNode.set_allowDrag(false);
                                                    gNode.set_allowDrop(false);
                                                    //gNode.expand();--nghiavt for collape at loading time
                                                    treeViewSite.get_nodes().add(gNode);
                                                }
                                                var sNode = new Telerik.Web.UI.RadTreeNode();
                                                sNode.set_text(s.Location);
                                                sNode.set_value(s.SiteId);
                                                sNode.set_allowDrag(false);
                                                sNode.set_allowDrop(false);
                                                //alert(i);
                                                var gpNode = treeViewSite.findNodeByText(s.DisplayGroup);
                                                gpNode.get_nodes().add(sNode);
                                                if (s.LoggerId != '') url = urlGetChannels + s.LoggerId;
                                                else url = urlGetChannels + 'nothing';
                                                $.getJSON(url, function (dc) {

                                                    //MAP CONTENT
                                                    labelHtml = '<table cellspacing="0" cellpadding="0" style="border: solid gray 2px;font-size:1em;border-width:2px"><tr><td colspan="2" style="text-align:center;font-weight:bold;color:blue;background-color:white"><span>' + s.SiteId + '</span></td></tr>';
                                                    infoHtml = '<span style="font-weight:bold">Vị trí: ' + s.Location + '</span>'
                                                        + '<br/><span>Logger Id: ' + s.LoggerId + '</span>'
                                                        + '</br><span>Index: ';
                                                    index = 0;
                                                    dLabelHtml = '';
                                                    dInfoHtml = '';

                                                    $.each(dc.GetChannelsResult, function (j, c) {
                                                        //ICON
                                                        if (c.Press1 == true || c.Press2 == true) {
                                                            switch (c.Status) {
                                                                case 1:
                                                                    img = image_nor;
                                                                    break;
                                                                case 2:
                                                                    img = image_err_previous;
                                                                    break;
                                                                case 3:
                                                                    img = image_err_sig_delay;
                                                                    break;
                                                                case 4:
                                                                    img = image_err_low_press;
                                                                    break;
                                                                case 5:
                                                                    img = image_err_MNF_baseline;
                                                                    break;
                                                                case 6:
                                                                    img = image_err_MNF_MNFhis;
                                                                    break;
                                                                default:
                                                                    img = image_nor;
                                                                    break;
                                                            }
                                                        }
                                                        //TREEVIEW CHANNEL NODE
                                                        var cNode = new Telerik.Web.UI.RadTreeNode();
                                                        cNode.set_text(c.ChannelName);
                                                        cNode.set_value(c.ChannelId + '|' + s.Location + '|' + c.ChannelName + '|' + c.Unit);
                                                        cNode.set_allowDrag(true);
                                                        cNode.set_allowDrop(true);
                                                        var spNode = treeViewSite.findNodeByText(s.Location);
                                                        spNode.get_nodes().add(cNode);
                                                        //MAP INFOWINDOW CONTENT
                                                        if (c.LastIndex != null && c.LastIndex != 'undefined') {
                                                            index -= c.LastIndex;
                                                        }
                                                        if (c.Timestamp != null && c.Timestamp != 'undefined') {
                                                            parsedDate = new Date(parseInt(c.Timestamp.substr(6)));
                                                            jsDate = new Date(parsedDate);
                                                            strDate = jsDate.getDate() + "/" + (jsDate.getMonth() + 1) + "/" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes();
                                                        }
                                                        else {
                                                            strDate = 'NO DATA';
                                                        }
                                                        if (c.Value != null && c.Value != 'undefined') {
                                                            val = c.Value;
                                                        }
                                                        else {
                                                            val = 'NO DATA';
                                                        }
                                                        dInfoHtml += "<tr><td><a href=\"#\" onclick=\"openChart('" + c.ChannelId + "','" + s.Location + " | " + c.ChannelName + "','" + c.Unit + "','" + s.BaseLine + "');\">" + c.ChannelName + "</a></td>"
                                                            + "<td>" + strDate + "</td>"
                                                            + '<td style="text-align:right;font-weight:bold;color:blue">' + val + "</td>"
                                                            + '<td style="font-weight:bold;color:blue">' + c.Unit + "</td></tr>";
                                                        //MAP LABEL CONTENT
                                                        //if (c.Press1 == true || c.Press2 == true) {
                                                        //    var htmlImg = "";
                                                        //    if (c.Status2 == true && img != image_err_sig_delay) {
                                                        //        htmlImg += '<img alt="" border="0" src="' + urlMOrange + '"></img>';
                                                        //    }
                                                        //    if (c.Status3 == true && img != image_err_previous) {
                                                        //        htmlImg += '<img alt="" border="0" src="' + urlMYellow + '"></img>';
                                                        //    }
                                                        //    if (c.Status6 == true && img != image_err_MNF_MNFhis) {
                                                        //        htmlImg += '<img alt="" border="0" src="' + urlMNF2 + '"></img>';
                                                        //    }
                                                        //    if (c.Status5 == true && img != image_err_MNF_baseline) {
                                                        //        htmlImg += '<img alt="" border="0" src="' + urlMNF + '"></img>';
                                                        //    }

                                                        //    if (c.Status4 == true && img != image_err_low_press) {
                                                        //        htmlImg += '<img alt="" border="0" src="' + urlMRed + '"></img>';
                                                        //    }

                                                        //    dLabelHtml = '<tr style="background-color:black"><td style="text-align:center;font-weight:bold;color:yellow;"><span>' + val + ' (' + c.Unit + ')' + '</span></td><td style="text-align:right">' + htmlImg + '</td></tr></table>';
                                                        //}
                                                        if (c.Press1 == true || c.Press2 == true) {
                                                            var htmlImg = "";
                                                            if (c.Status2 == true && img != image_err_previous) {
                                                                htmlImg += '<img alt="" border="0" src="' + urlMYellow + '"></img>';
                                                            }
                                                            if (c.Status3 == true && img != image_err_sig_delay) {
                                                                htmlImg += '<img alt="" border="0" src="' + urlMOrange + '"></img>';
                                                            }

                                                            if (c.Status6 == true && img != image_err_MNF_MNFhis) {
                                                                htmlImg += '<img alt="" border="0" src="' + urlMPink + '"></img>';
                                                            }
                                                            if (c.Status5 == true && img != image_err_MNF_baseline) {
                                                                htmlImg += '<img alt="" border="0" src="' + urlMBlack + '"></img>';
                                                            }


                                                            if (c.Status4 == true && img != image_err_low_press) {
                                                                htmlImg += '<img alt="" border="0" src="' + urlMRed + '"></img>';
                                                            }


                                                            dLabelHtml = '<tr style="background-color:black"><td style="text-align:center;font-weight:bold;color:yellow;"><span>' + val + ' (' + c.Unit + ')' + '</span></td><td style="text-align:right">' + htmlImg + '</td></tr></table>';
                                                        }
                                                    });
                                                    labelHtml += dLabelHtml;
                                                    infoHtml += '<span style="font-weight:bold;color:blue;">' + Math.round(Math.abs(index)) + '</span></span>';
                                                    infoHtml += '<br/><table cellpadding="5" cellspacing="5">';
                                                    infoHtml += dInfoHtml;
                                                    infoHtml += "<tr><td><a href=\"#\" onclick=\"openChartFlow('" + s.LoggerId + "');\">Total Flow</a></td></tr>"
                                                    infoHtml += "<tr><td><a href=\"#\" onclick=\"openChartMNF('" + s.LoggerId + "','" + s.BaseLine + "');\">MinMax Flow Day</a></td></tr>"
                                                    infoHtml += "<tr><td><a href=\"#\" onclick=\"openChartMinMaxPre('" + s.LoggerId + "');\">MinMax Pressure Day</a></td></tr>"

                                                        + '</table>';
                                                    //LOAD TO MAP
                                                    var latlng = new google.maps.LatLng(s.Latitude, s.Longitude);
                                                    var anchor = new google.maps.Point(s.LabelAnchorX = null ? 40 : s.LabelAnchorX, s.LabelAnchorY = null ? 0 : s.LabelAnchorY);
                                                    var omarker = new google.maps.Marker({
                                                        id: 'om_' + s.SiteId,
                                                        position: latlng,
                                                        map: map,
                                                        icon: img,
                                                        html: infoHtml
                                                    });
                                                    var marker = new MarkerWithLabel({
                                                        id: 'm_' + s.SiteId,
                                                        position: latlng,
                                                        map: map,
                                                        icon: img,
                                                        draggable: false,
                                                        raiseOnDrag: true,
                                                        labelContent: labelHtml,
                                                        labelAnchor: anchor,
                                                        labelClass: "labels", // the CSS class for the label
                                                        labelInBackground: false,
                                                        html: infoHtml,
                                                        visible: true
                                                    });
                                                    google.maps.event.addListener(marker, 'click', function () {
                                                        infowindow.setContent(this.html);
                                                        infowindow.open(map, this);
                                                    });
                                                    google.maps.event.addListener(omarker, 'click', function () {
                                                        infowindow.setContent(this.html);
                                                        infowindow.open(map, this);
                                                    });
                                                    markers.push(marker);
                                                    omarkers.push(omarker);
                                                });
                                            })
                                        });
                                        treeViewSite.commitChanges();
                                        //CONTEXT MENU
                                        var contextMenuOptions = {};
                                        contextMenuOptions.classNames = { menu: 'context_menu', menuSeparator: 'context_menu_separator' };
                                        var menuItems = [];
                                        menuItems.push({ className: 'context_menu_item', eventName: 'hide_click', label: 'Hide labels' });
                                        menuItems.push({ className: 'context_menu_item', eventName: 'show_click', label: 'Show labels' });
                                        contextMenuOptions.menuItems = menuItems;
                                        var contextMenu = new ContextMenu(map, contextMenuOptions);
                                        google.maps.event.addListener(map, 'rightclick', function (mouseEvent) {
                                            contextMenu.show(mouseEvent.latLng);
                                        });
                                        google.maps.event.addListener(contextMenu, 'menu_item_selected', function (latLng, eventName) {
                                            switch (eventName) {
                                                case 'hide_click':
                                                    for (var i = 0; i < markers.length; i++) {
                                                        markers[i].setVisible(false);
                                                    }
                                                    break;
                                                case 'show_click':
                                                    for (var i = 0; i < markers.length; i++) {
                                                        markers[i].setVisible(true);
                                                    }
                                                    break;
                                            }
                                        });
                                    }

                                    function updateMap() {
                                        $.each(sites, function (i, s) {
                                            if (s.LoggerId != '') url = urlGetChannels + s.LoggerId;
                                            else url = urlGetChannels + 'nothing';
                                            $.getJSON(url, function (dc) {

                                                //MAP CONTENT
                                                labelHtml = '<table cellspacing="0" cellpadding="0" style="border: solid gray 2px;font-size:1em"><tr><td colspan="2" style="text-align:center;font-weight:bold;color:blue;background-color:white"><span>' + s.SiteId + '</span></td></tr>';
                                                infoHtml = '<span style="font-weight:bold">Vị trí: ' + s.Location + '</span>'
                                                    + '<br/><span>Logger Id: ' + s.LoggerId + '</span>'
                                                    + '</br><span>Index: ';
                                                index = 0;
                                                dLabelHtml = '';
                                                dInfoHtml = '';
                                                $.each(dc.GetChannelsResult, function (j, c) {
                                                    //ICON
                                                    if (c.Press1 == true || c.Press2 == true) {
                                                        switch (c.Status) {
                                                            case 1:
                                                                img = image_nor;
                                                                break;
                                                            case 2:
                                                                img = image_err_previous;
                                                                break;
                                                            case 3:
                                                                img = image_err_sig_delay;
                                                                break;
                                                            case 4:
                                                                img = image_err_low_press;
                                                                break;
                                                            case 5:
                                                                img = image_err_MNF_baseline;
                                                                break;
                                                            case 6:
                                                                img = image_err_MNF_MNFhis;
                                                                break;
                                                            default:
                                                                img = image_nor;
                                                                break;
                                                        }
                                                    }
                                                    //MAP INFOWINDOW CONTENT
                                                    if (c.LastIndex != null && c.LastIndex != 'undefined') {
                                                        index -= c.LastIndex;
                                                    }
                                                    if (c.Timestamp != null && c.Timestamp != 'undefined') {
                                                        parsedDate = new Date(parseInt(c.Timestamp.substr(6)));
                                                        jsDate = new Date(parsedDate);
                                                        strDate = jsDate.getDate() + "/" + (jsDate.getMonth() + 1) + "/" + jsDate.getFullYear() + " " + jsDate.getHours() + ":" + jsDate.getMinutes();
                                                    }
                                                    else {
                                                        strDate = 'NO DATA';
                                                    }
                                                    if (c.Value != null && c.Value != 'undefined') {
                                                        val = c.Value;
                                                    }
                                                    else {
                                                        val = 'NO DATA';
                                                    }
                                                    dInfoHtml += "<tr><td><a href=\"#\" onclick=\"openChart('" + c.ChannelId + "','" + s.Location + " | " + c.ChannelName + "','" + c.Unit + "','" + s.BaseLine + "');\">" + c.ChannelName + "</a></td>"
                                                        + "<td>" + strDate + "</td>"
                                                        + '<td style="text-align:right;font-weight:bold;color:blue">' + val + "</td>"
                                                        + '<td style="font-weight:bold;color:blue">' + c.Unit + "</td></tr>";
                                                    //MAP LABEL CONTENT
                                                    //if (c.Press1 == true || c.Press2 == true) {

                                                    //    var htmlImg = "";
                                                    //    if (c.Status2 == true && img != image_err_sig_delay) {
                                                    //        htmlImg += '<img alt="" border="0" src="' + urlMOrange + '"></img>';
                                                    //    }
                                                    //    if (c.Status3 == true && img != image_err_previous) {
                                                    //        htmlImg += '<img alt="" border="0" src="' + urlMYellow + '"></img>';
                                                    //    }
                                                    //    if (c.Status6 == true && img != image_err_MNF_MNFhis) {
                                                    //        htmlImg += '<img alt="" border="0" src="' + urlMNF2 + '"></img>';
                                                    //    }
                                                    //    if (c.Status5 == true && img != image_err_MNF_baseline) {
                                                    //        htmlImg += '<img alt="" border="0" src="' + urlMNF + '"></img>';
                                                    //    }

                                                    //    if (c.Status4 == true && img != image_err_low_press) {
                                                    //        htmlImg += '<img alt="" border="0" src="' + urlMRed + '"></img>';
                                                    //    }

                                                    //    dLabelHtml = '<tr style="background-color:black"><td style="text-align:center;font-weight:bold;color:yellow;"><span>' + val + ' (' + c.Unit + ')' + '</span></td><td style="text-align:right">' + htmlImg + '</td></tr></table>';

                                                    //}
                                                    if (c.Press1 == true || c.Press2 == true) {
                                                        var htmlImg = "";
                                                        if (c.Status2 == true && img != image_err_previous) {
                                                            htmlImg += '<img alt="" border="0" src="' + urlMYellow + '"></img>';
                                                        }
                                                        if (c.Status3 == true && img != image_err_sig_delay) {
                                                            htmlImg += '<img alt="" border="0" src="' + urlMOrange + '"></img>';
                                                        }
                                                        if (c.Status6 == true && img != image_err_MNF_MNFhis) {
                                                            htmlImg += '<img alt="" border="0" src="' + urlMPink + '"></img>';
                                                        }
                                                        if (c.Status5 == true && img != image_err_MNF_baseline) {
                                                            htmlImg += '<img alt="" border="0" src="' + urlMBlack + '"></img>';
                                                        }

                                                        if (c.Status4 == true && img != image_err_low_press) {
                                                            htmlImg += '<img alt="" border="0" src="' + urlMRed + '"></img>';
                                                        }


                                                        dLabelHtml = '<tr style="background-color:black"><td style="text-align:center;font-weight:bold;color:yellow;"><span>' + val + ' (' + c.Unit + ')' + '</span></td><td style="text-align:right">' + htmlImg + '</td></tr></table>';
                                                    }
                                                });
                                                labelHtml += dLabelHtml;
                                                infoHtml += '<span style="font-weight:bold;color:blue;">' + Math.round(Math.abs(index)) + '</span></span>';
                                                infoHtml += '<br/><table cellpadding="5" cellspacing="5">';
                                                infoHtml += dInfoHtml;
                                                infoHtml += "<tr><td><a href=\"#\" onclick=\"openChartFlow('" + s.LoggerId + "');\">Total Flow</a></td></tr>"
                                                infoHtml += "<tr><td><a href=\"#\" onclick=\"openChartMNF('" + s.LoggerId + "','" + s.BaseLine + "');\">MinMax Flow Day</a></td></tr>"
                                                infoHtml += "<tr><td><a href=\"#\" onclick=\"openChartMinMaxPre('" + s.LoggerId + "');\">MinMax Pressure Day</a></td></tr>"

                                                    + '</table>';
                                                //LOAD TO MAP
                                                loop_m:
                                                for (var k = 0; k < markers.length; k++) {
                                                    if (markers[k].id == ('m_' + s.SiteId)) {

                                                        markers[k].setIcon(img);
                                                        markers[k].html = infoHtml;
                                                        markers[k].labelContent = labelHtml;
                                                        markers[k].label.setContent();
                                                        break loop_m;
                                                    }
                                                }
                                                loop_om:
                                                for (var k = 0; k < omarkers.length; k++) {
                                                    if (omarkers[k].id == ('om_' + s.SiteId)) {
                                                        omarkers[k].setIcon(img);
                                                        break loop_om;
                                                    }
                                                }
                                            });
                                        });

                                    }

                                    function openWin(id) {
                                        loop_ow:
                                        for (var i = 0; i < markers.length; i++) {
                                            if (markers[i].id == ('m_' + id)) {
                                                map.panTo(markers[i].getPosition());
                                                google.maps.event.trigger(markers[i], 'click');
                                                break loop_ow;
                                            }
                                        }
                                    };

                                    function dtToString(d) {
                                        var u = d.getFullYear() + "|" + (d.getMonth() + 1) + "|" + d.getDate() + "|" + d.getHours() + "|" + d.getMinutes() + "|" + d.getSeconds();
                                        return u;
                                    }

                                    var toOADate = (function () {
                                        var epoch = new Date(1899, 11, 30);
                                        var msPerDay = 8.64e7;

                                        return function (d) {
                                            var v = -1 * (epoch - d) / msPerDay;

                                            // Deal with dates prior to 1899-12-30 00:00:00
                                            var dec = v - Math.floor(v);

                                            if (v < 0 && dec) {
                                                v = Math.floor(v) - dec;
                                            }

                                            return v;
                                        }
                                    }());


                                    var fromOADate = (function () {
                                        var epoch = new Date(1899, 11, 30);
                                        var msPerDay = 8.64e7;

                                        return function (n) {
                                            // Deal with -ve values
                                            var dec = n - Math.floor(n);

                                            if (n < 0 && dec) {
                                                n = Math.floor(n) - dec;
                                            }

                                            return new Date(n * msPerDay + +epoch);
                                        }
                                    }());

                                    function openChartFlow(loggerId) {
                                        var window = $find("<%= radwindowFlow.ClientID %>");
                                        window.show();
                                        window.center();
                                        end = new Date();
                                        // end = new Date(end.setDate(end.getDate() - 9));
                                        start = new Date();
                                        start = new Date(start.setDate(start.getDate() - 30));
                                        var cDtStart = $find("<%=radDateTimePicker1.ClientID %>");
                                        var cDtEnd = $find("<%=radDateTimePicker2.ClientID %>");
                                        cDtStart.set_selectedDate(start);
                                        cDtEnd.set_selectedDate(end);
                                        start = toOADate(start);
                                        end = toOADate(end);
                                        start = start.toString().replace('.', '_');
                                        end = end.toString().replace('.', '_');
                                        //console.log(start);
                                        //console.log(end);
                                        var channel = { id: loggerId, sum: "_sum", base: "_base" };
                                        channels = [];
                                        channels.push(channel);

                                        colors = [];
                                        mreds = [];
                                        mblues = [];
                                        drawChartFlow(channels[0], start, end);
                                    };
                                    // this method is called when chart is first inited as we listen for "dataUpdated" event
                                    function zoomChartFlow() {
                                        // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
                                        chart_flow.zoomToIndexes(chartDataFlow.length - chartDataFlow.length, chartDataFlow.length - 1); urlGetDailyComplexData
                                    }
                                    function drawChartFlow(channel, start, end) {
                                        //alert(channel.sum);
                                        var url = urlGetDailyComplexData + channel.id + "/" + start + "/" + end;
                                        $.getJSON(url, function (d) {
                                            chartDataFlow = [];
                                            //alert(channel.base);
                                            $.each(d.GetDailyComplexDataResult, function (i, val) {
                                                var parsedDate = new Date(parseInt(val.TimeStamp.substr(6)));
                                                var jsDate = new Date(parsedDate);
                                                chartDataFlow.push({
                                                    TimeStamp: jsDate
                                                });
                                                if (val.MinFlowRate != null && val.MinFlowRate != 'undefined') {

                                                    chartDataFlow[i]["'" + channel.id + "'"] = Math.round(val.Output);
                                                }

                                            });


                                            //SERIAL CHART
                                            chart_flow = new AmCharts.AmSerialChart();
                                            chart_flow.pathToImages = "../../js/amcharts/images/";
                                            chart_flow.dataProvider = chartDataFlow;
                                            chart_flow.type = "serial";
                                            chart_flow.dataTableId = "chart_table_Flow";
                                            chart_flow.categoryField = "TimeStamp";
                                            chart_flow.balloon.bulletSize = 5;
                                            //ZOOM
                                            chart_flow.addListener("dataUpdated", zoomChartFlow);
                                            //AXES
                                            //X

                                            var categoryAxis = chart_flow.categoryAxis;
                                            categoryAxis.parseDates = true;
                                            categoryAxis.minPeriod = "DD";
                                            categoryAxis.dashLength = 1;
                                            categoryAxis.minorGridEnabled = true;
                                            categoryAxis.twoLineMode = true;
                                            categoryAxis.dateFormats = [{
                                                period: 'fff',
                                                format: 'JJ:NN:SS'
                                            }, {
                                                period: 'ss',
                                                format: 'JJ:NN:SS'
                                            }, {
                                                period: 'mm',
                                                format: 'JJ:NN'
                                            }, {
                                                period: 'hh',
                                                format: 'JJ:NN'
                                            }, {
                                                period: 'DD',
                                                format: 'DD'
                                            }, {
                                                period: 'WW',
                                                format: 'DD'
                                            }, {
                                                period: 'MM',
                                                format: 'YYYY'
                                            }, {
                                                period: 'YYYY',
                                                format: 'YYYY'
                                            }];

                                            categoryAxis.axisColor = "#DADADA";
                                            categoryAxis.gridAlpha = 0.15;
                                            //AXE
                                            //Y1
                                            valueAxisSum = new AmCharts.ValueAxis();
                                            valueAxisSum.axisColor = 'blue';
                                            valueAxisSum.axisThickness = 1;
                                            valueAxisSum.title = 'Total Flow';
                                            valueAxisSum.position = 'left';
                                            valueAxisSum.titleColor = 'blue';
                                            chart_flow.addValueAxis(valueAxisSum);




                                            // GRAPH                       
                                            var graph_flow = new AmCharts.AmGraph();
                                            //alert("a");
                                            graph_flow.id = "Total_Flow";
                                            graph_flow.valueAxis = valueAxisSum;
                                            graph_flow.title = "Total Flow";
                                            graph_flow.valueField = "'" + channel.id + "'";
                                            graph_flow.bullet = "round";
                                            graph_flow.bulletBorderColor = "#FFFFFF";
                                            // graph_flow.negativeBase = 25;
                                            // graph_flow.negativeLineColor = "green";                        
                                            graph_flow.bulletBorderThickness = 2;
                                            graph_flow.bulletBorderAlpha = 1;
                                            graph_flow.bulletSize = 8;
                                            graph_flow.lineThickness = 1;
                                            graph_flow.lineColor = "blue";
                                            graph_flow.hideBulletsCount = 50;
                                            //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                            chart_flow.addGraph(graph_flow);



                                            //add table

                                            var total = 0;
                                            var min = 1000000;
                                            var max = 0;
                                            // check if export to table is enabled

                                            // get chart data
                                            var data = chart_flow.dataProvider;

                                            // create a table
                                            var holder = document.getElementById(chart_flow.dataTableId);
                                            holder.innerHTML = "";
                                            // if (holder.childElementCount == 0) {
                                            var table = document.createElement("table");
                                            holder.appendChild(table);

                                            // document.getElementById("chart_table").innerHTML(table);
                                            var tr, td;

                                            // add first row
                                            for (var x = 0; x < chart_flow.dataProvider.length; x++) {
                                                // first row
                                                if (x == 0) {
                                                    tr = document.createElement("tr");
                                                    table.appendChild(tr);
                                                    td = document.createElement("th");
                                                    //td.innerHTML = chart_flow.categoryAxis.title;
                                                    td.innerHTML = "Timestamp";
                                                    tr.appendChild(td);
                                                    for (var i = 0; i < chart_flow.graphs.length; i++) {
                                                        td = document.createElement('th');
                                                        td.innerHTML = chart_flow.graphs[i].title;
                                                        tr.appendChild(td);
                                                    }
                                                }

                                                // add rows
                                                tr = document.createElement("tr");
                                                table.appendChild(tr);
                                                td = document.createElement("td");
                                                td.className = "row-title";

                                                // td.innerHTML = chart_flow.dataProvider[x][chart_flow.categoryField].toUTCString();
                                                var todayTime = new Date(chart_flow.dataProvider[x][chart_flow.categoryField]);
                                                var month = todayTime.getMonth() + 1;
                                                var day = todayTime.getDate();
                                                var year = todayTime.getFullYear();
                                                var dt = day + "/" + month + "/" + year;
                                                td.innerHTML = dt;
                                                tr.appendChild(td);
                                                // alert(chart_flow.graphs.length);

                                                var valuetotal;
                                                for (var i = 0; i < chart_flow.graphs.length; i++) {

                                                    td = document.createElement('td');
                                                    valuetotal = chart_flow.dataProvider[x][chart_flow.graphs[i].valueField];
                                                    td.innerHTML = valuetotal;
                                                    tr.appendChild(td);
                                                    if (valuetotal > max) {
                                                        max = valuetotal;
                                                    }
                                                    if (valuetotal < min) {
                                                        min = valuetotal;
                                                    }
                                                    total += chart_flow.dataProvider[x][chart_flow.graphs[i].valueField];

                                                }
                                            }
                                            document.getElementById("totalflow1").innerHTML = Math.round(total);
                                            document.getElementById("mintotalFlow").innerHTML = min;
                                            document.getElementById("maxtotalFlow").innerHTML = max;
                                            //}//end if


                                            // CURSOR
                                            var chartCursor = new AmCharts.ChartCursor();
                                            chartCursor.categoryBalloonDateFormat = "MMM DD, YYYY ";
                                            chart_flow.addChartCursor(chartCursor);
                                            // SCROLLBAR
                                            var chartScrollbar = new AmCharts.ChartScrollbar();
                                            chartScrollbar.autoGridCount = true;
                                            chartScrollbar.scrollbarHeight = 20;
                                            chart_flow.addChartScrollbar(chartScrollbar);
                                            // LEGEND
                                            var legend = new AmCharts.AmLegend();
                                            legend.marginLeft = 110;
                                            legend.useGraphSettings = true;
                                            chart_flow.addLegend(legend);
                                            //MOUSE
                                            chart_flow.mouseWheelZoomEnabled = true;
                                            chart_flow.mouseWheelScrollEnabled = true;
                                            chart_flow.creditsPosition = "bottom-right";
                                            //EXPORT
                                            chart_flow.amExport = {
                                                top: 21,
                                                right: 21,
                                                buttonColor: '#EFEFEF',
                                                buttonRollOverColor: '#DDDDDD',
                                                exportPNG: true,
                                                exportJPG: true,
                                                exportPDF: true,
                                                exportSVG: true
                                            }
                                            // WRITE
                                            chart_flow.write("chart_canvas_Flow");
                                        });
                                    };

                                    ///////////////////chart MNF///////////////////////////////////////////////////////////////////////////////////
                                    function openChartMNF(loggerId, baseLine) {
                                        var window = $find("<%= radwindowMNF.ClientID %>");
                                        window.show();
                                        window.center();
                                        end = new Date();
                                        // end = new Date(end.setDate(end.getDate() - 9));
                                        start = new Date();
                                        start = new Date(start.setDate(start.getDate() - 30));
                                        var cDtStart = $find("<%=radDateTimePicker3.ClientID %>");
                                        var cDtEnd = $find("<%=radDateTimePicker4.ClientID %>");
                                        cDtStart.set_selectedDate(start);
                                        cDtEnd.set_selectedDate(end);
                                        start = toOADate(start);
                                        end = toOADate(end);
                                        start = start.toString().replace('.', '_');
                                        end = end.toString().replace('.', '_');
                                        console.log(start);
                                        console.log(end);
                                        var channel = { id: loggerId, max: "_max", base: baseLine, mnf: "_mnf" };
                                        channels = [];
                                        channels.push(channel);
                                        colors = [];
                                        mreds = [];
                                        mblues = [];
                                        drawChartMNF(channels[0], start, end, baseLine);
                                    };
                                    // this method is called when chart is first inited as we listen for "dataUpdated" event
                                    function zoomChartMNF() {
                                        // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
                                        chartMNF.zoomToIndexes(chartDataMNF.length - chartDataMNF.length, chartDataMNF.length - 1); urlGetDailyComplexData
                                    }



                                    function drawChartMNF(channel, start, end, baseLine) {
                                        //alert(channel.sum);

                                        var url = urlGetDailyComplexData + channel.id + "/" + start + "/" + end;
                                        $.getJSON(url, function (d) {
                                            chartDataMNF = [];
                                            //alert(channel.base);
                                            $.each(d.GetDailyComplexDataResult, function (i, val) {
                                                var parsedDate = new Date(parseInt(val.TimeStamp.substr(6)));
                                                var jsDate = new Date(parsedDate);
                                                chartDataMNF.push({
                                                    TimeStamp: jsDate
                                                });
                                                if (val.MinFlowRate != null && val.MinFlowRate != 'undefined') {
                                                    chartDataMNF[i]["'" + channel.id + "'"] = val.MinFlowRate;
                                                    chartDataMNF[i]["'" + channel.max + "'"] = val.MaxFlowRate;
                                                    chartDataMNF[i]["'" + channel.base + "'"] = baseLine;
                                                    chartDataMNF[i]["'" + channel.mnf + "'"] = val.MNF;
                                                }

                                            });


                                            //SERIAL CHART
                                            chartMNF = new AmCharts.AmSerialChart();
                                            chartMNF.pathToImages = "../../js/amcharts/images/";
                                            chartMNF.dataProvider = chartDataMNF;
                                            chartMNF.type = "serial";
                                            chartMNF.dataTableId = "chart_table_MNF";
                                            chartMNF.categoryField = "TimeStamp";
                                            chartMNF.balloon.bulletSize = 5;
                                            //ZOOM
                                            chartMNF.addListener("dataUpdated", zoomChartMNF);
                                            //AXES
                                            //X

                                            var categoryAxis = chartMNF.categoryAxis;
                                            categoryAxis.parseDates = true;
                                            categoryAxis.minPeriod = "DD";
                                            categoryAxis.dashLength = 1;
                                            categoryAxis.minorGridEnabled = true;
                                            categoryAxis.twoLineMode = true;
                                            categoryAxis.dateFormats = [{
                                                period: 'fff',
                                                format: 'JJ:NN:SS'
                                            }, {
                                                period: 'ss',
                                                format: 'JJ:NN:SS'
                                            }, {
                                                period: 'mm',
                                                format: 'JJ:NN'
                                            }, {
                                                period: 'hh',
                                                format: 'JJ:NN'
                                            }, {
                                                period: 'DD',
                                                format: 'DD'
                                            }, {
                                                period: 'WW',
                                                format: 'DD'
                                            }, {
                                                period: 'MM',
                                                format: 'YYYY'
                                            }, {
                                                period: 'YYYY',
                                                format: 'YYYY'
                                            }];

                                            categoryAxis.axisColor = "#DADADA";
                                            categoryAxis.gridAlpha = 0.15;
                                            //AXE
                                            //Y1
                                            valueAxisSum = new AmCharts.ValueAxis();
                                            valueAxisSum.axisColor = 'blue';
                                            valueAxisSum.axisThickness = 1;
                                            valueAxisSum.title = 'MinMax Flow';
                                            valueAxisSum.position = 'left';
                                            valueAxisSum.titleColor = 'blue';
                                            chartMNF.addValueAxis(valueAxisSum);
                                            //Y2 
                                            // valueAxisMNF = new AmCharts.ValueAxis();
                                            // valueAxisMNF.axisColor = 'yellow';                      
                                            // valueAxisMNF.axisThickness = 1;
                                            // valueAxisMNF.position = 'right';
                                            // valueAxisMNF.title = 'Min Flow';
                                            //// valueAxisMNF.baseValue = baseLine;
                                            // valueAxisMNF.titleColor = 'yellow';
                                            // //alert("a");
                                            // chartMNF.addValueAxis(valueAxisMNF);

                                            //Y1
                                            valueAxisBaseline = new AmCharts.ValueAxis();
                                            valueAxisBaseline.axisColor = 'red';
                                            valueAxisBaseline.axisThickness = 1;
                                            valueAxisBaseline.title = 'Baseline';
                                            valueAxisBaseline.position = 'right';
                                            valueAxisBaseline.titleColor = 'red';
                                            chartMNF.addValueAxis(valueAxisBaseline);
                                            //GRAPH COLOR



                                            // GRAPH
                                            var graph1 = new AmCharts.AmGraph();
                                            //alert("a");
                                            graph1.id = "MNF";
                                            graph1.valueAxis = valueAxisSum;
                                            graph1.title = "Min Flow";
                                            graph1.valueField = "'" + channel.id + "'";
                                            graph1.bullet = "round";
                                            graph1.bulletBorderColor = "#FFFFFF";
                                            // graph.negativeBase = baseLine;
                                            // graph.negativeLineColor = "red";                        
                                            graph1.bulletBorderThickness = 2;
                                            graph1.bulletBorderAlpha = 1;
                                            graph1.bulletSize = 8;
                                            graph1.lineThickness = 1;
                                            graph1.lineColor = "yellow";
                                            graph1.hideBulletsCount = 50;
                                            //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                            chartMNF.addGraph(graph1);

                                            // GRAPH                       
                                            var graph2 = new AmCharts.AmGraph();
                                            //alert("a");
                                            graph2.id = "MNFSUM";
                                            graph2.valueAxis = valueAxisSum;
                                            graph2.title = "Max Flow";
                                            graph2.valueField = "'" + channel.max + "'";
                                            graph2.bullet = "round";
                                            graph2.bulletBorderColor = "#FFFFFF";
                                            // graph.negativeBase = 25;
                                            // graph.negativeLineColor = "green";                        
                                            graph2.bulletBorderThickness = 2;
                                            graph2.bulletBorderAlpha = 1;
                                            graph2.bulletSize = 8;
                                            graph2.lineThickness = 1;
                                            graph2.lineColor = "blue";
                                            graph2.hideBulletsCount = 50;
                                            //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                            chartMNF.addGraph(graph2);

                                            // GRAPH                       
                                            var graph4 = new AmCharts.AmGraph();
                                            //alert("a");
                                            graph4.id = "MNFst";
                                            graph4.valueAxis = valueAxisSum;
                                            graph4.title = "MNF";
                                            graph4.valueField = "'" + channel.mnf + "'";
                                            graph4.bullet = "round";
                                            graph4.bulletBorderColor = "#FFFFFF";
                                            // graph.negativeBase = 25;
                                            // graph.negativeLineColor = "green";                        
                                            graph4.bulletBorderThickness = 2;
                                            graph4.bulletBorderAlpha = 1;
                                            graph4.bulletSize = 8;
                                            graph4.lineThickness = 1;
                                            graph4.lineColor = "pink";
                                            graph4.hideBulletsCount = 50;
                                            //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                            chartMNF.addGraph(graph4);

                                            //  GRAPH 
                                            var graph3 = new AmCharts.AmGraph();
                                            //alert("a");
                                            //graph3.id = "Baseline";
                                            graph3.valueAxis = valueAxisSum;
                                            graph3.title = "BaseLine";
                                            graph3.valueField = "'" + channel.base + "'";
                                            graph3.bullet = "round";
                                            graph3.bulletBorderColor = "#FFFFFF";
                                            // graph.negativeBase = 25;
                                            // graph.negativeLineColor = "green";                        
                                            graph3.bulletBorderThickness = 2;
                                            graph3.bulletBorderAlpha = 1;
                                            graph3.bulletSize = 8;
                                            graph3.lineThickness = 1;
                                            graph3.lineColor = "red";
                                            graph3.hideBulletsCount = 50;
                                            //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                            chartMNF.addGraph(graph3);


                                            //add table

                                            var total = 0;
                                            var min = 1000000;
                                            var minmnf = 100000;
                                            var max = 0;
                                            var maxmnf = 0;
                                            // get chart data
                                            var data = chartMNF.dataProvider;
                                            // create a table
                                            var holder = document.getElementById(chartMNF.dataTableId);
                                            holder.innerHTML = "";
                                            // if (holder.childElementCount == 0) {
                                            var table = document.createElement("table");
                                            holder.appendChild(table);
                                            var tr, td;

                                            // add first row
                                            for (var x = 0; x < chartMNF.dataProvider.length; x++) {

                                                // first row
                                                if (x == 0) {
                                                    tr = document.createElement("tr");
                                                    table.appendChild(tr);
                                                    td = document.createElement("th");
                                                    //td.innerHTML = chartMNF.categoryAxis.title;
                                                    td.innerHTML = "Timestamp";
                                                    tr.appendChild(td);
                                                    for (var i = 0; i < chartMNF.graphs.length - 1; i++) {
                                                        td = document.createElement('th');
                                                        td.innerHTML = chartMNF.graphs[i].title;
                                                        tr.appendChild(td);
                                                    }
                                                }

                                                // add rows
                                                tr = document.createElement("tr");
                                                table.appendChild(tr);
                                                td = document.createElement("td");
                                                td.className = "row-title";

                                                // td.innerHTML = chartMNF.dataProvider[x][chartMNF.categoryField].toUTCString();
                                                var todayTime = new Date(chartMNF.dataProvider[x][chartMNF.categoryField]);
                                                var month = todayTime.getMonth() + 1;
                                                var day = todayTime.getDate();
                                                var year = todayTime.getFullYear();
                                                var dt = day + "/" + month + "/" + year;
                                                // alert(dt + "aaaa");
                                                // var dt = chartMNF.dataProvider[x][chartMNF.categoryField].substr(14);
                                                td.innerHTML = dt;
                                                tr.appendChild(td);
                                                // alert(chartMNF.graphs.length);
                                                var valuetotal;
                                                for (var i = 0; i < chartMNF.graphs.length - 1; i++) {
                                                    td = document.createElement('td');
                                                    td.innerHTML = chartMNF.dataProvider[x][chartMNF.graphs[i].valueField];
                                                    valuetotal = chartMNF.dataProvider[x][chartMNF.graphs[i].valueField];
                                                    tr.appendChild(td);
                                                    if (valuetotal > max) {
                                                        max = valuetotal;
                                                    }
                                                    if (valuetotal < min) {
                                                        min = valuetotal;
                                                    }
                                                    if (i == 2) {


                                                        if (valuetotal < minmnf) {
                                                            minmnf = valuetotal;
                                                        }
                                                        if (valuetotal > maxmnf) {
                                                            maxmnf = valuetotal;
                                                        }
                                                    }
                                                    //if (i == 1)
                                                    //   {
                                                    //    total += chartMNF.dataProvider[x][chartMNF.graphs[i].valueField];
                                                    //   }
                                                }
                                            }
                                            document.getElementById("minFlow").innerHTML = min;
                                            document.getElementById("maxFlow").innerHTML = max;
                                            document.getElementById("minMNFst").innerHTML = minmnf;
                                            document.getElementById("maxMNFst").innerHTML = maxmnf;
                                            // document.getElementById("totalMNF").innerHTML = Math.round(total);
                                            // $("#totalflow").load("total");
                                            //  }//end if


                                            // CURSOR
                                            var chartCursor = new AmCharts.ChartCursor();
                                            chartCursor.categoryBalloonDateFormat = "MMM DD, YYYY ";
                                            chartMNF.addChartCursor(chartCursor);
                                            // SCROLLBAR
                                            var chartScrollbar = new AmCharts.ChartScrollbar();
                                            chartScrollbar.autoGridCount = true;
                                            chartScrollbar.scrollbarHeight = 20;
                                            chartMNF.addChartScrollbar(chartScrollbar);
                                            // LEGEND
                                            var legend = new AmCharts.AmLegend();
                                            legend.marginLeft = 110;
                                            legend.useGraphSettings = true;
                                            chartMNF.addLegend(legend);
                                            //MOUSE
                                            chartMNF.mouseWheelZoomEnabled = true;
                                            chartMNF.mouseWheelScrollEnabled = true;
                                            chartMNF.creditsPosition = "bottom-right";
                                            //EXPORT
                                            chartMNF.amExport = {
                                                top: 21,
                                                right: 21,
                                                buttonColor: '#EFEFEF',
                                                buttonRollOverColor: '#DDDDDD',
                                                exportPNG: true,
                                                exportJPG: true,
                                                exportPDF: true,
                                                exportSVG: true
                                            }
                                            // WRITE
                                            chartMNF.write("chart_canvas_MNF");
                                        });
                                    };
                                    ///////////////////chart minmax Press///////////////////////////////////////////////////////////////////////////////////
                                    function openChartMinMaxPre(loggerId) {
                                        var window = $find("<%= radminmaxPress.ClientID %>");
                                        window.show();
                                        window.center();
                                        end = new Date();
                                        start = new Date();
                                        start = new Date(start.setDate(start.getDate() - 30));
                                        var cDtStart = $find("<%=radDateTimePicker5.ClientID %>");
                                        var cDtEnd = $find("<%=radDateTimePicker6.ClientID %>");
                                        cDtStart.set_selectedDate(start);
                                        cDtEnd.set_selectedDate(end);
                                        start = toOADate(start);
                                        end = toOADate(end);
                                        start = start.toString().replace('.', '_');
                                        end = end.toString().replace('.', '_');
                                        console.log(start);
                                        console.log(end);
                                        var channel = { id: loggerId, max: "_max" };
                                        channels = [];
                                        channels.push(channel);
                                        colors = [];
                                        mreds = [];
                                        mblues = [];
                                        drawChartMinMax(channels[0], start, end);
                                    };
                                    // this method is called when chart is first inited as we listen for "dataUpdated" event
                                    function zoomchartMinMax() {
                                        // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
                                        chartMinMax.zoomToIndexes(chartDataMinMax.length - chartDataMinMax.length, chartDataMinMax.length - 1); urlGetDailyComplexData
                                    }


                                    function drawChartMinMax(channel, start, end) {
                                        //alert(channel.sum);

                                        var url = urlGetDailyComplexData + channel.id + "/" + start + "/" + end;
                                        $.getJSON(url, function (d) {
                                            chartDataMinMax = [];
                                            //alert(channel.base);
                                            $.each(d.GetDailyComplexDataResult, function (i, val) {
                                                var parsedDate = new Date(parseInt(val.TimeStamp.substr(6)));
                                                var jsDate = new Date(parsedDate);
                                                chartDataMinMax.push({
                                                    TimeStamp: jsDate
                                                });
                                                if (val.MinFlowRate != null && val.MinFlowRate != 'undefined') {
                                                    chartDataMinMax[i]["'" + channel.id + "'"] = val.MinPressure;
                                                    chartDataMinMax[i]["'" + channel.max + "'"] = val.MaxPressure;

                                                }

                                            });


                                            //SERIAL CHART
                                            chartMinMax = new AmCharts.AmSerialChart();
                                            chartMinMax.pathToImages = "../../js/amcharts/images/";
                                            chartMinMax.dataProvider = chartDataMinMax;
                                            chartMinMax.type = "serial";
                                            chartMinMax.dataTableId = "chart_table_MinMax";
                                            chartMinMax.categoryField = "TimeStamp";
                                            chartMinMax.balloon.bulletSize = 5;
                                            //ZOOM
                                            chartMinMax.addListener("dataUpdated", zoomchartMinMax);
                                            //AXES
                                            //X

                                            var categoryAxis = chartMinMax.categoryAxis;
                                            categoryAxis.parseDates = true;
                                            categoryAxis.minPeriod = "DD";
                                            categoryAxis.dashLength = 1;
                                            categoryAxis.minorGridEnabled = true;
                                            categoryAxis.twoLineMode = true;
                                            categoryAxis.dateFormats = [{
                                                period: 'fff',
                                                format: 'JJ:NN:SS'
                                            }, {
                                                period: 'ss',
                                                format: 'JJ:NN:SS'
                                            }, {
                                                period: 'mm',
                                                format: 'JJ:NN'
                                            }, {
                                                period: 'hh',
                                                format: 'JJ:NN'
                                            }, {
                                                period: 'DD',
                                                format: 'DD'
                                            }, {
                                                period: 'WW',
                                                format: 'DD'
                                            }, {
                                                period: 'MM',
                                                format: 'YYYY'
                                            }, {
                                                period: 'YYYY',
                                                format: 'YYYY'
                                            }];

                                            categoryAxis.axisColor = "#DADADA";
                                            categoryAxis.gridAlpha = 0.15;
                                            //AXE
                                            //Y1
                                            valueAxisSum = new AmCharts.ValueAxis();
                                            valueAxisSum.axisColor = 'blue';
                                            valueAxisSum.axisThickness = 1;
                                            valueAxisSum.title = 'MinMax Pressure';
                                            valueAxisSum.position = 'left';
                                            valueAxisSum.titleColor = 'blue';
                                            chartMinMax.addValueAxis(valueAxisSum);

                                            //GRAPH COLOR


                                            // GRAPH
                                            var graph1 = new AmCharts.AmGraph();
                                            //alert("a");
                                            graph1.id = "MNF";
                                            graph1.valueAxis = valueAxisSum;
                                            graph1.title = "Min Press";
                                            graph1.valueField = "'" + channel.id + "'";
                                            graph1.bullet = "round";
                                            graph1.bulletBorderColor = "#FFFFFF";
                                            // graph.negativeBase = baseLine;
                                            // graph.negativeLineColor = "red";                        
                                            graph1.bulletBorderThickness = 2;
                                            graph1.bulletBorderAlpha = 1;
                                            graph1.bulletSize = 8;
                                            graph1.lineThickness = 1;
                                            graph1.lineColor = "yellow";
                                            graph1.hideBulletsCount = 50;
                                            //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                            chartMinMax.addGraph(graph1);

                                            // GRAPH                       
                                            var graph2 = new AmCharts.AmGraph();
                                            //alert("a");
                                            graph2.id = "MNFSUM";
                                            graph2.valueAxis = valueAxisSum;
                                            graph2.title = "Max Press";
                                            graph2.valueField = "'" + channel.max + "'";
                                            graph2.bullet = "round";
                                            graph2.bulletBorderColor = "#FFFFFF";
                                            // graph.negativeBase = 25;
                                            // graph.negativeLineColor = "green";                        
                                            graph2.bulletBorderThickness = 2;
                                            graph2.bulletBorderAlpha = 1;
                                            graph2.bulletSize = 8;
                                            graph2.lineThickness = 1;
                                            graph2.lineColor = "blue";
                                            graph2.hideBulletsCount = 50;
                                            //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                            chartMinMax.addGraph(graph2);


                                            //add table

                                            var total = 0;
                                            var min = 100000;
                                            var max = 0;
                                            // get chart data
                                            var data = chartMinMax.dataProvider;
                                            // create a table
                                            var holder = document.getElementById(chartMinMax.dataTableId);
                                            holder.innerHTML = "";
                                            // if (holder.childElementCount == 0) {
                                            var table = document.createElement("table");
                                            holder.appendChild(table);
                                            var tr, td;

                                            // add first row
                                            for (var x = 0; x < chartMinMax.dataProvider.length; x++) {

                                                // first row
                                                if (x == 0) {
                                                    tr = document.createElement("tr");
                                                    table.appendChild(tr);
                                                    td = document.createElement("th");
                                                    //td.innerHTML = chartMinMax.categoryAxis.title;
                                                    td.innerHTML = "Timestamp";
                                                    tr.appendChild(td);
                                                    for (var i = 0; i < chartMinMax.graphs.length; i++) {
                                                        td = document.createElement('th');
                                                        td.innerHTML = chartMinMax.graphs[i].title;
                                                        tr.appendChild(td);
                                                    }
                                                }

                                                // add rows
                                                tr = document.createElement("tr");
                                                table.appendChild(tr);
                                                td = document.createElement("td");
                                                td.className = "row-title";

                                                // td.innerHTML = chartMinMax.dataProvider[x][chartMinMax.categoryField].toUTCString();
                                                var todayTime = new Date(chartMinMax.dataProvider[x][chartMinMax.categoryField]);
                                                var month = todayTime.getMonth() + 1;
                                                var day = todayTime.getDate();
                                                var year = todayTime.getFullYear();
                                                var dt = day + "/" + month + "/" + year;
                                                // alert(dt + "aaaa");
                                                // var dt = chartMinMax.dataProvider[x][chartMinMax.categoryField].substr(14);
                                                td.innerHTML = dt;
                                                tr.appendChild(td);
                                                var valuetotal;
                                                for (var i = 0; i < chartMinMax.graphs.length; i++) {
                                                    td = document.createElement('td');
                                                    valuetotal = chartMinMax.dataProvider[x][chartMinMax.graphs[i].valueField];
                                                    td.innerHTML = valuetotal;
                                                    tr.appendChild(td);
                                                    if (valuetotal > max) {
                                                        max = valuetotal;
                                                    }
                                                    if (valuetotal < min) {
                                                        min = valuetotal;
                                                    }
                                                    //if (i == 1)
                                                    //   {
                                                    //    total += chartMinMax.dataProvider[x][chartMinMax.graphs[i].valueField];
                                                    //   }
                                                }
                                            }
                                            //document.getElementById("totalMinMax").innerHTML = Math.round(total);
                                            document.getElementById("minPress").innerHTML = min;
                                            document.getElementById("maxPress").innerHTML = max;
                                            // $("#totalflow").load("total");
                                            //  }//end if


                                            // CURSOR
                                            var chartCursor = new AmCharts.ChartCursor();
                                            chartCursor.categoryBalloonDateFormat = "MMM DD, YYYY ";
                                            chartMinMax.addChartCursor(chartCursor);
                                            // SCROLLBAR
                                            var chartScrollbar = new AmCharts.ChartScrollbar();
                                            chartScrollbar.autoGridCount = true;
                                            chartScrollbar.scrollbarHeight = 20;
                                            chartMinMax.addChartScrollbar(chartScrollbar);
                                            // LEGEND
                                            var legend = new AmCharts.AmLegend();
                                            legend.marginLeft = 110;
                                            legend.useGraphSettings = true;
                                            chartMinMax.addLegend(legend);
                                            //MOUSE
                                            chartMinMax.mouseWheelZoomEnabled = true;
                                            chartMinMax.mouseWheelScrollEnabled = true;
                                            chartMinMax.creditsPosition = "bottom-right";
                                            //EXPORT
                                            chartMinMax.amExport = {
                                                top: 21,
                                                right: 21,
                                                buttonColor: '#EFEFEF',
                                                buttonRollOverColor: '#DDDDDD',
                                                exportPNG: true,
                                                exportJPG: true,
                                                exportPDF: true,
                                                exportSVG: true
                                            }
                                            // WRITE
                                            chartMinMax.write("chart_canvas_MinMax");
                                        });
                                    };
                                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                                    function openChart(channelId, namePath, unit, baseLine) {
                                        var window = $find("<%= radWindowChart.ClientID %>");
                                        window.show();
                                        window.center();
                                        end = new Date();
                                        start = new Date();
                                        start = new Date(start.setDate(start.getDate() - 10));
                                        var cDtStart = $find("<%=radDateTimePickerStart.ClientID %>");
                                        var cDtEnd = $find("<%=radDateTimePickerEnd.ClientID %>");
                                        cDtStart.set_selectedDate(start);
                                        cDtEnd.set_selectedDate(end);
                                        start = toOADate(start);
                                        end = toOADate(end);
                                        start = start.toString().replace('.', '_');
                                        end = end.toString().replace('.', '_');
                                        var channel = { id: channelId, namePath: namePath, unit: unit, base: baseLine };
                                        channels = [];
                                        channels.push(channel);
                                        colors = [];
                                        mreds = [];
                                        mblues = [];
                                        drawChart(channels[0], start, end, baseLine);
                                    };

                                    // this method is called when chart is first inited as we listen for "dataUpdated" event
                                    function zoomChart() {
                                        // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
                                        chart.zoomToIndexes(chartData.length - chartData.length, chartData.length - 1);
                                    }

                                    // changes cursor mode from pan to select
                                    function setPanSelect() {
                                        if (document.getElementById("rb1").checked) {
                                            chartCursor.pan = false;
                                            chartCursor.zoomable = true;
                                        } else {
                                            chartCursor.pan = true;
                                        }
                                        chart.validateNow();
                                    }

                                    function drawChart(channel, start, end, baseLine) {
                                        var url = urlGetChannelData + channel.id + "/" + start + "/" + end;
                                        $.getJSON(url, function (d) {
                                            chartData = [];
                                            $.each(d.GetChannelDataResult, function (i, val) {
                                                var parsedDate = new Date(parseInt(val.Timestamp.substr(6)));
                                                var jsDate = new Date(parsedDate);
                                                chartData.push({
                                                    Timestamp: jsDate
                                                });
                                                if (val.Value != null && val.Value != 'undefined') {
                                                    chartData[i]["'" + channel.id + "'"] = val.Value;
                                                    chartData[i]["'" + channel.base + "'"] = baseLine;
                                                }
                                            });
                                            //SERIAL CHART
                                            chart = new AmCharts.AmSerialChart();
                                            chart.pathToImages = "../../js/amcharts/images/";
                                            chart.dataProvider = chartData;
                                            chart.type = "serial";
                                            chart.dataTableId = "chart_table";
                                            chart.categoryField = "Timestamp";
                                            chart.balloon.bulletSize = 5;
                                            //ZOOM
                                            chart.addListener("dataUpdated", zoomChart);
                                            //AXES
                                            //X
                                            var categoryAxis = chart.categoryAxis;
                                            categoryAxis.parseDates = true;
                                            categoryAxis.minPeriod = "mm";
                                            categoryAxis.dashLength = 1;
                                            categoryAxis.minorGridEnabled = true;
                                            categoryAxis.twoLineMode = true;
                                            categoryAxis.dateFormats = [{
                                                period: 'fff',
                                                format: 'JJ:NN:SS'
                                            }, {
                                                period: 'ss',
                                                format: 'JJ:NN:SS'
                                            }, {
                                                period: 'mm',
                                                format: 'JJ:NN'
                                            }, {
                                                period: 'hh',
                                                format: 'JJ:NN'
                                            }, {
                                                period: 'DD',
                                                format: 'DD'
                                            }, {
                                                period: 'WW',
                                                format: 'DD'
                                            }, {
                                                period: 'MM',
                                                format: 'YYYY'
                                            }, {
                                                period: 'YYYY',
                                                format: 'YYYY'
                                            }];

                                            categoryAxis.axisColor = "#DADADA";
                                            categoryAxis.gridAlpha = 0.15;
                                            //AXE
                                            //Y1
                                            valueAxisPress = new AmCharts.ValueAxis();
                                            valueAxisPress.axisColor = 'red';
                                            valueAxisPress.axisThickness = 1;
                                            valueAxisPress.title = 'm';
                                            valueAxisPress.titleColor = 'red';
                                            chart.addValueAxis(valueAxisPress);
                                            //Y2 
                                            valueAxisFlow = new AmCharts.ValueAxis();
                                            valueAxisFlow.axisColor = 'blue';
                                            valueAxisFlow.axisThickness = 1;
                                            valueAxisFlow.position = 'right';
                                            valueAxisFlow.title = 'm3/h';
                                            valueAxisFlow.titleColor = 'blue';
                                            chart.addValueAxis(valueAxisFlow);
                                            //GRAPH COLOR
                                            var type;
                                            var color;
                                            switch (channel.unit) {
                                                case "m":
                                                    type = valueAxisPress;
                                                    color = '#ff0000';
                                                    colors.push(color);
                                                    break;
                                                case "m3/h":
                                                    type = valueAxisFlow;
                                                    color = '#0000ff';
                                                    colors.push(color);
                                                    break;
                                                default:
                                                    type = valueAxisPress;
                                                    break;
                                            }
                                            // GRAPH
                                            var graph = new AmCharts.AmGraph();
                                            graph.id = channel.namePath;
                                            graph.valueAxis = type;
                                            graph.title = channel.namePath;
                                            graph.valueField = "'" + channel.id + "'";
                                            graph.bullet = "round";
                                            graph.bulletBorderColor = "#FFFFFF";
                                            graph.bulletBorderThickness = 2;
                                            graph.bulletBorderAlpha = 1;
                                            graph.bulletSize = 8;
                                            graph.lineThickness = 1;
                                            graph.lineColor = color;
                                            graph.hideBulletsCount = 50;
                                            //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";
                                            chart.addGraph(graph);

                                            //add baseline Flow
                                            if (channel.unit == "m3/h") {
                                                //graph baseline
                                                var graph = new AmCharts.AmGraph();
                                                graph.valueAxis = valueAxisFlow;
                                                graph.valueField = "'" + channel.base + "'";
                                                graph.title = "Baseline";
                                                graph.bullet = "round";
                                                graph.bulletBorderThickness = 2;
                                                graph.bulletSize = 8;
                                                graph.lineThickness = 1;
                                                graph.lineColor = "red";
                                                graph.hideBulletsCount = 50;
                                                chart.addGraph(graph);


                                                var total = 0;
                                                var min = 100000;
                                                var max = 0;
                                                // check if export to table is enabled
                                                if (chart.dataTableId === undefined)
                                                    return;
                                                // get chart data
                                                var data = chart.dataProvider;
                                                // create a table
                                                var holder = document.getElementById(chart.dataTableId);
                                                holder.innerHTML = "";

                                                var table = document.createElement("table");
                                                holder.appendChild(table);

                                                var tr, td;

                                                // add first row
                                                for (var x = 0; x < chart.dataProvider.length; x++) {
                                                    // first row
                                                    if (x == 0) {
                                                        tr = document.createElement("tr");
                                                        table.appendChild(tr);
                                                        td = document.createElement("th");
                                                        //td.innerHTML = chart.categoryAxis.title;
                                                        td.innerHTML = "Timestamp";
                                                        tr.appendChild(td);
                                                        for (var i = 0; i < chart.graphs.length - 1; i++) {
                                                            td = document.createElement('th');
                                                            td.innerHTML = chart.graphs[i].title;
                                                            tr.appendChild(td);
                                                        }
                                                    }

                                                    // add rows
                                                    tr = document.createElement("tr");
                                                    table.appendChild(tr);
                                                    td = document.createElement("td");
                                                    td.className = "row-title";
                                                    td.innerHTML = chart.dataProvider[x][chart.categoryField].toUTCString();
                                                    tr.appendChild(td);

                                                    for (var i = 0; i < chart.graphs.length - 1; i++) {
                                                        td = document.createElement('td');
                                                        td.innerHTML = chart.dataProvider[x][chart.graphs[i].valueField];
                                                        tr.appendChild(td);
                                                        var temp = chart.dataProvider[x][chart.graphs[i].valueField];
                                                        if (temp < min) {
                                                            min = temp;
                                                        }
                                                        if (temp > max) {
                                                            max = temp;
                                                        }
                                                        total += chart.dataProvider[x][chart.graphs[i].valueField];
                                                    }
                                                }
                                                document.getElementById("totalflow").innerHTML = Math.round(total);
                                                document.getElementById("minMNF").innerHTML = min;
                                                document.getElementById("dnzBaseline").innerHTML = max;

                                            }
                                            if (channel.unit == "m") {
                                                var total = 0;
                                                var min = 10000;
                                                var max = 0;
                                                // check if export to table is enabled
                                                if (chart.dataTableId === undefined)
                                                    return;
                                                // get chart data
                                                var data = chart.dataProvider;
                                                // create a table
                                                var holder = document.getElementById(chart.dataTableId);
                                                holder.innerHTML = "";

                                                var table = document.createElement("table");
                                                holder.appendChild(table);

                                                var tr, td;

                                                // add first row
                                                for (var x = 0; x < chart.dataProvider.length; x++) {
                                                    // first row
                                                    if (x == 0) {
                                                        tr = document.createElement("tr");
                                                        table.appendChild(tr);
                                                        td = document.createElement("th");
                                                        //td.innerHTML = chart.categoryAxis.title;
                                                        td.innerHTML = "Timestamp";
                                                        tr.appendChild(td);
                                                        for (var i = 0; i < chart.graphs.length; i++) {
                                                            td = document.createElement('th');
                                                            td.innerHTML = chart.graphs[i].title;
                                                            tr.appendChild(td);
                                                        }
                                                    }

                                                    // add rows
                                                    tr = document.createElement("tr");
                                                    table.appendChild(tr);
                                                    td = document.createElement("td");
                                                    td.className = "row-title";
                                                    td.innerHTML = chart.dataProvider[x][chart.categoryField].toUTCString();
                                                    tr.appendChild(td);

                                                    for (var i = 0; i < chart.graphs.length; i++) {
                                                        td = document.createElement('td');
                                                        td.innerHTML = chart.dataProvider[x][chart.graphs[i].valueField];
                                                        tr.appendChild(td);
                                                        var temp = chart.dataProvider[x][chart.graphs[i].valueField];
                                                        if (temp < min) {
                                                            min = temp;
                                                        }
                                                        if (temp > max) {
                                                            max = temp;
                                                        }
                                                        // total += chart.dataProvider[x][chart.graphs[i].valueField];
                                                    }
                                                }
                                                document.getElementById("totalflow").innerHTML = "View Channel Flow";
                                                document.getElementById("minMNF").innerHTML = min;
                                                document.getElementById("dnzBaseline").innerHTML = max;
                                            }//end table

                                            // CURSOR
                                            var chartCursor = new AmCharts.ChartCursor();
                                            chartCursor.categoryBalloonDateFormat = "MMM DD, YYYY JJ:NN";
                                            chart.addChartCursor(chartCursor);
                                            // SCROLLBAR
                                            var chartScrollbar = new AmCharts.ChartScrollbar();
                                            chartScrollbar.autoGridCount = true;
                                            chartScrollbar.scrollbarHeight = 20;
                                            chart.addChartScrollbar(chartScrollbar);
                                            // LEGEND
                                            var legend = new AmCharts.AmLegend();
                                            legend.marginLeft = 110;
                                            legend.useGraphSettings = true;
                                            chart.addLegend(legend);
                                            //MOUSE
                                            chart.mouseWheelZoomEnabled = true;
                                            chart.mouseWheelScrollEnabled = true;
                                            chart.creditsPosition = "bottom-right";
                                            //EXPORT
                                            chart.amExport = {
                                                top: 21,
                                                right: 21,
                                                buttonColor: '#EFEFEF',
                                                buttonRollOverColor: '#DDDDDD',
                                                exportPNG: true,
                                                exportJPG: true,
                                                exportPDF: true,
                                                exportSVG: true
                                            }
                                            // WRITE
                                            chart.write("chart_canvas");
                                        });
                                    };
                                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                                    function updateChartFlow(start, end) {
                                        //  alert(channels[0].id);
                                        var url = urlGetDailyComplexData + channels[0].id + "/" + start + "/" + end;
                                        $.getJSON(url, function (d) {
                                            chartDataFlow = [];
                                            $.each(d.GetDailyComplexDataResult, function (i, val) {
                                                var parsedDate = new Date(parseInt(val.TimeStamp.substr(6)));
                                                var jsDate = new Date(parsedDate);
                                                chartDataFlow.push({
                                                    TimeStamp: jsDate
                                                });
                                                if (val.Output != null && val.Output != 'undefined') {

                                                    chartDataFlow[i]["'" + channels[0].id + "'"] = Math.round(val.Output);

                                                }

                                            });
                                            $.each(channels, function (k, c) {

                                                var m_f = false;
                                                // alert(chart_flow.graphs.length);
                                                for (var i = 0; i < chart_flow.graphs.length; i++) {

                                                    if (chart_flow.graphs[i].valueField == ("'" + c.id + "'")) {
                                                        // alert(c.id);
                                                        m_f = true;
                                                    }
                                                }
                                                if (m_f == false) {


                                                    // GRAPH                       
                                                    var graph2 = new AmCharts.AmGraph();
                                                    //alert("a");
                                                    graph2.id = "Total_Flow";
                                                    graph2.valueAxis = valueAxisSum;
                                                    graph2.title = "Total Flow";
                                                    graph2.valueField = "'" + c.id + "'";
                                                    //alert(channels[0].id);
                                                    graph2.bullet = "round";
                                                    graph2.bulletBorderColor = "#FFFFFF";
                                                    // graph.negativeBase = 25;
                                                    // graph.negativeLineColor = "green";                        
                                                    graph2.bulletBorderThickness = 2;
                                                    graph2.bulletBorderAlpha = 1;
                                                    graph2.bulletSize = 8;
                                                    graph2.lineThickness = 1;
                                                    graph2.lineColor = "blue";
                                                    graph2.hideBulletsCount = 50;
                                                    //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                                    chart_flow.addGraph(graph2);

                                                }
                                            });
                                            //SERIAL CHART
                                            chart_flow.dataTableId = "chart_table_Flow";
                                            chart_flow.dataProvider = chartDataFlow;
                                            chart_flow.validateData();
                                            chart_flow.validateNow();



                                            var total = 0;
                                            // check if export to table is enabled

                                            // get chart data
                                            var data = chart_flow.dataProvider;

                                            // create a table
                                            var holder = document.getElementById(chart_flow.dataTableId);
                                            holder.innerHTML = "";
                                            // if (holder.childElementCount == 0) {
                                            var table = document.createElement("table");
                                            holder.appendChild(table);

                                            // document.getElementById("chart_table").innerHTML(table);
                                            var tr, td;

                                            // add first row
                                            for (var x = 0; x < chart_flow.dataProvider.length; x++) {
                                                // first row
                                                if (x == 0) {
                                                    tr = document.createElement("tr");
                                                    table.appendChild(tr);
                                                    td = document.createElement("th");
                                                    //td.innerHTML = chart_flow.categoryAxis.title;
                                                    td.innerHTML = "Timestamp";
                                                    tr.appendChild(td);
                                                    for (var i = 0; i < chart_flow.graphs.length; i++) {
                                                        td = document.createElement('th');
                                                        td.innerHTML = chart_flow.graphs[i].title;
                                                        tr.appendChild(td);
                                                    }
                                                }

                                                // add rows
                                                tr = document.createElement("tr");
                                                table.appendChild(tr);
                                                td = document.createElement("td");
                                                td.className = "row-title";

                                                // td.innerHTML = chart_flow.dataProvider[x][chart_flow.categoryField].toUTCString();
                                                var todayTime = new Date(chart_flow.dataProvider[x][chart_flow.categoryField]);
                                                var month = todayTime.getMonth() + 1;
                                                var day = todayTime.getDate();
                                                var year = todayTime.getFullYear();
                                                var dt = day + "/" + month + "/" + year;
                                                // alert(dt + "aaaa");
                                                // var dt = chart_flow.dataProvider[x][chart_flow.categoryField].substr(14);
                                                td.innerHTML = dt;
                                                tr.appendChild(td);
                                                // alert(chart_flow.graphs.length);
                                                for (var i = 0; i < chart_flow.graphs.length; i++) {

                                                    td = document.createElement('td');
                                                    td.innerHTML = chart_flow.dataProvider[x][chart_flow.graphs[i].valueField];
                                                    //alert(chart_flow.dataProvider[x][chart_flow.graphs[i].valueField]);
                                                    tr.appendChild(td);

                                                    total += chart_flow.dataProvider[x][chart_flow.graphs[i].valueField];

                                                }
                                            }
                                            document.getElementById("totalflow1").innerHTML = Math.round(total);
                                            //}end if


                                        });

                                    };

                                    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////              
                                    function updateChartMNF(start, end) {
                                        //  alert(channels[0].id);
                                        var url = urlGetDailyComplexData + channels[0].id + "/" + start + "/" + end;
                                        var baseLine = channels[0].base;
                                        $.getJSON(url, function (d) {
                                            chartDataMNF = [];
                                            $.each(d.GetDailyComplexDataResult, function (i, val) {
                                                var parsedDate = new Date(parseInt(val.TimeStamp.substr(6)));
                                                var jsDate = new Date(parsedDate);
                                                chartDataMNF.push({
                                                    TimeStamp: jsDate
                                                });
                                                if (val.Output != null && val.Output != 'undefined') {

                                                    chartDataMNF[i]["'" + channels[0].id + "'"] = val.MinFlowRate;
                                                    chartDataMNF[i]["'" + channels[0].max + "'"] = val.MaxFlowRate;
                                                    chartDataMNF[i]["'" + channels[0].base + "'"] = baseLine;
                                                    chartDataMNF[i]["'" + channels[0].mnf + "'"] = val.MNF;
                                                }
                                                //for (var j = 0; j < channels.length; j++) {
                                                //    if (val.Values[j] != null && val.Values[j] != 'undefined')
                                                //        chartData[i]["'" + channels[j].id + "'"] = val.Values[j];
                                                //}

                                            });

                                            $.each(channels, function (k, c) {

                                                var m_f = false;
                                                // alert(chart_flow.graphs.length);
                                                for (var i = 0; i < chartMNF.graphs.length; i++) {

                                                    if (chartMNF.graphs[i].valueField == ("'" + c.id + "'")) {
                                                        // alert(c.id);
                                                        m_f = true;
                                                    }
                                                }
                                                if (m_f == false) {

                                                    // GRAPH
                                                    var graph1 = new AmCharts.AmGraph();
                                                    //alert("a");
                                                    graph1.id = "MNF";
                                                    graph1.valueAxis = valueAxisSum;
                                                    graph1.title = "Min Flow";
                                                    graph1.valueField = "'" + channels[0].id + "'";
                                                    graph1.bullet = "round";
                                                    graph1.bulletBorderColor = "#FFFFFF";
                                                    // graph.negativeBase = 25;
                                                    // graph.negativeLineColor = "green";                        
                                                    graph1.bulletBorderThickness = 2;
                                                    graph1.bulletBorderAlpha = 1;
                                                    graph1.bulletSize = 8;
                                                    graph1.lineThickness = 1;
                                                    graph1.lineColor = "yellow";
                                                    graph1.hideBulletsCount = 50;
                                                    //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                                    chartMNF.addGraph(graph1);

                                                    // GRAPH                       
                                                    var graph2 = new AmCharts.AmGraph();
                                                    //alert("a");
                                                    graph2.id = "MNFSUM";
                                                    graph2.valueAxis = valueAxisSum;
                                                    graph2.title = "Max Flow";
                                                    graph2.valueField = "'" + channels[0].max + "'";
                                                    graph2.bullet = "round";
                                                    graph2.bulletBorderColor = "#FFFFFF";
                                                    // graph.negativeBase = 25;
                                                    // graph.negativeLineColor = "green";                        
                                                    graph2.bulletBorderThickness = 2;
                                                    graph2.bulletBorderAlpha = 1;
                                                    graph2.bulletSize = 8;
                                                    graph2.lineThickness = 1;
                                                    graph2.lineColor = "blue";
                                                    graph2.hideBulletsCount = 50;
                                                    //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                                    chartMNF.addGraph(graph2);

                                                    // GRAPH                       
                                                    var graph4 = new AmCharts.AmGraph();
                                                    //alert("a");
                                                    graph4.id = "MNFst";
                                                    graph4.valueAxis = valueAxisSum;
                                                    graph4.title = "MNF";
                                                    graph4.valueField = "'" + channels[0].mnf + "'";
                                                    graph4.bullet = "round";
                                                    graph4.bulletBorderColor = "#FFFFFF";
                                                    // graph.negativeBase = 25;
                                                    // graph.negativeLineColor = "green";                        
                                                    graph4.bulletBorderThickness = 2;
                                                    graph4.bulletBorderAlpha = 1;
                                                    graph4.bulletSize = 8;
                                                    graph4.lineThickness = 1;
                                                    graph4.lineColor = "pink";
                                                    graph4.hideBulletsCount = 50;
                                                    //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                                    chartMNF.addGraph(graph4);

                                                }
                                            });

                                            //SERIAL CHART
                                            chartMNF.dataTableId = "chart_table_MNF";
                                            chartMNF.dataProvider = chartDataMNF;
                                            chartMNF.validateData();
                                            chartMNF.validateNow();

                                            //add table
                                            var total = 0;
                                            var min = 1000000;
                                            var minmnf = 10000;
                                            var maxmnf = 0;
                                            var max = 0;
                                            // get chart data
                                            var data = chartMNF.dataProvider;
                                            // create a table
                                            var holder = document.getElementById(chartMNF.dataTableId);
                                            holder.innerHTML = "";
                                            // if (holder.childElementCount == 0) {
                                            var table = document.createElement("table");
                                            holder.appendChild(table);
                                            var tr, td;
                                            // add first row
                                            for (var x = 0; x < chartMNF.dataProvider.length; x++) {
                                                // first row
                                                if (x == 0) {
                                                    tr = document.createElement("tr");
                                                    table.appendChild(tr);
                                                    td = document.createElement("th");
                                                    //td.innerHTML = chartMNF.categoryAxis.title;
                                                    td.innerHTML = "Timestamp";
                                                    tr.appendChild(td);
                                                    for (var i = 0; i < chartMNF.graphs.length - 1; i++) {
                                                        td = document.createElement('th');
                                                        td.innerHTML = chartMNF.graphs[i].title;
                                                        tr.appendChild(td);
                                                    }
                                                }
                                                // add rows
                                                tr = document.createElement("tr");
                                                table.appendChild(tr);
                                                td = document.createElement("td");
                                                td.className = "row-title";

                                                // td.innerHTML = chartMNF.dataProvider[x][chartMNF.categoryField].toUTCString();
                                                var todayTime = new Date(chartMNF.dataProvider[x][chartMNF.categoryField]);
                                                var month = todayTime.getMonth() + 1;
                                                var day = todayTime.getDate();
                                                var year = todayTime.getFullYear();
                                                var dt = day + "/" + month + "/" + year;
                                                td.innerHTML = dt;
                                                tr.appendChild(td);
                                                // alert(chartMNF.graphs.length);
                                                var valuetotal;
                                                for (var i = 0; i < chartMNF.graphs.length - 1; i++) {
                                                    td = document.createElement('td');
                                                    td.innerHTML = chartMNF.dataProvider[x][chartMNF.graphs[i].valueField];
                                                    valuetotal = chartMNF.dataProvider[x][chartMNF.graphs[i].valueField];
                                                    tr.appendChild(td);
                                                    if (valuetotal > max) {
                                                        max = valuetotal;
                                                    }
                                                    if (valuetotal < min) {
                                                        min = valuetotal;
                                                    }
                                                    if (i == 2) {


                                                        if (valuetotal < minmnf) {
                                                            minmnf = valuetotal;
                                                        }
                                                        if (valuetotal > maxmnf) {
                                                            maxmnf = valuetotal;
                                                        }
                                                    }
                                                    //if (i == 1) {
                                                    //    total += chartMNF.dataProvider[x][chartMNF.graphs[i].valueField];
                                                    //}
                                                }
                                            }
                                            document.getElementById("minFlow").innerHTML = min;
                                            document.getElementById("maxFlow").innerHTML = max;
                                            document.getElementById("minMNFst").innerHTML = minmnf;
                                            document.getElementById("maxMNFst").innerHTML = maxmnf;
                                            //document.getElementById("totalMNF").innerHTML = Math.round(total);
                                            // $("#totalflow").load("total");
                                            //  }//end if

                                        });
                                    };
                                    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////              
                                    function updateChartMinMax(start, end) {
                                        //alert("a");
                                        var url = urlGetDailyComplexData + channels[0].id + "/" + start + "/" + end;
                                        //var baseLine = channels[0].base;
                                        $.getJSON(url, function (d) {
                                            chartDataMinMax = [];
                                            $.each(d.GetDailyComplexDataResult, function (i, val) {
                                                var parsedDate = new Date(parseInt(val.TimeStamp.substr(6)));
                                                var jsDate = new Date(parsedDate);
                                                chartDataMinMax.push({
                                                    TimeStamp: jsDate
                                                });
                                                if (val.Output != null && val.Output != 'undefined') {

                                                    chartDataMinMax[i]["'" + channels[0].id + "'"] = val.MinPressure;
                                                    chartDataMinMax[i]["'" + channels[0].max + "'"] = val.MaxPressure;

                                                }

                                            });

                                            $.each(channels, function (k, c) {

                                                var m_f = false;
                                                // alert(chart_flow.graphs.length);
                                                for (var i = 0; i < chartMinMax.graphs.length; i++) {

                                                    if (chartMinMax.graphs[i].valueField == ("'" + c.id + "'")) {
                                                        // alert(c.id);
                                                        m_f = true;
                                                    }
                                                }
                                                if (m_f == false) {

                                                    // GRAPH
                                                    var graph1 = new AmCharts.AmGraph();
                                                    //alert("a");
                                                    graph1.id = "MNF";
                                                    graph1.valueAxis = valueAxisSum;
                                                    graph1.title = "Min Press";
                                                    graph1.valueField = "'" + channels[0].id + "'";
                                                    graph1.bullet = "round";
                                                    graph1.bulletBorderColor = "#FFFFFF";
                                                    graph1.bulletBorderThickness = 2;
                                                    graph1.bulletBorderAlpha = 1;
                                                    graph1.bulletSize = 8;
                                                    graph1.lineThickness = 1;
                                                    graph1.lineColor = "yellow";
                                                    graph1.hideBulletsCount = 50;
                                                    //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                                    chartMinMax.addGraph(graph1);

                                                    // GRAPH                       
                                                    var graph2 = new AmCharts.AmGraph();
                                                    //alert("a");
                                                    graph2.id = "MNFSUM";
                                                    graph2.valueAxis = valueAxisSum;
                                                    graph2.title = "Max Press";
                                                    graph2.valueField = "'" + channels[0].max + "'";
                                                    graph2.bullet = "round";
                                                    graph2.bulletBorderColor = "#FFFFFF";
                                                    graph2.bulletBorderThickness = 2;
                                                    graph2.bulletBorderAlpha = 1;
                                                    graph2.bulletSize = 8;
                                                    graph2.lineThickness = 1;
                                                    graph2.lineColor = "blue";
                                                    graph2.hideBulletsCount = 50;
                                                    //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";                      
                                                    chartMinMax.addGraph(graph2);


                                                }
                                            });

                                            //SERIAL CHART
                                            chartMinMax.dataTableId = "chart_table_MinMax";
                                            chartMinMax.dataProvider = chartDataMinMax;
                                            chartMinMax.validateData();
                                            chartMinMax.validateNow();

                                            //add table
                                            var total = 0;
                                            var min = 1000000;
                                            var max = 0;
                                            // get chart data
                                            var data = chartMinMax.dataProvider;
                                            // create a table
                                            var holder = document.getElementById(chartMinMax.dataTableId);
                                            holder.innerHTML = "";
                                            // if (holder.childElementCount == 0) {
                                            var table = document.createElement("table");
                                            holder.appendChild(table);
                                            var tr, td;
                                            // add first row
                                            for (var x = 0; x < chartMinMax.dataProvider.length; x++) {
                                                // first row
                                                if (x == 0) {
                                                    tr = document.createElement("tr");
                                                    table.appendChild(tr);
                                                    td = document.createElement("th");
                                                    //td.innerHTML = chartMinMax.categoryAxis.title;
                                                    td.innerHTML = "Timestamp";
                                                    tr.appendChild(td);
                                                    for (var i = 0; i < chartMinMax.graphs.length; i++) {
                                                        td = document.createElement('th');
                                                        td.innerHTML = chartMinMax.graphs[i].title;
                                                        tr.appendChild(td);
                                                    }
                                                }
                                                // add rows
                                                tr = document.createElement("tr");
                                                table.appendChild(tr);
                                                td = document.createElement("td");
                                                td.className = "row-title";

                                                // td.innerHTML = chartMinMax.dataProvider[x][chartMinMax.categoryField].toUTCString();
                                                var todayTime = new Date(chartMinMax.dataProvider[x][chartMinMax.categoryField]);
                                                var month = todayTime.getMonth() + 1;
                                                var day = todayTime.getDate();
                                                var year = todayTime.getFullYear();
                                                var dt = day + "/" + month + "/" + year;
                                                td.innerHTML = dt;
                                                tr.appendChild(td);
                                                // alert(chartMinMax.graphs.length);
                                                var valuetotal;
                                                for (var i = 0; i < chartMinMax.graphs.length; i++) {
                                                    td = document.createElement('td');
                                                    td.innerHTML = chartMinMax.dataProvider[x][chartMinMax.graphs[i].valueField];
                                                    tr.appendChild(td);
                                                    valuetotal = chartMinMax.dataProvider[x][chartMinMax.graphs[i].valueField];
                                                    if (valuetotal > max) {
                                                        max = valuetotal;
                                                    }
                                                    if (valuetotal < min) {
                                                        min = valuetotal;
                                                    }
                                                    //if (i == 1) {
                                                    //    total += chartMinMax.dataProvider[x][chartMinMax.graphs[i].valueField];
                                                    //}
                                                }
                                            }
                                            document.getElementById("minPress").innerHTML = min;
                                            document.getElementById("maxPress").innerHTML = max;
                                            // document.getElementById("totalMinMax").innerHTML = Math.round(total);
                                            // $("#totalflow").load("total");
                                            //  }//end if

                                        });
                                    };
                                    //////////////////////////////////////////////////////////////////////////////////////////////////////////
                                    function updateChart(start, end) {
                                        var multipleChannelId = "";
                                        for (var i = 0; i < channels.length; i++) {
                                            if (i != channels.length - 1)
                                                multipleChannelId += channels[i].id + "|";
                                            else multipleChannelId += channels[i].id;
                                        }
                                        var url = urlGetMultipleChannelsData + multipleChannelId + "/" + start + "/" + end;
                                        //alert(url);
                                        var baseLine = channels[0].base;
                                        // alert(baseLine);
                                        $.getJSON(url, function (d) {
                                            chartData = [];
                                            $.each(d.GetMultipleChannelsDataResult, function (i, val) {
                                                var parsedDate = new Date(parseInt(val.Timestamp.substr(6)));
                                                var jsDate = new Date(parsedDate);

                                                chartData.push({
                                                    Timestamp: jsDate
                                                });

                                                for (var j = 0; j < channels.length; j++) {
                                                    if (val.Values[j] != null && val.Values[j] != 'undefined') {
                                                        chartData[i]["'" + channels[j].id + "'"] = val.Values[j];
                                                        chartData[i]["'" + channels[j].base + "'"] = baseLine;
                                                    }
                                                }
                                            });

                                            $.each(channels, function (k, c) {
                                                var m_f = false;
                                                for (var i = 0; i < chart.graphs.length; i++) {
                                                    if (chart.graphs[i].valueField == ("'" + c.id + "'")) {
                                                        m_f = true;
                                                    }
                                                }
                                                if (m_f == false) {
                                                    var type;
                                                    var color = "";
                                                    switch (c.unit) {
                                                        case "m":
                                                            type = valueAxisPress;
                                                            var fr = false;
                                                            for (var i = 0; i < colors.length; i++) {
                                                                if (colors[i] == '#ff0000') fr = true;
                                                            }
                                                            if (fr == true) {
                                                                if (mreds.length == 0) {
                                                                    mreds.push(reds[0]);
                                                                    color = mreds[0];
                                                                }
                                                                else if (mreds.length != reds.length) {
                                                                    mreds.push(reds[mreds.length]);
                                                                    color = mreds[mreds.length - 1];
                                                                }
                                                                else {
                                                                    color = randomColor();
                                                                }
                                                                //color = randomColor({
                                                                //    luminosity: 'bright',
                                                                //    hue: 'orange'
                                                                //});
                                                            }
                                                            else color = '#ff0000';
                                                            colors.push(color);
                                                            break;
                                                        case "m3/h":
                                                            type = valueAxisFlow;
                                                            var fb = false;
                                                            for (var i = 0; i < colors.length; i++) {
                                                                if (colors[i] == '#0000ff') fb = true;
                                                            }
                                                            if (fb == true) {
                                                                if (mblues.length == 0) {
                                                                    mblues.push(blues[0]);
                                                                    color = mblues[0];
                                                                }
                                                                else if (mblues.length != blues.length) {
                                                                    mblues.push(blues[mblues.length]);
                                                                    color = mblues[mblues.length - 1];
                                                                }
                                                                else {
                                                                    color = randomColor();
                                                                }
                                                                //color = randomColor({
                                                                //    luminosity: 'bright',
                                                                //    hue: 'purple'
                                                                //});
                                                            }
                                                            else color = '#0000ff';
                                                            colors.push(color);
                                                            break;
                                                        default:
                                                            type = valueAxisPress;

                                                            break;
                                                    }
                                                    // GRAPH
                                                    var graph = new AmCharts.AmGraph();
                                                    graph.id = c.namePath;
                                                    graph.valueAxis = type;
                                                    graph.title = c.namePath;
                                                    graph.valueField = "'" + c.id + "'";
                                                    graph.bullet = "round";
                                                    graph.bulletBorderColor = "#FFFFFF";
                                                    graph.bulletBorderThickness = 2;
                                                    graph.bulletBorderAlpha = 1;
                                                    graph.bulletSize = 8;
                                                    graph.lineThickness = 1;
                                                    graph.lineColor = color;
                                                    graph.hideBulletsCount = 50;
                                                    //graph.balloonText = "[[Timestamp]]<br><b><span style='font-size:12px;'>Value: [[" + channel.id + "]]</span></b>";
                                                    chart.addGraph(graph);
                                                }
                                            });
                                            chart.dataTableId = "chart_table";
                                            chart.dataProvider = chartData;
                                            chart.validateData();
                                            chart.validateNow();



                                            if (channels[0].unit == "m3/h") {
                                                var total = 0;
                                                var min = 100000;
                                                var max = 0;
                                                // check if export to table is enabled
                                                if (chart.dataTableId === undefined)
                                                    return;
                                                // get chart data
                                                var data = chart.dataProvider;
                                                // create a table
                                                var holder = document.getElementById(chart.dataTableId);
                                                holder.innerHTML = "";
                                                //if (holder.childElementCount == 0) {
                                                var table = document.createElement("table");
                                                holder.appendChild(table);

                                                // document.getElementById("chart_table").innerHTML(table);
                                                var tr, td;

                                                // add first row
                                                for (var x = 0; x < chart.dataProvider.length; x++) {
                                                    // first row
                                                    if (x == 0) {
                                                        tr = document.createElement("tr");
                                                        table.appendChild(tr);
                                                        td = document.createElement("th");
                                                        //td.innerHTML = chart.categoryAxis.title;
                                                        td.innerHTML = "Timestamp";
                                                        tr.appendChild(td);
                                                        for (var i = 0; i < chart.graphs.length; i++) {
                                                            td = document.createElement('th');
                                                            if (chart.graphs[i].title != "Baseline") {
                                                                td.innerHTML = chart.graphs[i].title;
                                                                tr.appendChild(td);
                                                            }
                                                        }
                                                    }

                                                    // add rows
                                                    tr = document.createElement("tr");
                                                    table.appendChild(tr);
                                                    td = document.createElement("td");
                                                    td.className = "row-title";
                                                    td.innerHTML = chart.dataProvider[x][chart.categoryField].toUTCString();
                                                    tr.appendChild(td);

                                                    for (var i = 0; i < chart.graphs.length; i++) {
                                                        td = document.createElement('td');
                                                        if (chart.graphs[i].title != "Baseline") {
                                                            td.innerHTML = chart.dataProvider[x][chart.graphs[i].valueField];
                                                            tr.appendChild(td);
                                                            if (i == 0)//only total flow first
                                                            {
                                                                var temp = chart.dataProvider[x][chart.graphs[i].valueField];
                                                                if (temp < min) {
                                                                    min = temp;
                                                                }
                                                                if (temp > max) {
                                                                    max = temp;
                                                                }
                                                                total += chart.dataProvider[x][chart.graphs[i].valueField];

                                                            }
                                                        }
                                                    }
                                                }
                                                document.getElementById("totalflow").innerHTML = Math.round(total);
                                                document.getElementById("minMNF").innerHTML = min;
                                                document.getElementById("dnzBaseline").innerHTML = max;
                                            }

                                            if (channels[0].unit == "m") {
                                                var total = 0;
                                                var min = 100000;
                                                var max = 0;
                                                // check if export to table is enabled
                                                if (chart.dataTableId === undefined)
                                                    return;
                                                // get chart data
                                                var data = chart.dataProvider;
                                                // create a table
                                                var holder = document.getElementById(chart.dataTableId);
                                                holder.innerHTML = "";
                                                //if (holder.childElementCount == 0) {
                                                var table = document.createElement("table");
                                                holder.appendChild(table);

                                                // document.getElementById("chart_table").innerHTML(table);
                                                var tr, td;

                                                // add first row
                                                for (var x = 0; x < chart.dataProvider.length; x++) {
                                                    // first row
                                                    if (x == 0) {
                                                        tr = document.createElement("tr");
                                                        table.appendChild(tr);
                                                        td = document.createElement("th");
                                                        //td.innerHTML = chart.categoryAxis.title;
                                                        td.innerHTML = "Timestamp";
                                                        tr.appendChild(td);
                                                        for (var i = 0; i < chart.graphs.length; i++) {
                                                            td = document.createElement('th');
                                                            // if (chart.graphs[i].title != "Baseline") {
                                                            td.innerHTML = chart.graphs[i].title;
                                                            tr.appendChild(td);
                                                            //}
                                                        }
                                                    }

                                                    // add rows
                                                    tr = document.createElement("tr");
                                                    table.appendChild(tr);
                                                    td = document.createElement("td");
                                                    td.className = "row-title";
                                                    td.innerHTML = chart.dataProvider[x][chart.categoryField].toUTCString();
                                                    tr.appendChild(td);

                                                    for (var i = 0; i < chart.graphs.length; i++) {
                                                        td = document.createElement('td');
                                                        // if (chart.graphs[i].title != "Baseline") {
                                                        td.innerHTML = chart.dataProvider[x][chart.graphs[i].valueField];
                                                        tr.appendChild(td);
                                                        if (i == 0)//only total flow first
                                                        {
                                                            var temp = chart.dataProvider[x][chart.graphs[i].valueField];
                                                            if (temp < min) {
                                                                min = temp;
                                                            }
                                                            if (temp > max) {
                                                                max = temp;
                                                            }
                                                            // total += chart.dataProvider[x][chart.graphs[i].valueField];

                                                        }
                                                        // }
                                                    }
                                                }
                                                document.getElementById("totalflow").innerHTML = "View Channel Flow";
                                                document.getElementById("minMNF").innerHTML = min;
                                                document.getElementById("dnzBaseline").innerHTML = max;
                                            }
                       // }//end if               

                        // }//end table
                        <%--var tableView = $find("<%= grvTable.ClientID %>").get_masterTableView();
                        tableView.set_dataSource(chartData);
                        tableView.dataBind();--%>
                                        });
                                    }
                                    window.onload = window_init;
                                    setInterval(updateMap, 5000);
                                </script>
                            </telerik:RadScriptBlock>
                        </div>



                    </div>
                </div>
            </div>

        </form>

        <script type="text/javascript">
            $(function () {
                $('#RAD_SLIDING_ZONE_TABS_CONTAINER_ctl00_ContentPlaceHolder1_RadSlidingZone1').remove();
                $("#dashboard-history").css("height", "100%");


                $("#RAD_SPLITTER_ctl00_ContentPlaceHolder1_RadSplitter1").css("height", "100%");
                $("#ctl00_ContentPlaceHolder1_RadSplitter1").css("height", "100%");
                $("#ctl00_ContentPlaceHolder1_RadSplitter1>div").css("height", "100%");
                $("#ctl00_ContentPlaceHolder1_RadPane2").css("height", "100%");
                $("#RAD_SPLITTER_PANE_CONTENT_ctl00_ContentPlaceHolder1_RadPane2").css("height", "100%");
                $("#RAD_SPLITTER_PANE_CONTENT_ctl00_ContentPlaceHolder1_RadPane1").css("height", "100%");

                var screenheight = ($("#dashboard-history").height());
                $("#content").css("height", screenheight + "px");

                /*phuong 15-01-2019*/
            })
        </script>

    </body>

    <script type="text/javascript" src="/js/Pi-solution/vendor.js"></script>
    <script type="text/javascript" src="/js/Pi-solution/app.js"></script>

    <script type="text/javascript">

        $(function () {

            /*phuong 15-01-2019*/
        })

        function pageLoad(sender, args) {

            $(function () {

                //resize menu + map by screen
                var screenheight = $(document).height();
                var screenwidth = $(document).width();
                var strh = (screenheight - 70);
                var strw = (screenwidth - 220);
                if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                    strw = (screenwidth - 20);
                    $("#<%=lbPageTitle.ClientID%>").html("VIWATER SCADA SYSTEM");
                    $("#MenuCollapse").attr("style", "display:none");
                }
                $("#RAD_SPLITTER_PANE_CONTENT_ctl00_ContentPlaceHolder1_RadPane2").css("height", strh);//resize map height
                $("#RAD_SPLITTER_PANE_CONTENT_ctl00_ContentPlaceHolder1_RadPane2").css("width", strw);//resize map width

                $("#RAD_SPLITTER_PANE_CONTENT_ctl00_ContentPlaceHolder1_RadPane1").css("width", "0px");//hide menu in radslide
                // height of screen
                if (screenwidth > 768) {
                    $("#sidebar-menu").attr("style", "height:" + (screenheight - 50) + "px ; overflow-y:scroll; overflow-x:hidden"); // leftmenu scroll for >ipad 
                }

                $("li").click(function () {
                    if ($(this).hasClass('active')) {
                        $(this).removeClass('active');
                    }
                    else {
                        $(this).addClass('active');
                    }
                    $("#MapJS_rev1_DMA").addClass("open active ");

                });

                $(".HeaderLogout").click(function () {
                    var abc = $(this).find("#LogoutRegion");
                    if (abc.hasClass("show")) {
                        $(this).find("#LogoutRegion").removeClass("show");

                    }
                    else {
                        $(this).find("#LogoutRegion").addClass("show");
                    }

                });

                setInterval(function () { $(".rwControlButtons").css("width", "auto"); }, 100);
                $("#btnLogout").click(function () {
                    $.ajax({
                        type: "POST",
                        url: "/Pi-solution/Pi1.asmx/Logout_pi",
                        data: "{}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (result) {
                            window.location.href = result.d;
                        },
                        error: function (error) {
                            alert("The system is under maintenance. Please come back later");
                        }
                    });
                });
                // active when click menu
                var pathname = window.location.pathname;
                $(".sidebar-nav a").each(function () {

                    if ($(this).attr("href") == pathname) {
                        alert("a");
                        $(this).addClass("subMenuActive");
                        $(this).parent().parent().parent().addClass("open active");
                        $(this).closest("ul").attr("aria-expanded", "true");
                        $(this).closest("ul").removeClass("collapse");
                        $(this).closest("ul").addClass("sidebar-nav collapse in");
                    }
                    //privilege sub menu

                    var substring = '@' + $(this).attr("href") + '@';
                    if ($("#ContentPlaceHolder1_hidListMenu").val().indexOf(substring) == -1) {

                        $(this).parent().attr("style", "display:none !important");
                    }
                });
                //privilege  menu
                $(".privilege").each(function () {
                    var substring = '@' + $(this).attr("href") + '@';
                    if ($("#ContentPlaceHolder1_hidListMenu").val().indexOf(substring) == -1) {
                        $(this).parent().attr("style", "display:none !important");
                    }
                });

                //active when click menu
                $(".sidebar-menu a").each(function () {
                    if ($(this).attr("href") == pathname) {
                        $(this).parent().addClass("open active");
                    }
                });

                $(".rfdRoundedCorners, .form-control").each(function () {
                    $(this).removeClass("rfdDecorated");
                });


                $(".rwControlButtons, .rbDecorated").each(function () {
                    $(this).removeAttr("style");
                    $(this).parent().removeClass("rfdSkinnedButton");

                });
                $(".rfdDecorated").each(function () {
                    $(this).parent().removeClass("rfdSkinnedButton");

                });
                $("#MenuCollapse").click(function () {
                    $(".sidebar").toggle(500);
                    $(".header").toggleClass('headerHide');
                    $(".app").toggleClass('headerHide');

                    //resize menu + map by screen
                    var screenwidth = $(document).width();
                    if ($(".header").hasClass("headerHide")) {
                        var strw = (screenwidth - 35);
                    }
                    else {
                        var strw = (screenwidth - 220);
                    }
                    $("#RAD_SPLITTER_PANE_CONTENT_ctl00_ContentPlaceHolder1_RadPane2").css("width", strw);//resize map width

                });

            })
        }
    </script>

</asp:Content>
