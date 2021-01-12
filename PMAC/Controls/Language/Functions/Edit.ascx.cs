using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;
using PMAC.ULT;

public partial class Controls_Language_ucFunction_edit : System.Web.UI.UserControl
{
    UserBL _userBL = new UserBL();
    StringUT _stringUT = new StringUT();
    FunctionBL functionBL = new FunctionBL();
    private static int functionId = -1;

    protected void Page_Load(object sender, EventArgs e)
    {

        string linkID = string.IsNullOrEmpty(Request.QueryString["FunctionId"]) ? "0" : Request.QueryString["FunctionId"];

        // Load language contents
        if (!IsPostBack)
        {
            functionId = int.Parse(linkID);
            t_Function functionList = functionBL.FindSingle(x => x.FunctionId == functionId);

            // Vietnamese language zone
            if (functionList != null)
            {
                txtFormName.Text = functionList.FunctionName;
                txtURL.Text = functionList.URL;
                txtStatus.SelectedValue = (functionList.IsOnMenu == true) ? "1" : "0";
            }
        }

        // Required messgage warning
        RequiredFieldValidator1.ErrorMessage = "** Required value";
    }
    

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            ntf.VisibleOnPageLoad = true;
            t_Function entity = new t_Function
            {
                FunctionName = txtFormName.Text,
                IsOnMenu = (txtStatus.SelectedValue == "1") ? true : false,
            };
            bool updateStatus = functionBL.Update(entity, functionId);
            string message = (updateStatus) ? "Cập nhật thành công" : "Cập nhật không thành công";
            ntf.Text = message;
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        string urlRedirect = string.Format("/Supervisor/Language/ChangeFunction.aspx");
        Response.Redirect(urlRedirect);
    }
}