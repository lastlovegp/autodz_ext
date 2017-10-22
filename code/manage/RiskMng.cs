using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MySql.Data.MySqlClient;
using System.Data;

namespace MdTZ
{
   /// <summary>
   /// 止损，止盈管理
   /// </summary>
    class RiskMng
    {
        //止损参数
        public static Dictionary<int, double> zsParam = new Dictionary<int, double>();

        //止赢参数
        public static Dictionary<int, double> zyParam = new Dictionary<int, double>();

        //止赢时间
        public static Dictionary<int, double> sellZYTime = new Dictionary<int, double>();

        //止赢时间
        public static Dictionary<int, double> sellZSTime = new Dictionary<int, double>();

        //止赢时间
        public static Dictionary<int, double> buyTime = new Dictionary<int, double>();

        //止赢时间
        public static Dictionary<int, string> xhDesc = new Dictionary<int, string>();

        /// <summary>
        /// 设置止损,止赢参数
        /// 
        /// 
        /// </summary>
        public static void setRiskParam()
        {
            xhDesc.Clear();
            zyParam.Clear();
            zsParam.Clear();
            sellZYTime.Clear();
            sellZSTime.Clear();
            buyTime.Clear();                      

            xhDesc.Add(GPConstants.XH_BUY_JCMR,"金叉当日");
            xhDesc.Add(GPConstants.XH_BUY_ZDCD_10, "10日新低抄底");
            xhDesc.Add(GPConstants.XH_BUY_SSZJ, "上升追击");
            xhDesc.Add(GPConstants.XH_BUY_GKJJ, "高开追击");
            xhDesc.Add(GPConstants.XH_BUY_QSHT, "强势股回调");  
            xhDesc.Add(GPConstants.XH_BUY_ZDCD_5, "5日最低反弹");
            xhDesc.Add(GPConstants.XH_BUY_DEDD, "第二低点");
            xhDesc.Add(GPConstants.XH_BUY_ZDCD_20, "20新低抄底");
            xhDesc.Add(GPConstants.XH_BUY_ALL_SEL, "全局选股");
            xhDesc.Add(GPConstants.XH_BUY_TP_TOP_20, "突波20日最高");
            xhDesc.Add(GPConstants.XH_BUY_TP_JX, "穿线");
            xhDesc.Add(GPConstants.XH_BUY_HP_QD, "横盘启动");            
            xhDesc.Add(GPConstants.XH_BUY_TL, "套利");
            xhDesc.Add(GPConstants.XH_BUY_CD, "抄底1");
            xhDesc.Add(GPConstants.XH_BUY_CJL_ZD, "昨日成交量最低反弹");

            xhDesc.Add(GPConstants.XH_BUY_ZT_ECFT, "二次反弹");
            xhDesc.Add(GPConstants.XH_BUY_ZT_GSD, "涨停敢死队");
            xhDesc.Add(GPConstants.XH_BUY_TP_XP, "突破洗盘");
            xhDesc.Add(GPConstants.XH_BUY_FRIST_ZJ, "早盘追击");

            xhDesc.Add(GPConstants.XH_BUY_DK_LAHONG, "低开拉红");
            xhDesc.Add(GPConstants.XH_BUY_LD_2DAY_FD, "连跌两天后反弹");
            xhDesc.Add(GPConstants.XH_BUY_ZT_ZJ, "涨停板追击"); 

            zyParam.Add(GPConstants.XH_BUY_JCMR, getModeZYOpt(MdComm.TRAN_MODE, GPConstants.XH_BUY_JCMR));
            zyParam.Add(GPConstants.XH_BUY_ZDCD_10, 5);
            zyParam.Add(GPConstants.XH_BUY_SSZJ, 5);
            zyParam.Add(GPConstants.XH_BUY_QSHT, 5);
            zyParam.Add(GPConstants.XH_BUY_GKJJ, getModeZYOpt(MdComm.TRAN_MODE, GPConstants.XH_BUY_GKJJ));
            zyParam.Add(GPConstants.XH_BUY_ZDCD_5, getModeZYOpt(MdComm.TRAN_MODE, GPConstants.XH_BUY_ZDCD_5));
            zyParam.Add(GPConstants.XH_BUY_DEDD, 6);
            zyParam.Add(GPConstants.XH_BUY_ZDCD_20, 6);

            zsParam.Add(GPConstants.XH_BUY_JCMR, getModeZSOpt(MdComm.TRAN_MODE, GPConstants.XH_BUY_JCMR));
            zsParam.Add(GPConstants.XH_BUY_ZDCD_10, -3.5);
            zsParam.Add(GPConstants.XH_BUY_SSZJ, -3.5);
            zsParam.Add(GPConstants.XH_BUY_QSHT, -3.5);
            zsParam.Add(GPConstants.XH_BUY_GKJJ, getModeZSOpt(MdComm.TRAN_MODE, GPConstants.XH_BUY_GKJJ));
            zsParam.Add(GPConstants.XH_BUY_ZDCD_5, getModeZSOpt(MdComm.TRAN_MODE, GPConstants.XH_BUY_ZDCD_5));
            zsParam.Add(GPConstants.XH_BUY_DEDD, -3.5);
            zsParam.Add(GPConstants.XH_BUY_ZDCD_20, -3.5);   
                  
            //卖出止盈时间
            sellZYTime.Add(GPConstants.XH_BUY_JCMR, getModeSellZYTime(MdComm.TRAN_MODE, GPConstants.XH_BUY_JCMR));
            sellZYTime.Add(GPConstants.XH_BUY_ZDCD_10, 14.50);
            sellZYTime.Add(GPConstants.XH_BUY_SSZJ, 14.35);
            sellZYTime.Add(GPConstants.XH_BUY_QSHT, 9.45);
            sellZYTime.Add(GPConstants.XH_BUY_GKJJ, getModeSellZYTime(MdComm.TRAN_MODE, GPConstants.XH_BUY_GKJJ));
            sellZYTime.Add(GPConstants.XH_BUY_ZDCD_5, getModeSellZYTime(MdComm.TRAN_MODE, GPConstants.XH_BUY_ZDCD_5));
            sellZYTime.Add(GPConstants.XH_BUY_DEDD, 14.45);
            sellZYTime.Add(GPConstants.XH_BUY_ZDCD_20, 14.45);

            //卖出止损时间
            sellZSTime.Add(GPConstants.XH_BUY_JCMR, getModeSellZSTime(MdComm.TRAN_MODE, GPConstants.XH_BUY_JCMR));
            sellZSTime.Add(GPConstants.XH_BUY_ZDCD_10, 9.45);
            sellZSTime.Add(GPConstants.XH_BUY_SSZJ, 9.35);
            sellZSTime.Add(GPConstants.XH_BUY_QSHT, 9.40);
            sellZSTime.Add(GPConstants.XH_BUY_GKJJ, getModeSellZSTime(MdComm.TRAN_MODE, GPConstants.XH_BUY_GKJJ));
            sellZSTime.Add(GPConstants.XH_BUY_ZDCD_5, getModeSellZSTime(MdComm.TRAN_MODE, GPConstants.XH_BUY_ZDCD_5));
            sellZSTime.Add(GPConstants.XH_BUY_DEDD, 13.45);
            sellZSTime.Add(GPConstants.XH_BUY_ZDCD_20, 13.45); 

            //买入时间
            buyTime.Add(GPConstants.XH_BUY_JCMR, getModeBuyTime(MdComm.TRAN_MODE,GPConstants.XH_BUY_JCMR));
            buyTime.Add(GPConstants.XH_BUY_ZDCD_10, 10.40);
            buyTime.Add(GPConstants.XH_BUY_GKJJ, getModeBuyTime(MdComm.TRAN_MODE, GPConstants.XH_BUY_GKJJ));
            buyTime.Add(GPConstants.XH_BUY_QSHT, 14.40);       
            buyTime.Add(GPConstants.XH_BUY_SSZJ, 9.35);
            buyTime.Add(GPConstants.XH_BUY_ZDCD_5, getModeBuyTime(MdComm.TRAN_MODE, GPConstants.XH_BUY_ZDCD_5));
            buyTime.Add(GPConstants.XH_BUY_DEDD, 14.40);
            buyTime.Add(GPConstants.XH_BUY_ZDCD_20, 14.40); 
        }

