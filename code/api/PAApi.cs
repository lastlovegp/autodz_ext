using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows.Forms;

namespace MdTZ
{
    class PAApi
    {

        public static int keep_time = 300; //延时时间
        public static List<string> selList = new List<string>();
        public static List<string> buyList = new List<string>();

        /**
         * 卖出
         * */
        public static int sellOut(
            string code,           
            double price,
            int cnt
        )
        {
            //防止重复操作
            if (selList.Contains(code))
            {
                return -1;
            }

            //敲回车
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);

            //卖出
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_ABSOLUTE | WinAPI.MOUSEEVENTF_MOVE, 1745, 7800, 0, 0);
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_LEFTDOWN | WinAPI.MOUSEEVENTF_LEFTUP, 1, 1, 0, 0);
            Thread.Sleep(keep_time);           

            //输入股票代码         
            THSAPI.inputCode(code);
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);

            //价格默认
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);

            //股票数量
            //THSAPI.inputNum(cnt.ToString());
            //Thread.Sleep(keep_time);           
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);                      

            //下单
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);

            //交易确认
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);

            //移到别的地方
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_ABSOLUTE | WinAPI.MOUSEEVENTF_MOVE, 1745, 20000, 0, 0);
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_LEFTDOWN | WinAPI.MOUSEEVENTF_LEFTUP, 1, 1, 0, 0);

            selList.Add(code);

            return 0;
        }


        /**
      * 买入
      * */
        public static int buyIn(
            string code,          
            double price,          
            int cnt
        )
        {

            //防止重复操作
            if (buyList.Contains(code))
            {
                return -1;
            }

            //敲回车
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);

            //买入
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_ABSOLUTE | WinAPI.MOUSEEVENTF_MOVE, 1745, 5800, 0, 0);
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_LEFTDOWN | WinAPI.MOUSEEVENTF_LEFTUP, 1, 1, 0, 0);

            Thread.Sleep(keep_time);

            //输入股票代码
            THSAPI.inputCode(code);
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);

            //价格默认
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);

            //数量
            THSAPI.inputNum(cnt.ToString());
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);

            //下单
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);

            //交易确认
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);

            //移到别的地方
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_ABSOLUTE | WinAPI.MOUSEEVENTF_MOVE, 1745, 20000, 0, 0);
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_LEFTDOWN | WinAPI.MOUSEEVENTF_LEFTUP, 1, 1, 0, 0);

            buyList.Add(code);

            return 0;
        }


        /**
        * 委托撤销
        * */
        public static int agentCancel(string code, string cancelOpt)
        {
            //撤单
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_ABSOLUTE | WinAPI.MOUSEEVENTF_MOVE, 1745, 45800, 0, 0);
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_LEFTDOWN | WinAPI.MOUSEEVENTF_LEFTUP, 1, 1, 0, 0);

            Thread.Sleep(keep_time);

            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_ABSOLUTE | WinAPI.MOUSEEVENTF_MOVE, 13745, 38000, 0, 0);
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_LEFTDOWN | WinAPI.MOUSEEVENTF_LEFTUP, 1, 1, 0, 0);

            Thread.Sleep(keep_time);

            if (!String.IsNullOrEmpty(code))
            {
                //输入股票代码
                THSAPI.inputCode(code);
                WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
                Thread.Sleep(keep_time);
            }
            else
            {
                return 0;
            }

            //移动到撤销按钮
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_ABSOLUTE | WinAPI.MOUSEEVENTF_MOVE, 53000, 37800, 0, 0);
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_LEFTDOWN | WinAPI.MOUSEEVENTF_LEFTUP, 1, 1, 0, 0);

            Thread.Sleep(keep_time);
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);
            Thread.Sleep(keep_time);
            WinAPI.keybd_event((byte)Keys.Enter, 0, 0, 0);

            return 0;
        }

        /**
        * 刷新窗口
        * */
        public static int refreshWin()
        {
            //撤单
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_ABSOLUTE | WinAPI.MOUSEEVENTF_MOVE, 3000, 49000, 0, 0);
            WinAPI.mouse_event(WinAPI.MOUSEEVENTF_LEFTDOWN | WinAPI.MOUSEEVENTF_LEFTUP, 1, 1, 0, 0);
            return 0;
        }
    }
}
