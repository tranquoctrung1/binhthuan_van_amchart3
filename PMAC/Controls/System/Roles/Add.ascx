<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Add.ascx.cs" Inherits="Controls_System_ucRole_Add" %>

<link rel="stylesheet" href="/css/bootstrap/bootstrap.min.css">
<link href="/css/img-upload/img-upload.css" rel="stylesheet">
<%--<link rel="stylesheet" href="/css/app-blue.css" />
<link rel="stylesheet" href="/css/vendor.css" />--%>

<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="min-height:600px">

    
    <form>

        <div class="form-group">
            <label>
                <asp:Label ID="lbDescription" runat="server" Text="Description"></asp:Label>: 
            </label>
            <br />
            <asp:TextBox style="width:30%" ID="txtDescription" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ControlToValidate="txtDescription"
                ErrorMessage="This is a required field."
                ForeColor="Red">
            </asp:RequiredFieldValidator>
        </div>
    </form>
    
    <div style="margin: 0 auto">
        <asp:Button ID="btnSaveChanges" CssClass="btn btn-success" runat="server" Text="Lưu thay đổi" OnClick="btnSave_Click" />
        <asp:Button ID="btnCancelSave" CssClass="btn btn-danger" CausesValidation="false" runat="server" Text="Hủy" OnClick="btnCancel_Click" />
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