using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Browser;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Printing;
using System.Windows.Shapes;
using System.IO;
using System.Windows.Media.Imaging;
using Telerik.Windows.Controls;
using Visiblox.Charts;

namespace Chart
{
    public partial class MainPage : UserControl
    {
        
        ChartServiceReference.ChartSoapClient proxy = new ChartServiceReference.ChartSoapClient();
        private string siteID;
        private string chartType;
        PrintDocument pd; 

        public MainPage()
        {
            InitializeComponent();
            double oADate = double.Parse(HtmlPage.Document.QueryString["dt"]);
            siteID = HtmlPage.Document.QueryString["si"];
            chartType = HtmlPage.Document.QueryString["ty"];
            DateTime date = DateTime.FromOADate(oADate);
            dtmStart.SelectedDate = date;
            switch (chartType)
            {
                case "daily":
                    dtmEnd.SelectedDate = date;
                    break;
                case "monthly":
                    dtmEnd.SelectedDate = date.AddMonths(1);
                    break;
                default:
                    break;
            }
            DateTime startDate = (DateTime)dtmStart.SelectedDate;
            DateTime endDate = (DateTime)dtmEnd.SelectedDate;
            proxy.Endpoint.Address = new System.ServiceModel.EndpointAddress("http://" + System.Windows.Browser.HtmlPage.Document.DocumentUri.Host + ":" + HtmlPage.Document.DocumentUri.Port + "/Chart.asmx");
            proxy.GetSiteCompleted += new EventHandler<ChartServiceReference.GetSiteCompletedEventArgs>(proxy_GetSiteCompleted);
            proxy.GetLoggerDataViewModelCompleted += new EventHandler<ChartServiceReference.GetLoggerDataViewModelCompletedEventArgs>(proxy_GetLoggerDataViewModelCompleted);
            proxy.GetLoggerDataViewModelAsync(siteID, startDate, endDate);
            proxy.GetSiteAsync(siteID);

            pd = new PrintDocument();
            pd.PrintPage += pd_PrintPage;
            
        }

        void pd_PrintPage(object sender, PrintPageEventArgs e)
        {
            double scale = 1;
            if (e.PrintableArea.Height < chart.ActualHeight)
            {
                scale = e.PrintableArea.Height / chart.ActualHeight;
            }

            if (e.PrintableArea.Width < chart.ActualWidth && e.PrintableArea.Width / chart.ActualWidth < scale)
            {
                scale = e.PrintableArea.Width / chart.ActualWidth;
            }

            if (scale < 1)
            {
                ScaleTransform scaleTransform = new ScaleTransform();
                scaleTransform.ScaleX = scale;
                scaleTransform.ScaleY = scale;
                chart.RenderTransform = scaleTransform;
            }
            e.PageVisual = chart;
        }

        void proxy_GetSiteCompleted(object sender, ChartServiceReference.GetSiteCompletedEventArgs e)
        {
            ChartServiceReference.mySite site = e.Result;
            lblChartName.Content = site.SiteID;
            //throw new NotImplementedException();
        }

