using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.ULT;
using PMAC.BLL;


public partial class Supervisor_File_Transmitter : System.Web.UI.Page
{
    StringUT _stringUT = new StringUT();
    FileUT _fileUT = new FileUT();
    TransmitterFileBL _transmitterFileBL = new TransmitterFileBL();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Pi-solution
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Device/All.aspx")).ToList();

            var var1 = list.Where(x => x.ControlId.Contains("winLinkUpload_MeterSeri")).FirstOrDefault();
            winLinkUpload_MeterSeri.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("winLinkUpload_FileSelection")).FirstOrDefault();
            winLinkUpload_FileSelection.Text = (var2 == null) ? "" : var2.Contents;


            var var28 = list.Where(x => x.ControlId.Contains("winLinkUpload_btnUpload")).FirstOrDefault();
            btnDownload.Text = (var28 == null) ? "" : var28.Contents;
            var var29 = list.Where(x => x.ControlId.Contains("winLinkUpload_btnDownload")).FirstOrDefault();
            btnUpload.Text = (var29 == null) ? "" : var29.Contents;
            var var30 = list.Where(x => x.ControlId.Contains("winLinkUpload_btnDelete")).FirstOrDefault();
            btnDelete.Text = (var30 == null) ? "" : var30.Contents;


            // Change header of rad grid
            var var5 = list.Where(x => x.ControlId.Contains("grv_FileName")).FirstOrDefault();
            grv.MasterTableView.GetColumn("FileName").HeaderText = (var5 == null) ? "" : var5.Contents;
            var var6 = list.Where(x => x.ControlId.Contains("grv_Seri_number")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column1").HeaderText = (var6 == null) ? "" : var6.Contents;
            var var7 = list.Where(x => x.ControlId.Contains("grv_mime_type")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column2").HeaderText = (var7 == null) ? "" : var7.Contents;
            var var8 = list.Where(x => x.ControlId.Contains("grv_size")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column3").HeaderText = (var8 == null) ? "" : var8.Contents;
            var var9 = list.Where(x => x.ControlId.Contains("grv_UploadDate")).FirstOrDefault();
            grv.MasterTableView.GetColumn("column4").HeaderText = (var9 == null) ? "" : var9.Contents;
        }

        if (!IsPostBack)
        {
            string Transmitter = Request.QueryString["transmitter"];
            txtSerial.Text = Transmitter;
            BindFile();
        }
        lblMessage.Visible = false;
    }
    protected void asyncUpload_FileUploaded(object sender, Telerik.Web.UI.FileUploadedEventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Device/All.aspx")).ToList();
        var up_download_upload_confirm = list.Where(x => x.ControlId.Contains("up_download_upload_confirm")).FirstOrDefault();


        lblMessage.Visible = true;
        if (string.IsNullOrEmpty(txtSerial.Text))
        {
            lblMessage.Text = "Please input seri .";
            txtSerial.Focus();
            return;
        }
        string targetFolder = asyncUpload.TargetFolder;
        string newName = "_" + txtSerial.Text + "_" + _stringUT.RemoveSign4VietnameseString(e.File.GetName());
        e.File.SaveAs(System.IO.Path.Combine(Server.MapPath(targetFolder), newName));

        var dbTransmitterFile = _transmitterFileBL.GetTransmitterFile(newName);
        t_Transmitter_Files transmitterFile = new t_Transmitter_Files();
        transmitterFile.FileName = newName;
        transmitterFile.MIMEType = e.File.ContentType;
        transmitterFile.Path = System.IO.Path.Combine(Server.MapPath(targetFolder), transmitterFile.FileName);
        transmitterFile.TransmitterSerial = txtSerial.Text;
        transmitterFile.Size = (int)e.File.ContentLength;
        transmitterFile.UploadDate = DateTime.Now;
        if (dbTransmitterFile != null)
        {
            try
            {
                _transmitterFileBL.UpdateTransmitterFile(transmitterFile, dbTransmitterFile);
                //lblMessage.Text = "Đã upload file mới.";
                lblMessage.Text = up_download_upload_confirm.Contents;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi: " + ex.Message;
                //throw;
            }
        }
        else
        {
            try
            {
                _transmitterFileBL.InsertTransmitterFile(transmitterFile);
                lblMessage.Text = "file uploaded .";
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
                //throw;
            }
        }
        BindFile();
    }

    protected void btnDownload_Click(object sender, EventArgs e)
    {
        List<string> listFiles = GetFiles();
        if (listFiles.Count == 0)
        {
            return;
        }
        string folder = Server.MapPath(asyncUpload.TargetFolder);
        _fileUT.DownloadMultiFiles(txtSerial.Text, listFiles, folder, Response);
    }

    private List<string> GetFiles()
    {
        List<string> listFiles = new List<string>();
        foreach (Telerik.Web.UI.GridDataItem row in grv.SelectedItems)
        {
            listFiles.Add(row["FileName"].Text);
        }
        return listFiles;
    }

    private void BindFile()
    {
        grv.DataSource = _transmitterFileBL.GetTransmitterFilesByTransmitterSerial(txtSerial.Text);
        grv.DataBind();
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Device/All.aspx")).ToList();
        var up_download_empty_fileselected = list.Where(x => x.ControlId.Contains("up_download_empty_fileselected")).FirstOrDefault();
        var up_download_delete_confirm = list.Where(x => x.ControlId.Contains("up_download_delete_confirm")).FirstOrDefault();

        lblMessage.Visible = true;
        string folder = asyncUpload.TargetFolder;
        List<string> listFiles = GetFiles();
        if (listFiles.Count == 0)
        {
            //lblMessage.Text = "Không có file hoặc chưa chọn file.";
            lblMessage.Text = up_download_empty_fileselected.Contents;
            return;
        }
        _fileUT.DeleteFiles(folder, listFiles);
        try
        {
            foreach (var fileName in listFiles)
            {
                var f = _transmitterFileBL.GetTransmitterFile(fileName);
                _transmitterFileBL.DeleteTransmitterFile(f);
            }
            //lblMessage.Text = "Đã xóa file.";
            lblMessage.Text = up_download_delete_confirm.Contents;
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Lỗi: " + ex.Message;
            //throw;
        }
        BindFile();
    }
}