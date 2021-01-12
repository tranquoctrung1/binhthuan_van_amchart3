using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;
public partial class Supervisor_Logger_chart : System.Web.UI.Page
{
    SiteBL _siteBL = new SiteBL();
    UserBL _userBL = new UserBL();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var user = _userBL.GetUser(HttpContext.Current.User.Identity.Name);
            IEnumerable<t_Sites> sites;
            if (user.Role == "consumer")
            {
                sites = _siteBL.GetSitesByConsumerID(user.ConsumerId);
            }
            else if (user.Role == "staff")
            {
                sites = _siteBL.GetSitesByStaffId(user.StaffId);
            }
            else
            {
                sites = null;
            }
            cboSites.DataSource = sites;
           
            cboSites.DataBind();
        }
    }
    protected void cboSites_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        var site = _siteBL.GetSite(cboSites.SelectedValue);
        //txtLocation.Text = site.Location;
        //SetEmpty();
    }
    protected void cboSites_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cboSites.SelectedIndex = 0;
        }
    }
}