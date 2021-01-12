<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Edit.ascx.cs" Inherits="Controls_System_ucGeneral_edit" %>

<link rel="stylesheet" href="/css/bootstrap/bootstrap.min.css">
<link href="/css/img-upload/img-upload.css" rel="stylesheet">
<%--<link rel="stylesheet" href="/css/app-blue.css" />
<link rel="stylesheet" href="/css/vendor.css" />--%>

<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="min-height:600px">

    
    <form>
      <div class="form-group">
        <label>Logo</label> <br />
         <asp:ImageButton ID="imgLogo" runat="server" ImageUrl="#" Visible="true" />

        <br />
        

        <asp:TextBox Visible="false" autocomplete="off" ID="txtVal" CssClass="form-control" runat="server"></asp:TextBox>     
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  
                ControlToValidate="txtVal" ErrorMessage="(*)" style="color:red" >
                </asp:RequiredFieldValidator>
          <br />
          <label>Select a new image ...</label>
                    <div class="panel panel-default img-upload">
                        
                        <div class="panel-body img-file-tab" style="margin-bottom:10px">
                            <div>
                                <span class="btn btn-default btn-file img-select-btn">
                                    <span>Browse</span>
                                    <input type="file" name="img-file-input" runat="server" id="imgNewLogo" />
                                </span>
                                <span class="btn btn-default img-remove-btn">Remove</span>
                            </div>
                        </div>
                        
                    </div>

      </div>


      <div class="form-group">
        <label>Description:</label> <br />
        <asp:TextBox ID="txtDescription" CssClass="form-control" runat="server"></asp:TextBox>
      </div>

      
      
    </form>
    
    <div style="margin: 0 auto">
        <asp:Button ID="btnSave" CssClass="btn btn-success" runat="server" Text="Lưu thay đổi" OnClick="btnSave_Click" />
        <asp:Button ID="btnCancel" CssClass="btn btn-danger" CausesValidation="false" runat="server" Text="Hủy" OnClick="btnCancel_Click" />
    </div>

</div>

<telerik:RadNotification ID="ntf" runat="server" >
</telerik:RadNotification>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnOK">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ntf" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
<script src="/js/Pi-solution/img-upload.js"></script>
<script>
    $('.img-upload').imgUpload();
</script>

<script type="text/javascript">
    $(function () {
        $("#ContentPlaceHolder1_ucSystemGeneralEdit_btnSave").click(function () {

            var formData = new FormData();
            formData.append('file', $('#ContentPlaceHolder1_ucSystemGeneralEdit_imgNewLogo')[0].files[0]);
            $.ajax({
                type: 'post',
                url: '/Pi-Solution/ImageHandler.ashx',
                data: formData,
                success: function (status) {
                    if (status != 'error') {
                        console.log(status);
                    }
                },
                processData: false,
                contentType: false,
                error: function (error) {
                    console.log(error);
                    alert("Whoops something went wrong!");
                }
            });
            

            return true;
        })
    });
</script>