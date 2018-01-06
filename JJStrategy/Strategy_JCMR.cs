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
    class Strategy_JCMR: Strategy
    {

        #region 成员变量
        //标的tick状态
        public static Dictionary<string, TranBean> tranBeanDic = new Dictionary<string, TranBean>();

        //标的bar状态
        public Dictionary<string, BarTotal> barDic = new Dictionary<string, BarTotal>();

        //策略状态
        public static StrateSta strateSta = new StrateSta();

        public StaUtilEx Util = new StaUtilEx();

        private int today_buy_cnt = 1;     //买入次数           

        private Random ran = new Random();

        public static readonly object Locker2 = new object();

        #endregion

        #region 成员方法
     
        /// <summary>
        /// 逐步补仓法，尾盘买入
        /// </summary>
        /// <param name="sta"></param>
        /// <param name="bean"></param>
        /// <param name="tran_mode"></param>
        /// <returns></returns>
        public bool isNeedOpenOrder(StrateSta sta, TranBean bean, int tran_mode)
        {
            #region 初始化
            bean.xh_type = 0;
            if (bean.isDp || bean.isCYB || bean.isZxp || bean.isSZ50 || bean.gpInfo == null)
            {
                return false;
            }
            #endregion

            #region 龙头1 
            if (
                sta != null && sta.dp != null
                && bean.gpTotal != null
                && bean.gpInfo != null
                && !bean.gpInfo.gns.Equals("zs")              
                && bean.lastDailyBar != null
                && bean.gpInfo.gpflag == 10
                && bean.buy_cnt == 0
                && bean.tick.pre_close > 0
                && bean.tick.pre_close <= bean.gpTotal.low_3_day
                && bean.btime > (bean.zf > 0 ? 9.32 : 14.50)    
                && bean.btime <= 14.58
               )
            {
                bean.xh_type = GPConstants.XH_BUY_CD;
                return true;
            }

            #endregion      

            #region 龙头2
            if (
                sta != null && sta.dp != null
                && bean.gpTotal != null
                && bean.gpInfo != null
                && !bean.gpInfo.gns.Equals("zs")
                && bean.lastDailyBar != null
                && bean.gpInfo.gpflag == 9
                && bean.buy_cnt == 0
                && bean.tick.pre_close > 0
                && bean.tick.pre_close <= bean.gpTotal.low_5_day
                && bean.btime > (bean.zf > 0 ? 9.32 : 14.50)
                && bean.btime <= 14.58
               )
            {
                bean.xh_type = GPConstants.XH_BUY_CD;
                return true;
            }

            #endregion 
            
            #region 龙头3
            if (
                sta != null && sta.dp != null
                && bean.gpTotal != null
                && bean.gpInfo != null
                && !bean.gpInfo.gns.Equals("zs")
                && bean.lastDailyBar != null
                && bean.gpInfo.gpflag == 8
                && bean.buy_cnt == 0
                && bean.tick.pre_close > 0
                && bean.tick.pre_close <= bean.gpTotal.low_10_day
                && bean.btime > (bean.zf > 0 ? 9.32 : 14.50)
                && bean.btime <= 14.58
               )
            {
                bean.xh_type = GPConstants.XH_BUY_CD;
                return true;
            }
            #endregion

            #region 龙头4
            if (
                sta != null && sta.dp != null
                && bean.gpTotal != null
                && bean.gpInfo != null
                && !bean.gpInfo.gns.Equals("zs")
                && bean.lastDailyBar != null
                && bean.gpInfo.gpflag == 7
                && bean.buy_cnt == 0
                && bean.tick.pre_close > 0
                && bean.tick.pre_close <= bean.gpTotal.low_20_day
                && bean.btime > (bean.zf > 0 ? 9.32 : 14.50)
                && bean.btime <= 14.58
               )
            {
                bean.xh_type = GPConstants.XH_BUY_CD;
                return true;
            }
            #endregion

            #region 龙头5
            if (
                sta != null && sta.dp != null
                && bean.gpTotal != null
                && bean.gpInfo != null
                && !bean.gpInfo.gns.Equals("zs")
                && bean.lastDailyBar != null
                && bean.gpInfo.gpflag == 6
                && bean.buy_cnt == 0
                && bean.tick.pre_close > 0
                && bean.tick.pre_close <= bean.gpTotal.low_30_day
                && bean.btime > (bean.zf > 0 ? 9.32 : 14.50)
                && bean.btime <= 14.58
               )
            {
                bean.xh_type = GPConstants.XH_BUY_CD;
                return true;
            }
            #endregion

            #region 龙头6
            if (
                sta != null && sta.dp != null
                && bean.gpTotal != null
                && bean.gpInfo != null
                && !bean.gpInfo.gns.Equals("zs")
                && bean.lastDailyBar != null
                && bean.gpInfo.gpflag < 6
                && bean.buy_cnt == 0
                && bean.tick.pre_close > 0
                && bean.tick.pre_close <= bean.gpTotal.low_60_day
                && bean.btime > (bean.zf > 0 ? 9.32 : 14.50)
                && bean.btime <= 14.58
               )
            {
                bean.xh_type = GPConstants.XH_BUY_CD;
                return true;
            }
            #endregion

            #region 补仓
            if (
                bean.gpInfo != null
                && !bean.gpInfo.gns.Equals("zs")
                && bean.gpTotal != null
                && bean.buy_cnt == 0
                && bean.sell_cnt == 0
                && bean.lastDailyBar != null
                && bean.tick.cum_amount > 0
                && bean.positionDb != null
                && bean.positionDb.available > 0
                && (bean.tick.pre_close < bean.gpTotal.jj5
                    && bean.tick.pre_close < bean.gpTotal.jj10
                    && bean.tick.pre_close < bean.gpTotal.jj30
                    && bean.tick.pre_close < bean.gpTotal.jj60)   
                && bean.ykl < -1
                && bean.zf < 0
                && bean.tick.last_price < bean.timejj
                && bean.btime >= 14.50
               )
            {
                bean.xh_type = GPConstants.XH_BUY_BC;
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
            //时间控制下
            DateTime t_time = Convert.ToDateTime(tick.strtime);
            //获取封装过的bean
            TranBean bean = null;
            try
            {
                bean = HGStaUtil.getTranBean(this, tranBeanDic, tick, strateSta);
                //大盘指数的时候过滤掉
                if (bean == null)
                {
                    return;
                }

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
            else if ("000016".Equals(bean.code)) //上周50
            {
                bean.isSZ50 = true;
                strateSta.sz50 = bean;
            }
            else if ("399001".Equals(bean.code))
            {
                bean.isZxp = true;
                strateSta.zxb = bean;
            }
            else if ("399006".Equals(bean.code))
            {
                bean.isCYB = true;
                strateSta.cyb = bean;
            }            

            //tick时间
            double btime = bean.btime;          

            //初始化信号标志
            bean.xh_flag = 0;
            bean.xh_type = 0;

            #region 仓位初始化
            if (bean != null && bean.gpTotal != null && bean.gpInfo != null
                && !bean.isDp && !bean.isZxp && !bean.isSZ50 && !bean.isCYB)
            {
                //最小买入单位
                bean.gpTotal.minUnit = 1;

                //本地仓库（数据库)           
                if (bean.gpInfo != null && bean.positionDb != null)
                {                   
                    if (bean.positionDb.available > 0 && bean.positionDb.vwap > 0)
                    {
                        //盈亏率
                        bean.ykl = Math.Round((tick.last_price - bean.positionDb.vwap) / bean.positionDb.vwap * 100, 2);
                    }
                    else
                    {
                        bean.ykl = 0;
                    }
                }
            }
            #endregion

            #endregion          

            #region 股票平仓

            //平仓
            if (!bean.isDp 
                && bean.gpInfo != null
                && !bean.gpInfo.gns.Equals("zs")
                && bean.positionDb != null
                && bean.code.Equals(bean.positionDb.code)
                && bean.positionDb.can_tran_dw > 0
                && strateSta != null && strateSta.dp != null
                && tick.last_price > 0
                && strateSta != null && strateSta.dp != null
                && bean.buy_cnt == 0
                && bean.sell_cnt == 0)
            {

                double zy_sellTime = 9.35;
                double zs_sellTime = 9.35;

                //设置止盈止损               
                double zy = 1;
                double zs = -2;

                if (bean.gpTotal.sum30Zf < -20 
                    || bean.gpTotal.sum10Zf < -15 
                    || bean.gpTotal.sum5Zf < -10)
                {
                     zy = 2;
                     zs = -4;
                }
                else if (bean.gpTotal.sum30Zf <= 2)
                {
                    zs_sellTime = 10.45;
                }
                else if (bean.gpInfo.gpflag >=8)
                {
                    zs_sellTime = 14.45;
                }

                if (strateSta.dp.zf >= 0.5)
                {
                    zy = 2;
                    zs = -4;
                }

                if (bean.tick.last_price < bean.gpTotal.jj5 
                    && bean.tick.last_price < bean.gpTotal.jj10
                    && bean.tick.last_price < bean.gpTotal.jj30
                    && bean.tick.last_price < bean.gpTotal.jj60)
                {
                    zy = 2;
                    zs = -4;
                }

                if (bean.gpInfo.gpflag >= 10)
                {
                    zy = 4;
                    zs = -4;
                }
              
                bool default_zs = (bean.ykl < zs && bean.btime > ((bean.tick.last_price < bean.timejj) ? zs_sellTime : 14.40));
                bool default_zy = (bean.ykl > zy && bean.btime > ((bean.tick.last_price < bean.timejj) ? zy_sellTime : 14.40));

                //涨停不卖
                if (bean.zf > 9)
                {
                    default_zy = false;
                }

                if (bean.zf > 0)
                {
                    default_zs = false;
                }

                //兜底的止损强制止益--保险丝
                if (default_zy || default_zs)
                {
                    lock (Locker2)
                    {
                        //实盘交易
                        if (MdComm.str_mode == 6 && MdComm.JJ_SP_FLAG == 1 && MdComm.TRAN_FALG == 1)
                        {
                            MdComm.SP_TRAN_FLAG = 1;
                            PAApi.sellOut(tick.sec_id, 0, 0);
                            MdComm.SP_TRAN_FLAG = 0;
                            //ZXApi.sellOut(tick.sec_id, THSAPI.PRICE_OPT_BUY_2, tick.bid_p2, THSAPI.NUM_OPT_ALL, 0);
                            //TXDApi.sellOut(tick.sec_id, 0);                                                                                                                           
                        }
                    }

                  
                    //导入1分钟BAR记录
                    if (MdComm.str_mode == 8)
                    {
                        //卖出交易
                        CloseLong(tick.exchange, tick.sec_id, tick.last_price, bean.positionDb.can_tran_dw);

                        HGStaUtil.insertGpZhiBiao(strateSta.dp, bean, 1);
                    }                 

                    //头寸更新
                    if (bean.positionDb != null)
                    {
                        //卖出更新仓位                   
                        GPUtil.updatePosition(-1, tick.sec_id, bean.positionDb.inxh, bean.positionDb.can_tran_dw, tick.last_price, Convert.ToDateTime(tick.strtime), "0");

                        Console.WriteLine("卖出: {0},时间 {1} 买入 {2} 价格 {3} 数量 {4} 盈亏率 {5} 信号 {6}",
                                tick.sec_id,
                                Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss"),
                                bean.positionDb.vwap, tick.bid_p2, bean.positionDb.can_tran_dw, bean.ykl, RiskMng.getXhDesc(bean.positionDb.inxh));

                        JJUtil.dblog(5, "掘金卖出:" + tick.sec_id + "成本价:"
                            + bean.positionDb.vwap + ",价格:" + tick.bid_p2 + " 数量:" + bean.positionDb.can_tran_dw + ",信号:" + RiskMng.getXhDesc(bean.positionDb.inxh)
                            , Convert.ToDateTime(tick.strtime));
                    }

                    //本地库
                    bean.positionDb = GPUtil.getPositionDb(bean.tick.sec_id);

                    //累计卖出次数
                    bean.sell_cnt++;


                }
            }

            #endregion

            #region 股票开仓
            //开仓
            if (
                !bean.isDp && !bean.isCYB && !bean.isSZ50 && !bean.isZxp
                && bean.gpInfo != null
                && !bean.gpInfo.gns.Equals("zs")
                && isNeedOpenOrder(strateSta, bean, MdComm.TRAN_MODE)
                && bean.xh_type != 0
                && bean.tick.last_price > 0             
                && bean.buy_cnt < today_buy_cnt
                && bean.sell_cnt == 0
                )
            {
                //同类的只能有一个                
                if (bean.xh_type != GPConstants.XH_BUY_BC
                    && MdComm.str_mode == 6
                    && JJUtil.dbGnsList.Contains(bean.gpInfo.gns))
                {
                    return;
                }   

                //实盘仓位数
                int buy_num = 300;
                if (bean.tick.last_price > 30)
                {
                    buy_num = 100;
                }
                else if (bean.tick.last_price < 10)
                {
                    buy_num = 500;
                }
                else if (bean.tick.last_price > 10 && bean.tick.last_price < 20)
                {
                    buy_num = 300;
                }    

                if (MdComm.JJ_SP_FLAG == 1
                    && MdComm.str_mode == 6 
                    && bean.gpInfo.gpflag >= 5
                    && MdComm.TRAN_FALG == 1)
                {
                    lock (Locker2)
                    {
                        //ZXApi.buyIn(tick.sec_id, THSAPI.PRICE_OPT_SELL_2, tick.ask_p2, THSAPI.NUM_OPT_INPUT, 1 * 100);
                        //TXDApi.buyIn(tick.sec_id, buy_num);
                        MdComm.SP_TRAN_FLAG = 1;
                        PAApi.buyIn(bean.code, 0, buy_num);
                        MdComm.SP_TRAN_FLAG = 0;

                        Console.WriteLine("###掘金开仓中信: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                             bean.code, Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss")
                             , tick.ask_p2, buy_num, RiskMng.getXhDesc(bean.xh_type));
                    }
                }
              

                //概念集合
                if (!JJUtil.dbGnsList.Contains(bean.gpInfo.gns))
                {
                    JJUtil.dbGnsList.Add(bean.gpInfo.gns);
                }

                //买入更新仓位
                GPUtil.updatePosition(1, bean.code, bean.xh_type, buy_num, tick.ask_p2, Convert.ToDateTime(tick.strtime), "0");

                //重新查询
                bean.positionDb = GPUtil.getPositionDb(bean.tick.sec_id);

                JJUtil.dblog(6, "掘金开仓:" + bean.code + ",价格:" + tick.ask_p2
                        + "数量:" + buy_num +
                        ",信号:" + RiskMng.getXhDesc(bean.xh_type)
                        , Convert.ToDateTime(tick.strtime));


                //更新买入次数
                bean.buy_cnt++;
                strateSta.buy_cnt++;

                Console.WriteLine("掘金开仓: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                   bean.code, Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss")
                   , tick.ask_p2, buy_num, RiskMng.getXhDesc(bean.xh_type));


                //指标详细信息
                if (MdComm.str_mode == 8)
                {
                    //买入交易                
                    OpenLong(tick.exchange, tick.sec_id, tick.last_price, buy_num);

                    HGStaUtil.insertGpZhiBiao(strateSta.dp, bean, 0);
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
            return;
        }

        #region 非主要事件

        /// <summary>
        /// 委托执行回报，订单的任何执行回报都会触发本事件，通过rpt可访问回报信息。
        /// </summary>
        /// <param name="rpt"></param>
        public override void OnExecRpt(ExecRpt rpt)
        {
            //if (MdComm.str_mode != 4 && MdComm.str_mode != 5 && MdComm.str_mode != 6)
            //{
            //    //Console.WriteLine(
            //    //"成交: 序号={0} price={1} amount={2} exec_type={3}",
            //    //rpt.cl_ord_id,
            //    //rpt.price,
            //    //rpt.amount,
            //    //rpt.exec_type);
            //}
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