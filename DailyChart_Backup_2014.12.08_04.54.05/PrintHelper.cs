using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.Windows.Printing;

namespace Chart
{
    public class PrintHelper
    {

        /// <summary>
        /// Prints a FrameworkElement in landscape, automatically rotating element if necessary
        /// </summary>
        /// <param name="DocumentName"></param>
        /// <param name="PrintableElement"></param>
        /// <param name="footerText"></param>
        public static void PrintElement(string DocumentName, FrameworkElement PrintableElement, string footerText)
        {
            PrintDocument p = new PrintDocument();
            Panel printableParent = PrintableElement.Parent as Panel;
            bool okToPrint = false;

            System.Windows.Controls.Panel tmp = new System.Windows.Controls.Canvas();

            p.BeginPrint += (object sender, BeginPrintEventArgs e) =>
            {
                ((Panel)PrintableElement.Parent).Children.Remove(PrintableElement);
                tmp.Children.Add(PrintableElement);
                tmp.Children.Add(new TextBlock
                {
                    VerticalAlignment = System.Windows.VerticalAlignment.Bottom,
                    Text = footerText,
                    FontSize = 8
                });
            };

            p.EndPrint += (s2, e2) =>
            {
                tmp.Children.Remove(PrintableElement);
                printableParent.Children.Add(PrintableElement);
                PrintableElement.HorizontalAlignment = HorizontalAlignment.Stretch;
                PrintableElement.VerticalAlignment = VerticalAlignment.Stretch;
                PrintableElement.Margin = new Thickness(0);
            };


            p.PrintPage += (object s, PrintPageEventArgs e) =>
            {

                // Rotate to landscape if necessary
                if (e.PrintableArea.Height > e.PrintableArea.Width)
                {
                    double scale = e.PrintableArea.Height / e.PrintableArea.Width;
                    scale = 1.0;

                    tmp.Width = e.PrintableArea.Height;
                    tmp.Height = e.PrintableArea.Width * scale;

                    CompositeTransform transform = new CompositeTransform
                    {
                        Rotation = 90,
                        TranslateX = tmp.Height * scale,
                        ScaleX = scale,
                        ScaleY = scale
                    };
                    tmp.RenderTransform = transform;
                    tmp.RenderTransformOrigin = new Point(0.5, 0.5);
                    PrintableElement.Margin = new Thickness(48 / scale, 96 / scale, 48 / scale, 0);
                    PrintableElement.Width = tmp.Width - 96 / scale;
                    PrintableElement.Height = tmp.Height - 96 / scale;

                }
                else
                {
                    tmp.Width = e.PrintableArea.Width;
                    tmp.Height = e.PrintableArea.Height;
                    PrintableElement.Margin = new Thickness(48, 96, 0, 0);
                    PrintableElement.Width = tmp.Width - 96;
                    PrintableElement.Height = tmp.Height - 96;
                }
                PrintableElement.HorizontalAlignment = System.Windows.HorizontalAlignment.Stretch;
                PrintableElement.VerticalAlignment = System.Windows.VerticalAlignment.Stretch;
                tmp.InvalidateArrange();
                tmp.InvalidateMeasure();
                okToPrint = true;

                //tmp.SizeChanged += (s2, e2) => { okToPrint = true; };
                //PrintableElement.SizeChanged += (s2, e2) => { okToPrint = true; };

                if (okToPrint)
                {
                    e.PageVisual = tmp;
                    e.HasMorePages = false;
                }
                else
                {
                    e.PageVisual = null;
                    e.HasMorePages = true;
                }

            };
            p.Print(DocumentName);
        }

    }
}