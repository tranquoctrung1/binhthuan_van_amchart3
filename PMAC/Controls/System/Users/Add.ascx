<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Add.ascx.cs" Inherits="Controls_System_ucUser_Add" %>

<link rel="stylesheet" href="/css/bootstrap/bootstrap.min.css">
<link href="/css/img-upload/img-upload.css" rel="stylesheet">
<%--<link rel="stylesheet" href="/css/app-blue.css" />
<link rel="stylesheet" href="/css/vendor.css" />--%>

<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12" style="min-height:600px">

    
    <form>

        <div class="form-group">
            <label>
                <asp:Label ID="lbUserName" runat="server" Text="User name"></asp:Label>: 
            </label>
            <br />
            <asp:TextBox style="width:30%" ID="txtUserName" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ControlToValidate="txtUserName"
                ErrorMessage="This is a required field."
                ForeColor="Red">
            </asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label>
                <asp:Label ID="lbPassword" runat="server" Text="Password"></asp:Label>:
            </label>
            <br />
            <asp:TextBox style="width:30%" ID="txtPassword" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                ControlToValidate="txtPassword"
                ErrorMessage="This is a required field."
                ForeColor="Red">
            </asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label>
                <asp:Label ID="lbStaffId" runat="server" Text="Staff Id"></asp:Label>:
            </label>
            <br />
            <asp:TextBox style="width:30%" ID="txtStaffId" CssClass="form-control" runat="server" placeholder="000" Value="000"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                ControlToValidate="txtStaffId"
                ErrorMessage="This is a required field."
                ForeColor="Red">
            </asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <label>
                <asp:Label ID="lbConsumerId" runat="server" Text="Consumer Id"></asp:Label>:
            </label>
            <br />
            <asp:TextBox style="width:30%" ID="txtConsumerId" CssClass="form-control" runat="server" placeholder="0000" Value="0000"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                ControlToValidate="txtConsumerId"
                ErrorMessage="This is a required field."
                ForeColor="Red">
            </asp:RequiredFieldValidator>
        </div>

      <div class="form-group">
        <label>
            <asp:Label ID="lbEmail" runat="server" Text="Email"></asp:Label>:
        </label> <br />
        <asp:TextBox style="width:30%" ID="txtEmail" CssClass="form-control" runat="server"></asp:TextBox>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="This is a required field."
                ForeColor="Red">
            </asp:RequiredFieldValidator>
      </div>

        <div class="form-group">
            <label>
                <asp:Label ID="lbRole" runat="server" Text="Role"></asp:Label>:
            </label>
            <br />
            <asp:DropDownList ID="ddlRole" runat="server">
                <asp:ListItem Value="staff">staff</asp:ListItem>
                <asp:ListItem Value="admin">admin </asp:ListItem>
                <asp:ListItem Value="consumer">consumer</asp:ListItem>
                <asp:ListItem Value="supervisor">supervisor</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="form-group">
            <label>
                <asp:Label ID="lbActive" runat="server" Text="Active"></asp:Label>:
            </label>
            <br />
            <asp:DropDownList ID="ddlActive" runat="server">
                <asp:ListItem Value="True">True </asp:ListItem>
                <asp:ListItem Value="False">False </asp:ListItem>
            </asp:DropDownList>
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