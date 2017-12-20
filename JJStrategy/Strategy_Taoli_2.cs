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
    class Strategy_Taoli_2 : Strategy
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
        /// 插入图形数据
        /// </summary>
        /// <param name="dp"></param>
        /// <param name="bean"></param>
        /// <param name="type"></param>
        public static void insertGpZhiBiao(TranBean dp, TranBean bean, int type)
        {

            if (bean.buyCodes != null && bean.buyCodes.Count > 0)
            {
                foreach (Tick t in bean.buyCodes)
                {
                    GPUtil.helper.ExecuteNonQuery("DELETE FROM gpzhibiao WHERE CODE = '"
                         + t.sec_id + "' and type=" + type + " AND DATE = '" + Convert.ToDateTime(t.strtime).ToString("yyyy-MM-dd") + "'");

                    String sql = "insert into gpzhibiao (code,type,zf5,zf10,zf30,rsi_6,rsi_12,rsi_24,"
                                + "tp_bar_num,syx_bar_num,pj_15_zhengfu,pj_30_zhengfu,fszb,fszb_ext,dp_rsi_6,dp_zf3,dp_zf,date) values ('"
                                + t.sec_id + "'," + type + ","
                                + bean.gpTotal.sum5Zf + ","
                                + bean.gpTotal.sum10Zf + ","
                                + bean.gpTotal.sum30Zf + ","
                                + bean.gpTotal.rsi6 + ","
                                + bean.gpTotal.rsi12 + ","
                                + bean.gpTotal.rsi24 + ","
                                + bean.gpTotal.tp_bar_num + ","
                                + bean.gpTotal.syx_bar_num + ","
                                + bean.gpTotal.pj_15_zhengfu + ","
                                + bean.gpTotal.pj_30_zhengfu + ","
                                + bean.fszb + ","
                                + bean.fszb_ext + ","
                                + dp.gpTotal.rsi6 + ","
                                + dp.gpTotal.sum3Zf + ","
                                + dp.zf + ",'"
                                + Convert.ToDateTime(bean.tick.strtime).ToString("yyyy-MM-dd") + "')";
                    GPUtil.helper.ExecuteNonQuery(sql);
                }
            }
            else
            {
                GPUtil.helper.ExecuteNonQuery("DELETE FROM gpzhibiao WHERE CODE = '"
                + bean.code + "' and type=" + type + " AND DATE = '" + Convert.ToDateTime(bean.tick.strtime).ToString("yyyy-MM-dd") + "'");

                String sql = "insert into gpzhibiao (code,type,zf5,zf10,zf30,rsi_6,rsi_12,rsi_24,"
                            + "tp_bar_num,syx_bar_num,pj_15_zhengfu,pj_30_zhengfu,fszb,fszb_ext,dp_rsi_6,dp_zf3,dp_zf,date) values ('"
                            + bean.code + "'," + type + ","
                            + bean.gpTotal.sum5Zf + ","
                            + bean.gpTotal.sum10Zf + ","
                            + bean.gpTotal.sum30Zf + ","
                            + bean.gpTotal.rsi6 + ","
                            + bean.gpTotal.rsi12 + ","
                            + bean.gpTotal.rsi24 + ","
                            + bean.gpTotal.tp_bar_num + ","
                            + bean.gpTotal.syx_bar_num + ","
                            + bean.gpTotal.pj_15_zhengfu + ","
                            + bean.gpTotal.pj_30_zhengfu + ","
                            + bean.fszb + ","
                            + bean.fszb_ext + ","
                            + dp.gpTotal.rsi6 + ","
                            + dp.gpTotal.sum3Zf + ","
                            + dp.zf + ",'"
                            + Convert.ToDateTime(bean.tick.strtime).ToString("yyyy-MM-dd") + "')";
                GPUtil.helper.ExecuteNonQuery(sql);
            }
            
        }      

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

            if (bean.isCYB && bean.zf > 0.18 && sta.is_dc ==1)
            {
                sta.is_dc = 0;
            }

            if (bean.isDp || bean.isCYB || bean.isZxp)
            {
                return false;
            }

            if (!bean.isDp && bean.gpInfo == null)
            {
                return false;
            }                
            #endregion            
                                     
            #region 中小创
            if (               
                bean.gpInfo != null && bean.gpTotal != null              
                && bean.buy_cnt == 0
                && !bean.gpInfo.gns.Equals("sz50")
                && sta.sz50 != null
                && sta.cyb != null
                && sta.dp != null
                && sta.is_dc == 0
                && HGStaUtil.getBarZF(sta.cyb.lastDailyBar) < 1.2
                && bean.tick.cum_amount > 0
                && (bean.positionDb == null || bean.positionDb.available == 0)
                && ((sta.cyb.zf > 0.18 && sta.sz50.zf < -0.1) || sta.dp.zf > 0.15)         
                && sta.sz50.zf < sta.cyb.zf                    
                && bean.gpTotal.sum3Zf < 5      
                && bean.gpTotal.sum2Zf < 4      
                && bean.gpTotal.sum30Zf < 20
                && bean.tick.last_price < bean.tick.high                
                && bean.gpTotal.rsi6 < 80 && bean.gpTotal.rsi12 < 80
                && HGStaUtil.getBarZF(bean.lastDailyBar) < 3
                && (bean.gpTotal.rsi6 > 60 ? HGStaUtil.getBarZF(bean.lastDailyBar) > -3 : true)
                && bean.zf > 1 && bean.zf < 2
                && bean.btime > 9.33 && bean.btime < 14.52
               )
            {
                bean.xh_type = GPConstants.XH_BUY_TL_1;
                return true;
            }
            #endregion

            #region 对冲
            if (
                bean.gpInfo != null && bean.gpTotal != null              
                && bean.gpInfo.gns.Equals("sz50")
                && bean.tick.cum_amount > 0                              
                && sta.sz50 != null && sta.cyb != null
                && sta.sz50.zf > 0.1
                && sta.cyb.zf < -0.18
                && bean.buy_cnt == 0
                && sta.sz50.zf > sta.cyb.zf        
                && bean.tick.last_price < bean.tick.high      
                && bean.zf > 0.5 && bean.zf < 1.5
                && bean.btime > 9.33 && bean.btime < 14.52
               )
            {
                bean.xh_type = GPConstants.XH_BUY_DC;
                sta.is_dc = 1;
                return true;
            }
            #endregion

            #region 补仓
            if (
                bean.gpInfo != null && bean.gpTotal != null
                && bean.buy_cnt == 0
                && bean.positionDb != null 
                && bean.positionDb.available > 0
                && bean.positionDb.available_today == 0
                && bean.tick.cum_amount > 0
                && sta.is_dc == (bean.gpInfo.gns.Equals("sz50") ?1:0)
                && bean.ykl < -4 && bean.ykl > -6
                && bean.zf < 0                
                && bean.btime > 14.30
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
            if (MdComm.str_mode == 2 && t_time.Hour == 9 && t_time.Minute < 30)
            {
                return;
            }

            //获取封装过的bean
            TranBean bean = null;
            try
            {
                bean = HGStaUtil.getTranBean(this, tranBeanDic, tick, strateSta);    
                //大盘指数的时候过滤掉
                if (MdComm.str_mode == 2 && (bean == null || bean.btime < 9.30 || bean.seq < 20 || bean.btime > 15.02))
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
            int sell_xh = 0;

            //初始化信号标志
            bean.xh_flag = 0;
            bean.xh_type = 0;

            #region 仓位初始化
            if (bean != null && bean.gpTotal != null && bean.gpInfo != null
                && !bean.isDp && !bean.isZxp && !bean.isSZ50 && !bean.isCYB)
            {                              
                //最小买入单位
                bean.gpTotal.minUnit = 1;

                if (String.IsNullOrEmpty(bean.buyCode))
                {
                    bean.buyCode = bean.code;
                }

                //本地仓库（数据库)           
                if (bean.gpInfo != null && bean.positionDb != null)
                {

                    //判断是否对冲
                    if (bean.gpInfo.gns.Equals("sz50") 
                        && bean.positionDb.available > 0 
                        && bean.positionDb.inxh == 21
                        && strateSta.cyb != null
                        && strateSta.cyb.zf < -0.18)
                    {
                        strateSta.is_dc = 1;
                    }
                    else if (bean.gpInfo.gns.Equals("sz50") && (bean.positionDb.available == 0 || bean.positionDb.inxh != 21))
                    {
                        strateSta.is_dc = 0;
                    }

                    sell_xh = bean.positionDb.inxh;                                   
                    if (bean.positionDb.vwap > 0)
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

            #region 平仓

            //平仓
            if (!bean.isDp && !bean.isCYB && !bean.isZxp
                && bean.positionDb != null 
                && bean.positionDb.can_tran_dw > 0
                && tick.last_price > 0
                && bean.buy_cnt == 0
                && bean.sell_cnt == 0)
            {

                //设置止盈止损               
                double zy = (bean.gpTotal.rsi12 <= 30 && bean.gpTotal.rsi6 <= 30) ? 3 : 1;
                double zs = -6;

                if (bean.gpInfo != null && !bean.gpInfo.gns.Equals("sz50") && strateSta.is_dc == 1)
                {
                    zy = (bean.gpTotal.rsi12 <= 30 && bean.gpTotal.rsi6 <= 30) ? 1.5 : 0;
                    zs = (bean.gpTotal.rsi12 <= 30 && bean.gpTotal.rsi6 <= 30) ? -5 : -1;
                }

                if (bean.gpInfo != null && !bean.gpInfo.gns.Equals("sz50") && bean.gpTotal.rsi6 > 50
                    && bean.positionDb.vwap >= bean.gpTotal.top_10_day && bean.ykl < -1)
                {
                    zy = 0;
                    zs = -1;
                }

                if (bean.gpInfo != null && bean.gpInfo.gns.Equals("sz50") && strateSta.is_dc == 0)
                {                   
                    zs = -2;
                }

                double zy_sellTime = 9.45;
                double zs_sellTime = 9.45;

                if (HGStaUtil.getBarZF(bean.lastDailyBar) > 9)
                {
                    zy_sellTime = 10.30;
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
                        if (MdComm.str_mode == 2 && MdComm.JJ_SP_FLAG == 1 && MdComm.TRAN_FALG == 1)
                        {
                            MdComm.SP_TRAN_FLAG = 1;
                            PAApi.sellOut(tick.sec_id, 0, 0);
                            MdComm.SP_TRAN_FLAG = 0;
                            //ZXApi.sellOut(tick.sec_id, THSAPI.PRICE_OPT_BUY_2, tick.bid_p2, THSAPI.NUM_OPT_ALL, 0);
                            //TXDApi.sellOut(tick.sec_id, 0);                                                                                                                           
                        }

                        //卖出交易
                        if (tick.exchange != null)
                        {
                            CloseLong(tick.exchange, tick.sec_id, tick.last_price, 300);
                        }

                        //导入1分钟BAR记录
                        if (MdComm.str_mode == 4)
                        {
                            //JJUtil.loadGpBarList(tick.sec_id, -1, Convert.ToDateTime(tick.strtime).AddMinutes(-30).ToString("yyyy-MM-dd HH:MM:ss")
                            // , Convert.ToDateTime(tick.strtime).AddMinutes(30).ToString("yyyy-MM-dd HH:MM:ss"));

                            insertGpZhiBiao(strateSta.dp, bean, 1);
                        }

                        //卖出更新仓位                   
                        GPUtil.updatePosition(-1, tick.sec_id, sell_xh, 300, tick.last_price, Convert.ToDateTime(tick.strtime),"0");                       

                        //头寸更新
                        if (bean.positionDb != null)
                        {
                            Console.WriteLine("卖出: {0},时间 {1} 买入 {2} 价格 {3} 数量 {4} 盈亏率 {5} 信号 {6}",
                                    tick.sec_id,
                                    Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss"),
                                    bean.positionDb.vwap, tick.bid_p2, bean.positionDb.can_tran_dw * 100, bean.ykl, RiskMng.getXhDesc(sell_xh));

                            JJUtil.dblog(5, "卖出:" + tick.sec_id + "成本价:"
                                + bean.positionDb.vwap + ",价格:" + tick.bid_p2 + " 数量:" + bean.positionDb.can_tran_dw * 100 + ",信号:" + RiskMng.getXhDesc(sell_xh)
                                , Convert.ToDateTime(tick.strtime));
                        }

                        //本地库
                        bean.positionDb = GPUtil.getPositionDb(bean.code);

                        //累计卖出次数
                        bean.sell_cnt++;                   
                    }

                }
            }
                     
            #endregion

            #region 开仓
            //开仓
            if (
                !bean.isDp && !bean.isCYB && !bean.isSZ50
                && isNeedOpenOrder(strateSta, bean, MdComm.TRAN_MODE)                            
                && bean.xh_type != 0
                && bean.buy_cnt < today_buy_cnt
                )
            {               
                //每个信号只能买入一个股票
                //if (GPUtil.buyList.Contains(bean.xh_type))
                //{
                //    return;
                //}

                GPUtil.buyList.Add(bean.xh_type);

                //实盘仓位数
                int buy_num = 300;
                if (bean.tick.last_price > 20)
                {
                    buy_num = 100;
                }

                #region 买入频率控制
                //实盘买入标志
                bool real_buy_flag = true;
                //暂时只卖价格低的
                if (MdComm.TRAN_MODE == GPConstants.TRAN_MODE_UN_TRAN)
                {
                    real_buy_flag = false;
                }

                //当天有卖出的不要买入了
                if (bean.positionDb != null && bean.positionDb.outdate != null
                       && Math.Abs(DateTimeHelper.DateDiff("day", Convert.ToDateTime(bean.strtime).Date, bean.positionDb.outdate.Date)) <= 1)
                {
                    return;
                }

                #endregion

                if (real_buy_flag && MdComm.JJ_SP_FLAG == 1 && MdComm.TRAN_FALG == 1 && GPUtil.STORE_GP_NUMS < 12 && GPUtil.JJ_BUY_CNT < 3)
                {
                    //限制每天买入2只
                    if (strateSta.buy_cnt > 3)
                    {
                        real_buy_flag = false;
                    }

                    lock (Locker2)
                    {
                        //ZXApi.buyIn(tick.sec_id, THSAPI.PRICE_OPT_SELL_2, tick.ask_p2, THSAPI.NUM_OPT_INPUT, 1 * 100);
                        //TXDApi.buyIn(tick.sec_id, buy_num);
                        MdComm.SP_TRAN_FLAG = 1;
                        PAApi.buyIn(bean.buyCode, 0, buy_num);
                        MdComm.SP_TRAN_FLAG = 0;

                        Console.WriteLine("###中信: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                             bean.buyCode, Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss")
                             , tick.ask_p2, buy_num, RiskMng.getXhDesc(bean.xh_type));
                    }
                }

                //买入交易                
                if (tick.exchange != null)
                {
                    OpenLong(tick.exchange, bean.buyCode, tick.ask_p2, buy_num);
                }

                //买入更新仓位
                GPUtil.updatePosition(1, bean.buyCode, bean.xh_type, buy_num, tick.ask_p2, Convert.ToDateTime(tick.strtime), "0");
                //重新查询
                bean.positionDb = GPUtil.getPositionDb(bean.buyCode);

                JJUtil.dblog(6, "开仓:" + bean.buyCode + ",价格:" + tick.ask_p2
                        + "数量:" + buy_num +
                        ",信号:" + RiskMng.getXhDesc(bean.xh_type)
                        , Convert.ToDateTime(tick.strtime));


                //更新买入次数
                bean.buy_cnt++;
                strateSta.buy_cnt++;

                Console.WriteLine("开仓: {0},时间 {1} 价格 {2} 数量 {3} 信号 {4}",
                   bean.buyCode, Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:MM:ss")
                   , tick.ask_p2, buy_num, RiskMng.getXhDesc(bean.xh_type));


                //指标详细信息
                if (MdComm.str_mode == 4)
                {
                    insertGpZhiBiao(strateSta.dp, bean, 0);
                    //JJUtil.loadGpBarList(tick.sec_id, 1, Convert.ToDateTime(tick.strtime).AddMinutes(-30).ToString("yyyy-MM-dd HH:MM:ss")
                    //    , Convert.ToDateTime(tick.strtime).AddMinutes(30).ToString("yyyy-MM-dd HH:MM:ss"));
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