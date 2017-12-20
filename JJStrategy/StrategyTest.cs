using GMSDK;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace MdTZ
{
    /// <summary>
    /// 套利策略
    /// </summary>
    class StrategyTest : Strategy
    {

        #region 成员变量
        //标的tick状态
        public Dictionary<string, TranBean> tranBeanDic = new Dictionary<string, TranBean>();

        //标的bar状态
        public Dictionary<string, BarTotal> barDic = new Dictionary<string, BarTotal>();

        //策略状态
        public StrateSta strateSta = new StrateSta();

        public StaUtilEx Util = new StaUtilEx();

        private int today_buy_cnt = 1;     //买入次数     

        private static int bar_cnt = 0;

        private Random ran = new Random();

        #endregion

        #region 成员方法

        public static double getCjAmt(DailyBar bar)
        {
            return Math.Round(bar.amount / 100000000, 2);
        }


        public static bool crossOverToday(TranBean bean)
        {
            bool over = false;

            //实盘的时候这么做
            if (
                bean.todayJJ5 > Math.Round(bean.gpTotal.jj10 * (1 + 0.02), 2)
                && bean.gpTotal.jj5 < bean.gpTotal.jj10
               )
            {
                over = true;
            }

            return over;
        }

        /// <summary>
        /// 是否突破前期价位
        /// </summary>
        /// <param name="sta"></param>
        /// <param name="bean"></param>
        /// <param name="tran_mode"></param>
        /// <returns></returns>
        public static bool isNeedOpenOrder(StrateSta sta, TranBean bean, int tran_mode)
        {
            #region 设置止盈止损
            if (sta.dp == null)
            {
                return false;
            }

            double sellTime = bean.gpTotal.sum2Zf > 5 ? 9.40 : 14.40;
            sellTime = bean.gpTotal.sum3Zf > 5 ? 9.40 : sellTime;
            sellTime = bean.gpTotal.sum5Zf > 8 ? 9.40 : sellTime;
            sellTime = bean.gpTotal.sum10Zf > 10 ? 9.40 : sellTime;

            double zy = bean.gpTotal.sum2Zf > 5 ? 3 : 5;
            zy = bean.gpTotal.sum2Zf + bean.zf > 5 ? 2 : zy;
            zy = bean.gpTotal.sum3Zf > 5 ? 3 : zy;
            zy = bean.gpTotal.sum5Zf > 8 ? 3 : zy;
            zy = bean.gpTotal.sum10Zf > 10 ? 3 : zy;

            double zs = bean.gpTotal.sum2Zf > 5 ? -3 : -5;
            zs = bean.gpTotal.sum2Zf + bean.zf > 5 ? -2.5 : -5;
            zs = bean.gpTotal.sum3Zf > 5 ? -3 : zs;
            zs = bean.gpTotal.sum5Zf > 8 ? -3 : zs;
            zs = bean.gpTotal.sum10Zf > 10 ? -3 : zs;

            #region 行业过滤
            //if (MdComm.str_mode == 2 && bean.gpInfo != null && !HGStaUtil.hyDic.ContainsKey(bean.gpInfo.hy))
            //{
            //    string gns = bean.gpInfo.gns;
            //    bool isHot = false;
            //    if (!String.IsNullOrEmpty(gns))
            //    {
            //        foreach (string gn in gns.Split(new char[] { ',' }))
            //        {
            //            if (HGStaUtil.hotDic.ContainsKey(gn))
            //            {
            //                isHot = true;
            //                break;
            //            }
            //        }
            //    }
            //    热点命中
            //    if (!isHot)
            //    {
            //        bean.xh_type = GPConstants.XH_BUY_JCMR;
            //        return true;
            //    }
            //}
            //else
            //{
            //    bean.xh_type = GPConstants.XH_BUY_JCMR;
            //    return true;
            //}
            #endregion

            #endregion




            //#region 上升追击
            //if (bean.tp_cnt > 1
            //    && bean.zf > 0.5
            //    && bean.zf < 2.5
            //    && bean.gpTotal.sum5Zf > -2 && bean.gpTotal.sum5Zf < 3.5
            //    && bean.gpTotal.sum3Zf > -2 && bean.gpTotal.sum3Zf < 3.5
            //    && bean.gpTotal.sum10Zf > -2 && bean.gpTotal.sum10Zf < 3.5
            //    && bean.gpTotal.sum30Zf > -2 && bean.gpTotal.sum30Zf < 3.5
            //    && bean.tick.last_price > bean.tp_last_price
            //    && bean.btime < 13.30
            //    )
            //{
            //    bean.xh_type = GPConstants.XH_BUY_SSZJ;
            //    return true;

            //}
            //#endregion

            //#region 成交量放大5倍以上的
            //if (
            //    bean.lastDailyBar.amount > 0
            //    && bean.tick.cum_amount > Math.Round(bean.lastDailyBar.amount * 5, 2)
            //    && bean.zf > 0
            //    && bean.zf < 3.5
            //    )
            //{
            //    bean.xh_type = GPConstants.XH_BUY_DBTZ;
            //    return true;
            //}
            //#endregion

            //#region 金叉当天
            //if (
            //    JJUtil.crossOverToday(bean)
            //    && bean.zf > 0
            //    && bean.zf < 2.8
            //    && bean.gpTotal.sum30Zf > -2 && bean.gpTotal.sum30Zf < 3
            //    && bean.gpTotal.sum10Zf > -2 && bean.gpTotal.sum10Zf < 3
            //    && bean.gpTotal.sum5Zf > -2 && bean.gpTotal.sum5Zf < 3
            //    && bean.gpTotal.sum3Zf > -2 && bean.gpTotal.sum3Zf < 3
            //    && bean.btime < 13.30
            //    )
            //{
            //    bean.xh_type = GPConstants.XH_BUY_JCMR;
            //    return true;
            //}
            //#endregion

            //#region 60日价格最低

            //// 60日价格最低
            //if (bean.gpTotal.low_60_day > 0
            //       && bean.lastDailyBar.close < bean.gpTotal.low_60_day
            //       && bean.gpTotal.sum3Zf > -2
            //       && bean.btime > 14.52
            //       && bean.zf > 0.2
            //       && bean.zf < 2.3
            //)
            //{
            //    bean.xh_type = GPConstants.XH_BUY_ZDCD_20;
            //    return true;
            //}

            //#endregion

            //#region 5日成交量最低
            //// 10日价格最低
            //if (bean.gpTotal.low_cjl_5_day > 0
            //     && bean.lastDailyBar.amount < bean.gpTotal.low_cjl_5_day
            //     && bean.gpTotal.sum30Zf > -2 && bean.gpTotal.sum30Zf < 3
            //     && bean.gpTotal.sum10Zf > -2 && bean.gpTotal.sum10Zf < 3
            //     && bean.gpTotal.sum5Zf > -2 && bean.gpTotal.sum5Zf < 3
            //     && bean.gpTotal.sum3Zf > -2 && bean.gpTotal.sum3Zf < 3
            //     && bean.btime > 14.51
            //     && bean.zf > 0.2 && bean.zf < 1.3
            //)
            //{
            //    bean.xh_type = GPConstants.XH_BUY_ZDCD_10;
            //    return true;
            //}

            //#endregion

            //#region 开盘均线以上
            //if (bean.btime > 9.35
            //       && bean.tick.open > bean.tick.pre_close
            //       && bean.fszb > 70
            //       && bean.gpTotal.sum30Zf > -2 && bean.gpTotal.sum30Zf < 3
            //       && bean.gpTotal.sum10Zf > -2 && bean.gpTotal.sum10Zf < 3
            //       && bean.gpTotal.sum5Zf > -2 && bean.gpTotal.sum5Zf < 3
            //       && bean.gpTotal.sum3Zf > -2 && bean.gpTotal.sum3Zf < 3
            //       && bean.zf > 0
            //       && bean.zf < 1.2
            //       && bean.tick.last_price > bean.timejj
            //)
            //{
            //    bean.xh_type = GPConstants.XH_BUY_FRIST_ZJ;
            //    return true;
            //}
            //#endregion



            #region 上升追击
            if (!bean.isClearXHFlag
                && bean.gpTotal.preGpTotal != null && bean.gpTotal.preGpTotal.jj5 > 0
                && bean.gpTotal.preGpTotal.jj5 < bean.gpTotal.jj5
                && bean.gpTotal.sum5Zf > 0
                && (bean.gpTotal.zt_bar_num == 0 || bean.gpTotal.zt_bar_num > 7)
                && bean.tp_cnt > (bean.gpTotal.sum2Zf > 5 ? 2 : 1)
                && bean.tp_cnt > (bean.gpTotal.sum3Zf > 5 ? 2 : 1)
                && bean.tp_cnt > (bean.gpTotal.sum5Zf > 8 ? 3 : 1)
                && bean.tp_cnt > (bean.gpTotal.sum10Zf > 10 ? 4 : 1)
                && bean.zf > 0.5
                && bean.zf < (bean.gpTotal.sum2Zf + bean.zf > 5 ? 2 : 3)
                && bean.zf < (bean.gpTotal.sum2Zf > 5 ? 2 : 3)
                && bean.zf < (bean.gpTotal.sum3Zf > 5 ? 2 :3)
                && bean.zf < (bean.gpTotal.sum5Zf > 8 ? 2 : 3)
                && bean.zf < (bean.gpTotal.sum10Zf > 10 ? 2 :3)
                && bean.gpTotal.sum3Zf > -10
                && bean.gpTotal.sum3Zf < 10
                && (bean.gpTotal.sum3Zf > 5 ? bean.tick.last_price < bean.gpTotal.top_5_day : true)
                && bean.tick.last_price > bean.tp_last_price
                && bean.tick.last_price < 60
                )
            {
                bean.xh_type = GPConstants.XH_BUY_SSZJ;
                return true;

            }
            else if (!bean.isClearXHFlag && bean.buy_cnt > 0 && bean.btime >= 14.52)
            {
                //假突破第二天抛掉
                bean.xh_type = GPConstants.XH_BUY_UN_JC;
                GPUtil.helper.ExecuteProcNoOut("call clear_xh_proc('" + bean.code + "'," + sellTime + "," + zy + "," + zs + ");");
                bean.isClearXHFlag = true;
                return true;
            }
            #endregion

            #region 成交量放大4倍以上的
            if (
                bean.lastDailyBar.amount > 0
                && bean.tick.cum_amount > Math.Round(bean.lastDailyBar.amount * 4.5, 2)
                && bean.zf > 0
                && bean.zf < 4
                )
            {
                bean.xh_type = GPConstants.XH_BUY_DC;
                return true;
            }
            #endregion

            #region 金叉当天
            if (
                JJUtil.crossOverToday(bean)
                && bean.gpTotal.preGpTotal.jj10 > 0
                && bean.gpTotal.jj10 > 0
                && bean.gpTotal.preGpTotal.jj10 < bean.gpTotal.jj10
                && bean.zf > 0
                && bean.zf < 3.5
                && bean.gpTotal.sum30Zf < 3
                && bean.gpTotal.sum10Zf < 3
                && bean.gpTotal.sum5Zf < 3
                && bean.gpTotal.sum3Zf < 3
                && bean.btime > 14.52
                )
            {
                bean.xh_type = GPConstants.XH_BUY_JCMR;
                return true;
            }
            #endregion

            #region 60日价格最低

            // 60日价格最低
            if (bean.gpTotal.low_60_day > 0
                   && bean.lastDailyBar.close < bean.gpTotal.low_60_day
                   && bean.gpTotal.sum3Zf > -2
                   && bean.btime > 14.52
                   && bean.zf > 0.2
            )
            {
                bean.xh_type = GPConstants.XH_BUY_ZDCD_20;
                return true;
            }

            #endregion

            #region 5日成交量最低
            // 10日价格最低
            if (bean.gpTotal.low_cjl_5_day > 0
                 && bean.lastDailyBar.amount < bean.gpTotal.low_cjl_5_day
                 && bean.gpTotal.sum30Zf < 3
                 && bean.gpTotal.sum10Zf < 3
                 && bean.gpTotal.sum5Zf < 3
                 && bean.gpTotal.sum3Zf < 3
                 && bean.btime > 14.52
                 && bean.zf > 0.2
            )
            {
                bean.xh_type = GPConstants.XH_BUY_ZDCD_10;
                return true;
            }

            #endregion

            #region 开盘均线以上
            if (bean.btime > 9.35
                   && bean.tick.open > bean.tick.pre_close 
                   && bean.fszb >= 75
                   && bean.gpTotal.sum30Zf < 3
                   && bean.gpTotal.sum10Zf < 3
                   && bean.gpTotal.sum5Zf < 3
                   && bean.gpTotal.sum3Zf < 3
                   && bean.zf > 0 && bean.zf < 2                                 
                   && bean.tick.cum_amount > Math.Round(bean.lastDailyBar.amount * 1.5, 2)
            )
            {
                bean.xh_type = GPConstants.XH_BUY_FRIST_ZJ;
                return true;
            }
            #endregion

            return false;
        }

        #endregion

        /// <summary>
        /// 收到tick事件，在这里添加策略逻辑。我们简单的每10个tick开仓/平仓，以最新价下单。
        /// </summary>
        /// <param name="tick"></param>
        public override void OnTick(Tick tick)
        {

            #region 策略初始化

            //获取封装过的bean
            TranBean bean = null;
            try
            {
                bean = HGStaUtil.getTranBean(this, tranBeanDic, tick, strateSta);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.StackTrace);
                return;
            }

            //sh000001,sz399001,sz399006
            if ("000001".Equals(bean.code))
            {
                bean.isDp = true;
                strateSta.dp = bean;
            }
            else if ("399001".Equals(bean.code))
            {
                bean.isSZ50 = true;
                strateSta.sz50 = bean;
            }
            else if ("399006".Equals(bean.code))
            {
                bean.isCYB = true;
                strateSta.cyb = bean;
            }

            //大盘指数的时候过滤掉
            if (bean == null || bean.btime < 9.30)
            {
                return;
            }

            //止损止益         
            int can_tran_dw = 0;

            //tick时间
            double btime = bean.btime;
            int sell_xh = 0;

            //非大盘时候
            if (!bean.isDp && !bean.isSZ50 && !bean.isCYB)
            {
                if (bean == null || bean.gpTotal == null || bean.lastDailyBar == null)
                {
                    return;
                }
                //最小买入单位
                bean.gpTotal.minUnit = 1;
                //初始化信号标志
                bean.xh_flag = 0;
                bean.xh_type = 0;

                if (bean.positionDb != null
                   && bean.positionDb.indate.Date.CompareTo(Convert.ToDateTime(bean.tick.strtime).Date) >= 0)
                {
                    bean.positionDb = null;
                }

                //本地仓库（数据库)           
                if (bean.positionDb != null)
                {
                    sell_xh = bean.positionDb.inxh;
                    can_tran_dw = bean.positionDb.can_tran_dw;
                    if (bean.positionDb.vwap > 0)
                    {
                        //盈亏率
                        bean.ykl = Math.Round((tick.last_price - bean.positionDb.vwap) / bean.positionDb.vwap * 100, 2);
                    }
                }
            }
            else
            {
                return;
            }

            #endregion

            #region 平仓

            //平仓
            if (can_tran_dw > 0 && tick.bid_p2 > 0 && bean.sell_cnt <= 2)
            {

                //设置止盈止损               
                double zy = 6;
                double zs = -6;
                double zy_sellTime = bean.gpTotal.sum2Zf > 5 ? 9.40 : 14.40;
                double zs_sellTime = bean.gpTotal.sum2Zf > 5 ? 9.40 : 14.40;
                zy_sellTime = bean.gpTotal.sum2Zf + bean.zf > 5 ? 9.40 : 14.40;
                zy_sellTime = bean.gpTotal.sum3Zf > 5 ? 9.40 : zy_sellTime;
                zy_sellTime = bean.gpTotal.sum5Zf > 8 ? 9.40 : zy_sellTime;
                zy_sellTime = bean.gpTotal.sum10Zf > 10 ? 9.40 : zy_sellTime;

                zs_sellTime = bean.gpTotal.sum2Zf + bean.zf > 5 ? 9.40 : 14.40;
                zs_sellTime = bean.gpTotal.sum3Zf > 5 ? 9.40 : zs_sellTime;
                zs_sellTime = bean.gpTotal.sum5Zf > 8 ? 9.40 : zs_sellTime;
                zs_sellTime = bean.gpTotal.sum10Zf > 10 ? 9.40 : zs_sellTime;

                zy = bean.gpTotal.sum2Zf > 5 ? 3 : 5;
                zy = bean.gpTotal.sum2Zf + bean.zf > 5 ? 3 : zy;
                zy = bean.gpTotal.sum3Zf > 5 ? 3 : zy;
                zy = bean.gpTotal.sum5Zf > 8 ? 3 : zy;
                zy = bean.gpTotal.sum10Zf > 10 ? 3 : zy;

                zs = bean.gpTotal.sum2Zf > 5 ? -3 : -6;
                zs = bean.gpTotal.sum2Zf + bean.zf > 5 ? -3 : zs;
                zs = bean.gpTotal.sum3Zf > 5 ? -3 : zs;
                zs = bean.gpTotal.sum5Zf > 8 ? -3 : zs;
                zs = bean.gpTotal.sum10Zf > 8 ? -3 : zs;

                bool default_zs = (bean.ykl < zs && bean.btime > zs_sellTime);

                bool default_zy = (bean.ykl > zy && bean.zf < 5 && bean.btime > zy_sellTime);

                bool gg_zs = (bean.positionDb != null && bean.positionDb.selltime > 0
                               && bean.btime >= bean.positionDb.selltime
                               && bean.positionDb.zs != 0
                               && bean.ykl <= bean.positionDb.zs);

                bool gg_zy = (bean.positionDb != null && bean.positionDb.selltime > 0
                              && bean.btime >= bean.positionDb.selltime
                              && bean.positionDb.zy != 0
                              && bean.zf <= 7
                              && bean.ykl >= bean.positionDb.zy);

                //不止损
                if ((gg_zs || default_zs)
                    && (bean.tick.last_price > bean.timejj
                    || bean.tick.last_price > bean.pre_tick_price)
                )
                {
                    gg_zs = false;
                    default_zs = false;
                }

                //动态止盈
                if ((gg_zy || default_zy)
                    && (
                    bean.tick.last_price > bean.timejj ||
                    bean.tick.last_price > bean.pre_tick_price)
                )
                {
                    default_zy = false;
                    gg_zy = false;
                }

                //兜底的止损止益--保险丝
                if (gg_zs || gg_zy || default_zy || default_zs)
                {

                    //防止并发产生
                    bean.sell_xh_cnt++;
                    if (bean.sell_xh_cnt >= ran.Next(2, 12))
                    {
                        //实盘交易
                        if (!HGStaUtil.isTraning && MdComm.str_mode == 2)
                        {
                            HGStaUtil.isTraning = true;
                            //ZXApi.sellOut(tick.sec_id, THSAPI.PRICE_OPT_BUY_2, tick.bid_p2, THSAPI.NUM_OPT_ALL, 0);
                            //TXDApi.sellOut(tick.sec_id, 0);
                            PAApi.sellOut(tick.sec_id, 0, 0);
                            HGStaUtil.isTraning = false;
                        }

                        //卖出交易
                        CloseLong(tick.exchange, tick.sec_id, tick.bid_p2, can_tran_dw * 100);

                        //导入1分钟BAR记录
                        if (MdComm.str_mode == 4)
                        {
                            JJUtil.loadGpBarList(tick.sec_id, -1, Convert.ToDateTime(tick.strtime).AddMinutes(-30).ToString("yyyy-MM-dd HH:MM:ss")
                                , Convert.ToDateTime(tick.strtime).AddMinutes(30).ToString("yyyy-MM-dd HH:MM:ss"));
                        }

                        //卖出更新仓位                   
                        GPUtil.updatePosition(-1, tick.sec_id, sell_xh, can_tran_dw * 100, tick.bid_p2, Convert.ToDateTime(tick.strtime),"0");
                        //本地库
                        bean.positionDb = GPUtil.getPositionDb(bean.code);

                        //头寸更新
                        if (bean.positionDb != null)
                        {
                            Console.WriteLine("卖出: {0},时间 {1} 买入 {2} 价格 {3} 数量 {4} 盈亏率 {5} 信号 {6}",
                                 tick.sec_id,
                                 Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss"),
                                 bean.positionDb.vwap, tick.bid_p2, can_tran_dw * 100, bean.ykl, RiskMng.getXhDesc(sell_xh));

                            JJUtil.dblog(5, "卖出:" + tick.sec_id + "成本价:"
                                + bean.positionDb.vwap + ",价格:" + tick.bid_p2 + " 数量:" + can_tran_dw * 100 + ",信号:" + RiskMng.getXhDesc(sell_xh)
                                , Convert.ToDateTime(tick.strtime));
                        }


                        //累计卖出次数
                        bean.sell_cnt++;
                    }


                }
            }

            #endregion

            #region 开仓
            //开仓
            if (isNeedOpenOrder(strateSta, bean, MdComm.TRAN_MODE)
                && bean.xh_type != 0
                && bean.xh_type != GPConstants.XH_BUY_UN_JC)
            {
                bean.xh_cnt++;

                if (bean.xh_cnt >= ran.Next(15, 30)
                    && bean.buy_cnt < today_buy_cnt && tick.ask_p2 > 0)
                {

                    #region 买入频率控制
                    //上午只能买入3只
                    bool real_buy_flag = true;

                    //暂时只卖价格低的
                    if (bean.tick.last_price > 25)
                    {
                        real_buy_flag = false;
                    }

                    //已持仓5只不要实盘买入了
                    if (GPUtil.STORE_GP_NUMS > 5)
                    {
                        real_buy_flag = false;
                    }

                    //已有仓位不要再买入了
                    if (bean.positionDb != null && bean.positionDb.available > 0)
                    {
                        return;
                    }

                    //当天有卖出的不要买入了
                    if (bean.positionDb != null && bean.positionDb.outdate != null
                           && Math.Abs(DateTimeHelper.DateDiff("day", Convert.ToDateTime(bean.strtime).Date, bean.positionDb.outdate.Date)) <= 1)
                    {
                        return;
                    }

                    if (MdComm.str_mode == 2)
                    {
                        //限制每天买入2只
                        if (strateSta.buy_cnt > 2)
                        {
                            real_buy_flag = false;
                        }
                    }
                    #endregion

                    //实盘交易
                    if (!HGStaUtil.isTraning
                        && (MdComm.str_mode == GPConstants.STRATEGY_MODE_NORMAR_PRD || MdComm.str_mode == GPConstants.STRATEGY_MODE_NORMAR_MN))
                    {
                        HGStaUtil.isTraning = true;
                        int buy_num = 100;
                        if (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_NORMAR)
                        {
                            buy_num = 100;
                        }

                        //ZXApi.buyIn(tick.sec_id, THSAPI.PRICE_OPT_SELL_2, tick.ask_p2, THSAPI.NUM_OPT_INPUT, 1 * 100);
                        //TXDApi.buyIn(tick.sec_id, buy_num);
                        if (real_buy_flag)
                        {
                            PAApi.buyIn(tick.sec_id, 0, buy_num);
                            //总计买入
                            strateSta.buy_cnt++;
                        }
                        HGStaUtil.isTraning = false;

                        Console.WriteLine("###中信: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                              tick.sec_id, Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss")
                              , tick.ask_p2, bean.gpTotal.minUnit * 100, RiskMng.getXhDesc(bean.xh_type));
                    }

                    //买入交易
                    OpenLong(tick.exchange, tick.sec_id, tick.ask_p2, bean.gpTotal.minUnit * 100);

                    //买入更新仓位
                    GPUtil.updatePosition(1, tick.sec_id, bean.xh_type, bean.gpTotal.minUnit * 100, tick.ask_p2, Convert.ToDateTime(tick.strtime),"0");
                    //重新查询
                    bean.positionDb = GPUtil.getPositionDb(bean.code);

                    //更新买入次数
                    bean.buy_cnt++;

                    Console.WriteLine("开仓: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                       tick.sec_id, Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss")
                       , tick.ask_p2, bean.gpTotal.minUnit * 100, RiskMng.getXhDesc(bean.xh_type));

                    JJUtil.dblog(6, "开仓:" + tick.sec_id + ",价格:" + tick.ask_p2
                        + "数量:" + bean.gpTotal.minUnit * 100 + ",信号:" + RiskMng.getXhDesc(bean.xh_type)
                       , Convert.ToDateTime(tick.strtime));

                    //导入1分钟BAR记录
                    if (MdComm.str_mode == 4)
                    {
                        JJUtil.loadGpBarList(tick.sec_id, 1, Convert.ToDateTime(tick.strtime).AddMinutes(-30).ToString("yyyy-MM-dd HH:MM:ss")
                            , Convert.ToDateTime(tick.strtime).AddMinutes(30).ToString("yyyy-MM-dd HH:MM:ss"));
                    }

                }
            }
            #endregion

        }

        /// <summary>
        /// 10点半以后
        /// </summary>
        /// <param name="bar"></param>
        public override void OnBar(Bar bar)
        {
            //加载当日股票数据
            if (MdComm.str_mode == 3)
            {
                if (HGStaUtil.DP_TICK_CODES.IndexOf(bar.sec_id) != -1)
                {
                    bar_cnt++;
                }
            }

        }

        #region 非主要事件

        /// <summary>
        /// 委托执行回报，订单的任何执行回报都会触发本事件，通过rpt可访问回报信息。
        /// </summary>
        /// <param name="rpt"></param>
        public override void OnExecRpt(ExecRpt rpt)
        {
            if (MdComm.str_mode != 4 && MdComm.str_mode != 5 && MdComm.str_mode != 6)
            {
                //Console.WriteLine(
                //"成交: 序号={0} price={1} amount={2} exec_type={3}",
                //rpt.cl_ord_id,
                //rpt.price,
                //rpt.amount,
                //rpt.exec_type);
            }
        }


        /// <summary>
        /// 响应行情状态事件，收到MarketDataEvent数据后本函数被调用。
        /// 开盘，收盘，回放行情结束等事件
        /// </summary>
        /// <param name="bar"></param>
        public override void OnMdEvent(MDEvent md_event)
        {
            Console.WriteLine("event_type: {0}, utc_time: {1}", md_event.event_type, md_event.utc_time);
        }


        /// <summary>
        /// 错误处理，收到错误事件时，可以根据error_code判断是什么错误，然后进行处理。
        /// 以下示例实时行情/交易断线后，重新连接的过程。
        /// </summary>
        /// <param name="error_code"></param>
        public override void OnError(int error_code, string error_msg)
        {
            //Console.WriteLine("on_error: {0}, msg: {1}, time: {2}", error_code, error_msg, DateTime.Now.ToString());

            //服务断开
            if ("3000,3001,3002,3003,3004,3005,3006,3007,3008,3009,10000".IndexOf(error_code.ToString()) != -1)
            {
                MdComm.ERROR_CODE = error_code;
            }

        }
        #endregion

    }
}
