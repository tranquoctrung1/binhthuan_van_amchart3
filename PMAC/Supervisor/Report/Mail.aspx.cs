using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using System.IO;

using PMAC.BLL;
using NPOI.HSSF.UserModel;
using NPOI.HPSF;
using System.Net.Mail;
using System.Configuration;

public partial class Supervisor_Report_Mail : System.Web.UI.Page
{
    ReportHelper _reportDataHelper = new ReportHelper();
    SiteBL _siteBL = new SiteBL();
    UserBL _userBL = new UserBL();

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Visible = false;

        if (!IsPostBack)
        {
            string consumerID = Request.QueryString["co"];
            var listAdmins = _userBL.GetUsersByRole("admin");
            var listStaffs = _userBL.GetUsersByRole("staff");
            var listConsumers = _userBL.GetUsers(consumerID);
            chkListAdmins.Items.Add(new ListItem("All"));
            foreach (var admin in listAdmins)
            {
                chkListAdmins.Items.Add(admin.Email);
            }
            chkListStaffs.Items.Add(new ListItem("All"));
            foreach (var staff in listStaffs)
            {
                chkListStaffs.Items.Add(staff.Email);
            }
            chkListConsumers.Items.Add(new ListItem("All"));
            foreach (var consumer in listConsumers)
            {
                chkListConsumers.Items.Add(consumer.Email);
            }
        }
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        string siteID = Request.QueryString["si"];
        var site = _siteBL.GetSite(siteID);
        System.Globalization.CultureInfo culture = new System.Globalization.CultureInfo("en-GB");
        DateTime startDate = DateTime.Parse(Request.QueryString["st"], culture);
        DateTime endDate = DateTime.Parse(Request.QueryString["en"], culture);

