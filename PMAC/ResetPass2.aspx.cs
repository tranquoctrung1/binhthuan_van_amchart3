using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;
using PMAC.ULT;

public partial class ResetPass2 : System.Web.UI.Page
{
    UserBL _userBL = new UserBL();
    StringUT _stringUT = new StringUT();
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        string username = Request["u"];
        string salt = Request["c"];
        var user = _userBL.GetUser(username);
        if (user != null &&salt == user.Salt )
        {
            lblNotice.Text = "";
        }
        else {
            Response.Redirect("Login.aspx");
            
        }


        //language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

        //List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.ControlId.Contains("ChangePassword")).ToList();

        //string OldPassword = "";
        //string NewPassword = "";
        //string ConfirmNewPassword = "";
        //string buttonSave = "";

        ////Parse content to form
        //var var1 = list.Where(x => x.ControlId.Contains("txtOldPassword")).FirstOrDefault();
        //OldPassword = (var1 == null) ? "" : var1.Contents;
        //var var2 = list.Where(x => x.ControlId.Contains("txtNewPassword")).FirstOrDefault();
        //NewPassword = (var2 == null) ? "" : var2.Contents;
        //var var3 = list.Where(x => x.ControlId.Contains("txtConfirmNewPassword")).FirstOrDefault();
        //ConfirmNewPassword = (var3 == null) ? "" : var3.Contents;
        //var var4 = list.Where(x => x.ControlId.Contains("btnOK")).FirstOrDefault();
        //buttonSave = (var4 == null) ? "" : var4.Contents;

        //lbOldPassword.Text = OldPassword;
        //lbNewPassword.Text = NewPassword;
        //lbConfirmNewPassword.Text = ConfirmNewPassword;
        //btnOK.Text = buttonSave;
    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        

            string username = Request["u"];
            var user = _userBL.GetUser(username);
            var dbUser = user;
            string salt = _stringUT.CreateSalt(8);
            string password = _stringUT.HashMD5(_stringUT.HashMD5(txtNewPassword.Text) + salt);
            user.Salt = salt;
            user.Password = password;
            _userBL.UpdateUser(user, dbUser);
            lblNotice.Text = "Đã đổi mật khẩu thành công.";
            
    }
}
