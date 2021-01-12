using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace VanControllServices
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API configuration and services
            config.EnableCors();

            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            config.Routes.MapHttpRoute(
               name: "getChartDataAPI",
               routeTemplate: "api/{controller}/{id}/{start}/{end}",
               defaults: new { id = RouteParameter.Optional, start = RouteParameter.Optional, end = RouteParameter.Optional }
           );

            config.Routes.MapHttpRoute(
                name: "WriteAPIToDevice",
                routeTemplate: "api/{controller}/{ip}/{port}/{tagname}/{value}",
                defaults: new { ip = RouteParameter.Optional, port = RouteParameter.Optional, tagname = RouteParameter.Optional, value = RouteParameter.Optional }
                );

            var appXmlType = config.Formatters.XmlFormatter.SupportedMediaTypes.FirstOrDefault(t => t.MediaType == "application/xml");
            config.Formatters.XmlFormatter.SupportedMediaTypes.Remove(appXmlType);
        }
    }
}
