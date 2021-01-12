<%@ WebHandler Language="C#" Class="ImageHandler" %>

using System;
using System.Web;
using System.IO;


public class ImageHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        try
        {
            string dirFullPath = HttpContext.Current.Server.MapPath("~/_imgs/System");
            string str_image = "";

            foreach (string s in context.Request.Files)
            {
                HttpPostedFile file = context.Request.Files[s];
                string fileName = file.FileName;
                string fileExtension = file.ContentType;

                if (!string.IsNullOrEmpty(fileName))
                {
                    fileExtension = Path.GetExtension(fileName);
                    str_image = fileName;
                    string pathToSave_100 = dirFullPath + "/" + str_image;
                    
                    if(File.Exists(pathToSave_100))
                    {
                        File.Delete(pathToSave_100);
                    }

                    file.SaveAs(pathToSave_100);
                }
            }
            
            context.Response.Write("Save image successfully");
        }
        catch (Exception ac) 
        { 
        
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}