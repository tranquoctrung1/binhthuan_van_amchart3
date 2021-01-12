using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using System.IO;

using PMAC.BLL;
using NPOI.HSSF.UserModel;
using NPOI.HPSF;
using System.Net.Mail;
using System.Configuration;
using PMAC.ULT;

public partial class ResetPass : System.Web.UI.Page
{
    UserBL _userBL = new UserBL();
    StringUT _stringUT = new StringUT();
    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        

        language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.ControlId.Contains("ChangePassword")).ToList();
    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
       
        // check if yes
        var user = _userBL.GetUser(txtUserName.Text);
        if (user != null && user.Email == txtEmail.Text)
        {
            string subject = ConfigurationManager.AppSettings["sCompany"].ToString() + "reset password";
            string adminEmail = ConfigurationManager.AppSettings["mail"].ToString();
            string adminPassword = ConfigurationManager.AppSettings["mailPassword"].ToString();
            string body = "Hello " + user.Username;
            body = body + "<div> Bạn hoặc ai đó đã yêu cầu reset password</div>";
            body = body + "<div> Hãy click vào link </div>";
            body = body + "<a href='" + "https://viwater.pi-solution.vn/ResetPass2.aspx?u=" + user.Username + "&c=" + user.Salt + "'>  here </a>";
            body = body + "<div>";
            body = body +  "</div>";
            body = body +  "<div> Hoặc bỏ qua thư này nếu đó không phải là bạn</div>";
            body = body +  "<div>Trân trọng! </div></br> SysAdmin"  + ConfigurationManager.AppSettings["sCompany"].ToString() + "</div>";
            try
            {
                SendMail("Reset Password", body, adminEmail, adminPassword);
                lblNotice.Text = "Vui lòng kiểm tra email!";
            }
            catch (Exception ex) {
                lblNotice.Text = "Có lỗi trong quá trình gửi email!";
            }
            txtEmail.Text = "";
            txtUserName.Text = "";

        }
        else {
            lblNotice.Text = "Username or Email is wrong !";
        }


    }

    private void SendMail(string subject, string body,string adminEmail, string adminPassword)
    {
        adminEmail = "wareyouhello@gmail.com";
        adminPassword = "AQSW513 030 586";
        MailMessage mail = new MailMessage();
      
        mail.From = new MailAddress(adminEmail);
        mail.Subject = subject;
        mail.Body = body;
        mail.IsBodyHtml = true;
        mail.To.Add(txtEmail.Text);
       // mail.Attachments.Add(new Attachment(filePath));
        using (SmtpClient smtp = new SmtpClient())
        {
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.Credentials = new System.Net.NetworkCredential(adminEmail, adminPassword);
            smtp.EnableSsl = true;
            try
            {
                smtp.Send(mail);
                lblNotice.ForeColor = System.Drawing.Color.Green;
                lblNotice.Text = "Đã gửi.";
            }
            catch (Exception ex)
            {
                lblNotice.ForeColor = System.Drawing.Color.Red;
                lblNotice.Text = "Lỗi. Thử lại.";
            }
        }
        mail.Dispose();
    }
}