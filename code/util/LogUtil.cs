using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace MdTZ
{
    class LogUtil
    {
        private static FileStream ostrm;
        private static  StreamWriter writer;
        private static TextWriter oldOut;

        public static void write(string msg)
        {
            //当前程序目录
            string logPath = Path.GetDirectoryName(Application.ExecutablePath);
            //新建文件
            System.IO.StreamWriter sw = System.IO.File.AppendText(logPath + "/日志.txt");
            sw.WriteLine(DateTime.Now.ToString("HH:mm:ss  ") + msg);

            sw.Close();
            sw.Dispose();

        }

        public static void writeLog(string text)
        {            
            if (oldOut == null)
            {
                oldOut = Console.Out;
            }
            try
            {
                if (ostrm == null)
                {
                    ostrm = new FileStream("./Syslog.txt", FileMode.OpenOrCreate, FileAccess.Write);
                    writer = new StreamWriter(ostrm);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Cannot open Syslog.txt for writing");
                Console.WriteLine(e.StackTrace);
            }

            Console.SetOut(writer);

            Console.WriteLine(text);

            Console.SetOut(oldOut);
        }

        public static void closeLogFile()
        {
            writer.Close();
            ostrm.Close();
        }
    }
}
