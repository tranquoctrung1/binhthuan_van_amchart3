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
using System.Text.RegularExpressions;

using PMAC.BLL;

public partial class Supervisor_Logger_Map : System.Web.UI.Page
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

    private void BindGmapData()
    {
        var sites = _siteBL.GetSitesForMap().ToList();
        if (sites.Count == 0)
        {
            GMap1.setCenter(new GLatLng(16.109833, 107.201294), 6);
            return;
        }
        List<string> groups = (from s in sites
                               select s.DisplayGroup).Distinct().ToList();
        if (!IsPostBack)
        {     
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
            
         //throw ex;
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
                //formatedAliasName = s.SiteAliasName.Replace(' ', '_').Replace('.', '_').Replace('+','_').Replace('-','_');
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
                    + "Alias Name"
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
                    + string.Format("{0:0.0}", index) + " (" + (indexTimeStamp != null ? ((DateTime)indexTimeStamp).ToString("dd/MM/yyyy HH:mm:ss") : "") + ")"
                    + "</div>";
                html += "<table border=\"0\" cellpadding=\"3\" cellspacing=\"0\" style=\"width:auto;height=auto;\">";
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
                var isMobile = BrowserDetected();
                if (!isMobile)
                {
                    if (s.LabelAnchorX == null || s.LabelAnchorY == null)
                    {
                        sb.Append("labelAnchor: new google.maps.Point(15, 0),");
                    }
                    else
                    {
                        sb.AppendFormat("labelAnchor: new google.maps.Point({0}, {1}),", s.LabelAnchorX, s.LabelAnchorY);
                    }
                }
                else
                {
                    sb.Append("labelAnchor: new google.maps.Point(30, 0),");
                }
                //if (s.LabelLat != s.Latitude || s.LabelLng != s.Longitude)
                //{
                //    GLatLng lStart = new GLatLng((double)s.Latitude, (double)s.Longitude);
                //    GLatLng lEnd = new GLatLng((double)s.LabelLat, (double)s.LabelLng);
                //    List<GLatLng> collection = new List<GLatLng>();
                //    collection.Add(lStart);
                //    collection.Add(lEnd);
                //    GPolyline line = new GPolyline(collection, "0000FF", 2);
                //    GMap1.Add(line);
                //}
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

        //On Page reload
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

        //Zoom max
        sb.AppendFormat("google.maps.event.addListener({0}, 'zoom_changed', function ()", GMap1.GMap_Id);
        sb.Append("{");
        sb.AppendFormat("var _zoom = {0}.getZoom();", GMap1.GMap_Id);
        sb.AppendFormat("if(_zoom < {0})", System.Configuration.ConfigurationManager.AppSettings["gZoomMinForLabel"]);
        sb.Append("{");
        sb.Append("for (var i = 0; i < lablelMarkers.length; i++) {");
        sb.Append("lablelMarkers[i].setVisible(false);");
        sb.Append("display=false;");
        sb.Append("}");
        sb.Append("}");
        sb.Append("else");
        sb.Append("{");
        sb.Append("for (var i = 0; i < lablelMarkers.length; i++) {");
        sb.Append("lablelMarkers[i].setVisible(true);");
        sb.Append("display=true;");
        sb.Append("}");
        sb.Append("}");
        sb.Append("});");


        //fitBounds
        //if (!IsPostBack)
        //{
        //    sb.Append("var myBounds = new google.maps.LatLngBounds(); ");
        //    sb.AppendFormat("var ne = new google.maps.LatLng({0},{1});", gLatLngBounds.ne.lat.ToString(), gLatLngBounds.ne.lng.ToString());
        //    sb.AppendFormat("var sw = new google.maps.LatLng({0},{1});", gLatLngBounds.sw.lat.ToString(), gLatLngBounds.sw.lng.ToString());
        //    sb.Append("myBounds.extend(ne);myBounds.extend(sw);");
        //    sb.AppendFormat("{0}.fitBounds(myBounds);", GMap1.GMap_Id);
        //}
        if (!IsPostBack)
        {
            sb.AppendFormat("{0}.setZoom({1});", GMap1.GMap_Id, System.Configuration.ConfigurationManager.AppSettings["gZoomInit"]);
            sb.AppendFormat("{0}.setCenter(new google.maps.LatLng({1}, {2}));"
                , GMap1.GMap_Id, System.Configuration.ConfigurationManager.AppSettings["gLatInit"]
                , System.Configuration.ConfigurationManager.AppSettings["gLngInit"]);
        }


        sb.Append("}");
        GMap1.Add(sb.ToString());
        GMap1.Add("add_Window();", true);
    }

    public bool BrowserDetected()
    {
        string u = Request.ServerVariables["HTTP_USER_AGENT"];
        Regex b = new Regex(@"(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino", RegexOptions.IgnoreCase | RegexOptions.Multiline);
        Regex v = new Regex(@"1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-", RegexOptions.IgnoreCase | RegexOptions.Multiline);
        if ((b.IsMatch(u) || v.IsMatch(u.Substring(0, 4))))
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        BindGmapData();
    }


    protected void RadTreeView1_DataBound(object sender, EventArgs e)
    {
        RadTreeView1.ExpandAllNodes();
    }

    public string Clean(string input)
    {
        string clean = input.Replace(' ', '_')
            .Replace('+', '_')
            .Replace('-', '_')
            .Replace('*', '_')
            .Replace('/', '_')
            .Replace('.', '_')
            .Replace('~', '_')
            .Replace('!', '_')
            .Replace('@', '_')
            .Replace('#', '_')
            .Replace('$', '_')
            .Replace('%', '_')
            .Replace('^', '_')
            .Replace('&', '_')
            .Replace('{', '_')
            .Replace('}', '_')
            .Replace('<', '_')
            .Replace('>', '_')
            .Replace('?', '_');
        return clean;
    }

}