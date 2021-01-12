using System;
using System.ComponentModel;
using System.Configuration.Install;
using System.ServiceProcess;

namespace WindowsService
{
    [RunInstaller(true)]
    public class WindowsServiceInstaller : Installer
    {
        /// <summary>
        /// Public Constructor for WindowsServiceInstaller.
        /// - Put all of your Initialization code here.
        /// </summary>
        /// 
        ServiceInstaller serviceInstaller = new ServiceInstaller();

        public WindowsServiceInstaller()
        {
            ServiceProcessInstaller serviceProcessInstaller =
                               new ServiceProcessInstaller();
            

            //# Service Account Information
            serviceProcessInstaller.Account = ServiceAccount.LocalSystem;
            serviceProcessInstaller.Username = null;
            serviceProcessInstaller.Password = null;

            //# Service Information
            serviceInstaller.DisplayName = "Data Logger Alarming Service";
            serviceInstaller.StartType = ServiceStartMode.Automatic;
            serviceInstaller.DelayedAutoStart = true;   
            serviceInstaller.Description = "Bavitech Corp.";

            //# This must be identical to the WindowsService.ServiceBase name
            //# set in the constructor of WindowsService.cs
            serviceInstaller.ServiceName = "Data Logger Alarming Service";
            serviceInstaller.ServicesDependedOn = new string[] { "MSSQLSERVER" };
            this.Installers.Add(serviceProcessInstaller);
            this.Installers.Add(serviceInstaller);

            this.AfterInstall += WindowsServiceInstaller_AfterInstall;
            this.Committed += WindowsServiceInstaller_Committed;
        }

        private void InitializeComponent()
        {
            // 
            // WindowsServiceInstaller
            // 
            
        }

        void WindowsServiceInstaller_Committed(object sender, InstallEventArgs e)
        {
            using (ServiceController sc = new ServiceController(serviceInstaller.ServiceName))
            {
                sc.Start();
            }
        }

        /// <summary>
        /// Start automatically
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void WindowsServiceInstaller_AfterInstall(object sender, InstallEventArgs e)
        {
            
        }
    }
}