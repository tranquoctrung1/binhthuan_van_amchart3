﻿#pragma checksum "D:\Pi\DailyChart\MainPage.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "9111A342BB6AE85CD422B4595C8A44D8"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Automation.Peers;
using System.Windows.Automation.Provider;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Interop;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Imaging;
using System.Windows.Resources;
using System.Windows.Shapes;
using System.Windows.Threading;
using Visiblox.Charts;


namespace Chart {
    
    
    public partial class MainPage : System.Windows.Controls.UserControl {
        
        internal System.Windows.Controls.Grid LayoutRoot;
        
        internal RadDatePicker dtmStart;
        
        internal RadDatePicker dtmEnd;
        
        internal System.Windows.Controls.CheckBox chkFlowRate;
        
        internal System.Windows.Controls.CheckBox chkPressure;
        
        internal RadButton btnView;
        
        internal RadButton btnExport;
        
        internal System.Windows.Controls.Label lblChartName;
        
        internal System.Windows.Controls.Image printer;
        
        internal Visiblox.Charts.Chart chart;
        
        internal Visiblox.Charts.BehaviourManager behaviourManager;
        
        internal Visiblox.Charts.TrackballBehaviour track;
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Windows.Application.LoadComponent(this, new System.Uri("/Chart;component/MainPage.xaml", System.UriKind.Relative));
            this.LayoutRoot = ((System.Windows.Controls.Grid)(this.FindName("LayoutRoot")));
            this.dtmStart = ((RadDatePicker)(this.FindName("dtmStart")));
            this.dtmEnd = ((RadDatePicker)(this.FindName("dtmEnd")));
            this.chkFlowRate = ((System.Windows.Controls.CheckBox)(this.FindName("chkFlowRate")));
            this.chkPressure = ((System.Windows.Controls.CheckBox)(this.FindName("chkPressure")));
            this.btnView = ((RadButton)(this.FindName("btnView")));
            this.btnExport = ((RadButton)(this.FindName("btnExport")));
            this.lblChartName = ((System.Windows.Controls.Label)(this.FindName("lblChartName")));
            this.printer = ((System.Windows.Controls.Image)(this.FindName("printer")));
            this.chart = ((Visiblox.Charts.Chart)(this.FindName("chart")));
            this.behaviourManager = ((Visiblox.Charts.BehaviourManager)(this.FindName("behaviourManager")));
            this.track = ((Visiblox.Charts.TrackballBehaviour)(this.FindName("track")));
        }
    }
}

