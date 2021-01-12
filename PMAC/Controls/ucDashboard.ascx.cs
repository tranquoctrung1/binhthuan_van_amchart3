using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;

public partial class Controls_ucDashboard : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var site = (new SiteBL()).GetSites().FirstOrDefault();
        if (site != null) cboSites.SelectedValue = site.SiteId;
    }
}