        void proxy_GetLoggerDataViewModelCompleted(object sender, ChartServiceReference.GetLoggerDataViewModelCompletedEventArgs e)
        {
            var list = e.Result;
            chart.Series.Clear();
            double minY;
            double maxY;
            int i = 0;

            DataSeries<DateTime, double> seriesFlowRate = new DataSeries<DateTime, double>();
            DataSeries<DateTime, double> seriesPressure = new DataSeries<DateTime, double>();
            foreach (var item in list)
            {
                if (item.FlowRate != null)
                {
                    seriesFlowRate.Add(new DataPoint<DateTime, double>(item.TimeStamp, (double)item.FlowRate));
                    
                }
                if (item.Pressure!=null)
                {
                    seriesPressure.Add(new DataPoint<DateTime, double>(item.TimeStamp, (double)item.Pressure));
                }
            }

            double minY1;
            double maxY1;
            var flowRate = list.Select(l => l.FlowRate ?? 0);
            var pressure = list.Select(l => l.Pressure ?? 0);
            minY = flowRate.Min();
            maxY = flowRate.Max();
            minY1 = pressure.Min();
            maxY1 = pressure.Max();

            LineSeries lineSerie1 = new LineSeries();
            lineSerie1.DataSeries = seriesPressure;
            lineSerie1.DataSeries.Title = "Pressure";
            lineSerie1.LineStrokeThickness = 1;
            lineSerie1.LineStroke = new SolidColorBrush(Color.FromArgb(0xff, 0xff, 0x0, 0x0));
            lineSerie1.YAxis = chart.YAxis;
            

            LineSeries lineSerie2 = new LineSeries();
            lineSerie2.DataSeries = seriesFlowRate;
            lineSerie2.DataSeries.Title = "Net Flow";
            lineSerie2.LineStrokeThickness = 1;
            lineSerie2.LineStroke = new SolidColorBrush(Color.FromArgb(0xff, 0x0, 0x0, 0xff));
            lineSerie2.YAxis = chart.SecondaryYAxis;

            if ((bool)chkFlowRate.IsChecked && !(bool)chkPressure.IsChecked)
            {
                lineSerie1.Visibility = System.Windows.Visibility.Collapsed;
            }
            if ((bool)chkPressure.IsChecked && !(bool)chkFlowRate.IsChecked)
            {
                lineSerie2.Visibility = System.Windows.Visibility.Collapsed;
            }
            if (seriesFlowRate.Count!=0)
            {
                chart.Series.Add(lineSerie2);
            }
            if (seriesPressure.Count!=0)
            {
                chart.Series.Add(lineSerie1);
            }            
            //throw new NotImplementedException();
        }

        private void btnView_Click(object sender, RoutedEventArgs e)
        {
            if (dtmStart.SelectedDate == null)
            {
                dtmStart.Focus();
                MessageBox.Show("Chưa nhập ngày bắt đầu.");
                return;
            }
            if (dtmEnd.SelectedDate == null)
            {
                dtmEnd.Focus();
                MessageBox.Show("Chưa nhập ngày kết thúc.");
                return;
            }
            if ((!(bool)chkFlowRate.IsChecked) && (!(bool)chkPressure.IsChecked))
            {
                chkFlowRate.Focus();
                MessageBox.Show("Chưa chọn loại đồ thị.");
                return;
            }
            DateTime startDate = (DateTime)dtmStart.SelectedDate;
            DateTime endDate = (DateTime)dtmEnd.SelectedDate;
            proxy.GetLoggerDataViewModelAsync(siteID, startDate, endDate);
        }

        private void btnExport_Click(object sender, RoutedEventArgs e)
        {
            SaveFileDialog dlg = new SaveFileDialog();
            dlg.Filter = "PNG File|*.png";

            if (dlg.ShowDialog() == true)
            {
                Stream image_stream = ImageHelper.CreateImage(chart).GetStream();
                int length = (int)image_stream.Length;
                byte[] bytes = new byte[length];
                image_stream.Read(bytes, 0, length);
                image_stream.Close();

                Stream file_stream = dlg.OpenFile();
                file_stream.Write(bytes, 0, length);
                file_stream.Flush();
                file_stream.Close();
            }
        }

        private void printer_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            pd.Print("Chart");
            //PrintHelper.PrintElement("Chart", chart, lblChartName.Content + " " + ((DateTime)dtmStart.SelectedDate).ToString("dd/MM/yyyy HH:mm") + "To" + ((DateTime)dtmEnd.SelectedDate).ToString("dd/MM/yyyy HH:mm"));
        }
    }

    public class ImageHelper
    {
        public static EditableImage CreateImage(FrameworkElement element)
        {
            WriteableBitmap bmp = new WriteableBitmap(element, null);
            EditableImage img = new EditableImage(bmp.PixelWidth, bmp.PixelHeight);

            for (int i = 0; i < img.Height; i++)
            {
                for (int j = 0; j < img.Width; j++)
                {
                    int pixel = bmp.Pixels[(i * img.Width) + j];
                    img.SetPixel(j, i,
                            (byte)((pixel >> 16) & 0xFF),
                            (byte)((pixel >> 8) & 0xFF),
                            (byte)(pixel & 0xFF),
                            (byte)((pixel >> 24) & 0xFF)
                    );
                }
            }

            return img;
        }
    }
}
