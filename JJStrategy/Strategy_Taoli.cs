﻿using GMSDK;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace MdTZ
{
    /// <summary>
    /// 菲阿里四价策略
    /// </summary>
    class Strategy_Taoli : Strategy
    {

        #region 成员变量
        //标的tick状态
        public static Dictionary<string, TranBean> tranBeanDic = new Dictionary<string, TranBean>();

        //标的bar状态
        public Dictionary<string, BarTotal> barDic = new Dictionary<string, BarTotal>();

        //策略状态
        public static StrateSta strateSta = new StrateSta();

        public StaUtilEx Util = new StaUtilEx();      

        private Random ran = new Random();       

        public static readonly object Locker2 = new object();

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

            if (bean.isDp)
            {
                return;
            }

            //tick时间
            double btime = bean.btime;
            //快捷键
            String kjj = "";
            if (tick.sec_id.Equals("RB"))
            {
                kjj = "1";
            }
            else if (tick.sec_id.Equals("JM"))
            {
                kjj = "2";
            }
            else if (tick.sec_id.Equals("J"))
            {
                kjj = "3";
            }
            else if (tick.sec_id.Equals("I"))
            {
                kjj = "4";
            }
                  
            #region 仓位初始化
            if (bean != null && bean.gpTotal != null && bean.gpInfo != null)
            {                              
                //最小买入单位
                bean.gpTotal.minUnit = 1;

                //本地仓库（数据库)           
                if (bean.gpInfo != null && bean.positionDb != null && bean.positionDb.available > 0)
                {                                
                    if (bean.positionDb.vwap > 0 && tick.last_price > 0)
                    {
                        //盈亏率
                        if (bean.positionDb.inxh == 1)
                        {
                            bean.ykl = Math.Round((tick.last_price - bean.positionDb.vwap) / bean.positionDb.vwap * 100, 2);
                        } else if (bean.positionDb.inxh == 2) {
                            bean.ykl = Math.Round((bean.positionDb.vwap - tick.last_price) / tick.last_price * 100, 2);
                        }                        
                    }
                    else
                    {
                        bean.ykl = 0;
                    }
                }
            }
            #endregion

            #endregion           

            #region 止盈止损
            //止盈止损
            if ( bean.gpInfo != null              
                && bean.positionDb != null
                && bean.positionDb.available > 0
                && tick.exchange != null               
                && tick.last_price > 0  
                && bean.btime >= 9.05
                && bean.btime <= 14.58
                && bean.btime - bean.b_buy_time >= 0.5
                )
            {
                //设置止盈止损               
                double zy = 1;
                double zs = -1;

                if (bean.positionDb.inxh == 2
                 && bean.lastDailyBar.close >= bean.gpTotal.top_5_day
                 && bean.gpTotal.sum30Zf > 12)
                {
                    zs = -2;
                }

                if (bean.positionDb.inxh == 2
                   && bean.gpTotal.sum10Zf > 7
                   && bean.gpTotal.sum30Zf > 18)
                {
                    zs = -2;
                }
              
                bool default_zs = bean.ykl < zs;
                bool default_zy = bean.ykl > zy;
              
                //日内最后清仓
                if (bean.btime >= 14.55)
                {
                    default_zy = true;
                }

                if (bean.ykl >= 0.4 
                    && bean.lastDailyBar.close >= bean.gpTotal.top_5_day
                    && bean.gpTotal.sum30Zf > 10
                    && (bean.tick.high-bean.tick.last_price)/bean.tick.high * 100 >= 0.1)
                {
                    default_zy = true;
                }               
               
                //兜底的止损强制止益--保险丝
                if (default_zy || default_zs)
                {        
                    //卖出多仓
                    if (bean.positionDb.inxh == 1)
                    {
                        CloseLong(tick.exchange, tick.sec_id, tick.last_price, 1);
                    }
                    else
                    {
                        CloseShort(tick.exchange, tick.sec_id, tick.last_price, 1); 
                    }

                    if (MdComm.QH_SP_FLAG == 1)
                    {
                        lock (Locker2)
                        {
                            MdComm.SP_TRAN_FLAG = 1;                         
                            //if (bean.positionDb.inxh == 1)
                            //{
                            //    PAQHApi.xiadan(kjj, "d", "s");
                            //}
                            //else
                            //{
                            //    PAQHApi.xiadan(kjj, "k", "s");
                            //}
                            MdComm.SP_TRAN_FLAG = 0;
                            Console.WriteLine("###掘金开仓期货: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                                 bean.buyCode, Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss")
                                 , tick.ask_p2, 1, RiskMng.getXhDesc(bean.xh_type));
                        }
                    }     

                    //卖出更新仓位                   
                    GPUtil.updatePosition(-1, tick.sec_id, bean.positionDb.inxh, 1, tick.last_price, Convert.ToDateTime(tick.strtime), "0");  
                                                                             
                    //头寸更新
                    if (bean.positionDb != null)
                    {                       
                        Console.WriteLine("卖出: {0},时间 {1} 买入 {2} 价格 {3} 数量 {4} 盈亏率 {5} 信号 {6}",
                                tick.sec_id,
                                Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss"),
                                bean.positionDb.vwap, tick.bid_p2, bean.positionDb.can_tran_dw, bean.ykl, "止盈止损");

                        if (MdComm.str_mode == 2 )
                        {
                            JJUtil.dblog(5, "掘金卖出:" + tick.sec_id + "成本价:"
                               + bean.positionDb.vwap + ",价格:" + tick.bid_p2 + " 数量:" + bean.positionDb.can_tran_dw + ",信号:止盈止损"
                               , Convert.ToDateTime(tick.strtime));
                        }                       
                    }

                    //指标详细信息
                    if (MdComm.str_mode == 4 && bean.sell_cnt == 0)
                    {
                        HGStaUtil.insertGpZhiBiao(strateSta.dp, bean, 1);

                        if (bean.ykl < 0)
                        {
                            JJUtil.loadGpBarList(tick.exchange + "." + tick.sec_id, 1, Convert.ToDateTime(tick.strtime).AddMinutes(-500).ToString("yyyy-MM-dd HH:MM:ss")
                                , Convert.ToDateTime(tick.strtime).AddMinutes(500).ToString("yyyy-MM-dd HH:MM:ss"));
                        }
                        
                    }

                    //本地库
                    bean.positionDb = GPUtil.getPositionDb(bean.code);

                    //累计卖出次数
                    bean.sell_cnt++;

                    #region 反手做空
                    if (bean.positionDb.inxh == 1
                        && bean.lastDailyBar.close >= bean.gpTotal.top_3_day
                        && bean.gpTotal.sum30Zf > 10
                        && bean.btime <= 14.10
                        && default_zs)
                    {
                        bean.buy_cnt = 0;
                        bean.sell_cnt = 0;

                        //开空单                       
                        OpenShort(tick.exchange, tick.sec_id, tick.last_price, 1);

                        if (MdComm.QH_SP_FLAG == 1)
                        {
                            lock (Locker2)
                            {
                                MdComm.SP_TRAN_FLAG = 1;
                                //PAQHApi.xiadan(kjj, "k", "b");
                                MdComm.SP_TRAN_FLAG = 0;
                                Console.WriteLine("###掘金开仓期货: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                                     bean.buyCode, Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss")
                                     , tick.ask_p2, 1, RiskMng.getXhDesc(bean.xh_type));
                            }
                        }

                        //买入更新仓位
                        GPUtil.updatePosition(1, tick.sec_id, 2, 1, tick.last_price, Convert.ToDateTime(tick.strtime), "0");

                        //重新查询
                        bean.positionDb = GPUtil.getPositionDb(bean.tick.sec_id);

                        //更新买入次数
                        bean.buy_cnt++;
                        bean.b_buy_time = bean.btime;
                        strateSta.buy_cnt++;                       

                        Console.WriteLine("掘金开仓: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                             tick.sec_id, Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss")
                             , tick.last_price, 1, "卖出开仓");

                    }
                    #endregion

                }
              
            }
                     
            #endregion

            #region 开仓
            //开仓
            if (bean.tick.last_price > 0
                && (bean.positionDb == null || bean.positionDb.available ==0)
                && bean.lastDailyBar != null && tick.exchange != null
                && bean.btime >= 9.03
                && bean.btime <= 14.30
                )
            {                                 
                //实盘仓位数
                int buy_num = 1;
                double zrzf = HGStaUtil.getBarZF(bean.lastDailyBar);
                double sk = bean.lastDailyBar.high; //上轨＝昨日高点
                if (zrzf > -0.5 && zrzf < 0.5                    
                    && bean.lastDailyBar.close <= bean.gpTotal.low_5_day
                )
                {
                    sk = bean.lastDailyBar.close;
                }

                double xk = bean.lastDailyBar.low; //下轨＝昨日低点
                double openZf = (tick.open - bean.lastDailyBar.close) / bean.lastDailyBar.close * 100;

                //当价格突破上轨，买入开仓               
                if (tick.last_price > sk
                    && tick.last_price < tick.high                   
                    && bean.buy_cnt == 0
                    && bean.gpTotal != null
                    && bean.gpTotal.sum30Zf < 14
                    && bean.btime >= (bean.tick.last_price > bean.gpTotal.top_5_day && bean.gpTotal.sum30Zf > 10 ? 11.10 : 9.03)
                    && bean.btime >= (bean.tick.last_price > bean.gpTotal.top_5_day && bean.gpTotal.sum30Zf >= 7 ? 9.30 : 9.03)
                    && (bean.tick.last_price - bean.lastDailyBar.high) / bean.lastDailyBar.high * 100 < 0.4
                    && openZf < 0.15)
                {                    
                    //买多
                    OpenLong(tick.exchange, tick.sec_id, tick.last_price, buy_num);

                    if (MdComm.QH_SP_FLAG == 1)
                    {
                        lock (Locker2)
                        {                            
                            MdComm.SP_TRAN_FLAG = 1;
                            //PAQHApi.xiadan(kjj, "d", "b");                          
                            MdComm.SP_TRAN_FLAG = 0;

                            Console.WriteLine("###掘金开仓期货: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                                 bean.buyCode, Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss")
                                 , tick.ask_p2, 1, RiskMng.getXhDesc(bean.xh_type));
                        }
                    }

                    //买入更新仓位
                    GPUtil.updatePosition(1, tick.sec_id, 1, buy_num, tick.last_price, Convert.ToDateTime(tick.strtime), "0");

                    //重新查询
                    bean.positionDb = GPUtil.getPositionDb(bean.tick.sec_id);                    
                    
                    //更新买入次数
                    bean.buy_cnt++;
                    bean.b_buy_time = bean.btime;     
                    strateSta.buy_cnt++;

                    if (MdComm.str_mode == 4)
                    {
                        HGStaUtil.insertGpZhiBiao(strateSta.dp, bean, 0);                       
                    }
                   
                    Console.WriteLine("掘金开仓: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                                tick.sec_id, Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:mm:ss")
                                , tick.last_price, 1, "买入开仓");
                                                       

                }
                else if (tick.last_price < xk 
                    && tick.last_price > tick.low  
                    && bean.buy_cnt == 0
                    && bean.btime >= 9.30                    
                    && (bean.lastDailyBar.low - bean.tick.last_price) / bean.lastDailyBar.low * 100 < 0.4
                    && openZf > -0.15) //当价格跌穿下轨，卖出开仓
                {                    
                    //开空
                    OpenShort(tick.exchange, tick.sec_id, tick.last_price, buy_num);

                    if (MdComm.QH_SP_FLAG == 1)
                    {
                        lock (Locker2)
                        {
                            MdComm.SP_TRAN_FLAG = 1;
                            //PAQHApi.xiadan(kjj, "k", "b");
                            MdComm.SP_TRAN_FLAG = 0;
                            Console.WriteLine("###掘金开仓期货: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                                 bean.buyCode, Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss")
                                 , tick.ask_p2, buy_num, RiskMng.getXhDesc(bean.xh_type));
                        }
                    }

                    //买入更新仓位
                    GPUtil.updatePosition(1, tick.sec_id, 2, buy_num, tick.last_price, Convert.ToDateTime(tick.strtime), "0");

                    //重新查询
                    bean.positionDb = GPUtil.getPositionDb(bean.tick.sec_id);                  
                   
                    //更新买入次数
                    bean.buy_cnt++;
                    bean.b_buy_time = bean.btime;       
                    strateSta.buy_cnt++;

                    if (MdComm.str_mode == 4)
                    {
                        HGStaUtil.insertGpZhiBiao(strateSta.dp, bean, 0);                        
                    }

                    Console.WriteLine("掘金开仓: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                         tick.sec_id, Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss")
                         , tick.last_price, buy_num, "卖出开仓");         
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

            if (1 == 1)
            {
                return;
            }
           
            #region 策略初始化
            //时间控制下
            DateTime t_time = Convert.ToDateTime(bar.strtime);

            //获取封装过的bean
            BarTotal bean = null;
            try
            {
                 bean = HGStaUtil.getBarTotal(this, barDic, bar, strateSta);
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

            if (bean.isDp)
            {
                return;
            }

            //tick时间
            double btime = bean.btime;
            //快捷键
            String kjj = "";
            if (bar.sec_id.Equals("RB"))
            {
                kjj = "1";
            }
            else if (bar.sec_id.Equals("JM"))
            {
                kjj = "2";
            }
            else if (bar.sec_id.Equals("J"))
            {
                kjj = "3";
            }
            else if (bar.sec_id.Equals("I"))
            {
                kjj = "4";
            }

            #region 仓位初始化
            if (bean != null && bean.gpTotal != null)
            {
                //最小买入单位
                bean.gpTotal.minUnit = 1;

                //本地仓库（数据库)           
                if (bean.positionDb != null && bean.positionDb.available > 0)
                {
                    if (bean.positionDb.vwap > 0 && bar.close > 0)
                    {
                        //盈亏率
                        if (bean.positionDb.inxh == 1)
                        {
                            bean.ykl = Math.Round((bar.close - bean.positionDb.vwap) / bean.positionDb.vwap * 100, 2);
                        }
                        else if (bean.positionDb.inxh == 2)
                        {
                            bean.ykl = Math.Round((bean.positionDb.vwap - bar.close) / bar.close * 100, 2);
                        }
                    }
                    else
                    {
                        bean.ykl = 0;
                    }
                }
            }
            #endregion

            #endregion

            #region 止盈止损
            //止盈止损
            if (bean.positionDb != null
                && bean.positionDb.available > 0
                && bar.exchange != null
                && bar.close > 0
                && bean.btime >= 9.05
                && bean.btime <= 15.00                
                )
            {
                //设置止盈止损               
                double zy = 1;
                double zs = -1;

                if (bean.positionDb.inxh == 2
                 && bean.lastDailyBar.close >= bean.gpTotal.top_5_day
                 && bean.gpTotal.sum30Zf > 12)
                {
                    zs = -2;
                }

                bool default_zs = bean.ykl < zs;
                bool default_zy = bean.ykl > zy;

                //日内最后清仓
                if (bean.btime >= 14.55)
                {
                    default_zy = true;
                }

                if (bean.ykl >= 0.4
                    && bean.lastDailyBar.close >= bean.gpTotal.top_5_day
                    && bean.gpTotal.sum30Zf > 10
                    && (bar.high - bar.close) / bar.high * 100 >= 0.1)
                {
                    default_zy = true;
                }

                //兜底的止损强制止益--保险丝
                if (default_zy || default_zs)
                {
                    //卖出多仓
                    if (bean.positionDb.inxh == 1)
                    {
                        CloseLong(bar.exchange, bar.sec_id, bar.close, 1);
                    }
                    else
                    {
                        CloseShort(bar.exchange, bar.sec_id, bar.close, 1);
                    }             

                    //卖出更新仓位                   
                    GPUtil.updatePosition(-1, bar.sec_id, bean.positionDb.inxh, 1, bar.close, Convert.ToDateTime(bar.strtime), "0");

                    //头寸更新
                    if (bean.positionDb != null)
                    {
                        Console.WriteLine("卖出: {0},时间 {1} 买入 {2} 价格 {3} 数量 {4} 盈亏率 {5} 信号 {6}",
                                bar.sec_id,
                                Convert.ToDateTime(bar.strtime).ToString("yyyy-MM-dd HH:MM:ss"),
                                bean.positionDb.vwap, bar.close, bean.positionDb.can_tran_dw, bean.ykl, "止盈止损");

                        if (MdComm.str_mode == 2)
                        {
                            JJUtil.dblog(5, "掘金卖出:" + bar.sec_id + "成本价:"
                               + bean.positionDb.vwap + ",价格:" + bar.close + " 数量:" + bean.positionDb.can_tran_dw + ",信号:止盈止损"
                               , Convert.ToDateTime(bar.strtime));
                        }
                    }

                    //指标详细信息
                    if (MdComm.str_mode == 4 && bean.sell_cnt == 0)
                    {                       
                        if (bean.ykl < 0)
                        {
                            JJUtil.loadGpBarList(bar.exchange + "." + bar.sec_id, 1, Convert.ToDateTime(bar.strtime).AddMinutes(-500).ToString("yyyy-MM-dd HH:MM:ss")
                                , Convert.ToDateTime(bar.strtime).AddMinutes(500).ToString("yyyy-MM-dd HH:MM:ss"));
                        }

                    }

                    //本地库
                    bean.positionDb = GPUtil.getPositionDb(bean.code);

                    //累计卖出次数
                    bean.sell_cnt++;

                    #region 反手做空
                    if (bean.positionDb.inxh == 1
                        && bean.lastDailyBar.close >= bean.gpTotal.top_3_day
                        && bean.gpTotal.sum30Zf > 10
                        && bean.btime <= 14.10
                        && default_zs)
                    {
                        bean.buy_cnt = 0;
                        bean.sell_cnt = 0;

                        //开空单                       
                        OpenShort(bar.exchange, bar.sec_id, bar.close, 1);

                        //买入更新仓位
                        GPUtil.updatePosition(1, bar.sec_id, 2, 1, bar.close, Convert.ToDateTime(bar.strtime), "0");

                        //重新查询
                        bean.positionDb = GPUtil.getPositionDb(bar.sec_id);

                        //更新买入次数
                        bean.buy_cnt++;                        
                        strateSta.buy_cnt++;

                        Console.WriteLine("掘金开仓: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                             bar.sec_id, Convert.ToDateTime(bar.strtime).ToString("yyyy-MM-dd HH:MM:ss")
                             , bar.close, 1, "卖出开仓");

                    }
                    #endregion

                }

            }

            #endregion

            #region 开仓
            //开仓
            if (bar.close > 0
                && (bean.positionDb == null || bean.positionDb.available == 0)
                && bean.lastDailyBar != null && bar.exchange != null
                && bean.btime >= 9.03
                && bean.btime <= 14.30
                )
            {
                //实盘仓位数
                int buy_num = 1;
                double zrzf = HGStaUtil.getBarZF(bean.lastDailyBar);
                double sk = bean.lastDailyBar.high; //上轨＝昨日高点
                if (zrzf > -0.5 && zrzf < 0.5
                    && bean.lastDailyBar.close <= bean.gpTotal.low_5_day
                )
                {
                    sk = bean.lastDailyBar.close;
                }

                double xk = bean.lastDailyBar.low; //下轨＝昨日低点
                double openZf = (bar.open - bean.lastDailyBar.close) / bean.lastDailyBar.close * 100;

                //当价格突破上轨，买入开仓               
                if (bar.close > sk
                    && bar.close < bar.high
                    && bean.buy_cnt == 0
                    && bean.gpTotal != null
                    && bean.gpTotal.sum30Zf < 14
                    && bean.btime >= (bar.close > bean.gpTotal.top_5_day && bean.gpTotal.sum30Zf > 10 ? 11.10 : 9.03)
                    && bean.btime >= (bar.close > bean.gpTotal.top_5_day && bean.gpTotal.sum30Zf >= 7 ? 9.30 : 9.03)
                    && (bar.close - bean.lastDailyBar.high) / bean.lastDailyBar.high * 100 < 0.4
                    && openZf < 0.15)
                {
                    //买多
                    OpenLong(bar.exchange, bar.sec_id, bar.close, buy_num);

                    //买入更新仓位
                    GPUtil.updatePosition(1, bar.sec_id, 1, buy_num, bar.close, Convert.ToDateTime(bar.strtime), "0");

                    //重新查询
                    bean.positionDb = GPUtil.getPositionDb(bar.sec_id);

                    //更新买入次数
                    bean.buy_cnt++;                    
                    strateSta.buy_cnt++;

                    Console.WriteLine("掘金开仓: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                                bar.sec_id, Convert.ToDateTime(bar.strtime).ToString("yyyy-MM-dd HH:mm:ss")
                                , bar.close, 1, "买入开仓");


                }
                else if (bar.close < xk
                    && bar.close > bar.low
                    && bean.buy_cnt == 0
                    && bean.btime >= 9.30
                    && (bean.lastDailyBar.low - bar.close) / bean.lastDailyBar.low * 100 < 0.4
                    && openZf > -0.15) //当价格跌穿下轨，卖出开仓
                {
                    //开空
                    OpenShort(bar.exchange, bar.sec_id, bar.close, buy_num);

                    //买入更新仓位
                    GPUtil.updatePosition(1, bar.sec_id, 2, buy_num, bar.close, Convert.ToDateTime(bar.strtime), "0");

                    //重新查询
                    bean.positionDb = GPUtil.getPositionDb(bar.sec_id);

                    //更新买入次数
                    bean.buy_cnt++;                    
                    strateSta.buy_cnt++;

                    Console.WriteLine("掘金开仓: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                         bar.sec_id, Convert.ToDateTime(bar.strtime).ToString("yyyy-MM-dd HH:MM:ss")
                         , bar.close, buy_num, "卖出开仓");
                }

            }
            #endregion
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