using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;

public partial class MasterPage : System.Web.UI.MasterPage
{
    SysParamBL sysParamBL = new SysParamBL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            title.Text = sysParamBL.FindSingle(x => x.Name == "title").Val;
        }
    }
}