        public static string getXhDesc(int xhtype)
        {
            string desc = "";
            if (xhDesc.ContainsKey(xhtype))
            {
                desc = xhDesc[xhtype];
            }  
           
            return desc;
        }

        public static double getSellZYTime(int xh_type)
        {
            double time = 9.31;
            if (sellZYTime.ContainsKey(xh_type))
            {
                time = sellZYTime[xh_type];
            }           

            return time;
        }

        public static double getSellZSTime(int xh_type)
        {
            double time = 9.35;
            if (sellZSTime.ContainsKey(xh_type))
            {
                time = sellZSTime[xh_type];
            }

            return time;
        }

        public static double getBuyTime(int xh_type)
        {
            double time = 9.32;
            if (buyTime.ContainsKey(xh_type))
            {
                time = buyTime[xh_type];
            }
            return time;
        }

        /// <summary>
        /// 止盈值
        /// </summary>
        /// <param name="xh_type"></param>
        /// <returns></returns>
        public static double getZyPrice(int xh_type)
        {
            double price = 3;
            if (zyParam.ContainsKey(xh_type))
            {
                price = zyParam[xh_type];
            }           

            return price;
        }

     

        /// <summary>
        /// 可买入最小手数
        /// </summary>
        /// <param name="price"></param>
        /// <returns></returns>
        public static int getBuyDw(double price,double pamt,int tc_num)
        {
            int dw = 0;
            dw = Convert.ToInt16(pamt * tc_num / (price * 100) >= 1 ? Math.Round(pamt * tc_num / (price * 100), 0) : 0);
            return dw;
        }

