using GMSDK;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace MdTZ
{
    class JJUtil
    {

        //分时统计
        public static List<GpTime> gpTimes = new List<GpTime>();

        //是否加载标志
        public static String isLoadCurPosFlag = "0";

        public static String ALL_GNS = "gn,bj,bt,bx,cxg,dc,dou,gqgg,gt,hb,hj,hl,hlw,jbx,jg,jj,jm,jsj,jy,mo,mt,ningh,nongy,ny,spyl,sy,sz50,tong,xny,ydyl,ysjs,yy";


        public static String CF_GNS = "";
    
        /// <summary>
        ///  dma 指标判断是否开仓
        /// </summary>
        /// <param name="bean"></param>
        /// <returns></returns>
        public static bool isNeedOpenOrder(StrateSta sta,TranBean bean, int tran_mode)
        {
            bean.b_buy_time = 0; 

            #region 判断大盘分时低点
            if (bean.isDp)
            { 
                //当天最低点
                if (sta.dp.btime >= 9.32
                     && sta.dp.tick.last_price < sta.dp.tick.open
                     && sta.dp.pre_tick_price > 0 
                     && sta.dp.tick.last_price > sta.dp.pre_tick_price
                     && sta.dp.tick.last_price > sta.dp.tick.low + 0.5
                     //&& sta.dp.tick.last_price < Math.Round(sta.dp.tick.low + MdComm.ZZ_PLZ, 2)
                    )
                {
                    sta.is_dp_lowLevel = true;
                }
                else
                {
                    sta.is_dp_lowLevel = false;
                }


                sta.dp_qs = 0;

                //大盘连跌2天,顶部有点危险了
                if (bean.gpTotal.rsi6 > 50 
                    && HGStaUtil.getBarZF(bean.qtDailyBar) < 0 
                    && HGStaUtil.getBarZF(bean.lastDailyBar) < 0
                    )
                {
                    sta.dp_qs = -1;
                }

                //前3天有上影线也不玩了
                if (bean.gpTotal.rsi6 > 50
                   && bean.gpTotal.syx_bar_num > 0 && bean.gpTotal.syx_bar_num < 3
                   )
                {
                    sta.dp_qs = -1;
                }

                //大盘连张连天+美股下跌
                if (MdComm.str_mode == 2 && MdComm.US_GP_ZF < -1)
                {
                    sta.dp_qs = -1;
                }

                //大盘形式不好
                if (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_UN_TRAN)
                {
                    sta.dp_qs = -1;
                }                

                //低位高开
                if (bean.gpTotal.rsi6 < 50 && bean.gpTotal.rsi12 < 60 && bean.gpTotal.rsi24 < 50
                   && bean.tick.open > Math.Round(bean.tick.pre_close*(1+0.005),2)
                   )
                {
                    sta.dp_qs = 1;
                    MdComm.TRAN_MODE = GPConstants.TRAN_MODE_SUPER;
                }

                //大盘底部连张连天
                if (bean.gpTotal.rsi6 < 40 && bean.qtDailyBar != null
                   && HGStaUtil.getBarZF(bean.lastDailyBar) > 0
                   && HGStaUtil.getBarZF(bean.qtDailyBar) > 0)
                {
                    sta.dp_qs = 1;
                    MdComm.TRAN_MODE = GPConstants.TRAN_MODE_SUPER;
                }

                //大盘低位
                if (bean.gpTotal.rsi6 < 32 && bean.zf > 0)
                {
                    sta.dp_qs = 1;
                    MdComm.TRAN_MODE = GPConstants.TRAN_MODE_SUPER;
                }

                //大盘5日最低位
                if (bean.gpTotal.rsi6 < 40 && bean.tick.last_price < bean.gpTotal.low_5_day)
                {
                    sta.dp_qs = 1;
                    MdComm.TRAN_MODE = GPConstants.TRAN_MODE_SUPER;
                }

                if (sta.dp_qs == -1)
                {         
                    if (bean.seq % 120 == 0)
                    {
                        JJUtil.dblog(0, "大盘形式不好不玩了。。。", DateTime.Now);
                    }                    
                }              

                return false;
            }
           
            #endregion
       
            #region 我的策略

            #region 开盘均线以上
            if (bean.btime > 9.50
                   && bean.fszb >= 85
                   && sta.dp_qs != -1
                   && bean.tick.last_price < 50
                   && bean.tick.last_price > bean.timejj
                   && HGStaUtil.getBarZF(bean.lastDailyBar) < 8
                   && Math.Round((bean.tick.high-bean.tick.last_price)/bean.tick.high,2) < 0.01 
                   && bean.tick.cum_amount > Math.Round(bean.lastDailyBar.amount*1.5,2)
            )
            {
                bean.xh_type = GPConstants.XH_BUY_FRIST_ZJ;
                return true;
            }
            #endregion
          
            #region 大盘低位高开
            if (bean.btime > 9.40
                    && bean.tick.open > Math.Round(bean.lastDailyBar.close * (1 + 0.005), 2)
                    && bean.tick.open < Math.Round(bean.lastDailyBar.close * (1 + 0.04), 2)
                    && sta.dp_qs == 1
                    && bean.tick.last_price > bean.timejj                  
                    && HGStaUtil.getBarZF(bean.lastDailyBar) > -3
                    && HGStaUtil.getBarZF(bean.lastDailyBar) < 6
                    && sta.is_dp_lowLevel
                    && bean.zf > 0
                    && bean.zf < 2
                    && bean.fszb > 60
                    && bean.btime > 9.45         
                    && bean.gpTotal.pj_60_zhengfu > 1.5
                    && bean.tick.last_price < 40
                    && bean.gpTotal.rsi6 < 60
                    && bean.gpTotal.rsi6 < 60
                    && bean.gpTotal.rsi6 < 60

             )
            {
                bean.xh_type = GPConstants.XH_BUY_CD_3;
                return true;
            }
            #endregion

            #region 昨日追涨停股
            if (bean.btime > 10.05
                   && bean.tick.open > Math.Round(bean.lastDailyBar.close * (1 + 0.01), 2)
                   && bean.tick.open < Math.Round(bean.lastDailyBar.close * (1 + 0.035), 2)
                   && bean.tick.last_price > bean.timejj
                   && bean.fszb > 50
                   && bean.zf > 0
                   && bean.zf < 4
                   && HGStaUtil.getBarZF(bean.lastDailyBar) > 8
                   && bean.tick.last_price > bean.tick.open
                   && bean.tick.last_price < 35
            )
            {
                bean.xh_type = GPConstants.XH_BUY_ZT_ZJ;
                return true;
            }
            #endregion

            #region 成交量放大5倍以上的
            if (bean.tick.cum_amount > bean.lastDailyBar.amount * 4 
                && bean.zf < 6
                && bean.gpTotal.sum5Zf < 1
                && bean.gpTotal.sum20Zf < 1
                )
            {
                bean.xh_type = GPConstants.XH_BUY_CD_1;
                return true;
            }
            #endregion

            #region 上升追击
            if (bean.btime > (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_SUPER ? 9.50 : 14.50)
                    && bean.fszb > 60
                    && bean.gpTotal.ema10 > bean.gpTotal.preGpTotal.ema10
                    && bean.gpTotal.preGpTotal.ema10 > bean.gpTotal.qtGpTotal.ema10
                    && sta.dp_qs != -1
                    && bean.tick.last_price < 40
                    && bean.tick.last_price < bean.tick.high
                    && bean.tick.last_price > bean.timejj
                    && bean.tick.last_price > bean.pre_tick_price
                    && HGStaUtil.getBarZF(bean.lastDailyBar) > -2
                    && HGStaUtil.getBarZF(bean.lastDailyBar) < 3
                    && bean.tick.cum_amount > bean.lastDailyBar.amount
                    && (bean.gpTotal.syx_bar_num == 0 || bean.gpTotal.syx_bar_num > 6)
                    && bean.gpTotal.sum2Zf > -2
                    && bean.gpTotal.sum2Zf < 4
                    && bean.zf > 1
                    && bean.zf < 3.5
                    && bean.gpTotal.rsi6 < 70
                    && bean.gpTotal.rsi6 > 50
                    && bean.gpTotal.rsi12 < 60
                    && bean.gpTotal.rsi24 < 50
             )
            {
                bean.xh_type = GPConstants.XH_BUY_SSZJ;
                return true;
            }
            #endregion

            #region 金叉当天
            if (
                HGStaUtil.getBarZF(bean.lastDailyBar) > -4
                && HGStaUtil.getBarZF(bean.lastDailyBar) < 4
                && bean.tick.open < Math.Round(bean.lastDailyBar.close * (1 + 0.015), 2)
                && (bean.gpTotal.syx_bar_num == 0 || bean.gpTotal.syx_bar_num > 6)
                && sta.dp_qs != -1
                && JJUtil.crossOverToday(bean)
                && bean.gpTotal.rsi6 < 70
                && bean.gpTotal.rsi12 < 70
                && bean.gpTotal.rsi24 < 70
                && bean.fszb > (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_SUPER ? 40 : 70)
                && bean.gpTotal.sum2Zf > -3
                && bean.gpTotal.sum2Zf < 3
                && bean.gpInfo.ltsz < 120
                && bean.tick.last_price < bean.gpTotal.top_5_day
                && bean.tick.last_price < 35
                && bean.tick.last_price > bean.timejj
                && bean.tick.last_price < bean.tick.high
                && bean.tick.cum_amount > bean.lastDailyBar.amount
                && bean.zf > 2
                && bean.zf < 3.5)
            {
                bean.xh_type = GPConstants.XH_BUY_JCMR;
                return true;
            }
            #endregion

            #region 底部涨->跌->涨
            if (
                 bean.gpInfo.ltsz < 120
                 && HGStaUtil.getBarZF(bean.lastDailyBar) > -0.9
                 && HGStaUtil.getBarZF(bean.lastDailyBar) < 0.5
                 && bean.qtDailyBar != null
                 && HGStaUtil.getBarZF(bean.qtDailyBar) < -0.9
                 && HGStaUtil.getBarZF(bean.qtDailyBar) > 0.5
                 && bean.tick.last_price < bean.tick.high
                 && bean.tick.last_price > bean.timejj
                 && bean.tick.last_price > bean.tick.low
                 && (bean.gpTotal.syx_bar_num == 0 || bean.gpTotal.syx_bar_num > 8)
                 && bean.gpTotal.rsi6 < 37
                 && bean.gpTotal.rsi12 < 50
                 && bean.zf > 1
                 && bean.btime > (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_SUPER ? 9.51 : 14.30))
            {
                bean.xh_type = GPConstants.XH_BUY_CD;
                return true;
            }
            #endregion

            #region 10日价格最低
            if (bean.fszb > 85
                   && bean.btime > (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_SUPER ? 9.41 : 14.45)
                   && bean.gpTotal.low_10_day > 0
                   && bean.tick.last_price < 40
                   && bean.gpTotal.rsi24 < 40
                   && bean.lastDailyBar.close < bean.gpTotal.low_10_day
                   && bean.tick.last_price < bean.tick.high
                   && bean.tick.last_price > bean.timejj
                   && bean.tick.last_price > bean.tick.low
                   && bean.tick.last_price < Math.Round(bean.gpTotal.low_30_day * (1 + 0.025), 2)
                   && bean.tick.low < Math.Round(bean.lastDailyBar.close * (1 + 0.01), 2)
                   && bean.tick.cum_amount > bean.lastDailyBar.amount
                   && (bean.gpTotal.syx_bar_num == 0 || bean.gpTotal.syx_bar_num > 6)
                   && bean.zf > 0.3
                   && bean.gpInfo.ltsz < 100
                  )
            {
                bean.xh_type = GPConstants.XH_BUY_ZDCD_10;
                return true;
            }
            #endregion

            #region 30日价格最低

            // 30日价格最低
            if (bean.gpTotal.low_30_day > 0
                   && bean.tick.last_price < bean.gpTotal.low_30_day
                   && bean.tick.last_price < 35
                   && bean.gpInfo.ltsz < 100
                   && bean.btime > (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_SUPER ? 9.41 : 14.51)
                   && bean.cqFlag != 1
                   && bean.lastDailyBar.low > bean.gpTotal.low_30_day
                   && bean.lastDailyBar.close > bean.gpTotal.low_30_day
                   && HGStaUtil.getBarZF(bean.lastDailyBar) > -2
                   && (bean.gpTotal.syx_bar_num == 0 || bean.gpTotal.syx_bar_num > 6)
                   && bean.gpTotal.sum30Zf > 0
                   && bean.zf > -1
            )
            {
                bean.xh_type = GPConstants.XH_BUY_ZDCD_20;
                return true;
            }

            #endregion

            #region 高开追击
            if (
                bean.gpInfo.ltsz < 120
                && bean.tick.last_price < 40
                && bean.tick.open > Math.Round(bean.lastDailyBar.close * (1 + 0.01), 2)
                && bean.tick.open < bean.tick.high
                && bean.tick.last_price < bean.tick.open
                && bean.tick.last_price > bean.tick.low
                && bean.tick.last_price > bean.timejj
                && bean.gpTotal.rsi6 < 60
                && bean.gpTotal.rsi12 < 60
                && bean.gpTotal.rsi24 < 60
                && bean.btime > (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_SUPER ? 9.45 : 10.01)
                && bean.fszb > 85
             )
            {
                bean.xh_type = GPConstants.XH_BUY_GKJJ;
                return true;
            }
            #endregion

            #region 昨天突破的股票今天跟进
            //昨日涨停今天上升追击
            if (
                HGStaUtil.getBarZF(bean.lastDailyBar) > 4
                && bean.tick.open < Math.Round(bean.lastDailyBar.close * (1 + 0.015), 2)
                && bean.gpInfo.ltsz < 90
                && bean.tick.last_price < 35
                && bean.zf > -1
                && bean.zf < 1.5
                && bean.tick.last_price > bean.tick.low
                && bean.tick.last_price > bean.timejj
                && bean.btime > (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_SUPER ? 9.57 : 14.49)
                && bean.tick.last_price < bean.tick.high
                && bean.tick.last_price > bean.pre_tick_price
                && bean.tick.cum_amount < Math.Round(bean.lastDailyBar.amount * (5 / 6), 2)
                )
            {
                bean.xh_type = GPConstants.XH_BUY_CD_2;
                return true;
            }

            #endregion

            #region 涨停板敢死队
            if (bean.zf > (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_SUPER ? 4.5 : 5.5)
                  && bean.btime > (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_SUPER ? 9.59 : 14.41)
                  && bean.tick.last_price < 35
                  && sta.dp_qs != -1
                  && bean.tick.last_price < bean.tick.high
                  && bean.tick.last_price > bean.timejj
                  && bean.tick.last_price > bean.pre_tick_price
                  && bean.tick.cum_amount > bean.lastDailyBar.amount
                  && (bean.gpTotal.syx_bar_num == 0 || bean.gpTotal.syx_bar_num > 6)
                  && bean.gpTotal.rsi6 < 70
                  && bean.gpTotal.rsi12 < 70
                  && bean.gpTotal.rsi24 < 70
                  )
            {
                bean.xh_type = GPConstants.XH_BUY_ZT_GSD;
                return true;
            }
            #endregion

            #region 跌倒突破时的开盘价
            if (
                bean.tick.last_price < 40
                && bean.gpTotal.tp_bar_num > 0
                && bean.gpTotal.tp_bar_num < 10
                && bean.gpTotal.last_tp_open > 0
                && sta.dp_qs != -1
                && bean.tick.last_price < bean.gpTotal.jj60
                && bean.tick.last_price < bean.gpTotal.jj30
                && bean.tick.last_price > bean.tick.low
                && HGStaUtil.getBarZF(bean.lastDailyBar) > -4
                && HGStaUtil.getBarZF(bean.lastDailyBar) < 2.5
                && bean.tick.last_price < Math.Round(bean.gpTotal.last_tp_open * (1 - 0.01), 2)
                && bean.tick.last_price > Math.Round(bean.gpTotal.last_tp_open * (1 - 0.02), 2)
                && bean.zf > -2
                && bean.gpTotal.rsi6 > 45
                && bean.btime > 14.40
                && bean.gpInfo.ltsz < 120
                && bean.gpTotal.sum10Zf < 6
             )
            {
                bean.xh_type = GPConstants.XH_BUY_DEDD;
                return true;
            }
            #endregion

            #region 二次反弹
            if (
                bean.tick.last_price < 40
                && bean.gpTotal.tp_bar_num > 0
                && bean.gpTotal.tp_bar_num < 10
                && bean.gpTotal.last_tp_open > 0
                && bean.gpTotal.zt_bar_num < bean.gpTotal.tp_bar_num
                && sta.dp_qs != -1
                && bean.lastDailyBar.close < Math.Round(bean.gpTotal.last_tp_open * (1 + 0.025), 2)
                && bean.tick.last_price < bean.tick.high
                && bean.tick.last_price > bean.timejj
                && bean.tick.last_price > bean.tick.low
                && bean.tick.last_price > bean.pre_tick_price
                && HGStaUtil.getBarZF(bean.lastDailyBar) > -4
                && HGStaUtil.getBarZF(bean.lastDailyBar) < 3
                && bean.zf > 1.5 && bean.zf < 3
                && bean.gpTotal.rsi6 > 45
                && bean.btime > (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_SUPER ? 9.59 : 14.42)
                && (bean.gpTotal.syx_bar_num == 0 || bean.gpTotal.syx_bar_num > 10)
                && bean.gpTotal.sum3Zf < 1
                && bean.gpInfo.ltsz < 120
             )
            {
                bean.xh_type = GPConstants.XH_BUY_ZT_ECFT;
                return true;
            }
            #endregion

            #region 连张两天
            if (bean.gpTotal.rsi6 > 40 && bean.gpTotal.rsi6 < 70
                   && bean.qtDailyBar != null
                   && bean.pre_qtDailyBar != null
                   && HGStaUtil.getBarZF(bean.lastDailyBar) > 0.3 && HGStaUtil.getBarZF(bean.lastDailyBar) < 6
                   && HGStaUtil.getBarZF(bean.qtDailyBar) > -0.3 && HGStaUtil.getBarZF(bean.qtDailyBar) < 6
                   && HGStaUtil.getBarZF(bean.lastDailyBar) > HGStaUtil.getBarZF(bean.qtDailyBar)
                   && HGStaUtil.getBarZF(bean.pre_qtDailyBar) < 0
                   && sta.dp_qs != -1
                   && bean.gpTotal.sum5Zf < 25
                   && bean.zf > 1.5 && bean.zf < 3
                   && bean.tick.last_price < 40
                   && bean.gpTotal.sum2Zf <= 6
                   && (bean.gpTotal.syx_bar_num == 0 || bean.gpTotal.syx_bar_num > 10)
                   && bean.tick.last_price > bean.timejj
                   && bean.btime > (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_SUPER ? 9.58 : 10.31)
                )
            {
                bean.xh_type = GPConstants.XH_BUY_LZ_TWO_DAYS;
                return true;
            }
            #endregion

            #region 连张三天
            if (bean.gpTotal.rsi6 > 40 && bean.gpTotal.rsi6 < 60
                   && bean.pre_qtDailyBar != null && bean.qtDailyBar != null
                   && HGStaUtil.getBarZF(bean.lastDailyBar) > 0.3 && HGStaUtil.getBarZF(bean.lastDailyBar) < 2.5
                   && HGStaUtil.getBarZF(bean.qtDailyBar) > 0.3 && HGStaUtil.getBarZF(bean.qtDailyBar) < 2.5
                   && HGStaUtil.getBarZF(bean.pre_qtDailyBar) > 0.3 && HGStaUtil.getBarZF(bean.pre_qtDailyBar) < 2.5
                   && bean.zf > 0
                   && (bean.gpTotal.syx_bar_num == 0 || bean.gpTotal.syx_bar_num > 10)
                   && bean.tick.last_price < 35
                   && bean.tick.last_price > bean.timejj
                   && bean.btime > 9.58
                )
            {
                bean.xh_type = GPConstants.XH_BUY_THREE_SZ;
                return true;
            }
            #endregion

            #region 连跌两天后反弹
            if (bean.gpTotal.rsi6 < 45 && bean.gpTotal.rsi24 > 60
                   && HGStaUtil.getBarZF(bean.lastDailyBar) < -1 && HGStaUtil.getBarZF(bean.lastDailyBar) > -3
                   && HGStaUtil.getBarZF(bean.qtDailyBar) < -0.5 && HGStaUtil.getBarZF(bean.qtDailyBar) > -3
                   && bean.btime > (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_SUPER ? 9.58 : 14.43)
                   && bean.zf > 1
                   && sta.dp_qs != -1
                   && bean.tick.last_price < 40
                   && bean.zf < 3.1
                   && (bean.gpTotal.syx_bar_num == 0 || bean.gpTotal.syx_bar_num > 7)
                   && bean.tick.last_price > bean.timejj
                )
            {
                bean.xh_type = GPConstants.XH_BUY_LD_2DAY_FD;
                return true;
            }
            #endregion

            #region 低开很多拉红
            if (bean.tick.open < Math.Round(bean.tick.pre_close * (1 - 0.04), 2)
                && bean.tick.last_price > bean.timejj
                && sta.is_dp_lowLevel
                && bean.zf > 0
                && HGStaUtil.getBarZF(bean.lastDailyBar) < 1
                && HGStaUtil.getBarZF(bean.lastDailyBar) > -2
                && bean.gpTotal.rsi6 < 50
                && bean.gpTotal.rsi12 < 50
                )
            {
                bean.xh_type = GPConstants.XH_BUY_DK_LAHONG;
                return true;
            }
            #endregion

            #region 红柱穿4线
            if (
                  (
                      ((bean.tick.open < bean.gpTotal.jj20 && bean.tick.last_price > bean.gpTotal.jj20) &&
                      (bean.tick.open < bean.gpTotal.jj10 && bean.tick.last_price > bean.gpTotal.jj10) &&
                      (bean.tick.open < bean.gpTotal.jj30 && bean.tick.last_price > bean.gpTotal.jj30))
                       ||
                      ((bean.tick.open < bean.gpTotal.jj5 && bean.tick.last_price > bean.gpTotal.jj5) &&
                      (bean.tick.open < bean.gpTotal.jj10 && bean.tick.last_price > bean.gpTotal.jj10) &&
                      (bean.tick.open < bean.gpTotal.jj60 && bean.tick.last_price > bean.gpTotal.jj60))
                  )
                  && Math.Round((bean.gpTotal.jj5 - bean.gpTotal.jj20) / bean.gpTotal.jj20, 2) < 0.03
                  && bean.gpTotal.rsi6 < 70
                  && bean.gpTotal.rsi12 < 70
                  && bean.gpTotal.rsi24 < 70
                  && bean.gpInfo.ltsz < 120
                  && bean.zf > 2
                  && bean.tick.last_price < 40
                  && bean.tick.last_price > bean.lastDailyBar.high
                  && bean.tick.cum_amount > bean.lastDailyBar.amount * 1.2
                  && bean.tick.last_price > bean.timejj
                  && bean.tick.last_price < Math.Round(bean.timejj * 0.005, 2)
                )
            {
                bean.xh_type = GPConstants.XH_BUY_TP_JX;
                return true;
            }
            #endregion

            #region 昨日突破今天下跌到突破起点
            if (
                    HGStaUtil.getBarZF(bean.qtDailyBar) < 1
                    && HGStaUtil.getBarZF(bean.lastDailyBar) > 5
                    && bean.tick.last_price < bean.lastDailyBar.open
                    && bean.zf < 0
                    && (bean.gpTotal.syx_bar_num == 0 || bean.gpTotal.syx_bar_num > 10)
                    && bean.btime > 14.20
                    && bean.gpTotal.rsi6 < 70
                    && bean.gpTotal.pj_60_zhengfu < 2
                    && sta.is_dp_lowLevel
                   )
            {
                bean.xh_type = GPConstants.XH_BUY_TP_XP;
                return true;
            }
            #endregion

            #region 突破前30日最高
            if (bean.gpTotal.rsi6 < 70
                    && bean.gpTotal.rsi12 < 70
                    && bean.gpTotal.rsi24 < 70
                    && bean.zf > 1
                    && bean.btime > (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_SUPER ? 9.57 : 14.51)
                    && sta.dp_qs != -1
                    && bean.gpTotal.sum3Zf < 4.5
                    && bean.tick.open < bean.tick.high
                    && bean.tick.last_price < 40
                    && bean.gpInfo.ltsz < 120
                    && bean.tick.open < Math.Round(bean.lastDailyBar.close * (1 + 0.015), 2)
                    && bean.tick.last_price < bean.tick.high
                    && bean.tick.last_price > bean.pre_tick_price
                    && bean.tick.last_price > bean.timejj
                    && bean.lastDailyBar.close < bean.gpTotal.top_30_day
                    && (bean.gpTotal.syx_bar_num == 0 || bean.gpTotal.syx_bar_num > 6)
                    && (bean.gpTotal.tp_bar_num == 0 || bean.gpTotal.tp_bar_num > 12)
                    && !(HGStaUtil.getBarZF(bean.lastDailyBar) > 1 && HGStaUtil.getBarZF(bean.qtDailyBar) > 1)
                    && bean.tick.cum_amount > bean.lastDailyBar.amount * 1.5
                    && (bean.tick.last_price > bean.gpTotal.top_30_day || bean.tick.last_price > bean.gpTotal.top_60_day))
            {
                bean.xh_type = GPConstants.XH_BUY_ALL_SEL;
                return true;
            }
            #endregion

            #region 突破前20日最高
            if (bean.gpTotal.rsi6 < 70
                && bean.gpTotal.rsi12 < 70
                && bean.gpTotal.rsi24 < 70
                && bean.zf > 5
                && sta.dp_qs != -1
                && bean.gpTotal.sum2Zf < 3
                && bean.tick.last_price > bean.timejj
                && bean.btime > (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_SUPER ? 9.57 : 14.51)
                && bean.fszb > 60
                && HGStaUtil.getBarZF(bean.lastDailyBar) < 3
                && ((bean.tick.open < bean.gpTotal.jj20 && bean.tick.last_price > bean.gpTotal.jj20) ||
                   (bean.tick.open < bean.gpTotal.jj10 && bean.tick.last_price > bean.gpTotal.jj10))
                && bean.tick.cum_amount > bean.lastDailyBar.amount * 1.2
                && bean.lastDailyBar.close < bean.gpTotal.top_20_day
                && (bean.gpTotal.syx_bar_num == 0 || bean.gpTotal.syx_bar_num > 6)
                && !(HGStaUtil.getBarZF(bean.lastDailyBar) > 1 && HGStaUtil.getBarZF(bean.qtDailyBar) > 1)
                && bean.tick.last_price > bean.gpTotal.top_20_day)
            {
                bean.xh_type = GPConstants.XH_BUY_TP_TOP_20;
                return true;
            }
            #endregion
                       
            #endregion

            #region 尾盘处理
            end_time_check(sta,bean,MdComm.TRAN_MODE);
            #endregion

            return false;
        }

        /// <summary>
        /// 分时数据统计
        /// </summary>
        /// <param name="bean"></param>
        /// <param name="tran_mode"></param>
        /// <returns></returns>
        public static void updateTimePriceTotal(TranBean bean, int tran_mode)
        {
            //不操作
            if (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_UN_TRAN)
            {
                return;
            }
          
            //分时均价和当前价统计
            if (bean.more_timejj_cnt + bean.less_timejj_cnt > 20)
            {
                //上升追击
                if (bean.fszb >= 70 && !String.IsNullOrEmpty(bean.code))
                {
                   GpTime gt = new GpTime();
                   gt.code = bean.code;
                   gt.dqj = bean.tick.last_price;
                   gt.fszb = bean.fszb;

                   bool hs = false;
                   foreach (GpTime gt1 in gpTimes)
                   {
                       if (gt1.code.Equals(gt.code))
                       {
                           hs = true;
                           gpTimes.Remove(gt1);
                           gpTimes.Add(gt);
                           break;
                       }
                   }
                   if (!hs)
                   {
                       gpTimes.Add(gt);
                   }
                }
                else if (bean.fszb < 70 && !String.IsNullOrEmpty(bean.code))
                {
                    foreach (GpTime gt1 in gpTimes)
                    {
                        if (gt1.code.Equals(bean.code))
                        {                          
                            gpTimes.Remove(gt1);                           
                            break;
                        }
                    }
                }
            }

           
        }

        /// <summary>
        /// 尾盘监控
        /// </summary>
        /// <param name="bean"></param>
        /// <param name="tran_mode"></param>
        /// <returns></returns>
        public static void end_time_check(StrateSta sta,TranBean bean, int tran_mode)
        {
            if (MdComm.str_mode != GPConstants.STRATEGY_MODE_NORMAR_PRD)
            {
                return;
            }

            //加载当日所有入场信号
            if (!bean.isDp && bean.btime > 14.50)
            {
                lock (isLoadCurPosFlag)
                {
                    if (isLoadCurPosFlag.Equals("0"))
                    {
                        if (MdComm.str_mode == 2)
                        {
                            Console.WriteLine("尾盘加载监控买入股票清单 end....{0}", bean.strtime);
                            //插入数据库日志
                            JJUtil.dblog(0, "尾盘加载监控买入股票清单:", Convert.ToDateTime(bean.strtime));
                        }
                        
                        loadCurPosList();
                        isLoadCurPosFlag = "1";
                    }
                }
            }

            //尾盘监控已经买入信息的正确性                   
            if (bean.btime > 14.50 && bean.seq % 10 == 0)
            {
                if (bean.seq % 600 == 0)
                {
                    //插入数据库日志
                    Console.WriteLine("尾盘监控已经买入信息的正确性: {0}", bean.strtime);
                    JJUtil.dblog(0, "尾盘监控已经买入信息的正确性:", Convert.ToDateTime(bean.strtime));
                }

                PositionDb posDb = HGStaUtil.checkGpDic.ContainsKey(bean.code) ? HGStaUtil.checkGpDic[bean.code] : null;  
                //入场信号是金叉的检查尾盘价格是否跳水
                if (posDb != null && posDb.selltime == 0)
                {
                    //分时比例
                    double bl = getTimeBl(bean);
                    if (posDb.inxh == GPConstants.XH_BUY_SSZJ && bean.zf < 1)
                    {
                        GPUtil.helper.ExecuteNonQuery("delete FROM position where code='" + bean.code + "' and available >0");
                        HGStaUtil.checkGpDic.Remove(bean.code);
                    }                                      
                }
                
            }                           
           
        }

        public static bool just_sel_gps(TranBean bean)
        {
            return crossOverYesterday(bean);
        }

        /// <summary>
        /// ASC转化
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static String getASC2Str(String str)
        {
            return Encoding.ASCII.GetString(new byte[] { (byte)Convert.ToInt16(str)});
  

        }

        /// <summary>
        /// 历史数据导入
        /// </summary>
        /// <param name="symbol_list"></param>
        /// <param name="begin_time"></param>
        /// <param name="end_time"></param>
        public static void loadGpDayHisList(string code,
              string begin_time,
              string end_time)
        {
           
            if (MdComm.md == null)
            {
                MdComm.initMd();
            }

            GPUtil.helper.ExecuteNonQuery("delete from gpyaohhis where code='" + SinaAPI.getUrlCode(code) + "'");

            List<DailyBar> barList = MdComm.md.GetDailyBars(MdComm.getJJCode(code), begin_time, end_time);            
            string insertSql = "";
            List<String> SQLStringList = new List<string>();
            foreach (DailyBar bar in barList)
            {
                insertSql = "INSERT INTO gpyaohhis (DATE, OPEN, High, Low, CLOSE, Volume, zf, CODE) VALUES('" + Convert.ToDateTime(bar.strtime)
                        + "',"+bar.open+","+bar.high+","+bar.low+","+bar.close+","+bar.volume+","
                        + HGStaUtil.getBarZF(bar)+",'"+SinaAPI.getUrlCode(bar.sec_id)+"')";
                SQLStringList.Add(insertSql);
            }

            if (SQLStringList.Count > 0)
            {
                GPUtil.helper.ExecuteBatchExt(SQLStringList);
            }           

        }

        /// <summary>
        /// 导入BAR
        /// </summary>
        /// <param name="code"></param>
        /// <param name="begin_time"></param>
        /// <param name="end_time"></param>
        public static void loadGpBarList(string code,int type,
             string begin_time,
             string end_time)
        {

            if (MdComm.md == null)
            {
                MdComm.initMd();
            }

            //GPUtil.helper.ExecuteNonQuery("delete from bar where sec_id='" + SinaAPI.getUrlCode(code) + "' and type=" + type);

            List<Bar> barList = MdComm.md.GetBars(MdComm.getJJCode(code), 60, begin_time, end_time);
            string insertSql = "";
            List<String> SQLStringList = new List<string>();
            foreach (Bar bar in barList)
            {

                insertSql = "INSERT INTO bar (sec_id, bar_type,pre_close, open, low, high, close, tdate,ttime,type) VALUES('" 
                        + SinaAPI.getUrlCode(bar.sec_id)
                        + "'," + bar.bar_type + "," + bar.pre_close + "," + bar.open + "," + bar.low + "," + bar.high +","+bar.close+
                        ",'" + Convert.ToDateTime(bar.strtime).Date 
                        + "','" + Convert.ToDateTime(bar.strtime).TimeOfDay+ "'," + type + ")";
                SQLStringList.Add(insertSql);
            }

            if (barList.Count > 0)
            {
                GPUtil.helper.ExecuteBatchExt(SQLStringList);
            }
          

        }

        /// <summary>
        /// 分时比例
        /// </summary>
        /// <param name="bean"></param>
        /// <returns></returns>
        public static double getTimeBl(TranBean bean)
        {
            double bl = 0;
            if (bean.more_timejj_cnt + bean.less_timejj_cnt > 0)
            {
                bl = Convert.ToDouble(bean.more_timejj_cnt)
                      / (Convert.ToDouble(bean.more_timejj_cnt) + Convert.ToDouble(bean.less_timejj_cnt)) * 100;
                bl = Math.Round(bl, 2);
                bean.fszb = bl;
            }           

            return bl;
        }


        /// <summary>
        /// 在均线的上线区间内
        /// </summary>
        /// <param name="bean"></param>
        /// <returns></returns>
        public static double getTimeBlExt(TranBean bean)
        {
            double bl = 0;

            if (bean.less_timejj_cnt_ext + bean.more_timejj_cnt_ext > 0)
            {
                bl = Convert.ToDouble(bean.more_timejj_cnt_ext)
                       / (Convert.ToDouble(bean.more_timejj_cnt_ext) + Convert.ToDouble(bean.less_timejj_cnt_ext)) * 100;
            }
                
            bl = Math.Round(bl, 2);

            bean.fszb_ext = bl;

            return bl;
        }

        /**
        * 从SDK 更新guopiao 基本信息表
        * */
        public static void loadBaseInfoFromGM(string codes)
        {
            //初始化账号
            MdComm.initMd();

            if (string.IsNullOrEmpty(codes))
            {
                codes = GPUtil.codes;
            }

            string codes_str = "";
            List<string> codeList = codes.Split(",".ToCharArray()).ToList();
           
            foreach (string c in codeList)
            {
                codes_str += MdComm.getJJCode(c) + ",";
            }
          
            string code = "";
            string updSql = "";
            List<String> SQLStringList = new List<string>();

            //List<ShareIndex> sis = MdComm.md.GetLastShareIndex(codes_str);
            //foreach (ShareIndex si in sis)
            //{              
            //    code = si.symbol.Replace("SHSE", "sh").Replace("SZSE", "sz").Replace(".","");
            //    updSql = "update gp set ltsz=" + si.flow_a_share / 100000000  + ", zsz=" + si.total_share / 100000000  + " where code='" + code + "'";
            //    SQLStringList.Add(updSql);               
            //}

            //GPUtil.helper.ExecuteBatchExt(SQLStringList);

            //市盈率
            List<MarketIndex> mks = MdComm.md.GetLastMarketIndex(codes_str);
            foreach (MarketIndex mk in mks)
            {
                code = mk.symbol.Replace("SHSE", "sh").Replace("SZSE", "sz").Replace(".", "");

                updSql = "update gp set syl=" + Math.Round(mk.pe_ratio,2) + ", sjl=" + Math.Round(mk.pb_ratio,2) + ",ltsz="
                     + Math.Round(mk.market_value_flow / 100000000,2) + ",zsz=" + Math.Round(mk.market_value / 100000000,2) + " where code='" + code + "'";

                SQLStringList.Add(updSql);              
            }

            GPUtil.helper.ExecuteBatchExt(SQLStringList);
        }

        public static bool isDpContionDown()
        {
            string his = GPUtil.getDPHis();
            return Regex.IsMatch(his, "^.*[0-4]{2,5}$")
                   || Regex.IsMatch(his, "^.*[0-3]+$");
        }

        public static bool isMGContionDown(string his)
        {          
            return Regex.IsMatch(his, "^.*[0-4]{2,5}$")
                   || Regex.IsMatch(his, "^.*[0-3]+$");
        }

        public static bool isDpContionUp()
        {
            string his = GPUtil.getDPHis();
            return Regex.IsMatch(his, "^.*[5-9]{2,5}$")
                   || Regex.IsMatch(his, "^.*[7-9]+$");
        }

        public static bool up2top()
        {
            string his = GPUtil.getDPHis();
            return Regex.IsMatch(his, "^[5-9]{2,5}[0-4]+$");
        }

        public static bool down2buttom()
        {
            string his = GPUtil.getDPHis();
            return Regex.IsMatch(his, "^[0-4]{1,5}[5-9]+$");
        }

        public static double getDTime(string strTime) {

            if (strTime == null)
            {
                return 0;
            }

            double lowest_time = Convert.ToDouble(strTime.Substring(11, 5).Replace(":", "."));
            return lowest_time;
        }

        public static void dblog(int logtype,string logstr,DateTime trandate) {
            GPUtil.helper.ExecuteNonQuery("insert into jjlog (type,log,logtime) values (" 
                + logtype + ",'" + logstr + "','" + trandate.ToString()+"')");
        }

        public static void qsRec(String code,int qs,DateTime recDate)
        {
            GPUtil.helper.ExecuteNonQuery("insert into dpqs (code,qs,jdate) values ('"
                + code + "','" + qs + "','" + recDate.ToString() + "')");
        }

        public static void loadHyList()
        {
            Hy hy = null;
            int top = 30;           
            DataTable dataTable = GPUtil.helper.ExecuteDataTable("SELECT hy,zf,zf5,zfrec FROM hyzfrec where hy<>'上证大盘' and zf>0 and zf is not null"
                    + " and DATE = CURDATE() ORDER BY zf DESC LIMIT 0," + top, GPUtil.parms);
            HGStaUtil.hyDic.Clear();
            if (dataTable != null)
            {
                int i = 0;
                foreach (DataRow row in dataTable.Rows)
                {
                    hy = new Hy();
                    hy.hy = row["hy"].ToString();
                    hy.zf = Convert.ToDouble(row["zf"] == null ? 0 : row["zf"]);
                    hy.zf5 = Convert.ToDouble(row["zf5"] == null ? 0 : row["zf5"]);
                    hy.zfrec = row["zfrec"].ToString();
                    if (hy.zf != 0)
                    {
                        HGStaUtil.hyDic.Add(hy.hy, hy);
                    }

                    i++;
                    if (i == 1)
                    {
                        //最高TOP1行业
                        GPUtil.top1hy = hy.hy.Trim();
                    }

                    if (i <= 6)
                    {
                        HGStaUtil.hyTop6.Add(hy.hy);
                    }
                    
                }
            }
        }

        public static void loadHy5List()
        {
            Hy5 hy5 = null;           
            DataTable dataTable = GPUtil.helper.ExecuteDataTable("SELECT hy,zf from hy5zf order by zf desc limit 0,20", GPUtil.parms);
            HGStaUtil.hy5Dic.Clear();
            if (dataTable != null)
            {               
                foreach (DataRow row in dataTable.Rows)
                {
                    hy5 = new Hy5();
                    hy5.hy = row["hy"].ToString();
                    hy5.zf = Convert.ToDouble(row["zf"] == null ? 0 : row["zf"]);
                    HGStaUtil.hy5Dic.Add(hy5.hy, hy5);                   
                }
            }
        }

        public static void loadGn5List()
        {
            Hot5 gn5 = null;
            DataTable dataTable = GPUtil.helper.ExecuteDataTable("SELECT gn,zf from gn5zf order by zf desc limit 0,20", GPUtil.parms);
            HGStaUtil.hot5Dic.Clear();
            if (dataTable != null)
            {              
                foreach (DataRow row in dataTable.Rows)
                {
                    gn5 = new Hot5();
                    gn5.gn = Convert.ToInt16(row["gn"]);
                    gn5.zf = Convert.ToDouble(row["zf"] == null ? 0 : row["zf"]);
                    HGStaUtil.hot5Dic.Add(gn5.gn.ToString(), gn5);
                }
            }
        }

        public static int loadHotList()
        {
            Hot hot = null;
            DataTable dataTable = GPUtil.helper.ExecuteDataTable("SELECT gn,gnname,gnzf FROM 热点排序 where DATE = CURDATE() and gnzf >0 and gnzf is not null limit 0,30", GPUtil.parms);
            if (dataTable != null)
            {
                int cnt = 0;
                int i = 0;
                foreach (DataRow row in dataTable.Rows)
                {
                    hot = new Hot();
                    hot.gn = Convert.ToInt16(row["gn"] == null ? 0 : row["gn"]);
                    hot.gnname = row["gnname"].ToString();

                    if (!HGStaUtil.hotDic.ContainsKey(hot.gn.ToString()))
                    {
                        HGStaUtil.hotDic.Add(hot.gn.ToString(), hot);
                        cnt++;
                    }

                    i++;
                    if (i <= 6)
                    {
                        HGStaUtil.hotTop6.Add(hot.gn.ToString());
                    }
                }

                if (cnt == 0)
                {
                    return 0;
                }
            }

            return 1;
        }

        /// <summary>
        /// 优势行业获取
        /// </summary>
        /// <returns></returns>
        public static string getHotHyStrs()
        {
            DataTable dataTable = GPUtil.helper.ExecuteDataTable("SELECT hy FROM hyzfrec where hy <>'上证大盘' and zf>0 and zf is not null"
                    + " ORDER BY zf DESC limit 0,30", GPUtil.parms);
            string hotHys = "";
            if (dataTable != null)
            {
                int i = 0;
                foreach (DataRow row in dataTable.Rows)
                {                  
                    hotHys += row["hy"].ToString()+",";                  
                }
            }

            return hotHys;
        }

        /// <summary>
        /// 优势概念获取
        /// </summary>
        /// <returns></returns>
        public static string getHotGnStrs()
        {
            DataTable dataTable = GPUtil.helper.ExecuteDataTable("SELECT gn FROM gnzfrec where zf>0 and zf is not null"
                    + " ORDER BY zf DESC LIMIT 0,20", GPUtil.parms);
            string hotHys = "";
            if (dataTable != null)
            {
                int i = 0;
                foreach (DataRow row in dataTable.Rows)
                {
                    hotHys += row["gn"].ToString() + ",";
                }
            }

            return hotHys;
        }


        /// <summary>
        /// 获取套利
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public static string getGpTl(string code)
        {
            DataTable dataTable = GPUtil.helper.ExecuteDataTable("SELECT DISTINCT type FROM gprefcode where code='" + code + "'", GPUtil.parms);
            string tl = "";
            if (dataTable != null)
            {
                int i = 0;
                foreach (DataRow row in dataTable.Rows)
                {
                    tl += row["type"].ToString();
                }
            }

            return tl;
        }
   
        public static Hy getHy(String code)
        {
            Hy hy = null;
            DataRow row = GPUtil.helper.ExecuteDataRow("SELECT hy,code from gp where code='"+code+"'", GPUtil.parms);
            if (row != null)
            {
                hy = new Hy();
                hy.hy = row["hy"].ToString();               
            }
            return hy;
        }

        public static GpInfo getGpInfo(String code)
        {
            GpInfo gp = null;
            String sql = "SELECT ifnull(g.hy,'') hy,g1.code,ifnull(g.zsz,0) zsz,ifnull(g.syl,0) syl,ifnull(g.ltsz,0) ltsz,ifnull(g.mgsy,0) mgsy," +
                "g1.flag,g1.zbflag,g1.gn,g1.gpflag from gpsel g1 left join gp g on g1.code=g.code where g1.code like '%" + code + "%' limit 0,1";

            DataRow row = GPUtil.helper.ExecuteDataRow(sql, GPUtil.parms);
            if (row != null)
            {
                gp = new GpInfo();
                gp.hy = row["hy"].ToString();
                gp.gns = row["gn"].ToString(); 
                gp.code = row["code"].ToString();               
                gp.syl = Convert.ToDouble(row["syl"]);
                gp.ltsz = Convert.ToDouble(row["ltsz"]);
                gp.mgsy =  Convert.ToDouble(row["mgsy"]);
                gp.gpflag = Convert.ToInt16(row["gpflag"]);
                gp.zsz = Convert.ToDouble(row["zsz"]);
                gp.flag = Convert.ToInt16(row["flag"]);
                gp.zbflag = Convert.ToInt16(row["zbflag"]);
            }
                     
            return gp;
        }

        public static int getPostCnt()
        {
            int cnt = 0;
            DataRow row = GPUtil.helper.ExecuteDataRow("SELECT COUNT(*) FROM position_prd p WHERE p.`available`>0", GPUtil.parms);
            if (row != null)
            {
                cnt = Convert.ToInt16(row[0]);
            }
            return cnt;
        }

        public static string getHot(String code)
        {
            string gns = "";
            DataRow row = GPUtil.helper.ExecuteDataRow("SELECT gn from gpext where code='" + code + "'", GPUtil.parms);
            if (row != null)
            {
                gns = row["gn"].ToString();
            }
            return gns;
        }

        public static void loadCurPosList()
        {

            PositionDb positionDb = null;
            DataTable dataTable = GPUtil.helper.ExecuteDataTable("select code,indate,ifnull(outdate,null) outdate,inxh,available,available_today," +
                    "ifnull(vwap,0) vwap,ifnull(price,0) price from position where available > 0", GPUtil.parms);
            if (dataTable != null)
            {
                foreach (DataRow row in dataTable.Rows)
                {
                    positionDb = new PositionDb();
                    positionDb.inxh = Convert.ToInt16(row["inxh"]);
                    positionDb.code = row["code"].ToString();
                    positionDb.indate = Convert.ToDateTime(row["indate"]);
                    bool isDBNull = Convert.IsDBNull(row["outdate"]);
                    if (!isDBNull)
                    {
                        positionDb.outdate = Convert.ToDateTime(row["outdate"]);
                    }
                    positionDb.available = Convert.ToInt32(row["available"]);
                    positionDb.available_today = Convert.ToInt32(row["available_today"]);
                    positionDb.price = Convert.ToDouble(row["price"]);
                    positionDb.vwap = Convert.ToDouble(row["vwap"]);
                    positionDb.can_tran_dw = (positionDb.available - (isDBNull?0:positionDb.available_today)) / 100;                   
                    if (!HGStaUtil.checkGpDic.ContainsKey(positionDb.code))
                    {
                        HGStaUtil.checkGpDic.Add(positionDb.code, positionDb);
                    }
                }

            }

        }

        public static bool crossOverYesterday(TranBean bean)
        {
            bool over = false;          

            if (bean.gpTotal.jj5 > bean.gpTotal.jj10
              && bean.gpTotal.preGpTotal.jj5 <= bean.gpTotal.preGpTotal.jj10
              )
            {
                over = true;
            }

            return over;
        }

        public static bool crossDownYesterday(TranBean bean)
        {
            bool over = false;

            if (bean.gpTotal.jj5 <= bean.gpTotal.jj10
              && bean.gpTotal.preGpTotal.jj5 > bean.gpTotal.preGpTotal.jj10
              )
            {
                over = true;
            }

            return over;
        }

        public static bool crossOverToday(TranBean bean)
        {
            bool over = false;

            //实盘的时候这么做
            if (
                bean.todayJJ5 > Math.Round(bean.gpTotal.jj10 * (1 + 0.008),2)
                && bean.todayJJ5 > bean.gpTotal.jj5 
                && bean.gpTotal.jj5 < bean.gpTotal.jj10
                && bean.todayJJ10 > bean.gpTotal.jj10
                && bean.todayJJ5 > bean.todayJJ10 
               )
            {
                over = true;
            }           

            return over;
        }

        public static bool crossOver30jj(TranBean bean)
        {
            bool over = false;

            //实盘的时候这么做
            if (bean.todayJJ20 > bean.gpTotal.jj30
                && bean.gpTotal.jj20 <= bean.gpTotal.jj30)
            {
                over = true;
            }

            return over;
        }

        public static bool crossOver60jj(TranBean bean)
        {
            bool over = false;

            //实盘的时候这么做
            if (bean.todayJJ30 > bean.gpTotal.jj60
                && bean.gpTotal.jj30 <= bean.gpTotal.jj60)
            {
                over = true;
            }

            return over;
        }

        public static bool crossOver20jj(TranBean bean)
        {
            bool over = false;

            //实盘的时候这么做
            if (bean.todayJJ10 > Math.Round(bean.gpTotal.jj20 * (1 + 0.002), 2)
                && bean.gpTotal.jj10 <= bean.gpTotal.jj20)
            {
                over = true;
            }

            return over;
        }

        public static bool crossOver5NoPoint(TranBean bean)
        {
            bool over = false;

            if (bean.gpTotal.jj5 >= bean.gpTotal.jj10
                && bean.gpTotal.preGpTotal.jj10 > bean.gpTotal.preGpTotal.jj5)
            {
                over = true;
            }

            return over;
        }

        /// <summary>
        /// 死叉
        /// </summary>
        /// <param name="total"></param>
        /// <returns></returns>
        public static bool crossUnder(BarTotal total)
        {
            bool over = false;

            if (total.gpTotal.jj5 <= total.gpTotal.jj10 
                && total.gpTotal.preGpTotal.jj5 > total.gpTotal.preGpTotal.jj10)
            {
                over = true;
            }

            return over;
        }

        public static bool crossOver(BarTotal total)
        {
            bool over = false;

            if (total.gpTotal.jj5 >= total.gpTotal.jj10
                && total.gpTotal.preGpTotal.jj10 > total.gpTotal.preGpTotal.jj5
                && total.bar.close > total.gpTotal.top_5_day * (1 + 0.005))
            {
                over = true;
            }

            return over;
        }

        public static bool crossUnder(TranBean bean)
        {
            bool over = false;

            if (bean.gpTotal.jj5 <= bean.gpTotal.jj10
                && bean.gpTotal.preGpTotal.jj5 > bean.gpTotal.preGpTotal.jj10)
            {
                over = true;
            }

            return over;
        }


       



    }
}
