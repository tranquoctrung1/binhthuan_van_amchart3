using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PMAC.ULT
{
    /// <summary>
    /// Xử lý các thao tác liên quan đến upload, download, ghi file
    /// </summary>
    public class FileUT
    {
        /// <summary>
        /// Tải xuống một file đơn
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="path"></param>
        /// <param name="response"></param>
        public void DownloadSingleFile(string fileName, string path, HttpResponse response)
        {
            byte[] buffer;
            using (System.IO.FileStream fileStream = new System.IO.FileStream(path, System.IO.FileMode.Open))
            {
                int fileSize = (int)fileStream.Length;
                buffer = new byte[fileSize];
                fileStream.Read(buffer, 0, (int)fileSize);
            }
            response.Clear();
            response.Buffer = true;
            response.BufferOutput = true;
            response.ContentType = "APPLICATION/x-download";
            response.AddHeader("Content-Disposition", "attachment; filename=" + fileName);
            response.CacheControl = "public";
            response.OutputStream.Write(buffer, 0, buffer.Length);
            response.End();
        }
        /// <summary>
        /// Zip và tải xuống file nén các file
        /// </summary>
        /// <param name="serial"></param>
        /// <param name="listFiles"></param>
        /// <param name="path"></param>
        /// <param name="response"></param>
        public void DownloadMultiFiles(string serial, List<string> listFiles, string path, HttpResponse response)
        {
            string fullName = "";
            string zipName = serial + ".zip";
            string zipFullPath = path + zipName;
            ICSharpCode.SharpZipLib.Zip.ZipOutputStream zipOut =
                new ICSharpCode.SharpZipLib.Zip.ZipOutputStream(System.IO.File.Create(zipFullPath));
            foreach (string fileName in listFiles)
            {
                fullName = path + "\\" + fileName;
                System.IO.FileInfo fi = new System.IO.FileInfo(fullName);
                ICSharpCode.SharpZipLib.Zip.ZipEntry entry = new ICSharpCode.SharpZipLib.Zip.ZipEntry(fi.Name);
                System.IO.FileStream sReader = System.IO.File.OpenRead(fullName);
                byte[] buff = new byte[Convert.ToInt32(sReader.Length)];
                sReader.Read(buff, 0, (int)sReader.Length);
                entry.DateTime = fi.LastWriteTime;
                entry.Size = sReader.Length;
                sReader.Close();
                zipOut.PutNextEntry(entry);
                zipOut.Write(buff, 0, buff.Length);
            }
            zipOut.Finish();
            zipOut.Close();
            DownloadSingleFile(zipName, zipFullPath, response);
        }
        /// <summary>
        /// Xóa file
        /// </summary>
        /// <param name="virtualPath"></param>
        /// <param name="fileNames"></param>
        public void DeleteFiles(string virtualPath, List<string> fileNames)
        {
            foreach (var fileName in fileNames)
            {
                string file = HttpContext.Current.Server.MapPath(virtualPath + fileName);
                System.IO.File.Delete(file);
            }
        }
        /// <summary>
        /// Ghi vào file text
        /// </summary>
        /// <param name="filePath"></param>
        /// <param name="user"></param>
        /// <param name="content"></param>
        public void WriteLogFile(string filePath, string user, string content)
        {
            if (!System.IO.File.Exists(filePath))
            {
                using (System.IO.StreamWriter sw = System.IO.File.CreateText(filePath))
                {
                    sw.WriteLine("Web FMM SGWDC");
                    sw.WriteLine("Created at " + DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss TT"));
                    sw.WriteLine("-------------------------------------------------------------");
                }
            }
            using (System.IO.StreamWriter sw = new System.IO.StreamWriter(filePath, true))
            {
                sw.WriteLine(DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss TT") + " ==> <u>" + user + "</u><c>" + content + "</c>\r\n");
            }
        }
    }
}