        public static double getModeBuyTime(int mode, int xh_type)
        {
            double btime = 9.45;
            if (mode == GPConstants.TRAN_MODE_NORMAR)
            {
                btime = 14.50;                               
            }
            else if (mode == GPConstants.TRAN_MODE_RISK)
            {
                btime = 9.50;               
            }
            else if (mode == GPConstants.TRAN_MODE_SUPER)
            {
                btime = 9.30;              
            }

            return btime;
        }

        public static double getModeSellZSTime(int mode, int xh_type)
        {
            double stime = 9.45;
            if (mode == GPConstants.TRAN_MODE_NORMAR)
            {
                stime = 9.45;
            }
            else if (mode == GPConstants.TRAN_MODE_RISK)
            {
                stime = 9.50;
            }
            else if (mode == GPConstants.TRAN_MODE_SUPER)
            {
                stime = 14.40;
            }

            return stime;
        }

        public static double getModeSellZYTime(int mode, int xh_type)
        {
            double stime = 10.50;
            if (mode == GPConstants.TRAN_MODE_NORMAR)
            {
                stime = 10.50;
            }
            else if (mode == GPConstants.TRAN_MODE_RISK)
            {
                stime = 9.50;
            }
            else if (mode == GPConstants.TRAN_MODE_SUPER)
            {
                stime = 14.50;
            }

            return stime;
        }

        public static double getModeZYOpt(int mode, int xh_type)
        {
            double opt = 3;
            switch (xh_type)
            {          
                case GPConstants.XH_BUY_JCMR:
                    opt = 3;
                    break;
                default:
                    opt = 3;
                    break;
            }

            return opt;
        }

        public static double getModeZSOpt(int mode, int xh_type)
        {
            double opt = -5;                
            return opt;
        }
    }
}
