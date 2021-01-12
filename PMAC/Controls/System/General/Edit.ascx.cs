using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;
using PMAC.ULT;

public partial class Controls_System_ucGeneral_edit : System.Web.UI.UserControl
{
    UserBL _userBL = new UserBL();
    StringUT _stringUT = new StringUT();
    SysParamBL sysParamBL = new SysParamBL();
    private static int contentId = -1;

    protected void Page_Load(object sender, EventArgs e)
    {

        string linkID = string.IsNullOrEmpty(Request.QueryString["Id"]) ? "0" : Request.QueryString["Id"];

        if (!IsPostBack)
        {
            // Load language contents
            contentId = int.Parse(linkID);
            t_SysParam system = sysParamBL.FindSingle(x => x.ID == contentId);

            // Vietnamese language zone
            if (system != null)
            {
                txtVal.Text = system.Val;
                txtDescription.Text = system.Description;
                imgLogo.ImageUrl = system.Val;
            }

            // Required messgage warning
            RequiredFieldValidator1.ErrorMessage = "** Required value";
        }
    }
    

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            ntf.VisibleOnPageLoad = true;

            t_SysParam system = sysParamBL.FindSingle(x => x.ID == contentId);
            system.Description = txtDescription.Text;

            string logoName = imgNewLogo.Value;
            if (!string.IsNullOrEmpty(logoName))
            {
                system.Val = string.Format("/_imgs/System/{0}", logoName);
            }
            bool updateStatus = sysParamBL.Update(system, contentId);
            imgLogo.ImageUrl = system.Val;

            string message = (updateStatus) ? "Cập nhật thành công" : "Cập nhật không thành công";
            ntf.Text = message;            
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        string urlRedirect = string.Format("/Supervisor/System/General.aspx");
        Response.Redirect(urlRedirect);
    }
}