        string filePath = Server.MapPath("~/App_Data/Temp/" + site.SiteId.Replace(' ', '_') + "_from_" +  startDate.ToString("yyyy_MM") + "_to_" + endDate.ToString("yyyy_MM") + ".xls");
        if (File.Exists(filePath))
        {
            File.Delete(filePath);
        }
        CreateFile(filePath, siteID, startDate, endDate);
        string subject = "<"+ConfigurationManager.AppSettings["sCompany"].ToString()+"> Sản lượng " + site.SiteAliasName + "(" + site.Location + ") từ " + startDate.ToString("MM/yyyy") + " đến " + endDate.ToString("MM/yyyy");
        string body = "FYI,";
        string adminEmail = ConfigurationManager.AppSettings["mail"].ToString();
        string adminPassword = ConfigurationManager.AppSettings["mailPassword"].ToString();
        SendMail(subject, body, filePath, adminEmail, adminPassword);

    }

    private void CreateFile(string filePath, string siteID, DateTime startDate, DateTime endDate)
    {
        var site = _siteBL.GetSite(siteID);

        HSSFWorkbook hssfworkbook = new HSSFWorkbook();

        DocumentSummaryInformation dsi = PropertySetFactory.CreateDocumentSummaryInformation();
        dsi.Company = ConfigurationManager.AppSettings["company"].ToString();
        hssfworkbook.DocumentSummaryInformation = dsi;

        SummaryInformation si = PropertySetFactory.CreateSummaryInformation();
        si.Subject = "Report";
        hssfworkbook.SummaryInformation = si;

        var sheet = hssfworkbook.CreateSheet("Sheet1");

        var row0 = sheet.CreateRow(0);
        var cell00 = row0.CreateCell(0);
        cell00.SetCellValue("Sản lượng " + site.SiteAliasName + "(" + site.Location + ")");
        var row1 = sheet.CreateRow(1);
        var cell10 = row1.CreateCell(0);
        cell10.SetCellValue("Từ: ");
        var cell11 = row1.CreateCell(1);
        cell11.SetCellValue(startDate.ToString("MM-yyyy"));
        var row2 = sheet.CreateRow(2);
        var cell20 = row2.CreateCell(0);
        cell20.SetCellValue("Đến: ");
        var cell21 = row2.CreateCell(1);
        cell21.SetCellValue(endDate.ToString("MM-yyyy"));
        var row3 = sheet.CreateRow(3);
        var cell30 = row3.CreateCell(0);
        cell30.SetCellValue("Tháng");
        var cell31 = row3.CreateCell(1);
        cell31.SetCellValue("Vị trí");
        var cell32 = row3.CreateCell(2);
        cell32.SetCellValue("Bắt đầu");
        var cell33 = row3.CreateCell(3);
        cell33.SetCellValue("Chỉ số đầu");
        var cell34 = row3.CreateCell(4);
        cell34.SetCellValue("Kết thúc");
        var cell35 = row3.CreateCell(5);
        cell35.SetCellValue("Chỉ số cuối");
        var cell36 = row3.CreateCell(6);
        cell36.SetCellValue("Sản lượng");
        var list = _reportDataHelper.GetMonthyReportData(siteID, startDate, endDate);
        for (int i = 0; i < list.Count; i++)
        {
            var row = sheet.CreateRow(i + 4);
            var cell0 = row.CreateCell(0);
            cell0.SetCellValue(list[i].StartDate.ToString("MM-yyyy"));
            var cell1 = row.CreateCell(1);
            cell1.SetCellValue(list[i].Location);
            var cell2 = row.CreateCell(2);
            cell2.SetCellValue(list[i].StartDate.ToString("dd/MM/yyyy HH:mm tt"));
            if (list[i].StartIndex != null)
            {
                var cell3 = row.CreateCell(3);
                cell3.SetCellValue((double)list[i].StartIndex);
            }
            var cell4 = row.CreateCell(4);
            cell4.SetCellValue(list[i].EndDate.ToString("dd/MM/yyyy HH:mm tt"));
            if (list[i].EndIndex != null)
            {
                var cell5 = row.CreateCell(5);
                cell5.SetCellValue((double)list[i].EndIndex);
            }
            if (list[i].Output != null)
            {
                var cell6 = row.CreateCell(6);
                cell6.SetCellValue((double)list[i].Output);
            }
        }
        for (int i = 0; i < 7; i++)
        {
            sheet.AutoSizeColumn(i);
        }
        ((HSSFSheet)hssfworkbook.GetSheetAt(0)).AlternativeFormula = false;
        ((HSSFSheet)hssfworkbook.GetSheetAt(0)).AlternativeExpression = false;

        FileStream file = new FileStream(filePath, FileMode.Create);
        hssfworkbook.Write(file);
        file.Close();
    }

    private void SendMail(string subject, string body, string filePath, string adminEmail, string adminPassword)
    {
        MailMessage mail = new MailMessage();
        if (chkListAdmins.Items[0].Selected)
        {
            foreach (ListItem item in chkListAdmins.Items)
            {
                if (item.Text.Contains("@"))
                {
                    mail.To.Add(item.Text);
                }
            }
        }
        else
        {
            foreach (ListItem item in chkListAdmins.Items)
            {
                if (item.Text.Contains("@") && item.Selected)
                {
                    mail.To.Add(item.Text);
                }
            }
        }
        if (chkListStaffs.Items[0].Selected)
        {
            foreach (ListItem item in chkListStaffs.Items)
            {
                if (item.Text.Contains("@"))
                {
                    mail.To.Add(item.Text);
                }
            }
        }
        else
        {
            foreach (ListItem item in chkListStaffs.Items)
            {
                if (item.Text.Contains("@") && item.Selected)
                {
                    mail.To.Add(item.Text);
                }
            }
        }
        if (chkListConsumers.Items[0].Selected)
        {
            foreach (ListItem item in chkListConsumers.Items)
            {
                if (item.Text.Contains("@"))
                {
                    mail.To.Add(item.Text);
                }
            }
        }
        else
        {
            foreach (ListItem item in chkListConsumers.Items)
            {
                if (item.Text.Contains("@") && item.Selected)
                {
                    mail.To.Add(item.Text);
                }
            }
        }
        mail.From = new MailAddress(adminEmail);
        mail.Subject = subject;
        mail.Body = body;
        mail.IsBodyHtml = true;
        mail.Attachments.Add(new Attachment(filePath));
        using (SmtpClient smtp = new SmtpClient())
        {
            smtp.Host = "smtp.gmail.com";
            smtp.Credentials = new System.Net.NetworkCredential(adminEmail, adminPassword);
            smtp.EnableSsl = true;

            lblMsg.Visible = true;
            try
            {
                smtp.Send(mail);
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Đã gửi.";
            }
            catch (Exception ex)
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Lỗi. Thử lại.";
            }
        }
        mail.Dispose();
    }
}