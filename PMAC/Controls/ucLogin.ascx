<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucLogin.ascx.cs" Inherits="Controls_ucLogin" %>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js" ></script>
<asp:Login Visible="false"
    ID="Login1" runat="server" LoginButtonText="Đăng nhập" PasswordLabelText="Mật khẩu:" RememberMeText="Ghi nhớ mật khẩu" TitleText="Đăng nhập" UserNameLabelText="Ký danh:" OnAuthenticate="Login1_Authenticate">
</asp:Login>

<link rel="stylesheet" href="css/vendor.css" />
<link rel="stylesheet" href="css/app-blue.css" />
<div class="container-login100">
    <div class="auth">
        <div class="custom-container auth-container">
            <div class="card-parent">
                <div class="card">
                    <header class="auth-header">
                        <h1 class="custom-title auth-title">
                            <div class="auth-logo logo">
                                <img src="#" alt="Logo Company" height="70" runat="server" id="imgLogo">
                            </div>
                            <asp:Label ID="lbCompany" runat="server" Text="TAWACO"></asp:Label> 
                        </h1>
                        <div class="menu_login">
                            <div><a>Login</a></div>
                            <div><a>About</a></div>
                            <div class="right"><a>Guest</a></div>
                        </div>
                    </header>
                    <div class="auth-content">
                        <div class="logo-form">
                            <img src="../_imgs/Save-Water-logo.png"/>
                        </div>
                        <div class="custom-form">
                            <!--<p class="text-center">LOGIN TO CONTINUE</p>-->
                            <p class="text-auth">Login</p>
                            <form id="login-form" action="/index.html" method="GET" novalidate="">
                                <div class="custom-form-group form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="custom-form-control form-control" name="username" id="username" placeholder="Your username" required>
                                </div>
                                <div class="custom-form-group form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="custom-form-control form-control" name="password" id="password" placeholder="Your password" required>
                                </div>
                                <div class="form-group">
                                    <label for="remember">
                                        <input class="checkbox" id="remember" type="checkbox">
                                        <span>Remember me</span>
                                    </label>
                                    <a href="ResetPass.aspx" class="forgot-btn pull-right">Forgot password?</a>
                                </div>
                                <div class="submit-login form-group">
                                    <div class="alert alert-danger" id="alertMessage" style="display: none">
                                        alert message
                                    </div>
                                    <button type="button" id="btnLogin" class="btn btn-block btn-primary">Login</button>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
                <footer class="custom-FooterLogin FooterLogin">
                    <div class="footer_text">
                           Copyright @ 2019 by <a href="http://bavitech.com">Bavitech Corporation</a>
                    </div>
                    <p>42 Truong Son Street, Ward 2, Tan Binh District, Ho Chi Minh City, Viet Nam</p>
                    <p><b>Tel:</b> (+84-8) 3547 0976<b style="margin-left: 8px;"> Fax:</b> (+84-8) 3547 0977 </p>
                    <b>Email: <a style="margin-right: 8px;"> seles@bavitech.com </a> Website: <a href="http://bavitech.com"> www.bavitech.com </a></b>
                </footer>
            </div>
        </div>
    </div>
</div>

<telerik:RadNotification ID="ntf" runat="server" Title="Message" BackColor="Purple">
</telerik:RadNotification>
<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="txtPassword">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ntf" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnLogin">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ntf" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<script type="text/javascript">
    $(function () {

        if ($.cookie("sitevivawarter") != null) {
            $("#username").val($.cookie("sitevivawarter"));
        }
        $("#btnLogin").click(function () {
            if ($("#remember").prop("checked") == true) {
                        $.cookie("sitevivawarter", $("#username").val()); 
                         $.cookie("example", "foo", { expires: 7 });
            }
            $.ajax({
                type: "POST",
                url: "../../Pi-solution/Pi1.asmx/Login_pi",
                data: JSON.stringify({ username: $("#username").val(), password: $('#password').val() }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    $("#alertMessage").text("");
                    var obj = JSON.parse(result.d);
                    if (obj.resultId == 1) {
                        $("#alertMessage").hide();
                        window.location = obj.message;
                    }
                    else {
                        $("#alertMessage").show();
                        $("#alertMessage").text(obj.message);
                    }
                },
                error: function (error) {
                    console.log(error);
                    alert("The system is under maintenance. Please come back later");
                }
            });



        });
        $(".form-control").each(function () {
            $(this).removeClass("rfdDecorated");
        });

        $(".form-control").keypress(function (e) {
                if (e.keyCode == 13) {
                   $("#btnLogin").click();
                    return false;
                }
        });




    });
</script>
