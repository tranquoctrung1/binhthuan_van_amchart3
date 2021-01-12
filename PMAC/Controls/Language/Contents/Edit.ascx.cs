using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;
using PMAC.ULT;

public partial class Controls_Language_ucContent_edit : System.Web.UI.UserControl
{
    UserBL _userBL = new UserBL();
    StringUT _stringUT = new StringUT();
    LanguageBL languageBL = new LanguageBL();
    private static int contentId = -1;

    protected void Page_Load(object sender, EventArgs e)
    {

        string linkID = string.IsNullOrEmpty(Request.QueryString["Id"]) ? "0" : Request.QueryString["Id"];

        // Load language contents
        if (!IsPostBack)
        {
            contentId = int.Parse(linkID);
            t_LanguageTranslate content = languageBL.FindSingle(x => x.Id == contentId);

            // Vietnamese language zone
            if (content != null)
            {
                //txtControlId.Text = content.ControlId;
                txtContent.Text = content.Contents;
                txtNoted.Text = content.Noted;
            }

            // Required messgage warning
            //RequiredFieldValidator1.ErrorMessage = "** Required value";
            RequiredFieldValidator2.ErrorMessage = "** Required value";
        }
    }
    

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            ntf.VisibleOnPageLoad = true;
            t_LanguageTranslate entity = new t_LanguageTranslate
            {
                Contents = txtContent.Text,
                Noted = txtNoted.Text
            };
            bool updateStatus = languageBL.Update(entity, contentId);
            string message = (updateStatus) ? "Cập nhật thành công" : "Cập nhật không thành công";
            ntf.Text = message;
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        string urlRedirect = string.Format("/Supervisor/Language/ChangeContent.aspx");
        Response.Redirect(urlRedirect);
    }
}