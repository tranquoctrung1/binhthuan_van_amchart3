using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;

namespace VanControllServices.Models
{
    public class TakeSampleHelper
    {
        private string cookie = "";

        public string IP { get; set; }

        public TakeSampleHelper(string ip, string port)
        {
            IP = "https://" + ip + ":" + port + "/";
            //IP = "https://" + ip + "/";
        }

        public bool ChangeThreshold(string tag_name, string val)
        {
            var url_prefix = "data/tags/" + tag_name + "/value";
            try
            {
                API_result(url_prefix, "PUT", "{\"value\": \"" + val + "\"}");
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }

        }

        private object API_result(string url_prefix, string method, string strBody = null)
        {
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
            string status = "";
            string response = "";

            string url = IP + url_prefix;

            while (status != "OK")
            {

                if (!string.IsNullOrEmpty(cookie))
                {
                    var httpWebRequest = (HttpWebRequest)WebRequest.Create(url);
                    httpWebRequest.ContentType = "application/json";
                    httpWebRequest.Referer = IP;
                    httpWebRequest.Method = method;
                    httpWebRequest.Timeout = 1000;
                    httpWebRequest.Headers.Add("Cookie", cookie);

                    if (!string.IsNullOrEmpty(strBody))
                    {
                        //Nhận thông tin từ body
                        byte[] body = (new ASCIIEncoding()).GetBytes(strBody);
                        httpWebRequest.ContentLength = body.Length;
                        //Gửi request
                        using (Stream newStream = httpWebRequest.GetRequestStream())
                        {
                            newStream.Write(body, 0, body.Length);
                        }
                    }

                    //Nhận response

                    var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();

                    status = httpResponse.StatusCode.ToString();
                    using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                    {
                        response = streamReader.ReadToEnd();
                    }
                }
                else
                {
                    cookie = GetCookie();
                }
            }

            var dic = JsonConvert.DeserializeObject<IDictionary<string, Object>>(response);
            var obj = new ExpandoObject() as IDictionary<string, Object>;
            foreach (var property in dic)
            {
                obj.Add(property.Key, property.Value);
            }
            return obj;
        }

        private string GetCookie(string password = "00000000")
        {
            string url = IP + "sys/log_in";
            var httpWebRequest = (HttpWebRequest)WebRequest.Create(url);
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.Referer = IP;
            httpWebRequest.Method = "PUT";
            httpWebRequest.Timeout = 1000;
            //Nhận thông tin từ body
            byte[] body = (new ASCIIEncoding()).GetBytes("{\"password\": \"" + password + "\"}");
            httpWebRequest.ContentLength = body.Length;
            //Gửi request
            using (Stream newStream = httpWebRequest.GetRequestStream())
            {
                newStream.Write(body, 0, body.Length);
            }
            //Nhận response

            var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();

            string response = "";
            string status = httpResponse.StatusCode.ToString();
            using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
            {
                response = streamReader.ReadToEnd();
            }
            var a = JsonConvert.DeserializeObject<Cookie2>(response);
            //HttpContext.Current.Session.Add("COOKIE_SESSION", "ADAMSID=" + a.Session_id);
            return "ADAMSID=" + a.Session_id;
        }

        private class Cookie2
        {
            public string Session_id { get; set; }
        }
    }

   
}