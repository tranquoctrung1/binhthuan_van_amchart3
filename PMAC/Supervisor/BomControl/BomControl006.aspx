<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="../MasterPage.master" CodeFile="BomControl006.aspx.cs" Inherits="Supervisor_BomControl_BomControl006" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/alertify.css" integrity="sha512-MpdEaY2YQ3EokN6lCD6bnWMl5Gwk7RjBbpKLovlrH6X+DRokrPRAF3zQJl1hZUiLXfo2e9MrOt+udOnHCAmi5w==" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/themes/default.min.css" integrity="sha512-RgUjDpwjEDzAb7nkShizCCJ+QTSLIiJO1ldtuxzs0UIBRH4QpOjUU9w47AF9ZlviqV/dOFGWF6o7l3lttEFb6g==" crossorigin="anonymous" />
    <link href="https://unpkg.com/bootstrap-table@1.18.0/dist/bootstrap-table.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="../../css/bomcontrol.css" rel="stylesheet" />
    <script src="../../js/amcharts/amcharts.js"></script>
    <script src="../../js/amcharts/serial.js"></script>
    <script src="../../js/amcharts/exporting/amexport.js"></script>
    <script src="../../js/amcharts/exporting/canvg.js"></script>
    <script src="../../js/amcharts/exporting/filesaver.js"></script>
    <script src="../../js/amcharts/exporting/jspdf.js"></script>
    <script src="../../js/amcharts/exporting/jspdf.plugin.addimage.js"></script>
    <script src="../../js/amcharts/exporting/rgbcolor.js"></script>
    <script src="../../js/randomColor.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <section class="bom">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-9">
                            <div class="row">
                                <div class="col-md-4 text-center col-table-status" data-aos="flip-right">
                                    <table class="table table-status">
                                        <thead class="thead">
                                            <tr>
                                                <th scope="col">Các Loại Trạng Thái Valve</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                             <tr  class="status-row-open-full ">
                                                <th scope="row" id="openFull">Không đủ áp </th>
                                            </tr>
                                             <tr class="status-row-opening ">
                                                <th scope="row"  id="opening">Đang mở Van</th>
                                            </tr>
                                            <tr class="status-row-hold ">  
                                                <th scope="row"  id="hold">Giữ áp</th>
                                            </tr>
                                              <tr class="status-row-closing " >
                                                <th scope="row" id="closing">Đang đóng Van</th>
                                            </tr>
                                            <tr class="status-row-close-full ">
                                                <th scope="row"  id="closeFull">Không thể giảm áp</th>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <table class="table table-p-w">
                                        <thead class="thead">
                                            <tr>
                                                <th scope="col" colspan="2">Áp Suất Và Điện Áp</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th scope="row" colspan="2"> <span>Thời Gian:</span>  <span id="timeToSenData"></span></th>
                                            </tr>
                                            <tr>
                                                <th scope="row" colspan="2"><span>Áp suất đặt hiện tại </span><a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="psetShow">2.0</a></th>
                                                
                                            </tr>
                                            <tr>
                                                <th scope="row"><span>Nhiệt độ</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="tempShow">2.0</a></th>
                                                <%--<th scope="row"><span>P1</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="p1Show">2.0</a></th>--%>
                                                <th scope="row" style="display: none"><span>Solar</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="solarShow">2.0</a></th>
                                                <th scope="row"><span>Độ ẩm</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="humidityShow">2.0</a></th>
                                            </tr>
                                            <tr>
                                                <%--<th scope="row"><span>P2</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="p2Show">2.0</a></th>--%>
                                                <th scope="row"><span>Acquy</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="acquyShow">2.0</a></th>
                                            </tr>

                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-md-8 col-bom-control" data-aos="flip-right">
                                    <div class="row button-bom-control">
                                        <button type="button" class="btn btn-info" id="showModal" data-toggle="modal" data-target="#controllerMode">Chế Độ Điều Khiển</button>
                                        <button type="button" class="btn btn-success ml-3" disabled="disabled" id="action">Local</button>
                                        <button type="button" class="btn btn-info ml-3" data-toggle="modal" data-target="#history" id="showHistoryAlarm">Lịch Sữ Cảnh Báo</button>
                                    </div>
                                    <div class="row name-station-area">
                                        <h4 class="name-station">Tên Trạm: <span data-toggle="modal" data-target="#dataViewer" id="showPopupDataViewer">V006</span></h4>
                                        <button type="button" class="ml-4 connect" disabled="disabled"  id="buttonStatusConnect">Connect</button>
                                    </div>
                                    <%--<div class="custom-control custom-switch mb-3">
                                        <label class="mb-0 mr-4"  for="switchMode">Man</label>
                                        <input type="checkbox" class="custom-control-input" id="switchMode">
                                        <label class="custom-control-label" for="switchMode">Auto</label>
                                    </div>--%>
                                    <div class="box-image">
                                        <img src="../../_imgs/hold.jpg" id="imageStatusValve"/>
                                        <div id="p1Showleft">
                                            <span>P1</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="p1Show">2.0</a>
                                        </div>
                                         <div id="p2Showright">
                                             <span>P2</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="p2Show">2.0</a>
                                    </div>
                                         </div>
                                        
                                        
                                </div>
                            </div>
                            <div class="row">
                                <div id="date" class="row pl-3" data-aos="flip-right">
                                    <div>
                                         <label for="startDate">Ngày bắt đầu: </label>
                                        <input type="datetime-local" id="startDate">
                                    </div>
                                   <div class="ml-2">
                                         <label for="endDate">Ngày kết thúc: </label>
                                        <input type="datetime-local" id="endDate">
                                    </div>
                                    <div>
                                        <button type="button" class="btn btn-info ml-3" id="btnView">Xem</button>
                                    </div>
                                </div>
                                <div id="chart" ></div>
                            </div>
                        </div>
                        <div class="modal fade" id="controllerMode" data-backdrop="static" tabindex="-1" aria-labelledby="controllerMode" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Tinh Chỉnh Thông Số</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <div>
                                            <h5 class="modal-title text-center mb-2">Chế Độ Điều Khiển Valve</h5>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="remoteman" name="controller" value="0" checked class="custom-control-input remote">
                                                <label class="custom-control-label" for="remoteman">Remote_Man</label>
                                            </div>
                                            <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="remoteauto" name="controller" value="1" class="custom-control-input remote">
                                                <label class="custom-control-label" for="remoteauto">Remote_Auto</label>
                                            </div>
                                             <div class="custom-control custom-radio custom-control-inline">
                                                <input type="radio" id="remotelocal" name="controller" value="2" disabled="disabled" class="custom-control-input remote">
                                                <label class="custom-control-label" for="remotelocal">Local</label>
                                            </div>
                                        </div>
                                        <hr />
                                        <div id="loadingForMode" class="hide">
                                            <div class="box-img-loading-mode">
                                                <img src="../../_imgs/loading.gif" alt="loading for wait" />

                                            </div>
                                        </div>
                                        <div id="bodyMode" class="show">
                                             <div id="rowErrorNumber">
                                             <h5 class="modal-title text-center mb-2">Thông Tin Chỉ Số</h5>
                                            <div class="form-group row"  >
                                                <label for="errorNum" class="col-sm-2 col-form-label col-form-label-sm">Sai Số</label>
                                                <div class="col-sm-3">
                                                    <input type="number" class="form-control form-control-sm" id="errorNum" min="0" step="0.05" value="2">
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div>
                                            <div id="modeMan" class="show">
                                                <div class="form-group row">
                                                    <label for="errorNum" class="col-form-label col-form-label">Áp Suất Cài Đặt Cố Định (M0)</label>
                                                    <div class="col-sm-3">
                                                        <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="m0" value="2">
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="modeAuto" class="hide">
                                                <div class="text-center col-table-data">
                                                    <table class="table table-data">
                                                        <tbody>
                                                            <tr>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row" class="thead" colspan="2">Bảng áp suất cài đặt theo giờ</th>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">0h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="0h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">12h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="12h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">1h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="1h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">13h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="13h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">2h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="2h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">14h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="14h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">3h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="3h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">15h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="15h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">4h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="4h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">16h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="16h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">5h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="5h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">17h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="17h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">6h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="6h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">18h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="18h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">7h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="7h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">19h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="19h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">8h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="8h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">20h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="20h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">9h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="9h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">21h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="21h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">10h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="10h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">22h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="22h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                            <tr>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">11h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="11h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                                <th scope="row">
                                                                    <div class="form-group row">
                                                                        <label for="errorNum" class="col-form-label col-form-label">23h</label>
                                                                        <div class="col-sm-5">
                                                                            <input type="number" class="form-control form-control-sm" min="0" step="0.1" id="23h" value="2">
                                                                        </div>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        </div>
                                       
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary" data-dismiss="modal">Đóng</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="history" tabindex="-1" aria-labelledby="history" aria-hidden="true">
                            <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Lịch Sữ Cảnh Báo</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                </div>
                                <div class="modal-body">
                                    <div>
                                        <div>
                                         <label for="startDate">Ngày bắt đầu: </label>
                                        <input type="date" id="startDateHistory">
                                        </div>
                                       <div>
                                             <label for="endDate">Ngày kết thúc: </label>
                                            <input type="date" id="endDateHistory">
                                        </div>
                                        <div class="d-flex justify-content-end align-items-center mb-2" style="transform: translateY(-120%)">
                                            <button type="button" class="btn btn-info ml-3" id="btnViewHistory">Xem</button>
                                        </div>
                                    </div>
                                    <table class="table table-bordered table-sm" id="tableHistoryPagination">
                                      <thead class="thead">
                                        <tr>
                                          <th scope="col">TimeStamp</th>
                                          <th scope="col">Value</th>
                                        </tr>
                                      </thead>
                                      <tbody id="historyTable">
                                       
                                      </tbody>
                                    </table>
                                    <%--<div class="pagination-table">
                                        <nav aria-label="Page navigation">
                                          <ul class="pagination">
                                            <li class="page-item">
                                              <a class="page-link" href="#" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                              </a>
                                            </li>
                                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                                            <li class="page-item">
                                              <a class="page-link" href="#" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                              </a>
                                            </li>
                                          </ul>
                                        </nav>
                                    </div>--%>
                                </div>
                                <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-dismiss="modal">Đóng</button>
                                </div>
                            </div>
                            </div>
                        </div>
                        <div class="modal fade" id="dataViewer" tabindex="-1" aria-labelledby="dataViewer" aria-hidden="true">
                            <div class="data-viewer">
                            <div class="modal-content">
                                <div class="modal-header">
                                <h5 class="modal-title" id="dataViwerTitle">Tên trạm: V006</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                </div>
                                <div class="modal-body">
                                    <div>
                                       <div class="container-fluid2">
                                            <%--Chọn site và kênh xem--%>
                                            <div class="row">
                                                <div class="col-lg-6 col-md-12 mt-1">
                                                    <div class="row">
                                                        <div class="col-md-6 col-sm-12 mt-2">

                                                        </div>
                                                        <div class="col-md-6 col-sm-12 ">
                                                            <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#listchannel" id="showListChannel">
                                                                Lọc kênh xem
                                                            </button>

                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="col-lg-6 col-md-12 mt-1">
                                                    <div class="row">
                                                        <div class="col-md-4 col-sm-12 mt-2">
                                                            <telerik:RadDateTimePicker ID="dtmStart" runat="server" Culture="en-GB">
                                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

                                                                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" EmptyMessage="Bắt đầu"></DateInput>

                                                                <DatePopupButton ImageUrl="" HoverImageUrl="" ForeColor="White" BackColor="White"></DatePopupButton>
                                                            </telerik:RadDateTimePicker>
                                                        </div>
                                                        <div class="col-md-4 col-sm-12 mt-2">
                                                            <telerik:RadDateTimePicker ID="dtmEnd" runat="server" Culture="en-GB">
                                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>

                                                                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%" EmptyMessage="Kết thúc"></DateInput>

                                                                <DatePopupButton ImageUrl="" HoverImageUrl="" ForeColor="White" BackColor="White"></DatePopupButton>
                                                            </telerik:RadDateTimePicker>
                                                        </div>
                                                        <div class="col-md-4 col-sm-12 mt-2">
                                                            <button type="button" onclick="btnView_OnClientClick()" class="btn btn-primary btn-sm">Xem</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <%--Card từng kênh--%>
                                            <div class="row mt-2" id="channel_cards">
                                            </div>

                                            <div class="row">
                                                <div class="col-lg-8 col-md-12" id="c_col">
                                                    <div id="chart_canvas" style="height: 350px"></div>
                                                </div>
                                                <div class="col-lg-4 col-md-12" id="t_col">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <div id="data_table" class="haha"></div>
                                                        </div>
                                                        <div class="col-12 mt-1">
                                                            <a class="btn btn-success" id="btnExportXls" style="color: white; display: none"><i class="fa fa-file-excel-o"></i>Export</a>
                                                        </div>
                                                    </div>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="modal fade" id="listchannel" tabindex="-1" aria-labelledby="listchannel" aria-hidden="true">
                                                  <div class="modal-dialog">
                                                    <div class="modal-content">
                                                      <div class="modal-header">
                                                        <h5 class="modal-title" id="listchannelLabel">Lọc kênh</h5>
                                                        </button>
                                                      </div>
                                                      <div class="modal-body" id="bodyModal">
                                                            <div class="custom-control custom-switch">
                                                             <input type="checkbox" class="custom-control-input" id="Temp" data-channel="Temp" checked>
                                                             <label class="custom-control-label" for="Temp">Temp</label>
                                                           </div>
                                                          <%--<div class="custom-control custom-switch">
                                                             <input type="checkbox" class="custom-control-input" id="Solar" data-channel="Solar" checked>
                                                             <label class="custom-control-label" for="Solar">Solar</label>
                                                           </div>--%>
                                                           <div class="custom-control custom-switch">
                                                             <input type="checkbox" class="custom-control-input" id="Humidity" data-channel="Humidity" checked>
                                                             <label class="custom-control-label" for="Humidity">Humidity</label>
                                                           </div>
                                                           <div class="custom-control custom-switch">
                                                             <input type="checkbox" class="custom-control-input" id="Acquy" data-channel="Acquy" checked>
                                                             <label class="custom-control-label" for="Acquy">Acquy</label>
                                                           </div>
                                                           <div class="custom-control custom-switch">
                                                             <input type="checkbox" class="custom-control-input" id="P1" data-channel="P1" checked>
                                                             <label class="custom-control-label" for="P1">P1</label>
                                                           </div>
                                                          <div class="custom-control custom-switch">
                                                             <input type="checkbox" class="custom-control-input" id="P2" data-channel="P2" checked>
                                                             <label class="custom-control-label" for="P2">P2</label>
                                                           </div>
                                                          <div class="custom-control custom-switch">
                                                             <input type="checkbox" class="custom-control-input" id="P2Set" data-channel="P2Set" checked>
                                                             <label class="custom-control-label" for="P2Set">P2Set</label>
                                                           </div>
                                                      </div>
                                                      
                                                    </div>
                                                  </div>
                                                </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-dismiss="modal">Đóng</button>
                                </div>
                            </div>
                            </div>
                        </div>

                        <div class="col-md-3 text-center col-table-data" data-aos="flip-right">
                            <table class="table table-data">
                                <thead class="thead">
                                    <tr>
                                        <th scope="col" colspan="2">Áp suất đặt (bar)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row" colspan="2"><span>Áp suất cài đặt cố định</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="m0Show">2.0</a></th>
                                    </tr>
                                    <tr>
                                        <th scope="row" colspan="2">Bảng áp suất cài đặt theo giờ</th>
                                    </tr>
                                    <tr>
                                        <th scope="row"><span>0h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="0hShow">2.0</a></th>
                                        <th scope="row"><span>12h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="12hShow">2.0</a></th>
                                    </tr>
                                    <tr>
                                        <th scope="row"><span>1h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="1hShow">2.0</a></th>
                                        <th scope="row"><span>13h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="13hShow">2.0</a></th>
                                    </tr>
                                    <tr>
                                        <th scope="row"><span>2h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="2hShow">2.0</a></th>
                                        <th scope="row"><span>14h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="14hShow">2.0</a></th>
                                    </tr>
                                    <tr>
                                        <th scope="row"><span>3h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="3hShow">2.0</a></th>
                                        <th scope="row"><span>15h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="15hShow">2.0</a></th>
                                    </tr>
                                    <tr>
                                        <th scope="row"><span>4h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="4hShow">2.0</a></th>
                                        <th scope="row"><span>16h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="16hShow">2.0</a></th>
                                    </tr>
                                    <tr>
                                        <th scope="row"><span>5h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="5hShow">2.0</a></th>
                                        <th scope="row"><span>17h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="17hShow">2.0</a></th>
                                    </tr>
                                    <tr>
                                        <th scope="row"><span>6h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="6hShow">2.0</a></th>
                                        <th scope="row"><span>18h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="18hShow">2.0</a></th>
                                    </tr>
                                    <tr>
                                        <th scope="row"><span>7h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="7hShow">2.0</a></th>
                                        <th scope="row"><span>19h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="19hShow">2.0</a></th>
                                    </tr>
                                    <tr>
                                        <th scope="row"><span>8h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="8hShow">2.0</a></th>
                                        <th scope="row"><span>20h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="20hShow">2.0</a></th>
                                    </tr>
                                    <tr>
                                        <th scope="row"><span>9h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="9hShow">2.0</a></th>
                                        <th scope="row"><span>21h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="21hShow">2.0</a></th>
                                    </tr>
                                    <tr>
                                        <th scope="row"><span>10h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="10hShow">2.0</a></th>
                                        <th scope="row"><span>22h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="22hShow">2.0</a></th>
                                    </tr>
                                    <tr>
                                        <th scope="row"><span>11h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="11hShow">2.0</a></th>
                                        <th scope="row"><span>23h</span> <a href="javascript: void(0);" class="btn btn-primary btn-sm disabled" tabindex="-1" role="button" aria-disabled="true" id="23hShow">2.0</a></th>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
            </section>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    <script src="https://cdn.amcharts.com/lib/4/core.js"></script>
    <script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
    <script src="https://cdn.amcharts.com/lib/4/themes/spiritedaway.js"></script>
    <script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.20.0/axios.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js" integrity="sha512-JnjG+Wt53GspUQXQhc+c4j8SBERsgJAoHeehagKHlxQN+MtCCmFDghX9/AcbkkNRZptyZU4zC8utK59M5L45Iw==" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/bootstrap-table@1.18.0/dist/bootstrap-table.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="../../js/BomControl/chartBomController.js"></script>
    <script src="../../js/BomControl/bomcontroller0006.js"></script>
    <script src="../../js/BomControl/BomViewer6.js"></script>
</asp:Content>
