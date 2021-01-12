using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsServiceUltility
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args != null && args.Length == 1 && args[0].Length > 1
                && (args[0][0] == '-' || args[0][0] == '/'))
            {
                switch (args[0].Substring(1).ToLower())
                {
                    default:
                        break;
                    case "install":
                    case "i":
                        SelfInstaller.InstallMe();
                        break;
                    case "uninstall":
                    case "u":
                        SelfInstaller.UninstallMe();
                        break;
                    case "console":
                    case "c":
                        MyConsoleHost.Launch();
                        break;
                }
            }
            else
                MyWinServiceHost.Launch();
        }
    }
}
