using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows.Forms;

namespace MdTZ
{
    class ZXApi2
    {

        public static void KBBuy(string sec_id, double price, double volume)
        {
            //WinAPI.SetWindowPos(tradeWin, WinAPI.HWND_TOPMOST, 0, 0, this.splitContainer1.Panel2.Width, this.splitContainer1.Panel2.Height, WinAPI.SWP_NOZORDER);
            //WinAPI.SetForegroundWindow(tradeWin);
            SendKeys.SendWait("{F1}");
            SendKeys.Send(sec_id);
            SendKeys.Send("{TAB}");
            SendKeys.Send(string.Format("{0}", price));
            SendKeys.Send("{Tab}");
            SendKeys.Send(string.Format("{0}", volume));
            SendKeys.SendWait("{Enter}");
            SendKeys.SendWait("^y");
        }


        public static void KBSell(string sec_id, double price, double volume)
        {

            //WinAPI.SetWindowPos(tradeWin, WinAPI.HWND_TOPMOST, 0, 0, this.splitContainer1.Panel2.Width, this.splitContainer1.Panel2.Height, WinAPI.SWP_NOZORDER);
            //WinAPI.SetForegroundWindow(tradeWin);
            SendKeys.SendWait("{F2}");
            SendKeys.Send(sec_id);
            SendKeys.Send("{TAB}");
            SendKeys.Send(string.Format("{0}", price));
            SendKeys.Send("{Tab}");
            SendKeys.Send(string.Format("{0}", volume));
            SendKeys.SendWait("{Enter}");
            SendKeys.SendWait("^y");
        }
    }
}
