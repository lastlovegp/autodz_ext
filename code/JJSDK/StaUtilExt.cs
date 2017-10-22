using GMSDK;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MdTZ
{
    class StaUtilEx
    {
     
        /// <summary>
        ///  1: 买入 -1: 卖出 0:观望
        /// </summary>
        /// <param name="flag"></param>
        public void setXhFlag(Bar bar,Dictionary<string, TranBean> tranBeanDic, int flag)
        {
            if (tranBeanDic.ContainsKey(bar.sec_id))
            {
                tranBeanDic[bar.sec_id].xh_flag = flag;
            }
        }

        /// <summary>
        /// 信号类型
        /// </summary>
        /// <param name="type"></param>
        public void setXhType(Bar bar, Dictionary<string, TranBean> tranBeanDic, int type)
        {
            if (tranBeanDic.ContainsKey(bar.sec_id))
            {
                tranBeanDic[bar.sec_id].xh_type = type;
            }
        }

        /// <summary>
        /// 获取当日可交易单位数（手数)
        /// </summary>
        /// <param name="curPos"></param>
        /// <returns></returns>
        public int getCanTranDws(Position curPos)
        {
            int can_tran_dw = 0; //可以交易单位
            if (curPos != null)
            {
                can_tran_dw = Convert.ToInt16((curPos.available - curPos.available_today) / 100);
            }

            return can_tran_dw;
        }

        public TranBean getTickTranBean(Strategy strategy, 
            Tick tick, Dictionary<string, TranBean> tranBeanDic, StrateSta strateSta)
        {
            TranBean bean = null;
            //获取指标信息
            if (HGStaUtil.DP_TICK_CODES.IndexOf(tick.sec_id) == -1)
            {
                bean = HGStaUtil.getTranBean(strategy, tranBeanDic, tick, strateSta);
            }
            else
            {
                //判断大盘趋势
            }

            return bean;
        }

        public bool getIsStrongSellFlag(Tick tick, Dictionary<string, BarTotal> barDic)
        {
            bool flag = false;
            if (barDic.ContainsKey(tick.sec_id))
            {
                flag = barDic[tick.sec_id].strong_sell_flag;
            }

            return flag;

        }

        public TranBean getTickBean(Bar bar, Dictionary<string, TranBean> tranBeanDic)
        {
            TranBean bean = null;
            //获取指标信息
            if (tranBeanDic.ContainsKey(bar.sec_id))
            {
                bean = tranBeanDic[bar.sec_id];
            }

            return bean;
        }

        /// <summary>
        /// 检查当天大盘分时趋势,10.20后的最高，最低比较
        /// </summary>
        /// <param name="total"></param>
        /// <param name="bar"></param>
        /// <param name="strateSta"></param>
        public void updTodayTimeQs(BarTotal total, Bar bar, StrateSta strateSta)
        {
            //判断大盘分时趋势
            double lowest_cg = Math.Abs(Math.Round(total.lastDailyBar.close - total.low, 2));
            double highest_cg = Math.Abs(Math.Round(total.high - total.lastDailyBar.close, 2));
            if (
                highest_cg > lowest_cg &&
                JJUtil.getDTime(total.highest_time) > JJUtil.getDTime(total.lowest_time))
            {
                if (HGStaUtil.DP_TICK_CODES.IndexOf(bar.sec_id) != -1)
                {
                    //大盘分时强1， 2（高开调高)
                    strateSta.dp_time_qs = 1;
                }

                total.gp_time_qs = 1;
            }
            else if (
               highest_cg < lowest_cg &&
               JJUtil.getDTime(total.highest_time) < JJUtil.getDTime(total.lowest_time))
            {
                total.gp_time_qs = -1;

                if (HGStaUtil.DP_TICK_CODES.IndexOf(bar.sec_id) != -1)
                {
                    //大盘分时强1， 2（高开调高)
                    strateSta.dp_time_qs = -1;
                }

                if (total.seq % 30 == 0 && MdComm.str_mode != 4 && MdComm.str_mode != 6)
                {
                    Console.WriteLine("分时弱势：{0} 时间: {1}", total.strong_sell_flag, bar.strtime);
                }
            }
        }


        public static void updTodayTimeQs(TranBean bean)
        {

            if (bean == null || String.IsNullOrEmpty(bean.highest_time) || String.IsNullOrEmpty(bean.lowest_time))
            {
                return;
            }

            //判断大盘分时趋势           
            if (
                JJUtil.getDTime(bean.highest_time) > JJUtil.getDTime(bean.lowest_time))
            {
                bean.gp_time_qs = 1;              
            }
            else if (
               JJUtil.getDTime(bean.highest_time) < JJUtil.getDTime(bean.lowest_time))
            {
                bean.gp_time_qs = -1;               
            }   
        
            if (bean.isDp && bean.tick.last_price < Math.Round(bean.high*(1-0.002),2)) 
            {
                bean.gp_time_qs = 0;
                if (bean.tick.last_price < Math.Round(bean.high * (1 - 0.004), 2))
                {
                    bean.gp_time_qs = -1;
                }
            }
           
        }
    

        /// <summary>
        /// bar 形态类型
        /// </summary>
        /// <param name="bar"></param>
        /// <returns></returns>
        public string getBarType(Bar bar)
        {

            string type = "";
            if (bar == null)
            {
                return type;
            }

            double z_cg = Math.Abs(bar.open - bar.close);

            if ((bar.close > bar.open) && (z_cg <= Math.Abs(bar.close - bar.high))
                || (bar.close < bar.open) && (z_cg <= Math.Abs(bar.open - bar.high)))
            {
                type = "syx";
            }
            else if ((bar.close > bar.open) && (z_cg <= Math.Abs(bar.open - bar.low))
                || (bar.close < bar.open) && (z_cg <= Math.Abs(bar.close - bar.low)))
            {
                type = "xyx";
            }

            return type;
        }

    }
}
