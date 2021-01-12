using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using Subgurim.Controles;
using Telerik.Web.UI;
using System.Drawing;
using System.Text;
using PMAC.BLL;

public partial class Consumer_Logger_Map : System.Web.UI.Page
{
    UserBL _userBL = new UserBL();
    SiteBL _siteBL = new SiteBL();
    ChannelConfigurationBL _channelConfigurationBL = new ChannelConfigurationBL();
    System.Globalization.CultureInfo culture = new System.Globalization.CultureInfo("en-US");

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GMap1.Add(new GMapUI());
            GMap1.Add(GMapType.GTypes.Normal);
            GMap1.Add(GMapType.GTypes.Hybrid);
            GMap1.Add(GMapType.GTypes.Satellite);
            BindGmapData();
        }
        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            t_Users user = new t_Users();
            string username = HttpContext.Current.User.Identity.Name;
            t_Users dbUser = _userBL.GetUser(username);
            user = dbUser;
            user.Active = true;
            string hostName = Dns.GetHostName();
            user.Ip = Dns.GetHostAddresses(hostName).GetValue(0).ToString();
            user.TimeStamp = DateTime.Now;
            _userBL.UpdateUser(user, dbUser);
        }
    }

    public string Clean(string input)
    {
        string clean = input.Replace(' ', '_')
            .Replace('+', '_')
            .Replace('-', '_')
            .Replace('*', '_')
            .Replace('/', '_')
            .Replace('.', '_')
            .Replace('~','_')
            .Replace('!','_')
            .Replace('@','_')
            .Replace('#','_')
            .Replace('$','_')
            .Replace('%','_')
            .Replace('^','_')
            .Replace('&','_')
            .Replace('{','_')
            .Replace('}','_')
            .Replace('<','_')
            .Replace('>','_')
            .Replace('?','_');
        return clean;
    }

    private void BindGmapData()
    {
        var user = _userBL.GetUser(HttpContext.Current.User.Identity.Name);
        List<t_Sites> sites;
        if (user.Role == "consumer")
        {
            sites = _siteBL.GetSitesForMapByConsumerID(user.ConsumerId).ToList();
        }
        else if (user.Role == "staff")
        {
            sites = _siteBL.GetSitesForMapByStaffId(user.StaffId).ToList();
        }
        else
        {
            sites = null;
        }

        //var sites = _siteBL.GetSitesForMap().ToList();
        
        if (sites.Count == 0)
        {
            GMap1.setCenter(new GLatLng(16.109833, 107.201294), 6);
            return;
        }
        List<string> groups = (from s in sites
                               select s.DisplayGroup).Distinct().ToList();
        if (!IsPostBack)
        {
            GMap1.GZoom = (int)sites.Select(s => s.Zoom).Min();

            int i = 0;
            foreach (string g in groups)
            {
                Telerik.Web.UI.RadTreeNode parent = new Telerik.Web.UI.RadTreeNode(g);
                trvSites.Nodes.Add(parent);
                var gSites = (from s1 in sites
                              where s1.DisplayGroup == g
                              select s1).ToList();

                foreach (t_Sites gS in gSites)
                {
                    Telerik.Web.UI.RadTreeNode child = new Telerik.Web.UI.RadTreeNode(gS.Location, gS.SiteAliasName);
                    child.NavigateUrl = String.Format("javascript:open_Window({0});", i.ToString());
                    parent.Nodes.Add(child);
                    i++;
                }
            }
            trvSites.ExpandAllNodes();
        }
        GLatLngBounds gLatLngBounds = new GLatLngBounds();

        double forwardIndex = 0;
        double reveseIndex = 0;
        DateTime? lastForwardIndexTimeStamp = null;
        DateTime? lastReverseIndexTimeStamp = null;
        double? index = 0;
        DateTime? indexTimeStamp = null;

        GIcon icon = new GIcon();
        icon.image = System.Configuration.ConfigurationManager.AppSettings["gMarkerIcon"];
        icon.iconSize = new GSize(20, 20);
        icon.shadowSize = new GSize(20, 20);
        icon.iconAnchor = new GPoint(6, 20);
        icon.infoWindowAnchor = new GPoint(5, 1);

        GIcon icon_alrm = new GIcon();
        icon_alrm.image = System.Configuration.ConfigurationManager.AppSettings["gMarkerIconError"];
        icon_alrm.iconSize = new GSize(20, 20);
        icon_alrm.shadowSize = new GSize(20, 20);
        icon_alrm.iconAnchor = new GPoint(6, 20);
        icon_alrm.infoWindowAnchor = new GPoint(5, 1);

        GMap1.resetCustomInsideJS();
        GMap1.resetCustomJS();
        GMap1.resetInfoWindows();
        GMap1.resetMarkers();

        //Alarm display
        List<string> listSiteAlarm = new List<string>();
        OleDbConnection aCnn = new OleDbConnection("");
        aCnn.ConnectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;Data source=C:\PMAC\PMACSITE.MDB";
        try
        {
            aCnn.Open();
            OleDbCommand aCmd = new OleDbCommand("SELECT [Id] FROM [ALARMLOG] WHERE Priority LIKE 'H' OR Priority LIKE 'L' GROUP BY [Id]", aCnn);
            OleDbDataReader aRdr = aCmd.ExecuteReader();
            while (aRdr.Read())
            {
                listSiteAlarm.Add(aRdr[0].ToString());
            }
            aCnn.Close();
            aCnn.Dispose();
        }
        catch (Exception ex)
        {

            throw ex;
        }

        StringBuilder sb = new StringBuilder();

        sb.Append("markers = [];");
        sb.Append("lablelMarkers = [];");
        sb.Append("function add_Window()");
        sb.Append("{");
        string formatedAliasName;

        bool flag = false;

        foreach (string g in groups)
        {
            var gSites = (from s1 in sites
                          where s1.DisplayGroup == g
                          select s1).ToList();

            foreach (var s in gSites)
            {
                formatedAliasName = Clean(s.SiteAliasName);
                //formatedAliasName = s.SiteAliasName.Replace(' ', '_').Replace('.', '_').Replace('-','_').Replace('+','_');
                var channels = _channelConfigurationBL.GetChannelConfigurationsByLoggerID(s.LoggerId);
                forwardIndex = 0;
                reveseIndex = 0;
                foreach (var c in channels)
                {
                    if (c.ForwardFlow == true)
                    {
                        forwardIndex = c.LastIndex ?? 0;
                        lastForwardIndexTimeStamp = c.IndexTimeStamp;
                    }
                    else if (c.ReverseFlow == true)
                    {
                        reveseIndex = c.LastIndex ?? 0;
                        lastReverseIndexTimeStamp = c.IndexTimeStamp;
                    }
                }
                index = forwardIndex - reveseIndex;
                indexTimeStamp = lastForwardIndexTimeStamp ?? lastReverseIndexTimeStamp;

                string label = "";
                label += "<div id='l_" + formatedAliasName + "' >";
                label += "<div class='lblSiteName'>" + formatedAliasName + "</div>";
                label += "<table border='0' cellpadding='3' cellspacing='0'>";

                string html = "";

                html += "<div class=\"text\">"
                    + "Alias name"
                    + ": "
                    + s.SiteAliasName
                    + "</div>";
                html += "<div class=\"text\">"
                    + "Vị trí"
                    + ": "
                    + s.Location
                    + "</div>";
                html += "<div class=\"text\">"
                    + "Cỡ ống"
                    + ": "
                    + s.PipeSize
                    + "</div>";
                html += "<div class=\"text\">"
                    + "Chỉ số"
                    + ": "
                    + string.Format("{0:0.0}", index) + " (" + (indexTimeStamp != null ? ((DateTime)indexTimeStamp).ToString("dd/MM/yyyy HH:mm") : "") + ")"
                    + "</div>";
                html += "<table border=\"0\" cellpadding=\"3\" cellspacing=\"0\" style=\"width:auto;height:auto;\">";
                html += "<tr><td class=\"tblHeader\">"
                    + "Kênh"
                    + "</td><td class=\"tblHeader\">"
                    + "Mô tả"
                    + "</td><td class=\"tblHeader\">"
                    + "Ngày giờ"
                    + "</td><td class=\"tblHeader\">"
                    + "Giá trị"
                    + "</td><td class=\"tblHeader\">"
                    + "Đơn vị"
                    + "</td></tr>";

                flag = false;

                foreach (var c in channels)
                {
                    html += "<tr><td class=\"cellCenter\">"
                        + c.ChannelId
                        + "</td><td class=\"cellCenter\">"
                        + c.ChannelName
                        + "</td><td class=\"cellCenter imp\">"
                        + (c.TimeStamp == null ? "NO DATA" : ((DateTime)c.TimeStamp).ToString("dd/MM/yyyy HH:mm"))
                        + "</td><td class=\"cellRight imp\">"
                        + string.Format(culture, "{0:0.0}", c.LastValue)
                        + "</td><td class=\"cellLeft\">"
                        + c.Unit
                        + "</td></tr>";

                    if ((c.Pressure2 == true && c.Pressure1 == false && flag == false) || (c.Pressure2 == false && c.Pressure1 == true && flag == false))
                    {
                        label += "<tr><td class='cellCenterLbl'>"
                            + (c.LastValue == null ? "NO DATA" : string.Format(culture, "{0:0.0}", c.LastValue))
                            //+ "</td><td class='cellCenterLbl'>"
                            //+ c.Unit
                            + "</td></tr>";

                        flag = true;
                    }
                }

                html += "</table>";
                label += "</table></div>";

                GMarkerOptions markerOptions = new GMarkerOptions();
                if (listSiteAlarm.Contains(s.LoggerId) || s.t_Logger_Configurations.Alarm == true)
                {
                    markerOptions.icon = icon_alrm;
                }
                else
                {
                    markerOptions.icon = icon;
                }
                markerOptions.Animation = GMarkerOptions.AnimationType.Bounce;

                GLatLng loc = new GLatLng((double)s.Latitude, (double)s.Longitude);
                GMarker marker = new GMarker(loc, markerOptions);
                marker.ID = "m_" + formatedAliasName;
                GInfoWindow infoWindow = new GInfoWindow(marker, html);
                sb.Append(infoWindow.ToString(GMap1.GMap_Id));

                sb.AppendFormat("var {0} = new MarkerWithLabel(", "l_m_" + formatedAliasName);
                sb.Append("{");
                sb.AppendFormat(culture, "position: new google.maps.LatLng({0}, {1}),", (double)s.Latitude, (double)s.Longitude);
                sb.Append("draggable: false,");
                sb.Append("raiseOnDrag: false,");
                sb.AppendFormat("map: {0},", GMap1.GMap_Id);
                sb.AppendFormat("labelContent: \"{0}\",", label);
                sb.Append("labelAnchor: new google.maps.Point(15, 0),");
                sb.Append("icon: {}");
                sb.Append("});");

                sb.AppendFormat("{0}.setVisible(display);", "l_m_" + formatedAliasName);

                sb.AppendFormat("google.maps.event.addListener({0}, 'click', function (e) ", "l_m_" + formatedAliasName);
                sb.Append("{");
                sb.AppendFormat("google.maps.event.trigger({0}, 'click')", marker.ID);
                sb.Append("});");

                sb.AppendFormat("markers.push({0});", marker.ID);
                sb.AppendFormat("lablelMarkers.push({0});", "l_m_" + formatedAliasName);

                gLatLngBounds.extend(loc);
            }
        }

        if (!IsPostBack)
        {
            //fitBounds
            sb.Append("var myBounds = new google.maps.LatLngBounds(); ");
            sb.AppendFormat("var ne = new google.maps.LatLng({0},{1});", gLatLngBounds.ne.lat.ToString(), gLatLngBounds.ne.lng.ToString());
            sb.AppendFormat("var sw = new google.maps.LatLng({0},{1});", gLatLngBounds.sw.lat.ToString(), gLatLngBounds.sw.lng.ToString());
            sb.Append("myBounds.extend(ne);myBounds.extend(sw);");
            sb.AppendFormat("{0}.fitBounds(myBounds);", GMap1.GMap_Id);
        }
        //Center on page reload event
        sb.AppendFormat("google.maps.event.addListener({0}, 'center_changed', function()", GMap1.GMap_Id);
        sb.Append("{");
        sb.AppendFormat("center={0}.getCenter();", GMap1.GMap_Id);
        sb.Append("});");
        sb.AppendFormat("{0}.setCenter(center);", GMap1.GMap_Id);

        //	create the ContextMenu object
        sb.AppendFormat("var contextMenu = new ContextMenu({0}, contextMenuOptions);", GMap1.GMap_Id);

        //	display the ContextMenu on a Map right click
        sb.AppendFormat("google.maps.event.addListener({0}, 'rightclick', function (mouseEvent)", GMap1.GMap_Id);
        sb.Append("{contextMenu.show(mouseEvent.latLng);});");

        sb.Append("google.maps.event.addListener(contextMenu, 'menu_item_selected', function (latLng, eventName) {");
        sb.Append("switch (eventName) {");
        sb.Append("case 'hide_click':");
        sb.Append("for (var i = 0; i < lablelMarkers.length; i++) {");
        sb.Append("lablelMarkers[i].setVisible(false);");
        sb.Append("display=false;");
        sb.Append("}");
        sb.Append("break;");
        sb.Append("case 'show_click':");
        sb.Append("for (var i = 0; i < lablelMarkers.length; i++) {");
        sb.Append("lablelMarkers[i].setVisible(true);");
        sb.Append("display=true;");
        sb.Append("}");
        sb.Append("break;");
        sb.Append("}");
        sb.Append("});");

        sb.Append("}");

        
        GMap1.Add(sb.ToString());
        GMap1.Add("add_Window();", true);
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        BindGmapData();
    }

    protected void RadTreeView1_DataBound(object sender, EventArgs e)
    {
        RadTreeView1.ExpandAllNodes();
    }
}