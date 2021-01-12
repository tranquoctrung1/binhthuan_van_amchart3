using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;


public partial class Controls_ucConsumer : System.Web.UI.UserControl
{
    ConsumerBL _consumerBL = new ConsumerBL();

    LanguageBL languageBL = new LanguageBL();

    private static string language = "vi";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cboConsumers.Focus();
        }


        if (!IsPostBack)
        {
            // Pi-solution
            language = (Session["myapplication.language"] == null) ? "vi" : Session["myapplication.language"].ToString();

            List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();

            var var1 = list.Where(x => x.ControlId.Contains("winAddConsumer_customerId")).FirstOrDefault();
            winAddConsumer_customerId.Text = (var1 == null) ? "" : var1.Contents;
            var var2 = list.Where(x => x.ControlId.Contains("winAddConsumer_customerName")).FirstOrDefault();
            winAddConsumer_customerName.Text = (var2 == null) ? "" : var2.Contents;
            
            var var28 = list.Where(x => x.ControlId.Contains("winAddConsumer_btnEdit")).FirstOrDefault();
            btnAdd.Text = (var28 == null) ? "" : var28.Contents;
            var var29 = list.Where(x => x.ControlId.Contains("winAddConsumer_delete")).FirstOrDefault();
            btnDelete.Text = (var29 == null) ? "" : var29.Contents;
        }

        msg.Text = string.Empty;
    }

    protected void cboConsumers_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        string consumerID = cboConsumers.Text;
        var consumer = _consumerBL.GetConsumer(consumerID);
        if (consumer != null)
        {
            SetValues(consumer);
        }
        txtDescription.Focus();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Site/Config.aspx")).ToList();
        var winAddConsumer_empty_customerId = list.Where(x => x.ControlId.Contains("winAddConsumer_empty_customerId")).FirstOrDefault();
        var winAddConsumer_add_successfully = list.Where(x => x.ControlId.Contains("winAddConsumer_add_successfully")).FirstOrDefault();
        var winAddConsumer_edit_successfully = list.Where(x => x.ControlId.Contains("winAddConsumer_edit_successfully")).FirstOrDefault();

        if (string.IsNullOrEmpty(cboConsumers.Text))
        {
            msg.Text = winAddConsumer_empty_customerId.Contents;
            return;
        }
        var consumer = GetConsumer();
        var dbConsumer = _consumerBL.GetConsumer(cboConsumers.Text);
        if (dbConsumer == null)
        {
            _consumerBL.InsertConsumer(consumer);
            msg.Text = winAddConsumer_add_successfully.Contents;
            ReBind();
        }
        else
        {
            _consumerBL.UpdateConsumer(consumer, dbConsumer);
            msg.Text = winAddConsumer_edit_successfully.Contents;
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        List<t_LanguageTranslate> list = languageBL.FindAll(x => x.Language == language && x.Noted.Contains("/Supervisor/Admin/CreateUser.aspx")).ToList();
        var empty_customer_id = list.Where(x => x.ControlId.Contains("empty_customer_id")).FirstOrDefault();
        var lb_customer_delete_confirm = list.Where(x => x.ControlId.Contains("lb_customer_delete_confirm")).FirstOrDefault();

        if (string.IsNullOrEmpty(cboConsumers.Text))
        {
            msg.Text = empty_customer_id.Contents;
            return;
        }

        var consumer = GetConsumer();
        if (consumer != null)
        {
            _consumerBL.DeleteConsumer(consumer);
            //msg.Text = "Đã xóa khách hàng.";
            msg.Text = lb_customer_delete_confirm.Contents;
            ReBind();
            SetEmpty();
        }
    }

    private void ReBind()
    {
        ConsumersDataSource.DataBind();
        cboConsumers.DataBind();
    }

    private t_Consumers GetConsumer()
    {
        t_Consumers consumer = new t_Consumers();
        consumer.ConsumerId = cboConsumers.Text;
        consumer.Description = txtDescription.Text;
        return consumer;
    }

    private void SetValues(t_Consumers consumer)
    {
        cboConsumers.Text = consumer.ConsumerId;
        txtDescription.Text = consumer.Description;
    }

    private void SetEmpty()
    {
        cboConsumers.Text = string.Empty;
        txtDescription.Text = string.Empty;
    }
}