using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows.Forms;

namespace MdTZ
{
    class TXDApi
    {

        public static int keep_time = 300; //延时时间

        /**
         * 卖出
         * */
        public static int sellOut(
            string code,
            int cnt 
        )
        {
            //买出
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_ABSOLUTE | WinAPI.MOUSEEVENTF_MOVE, 33000, 37000, 0, 0);
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_LEFTDOWN | WinAPI.MOUSEEVENTF_LEFTUP, 1, 1, 0, 0);
            Thread.Sleep(keep_time);                 

            //买入
            WinAPI.keybd_event((byte)Keys.F1, 0, 0, 0);
            Thread.Sleep(keep_time);
            WinAPI.keybd_event((byte)Keys.F2, 0, 0, 0);
            Thread.Sleep(keep_time);

            //输入股票代码
            THSAPI.inputCode(code);
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);

            if (cnt > 0)
            {
                THSAPI.inputNum(cnt.ToString());
                Thread.Sleep(keep_time);
            }

            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);           
          
            return 0;
        }


        /**
          * 市价买入
        * */
        public static int buyIn(
            string code,           
            int cnt 
        )
        {
            //买出
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_ABSOLUTE | WinAPI.MOUSEEVENTF_MOVE, 33000, 37000, 0, 0);
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_LEFTDOWN | WinAPI.MOUSEEVENTF_LEFTUP, 1, 1, 0, 0);
            Thread.Sleep(keep_time);         

            //买入
            WinAPI.keybd_event((byte)Keys.F2, 0, 0, 0);
            Thread.Sleep(keep_time);
            WinAPI.keybd_event((byte)Keys.F1, 0, 0, 0);
            Thread.Sleep(keep_time);

            //输入股票代码
            THSAPI.inputCode(code);
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);

            if (cnt > 0)
            {
                THSAPI.inputNum(cnt.ToString());
                Thread.Sleep(keep_time);
            }
           
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);           

            return 0;
        }

        /**
        * 委托撤销
        * */
        public static int agentCancel()
        {
            //买出
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_ABSOLUTE | WinAPI.MOUSEEVENTF_MOVE, 33000, 37000, 0, 0);
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_LEFTDOWN | WinAPI.MOUSEEVENTF_LEFTUP, 1, 1, 0, 0);
            Thread.Sleep(keep_time);         

            //买入
            WinAPI.keybd_event((byte)Keys.F3, 0, 0, 0);
            Thread.Sleep(keep_time);

            //tab           
            WinAPI.keybd_event((byte)Keys.Tab, 0, 0, 0);
            Thread.Sleep(keep_time);
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);

            //tab           
            WinAPI.keybd_event((byte)Keys.Tab, 0, 0, 0);
            Thread.Sleep(keep_time);
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);

            return 0;
        }


    }
}
