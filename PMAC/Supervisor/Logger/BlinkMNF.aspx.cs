using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMAC.BLL;
public partial class Supervisor_Logger_BlinkMNF : System.Web.UI.Page
{
    ComplexDataHelper _com = new ComplexDataHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        double? numLoggerTotal;
        double? numLoggerZe;
        double? countMNF;
        double? countMNFhigh;
        double? LoggerErr;
        List<BlinkMNFViewModel> blink = _com.BlinkMNF();
        //tong logger
        numLoggerTotal = blink.Sum(d=>d.TotalLogger);
        numLogger.Text = numLoggerTotal.ToString();
        //logger bang zero
        numLoggerZe= blink.Sum(d => d.LoggerZero);
        numLoggerZero.Text = numLoggerZe.ToString();
        //logger cao ho baseline
        countMNF = blink.Sum(d => d.MNFLowBaseline);
        numMNFlow.Text = countMNF.ToString();
        //logger co MNF cao hon hom qua
        countMNFhigh = blink.Sum(d => d.MNFHighFirst);
        numMNFhigh.Text = countMNFhigh.ToString();
        //logger error
        LoggerErr = blink.Sum(d => d.LoggerError);
        numLoggerErr.Text = LoggerErr.ToString();
       

    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        numLogger.DataBind();
        numLoggerZero.DataBind();
        numMNFlow.DataBind();
        numMNFhigh.DataBind();
        numLoggerErr.DataBind();
    }
}