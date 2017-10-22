using System;
using System.Runtime.InteropServices;
using System.Drawing;

namespace MdTZ
{
    public class GPConstants
    {
        //s_sh000001,s_sz399001,s_sz399006
        public const string SH_CODE = "sh000001";
        public const string SZ_CODE = "sz399001";
        public const string CYB_CODE = "sz399006";
        public const string DP_ALL_CODES = "sh000001,sz399001,sz399006";

        public const int TRAN_MODE_NORMAR = 0; // 普通（稳妥)模式
        public const int TRAN_MODE_RISK = 1; // 风险模式
        public const int TRAN_MODE_SUPER = 2; // 激进模式
        public const int TRAN_MODE_UN_TRAN = 9; //不操作

        public const int STRATEGY_MODE_NORMAR_PRD = 2; //生产
        public const int STRATEGY_MODE_NORMAR_MN = 3; // 模拟
        public const int STRATEGY_MODE_NORMAR_HC= 4; // 回测  

        public const int EVENT_REFSH_YW= 0; // 刷新新闻
        public const int EVENT_BUY_TRANS = 1; //交易事件   
        public const int EVENT_SELL_TRANS = 2; //交易事件    	


        public const int XH_BUY_UN_JC= -100; //假突破

        public const int XH_BUY_JCMR = 1; //金叉买入
        public const int XH_BUY_ZDCD_10 = 2; //10新低抄底
        public const int XH_BUY_GKJJ = 3; //高开追击
        public const int XH_BUY_SSZJ = 4; //上升追击  
        public const int XH_BUY_QSHT = 25; //强势股回调
        public const int XH_BUY_ZDCD_5 = 29; //5日新低反弹
        public const int XH_BUY_ZDCD_20 = 7; //20新低抄底
        public const int XH_BUY_DEDD = 8; //第二地点     
        public const int XH_BUY_ALL_SEL = 9;//全局选股
        public const int XH_BUY_CD = 20;//昨天涨幅不大今天跟进
        public const int XH_BUY_CD_1 = 21;//成交量发大
        public const int XH_BUY_CD_2= 22; //强势股回调
        public const int XH_BUY_CD_3 = 23; //大盘低位高开
        public const int XH_BUY_TL = 24; //套利
        public const int XH_BUY_TL_EXT = 27; //套利 2
        public const int XH_BUY_HP_QD = 16; //横盘启动
        public const int XH_BUY_TP_TOP_20 = 17; //突波前20日最高
        public const int XH_BUY_TP_JX = 28; //突波均线
        public const int XH_BUY_CJL_ZD = 99; //成交量最低

        public const int XH_BUY_LZ_TWO_DAYS = 20; //连涨两天
        public const int XH_BUY_DK_LAHONG = 22; //低开拉红
        public const int XH_BUY_TP_XP = 35; //突破洗盘
        public const int XH_BUY_LD_2DAY_FD = 40; //两跌两天后反弹

        public const int XH_BUY_ZT_GSD = 30; //涨停敢死队
        public const int XH_BUY_ZT_ECFT = 31; //二次反弹
        public const int XH_BUY_ZT_ZJ = 32; //涨停板追击
        public const int XH_BUY_THREE_SZ = 33; //连张3天
        public const int XH_BUY_FRIST_ZJ = 34; //早盘追击

        public const int XH_SELL_DBXD = -5; //顶部下跌
        public const int XH_SELL_SCMC = -6; //顶部下跌

        public const int CZFX_ZC = 1; //左侧操作
        public const int CZFX_YC = 0; //右侧操作

        public const String STR_SEL_GPS = "Strategy_Sel_Gps"; //选股用
        public const String STR_TAOLI = "Strategy_Taoli"; //套利
        public const String STR_JCMR = "Strategy_JCMR"; //金叉买入
        public const String STR_SUPER_MAN = "Strategy_Superman"; //强弱指标买入

    }

}
