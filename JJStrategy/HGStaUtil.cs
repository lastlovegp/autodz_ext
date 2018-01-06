using GMSDK;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace MdTZ
{
    /// <summary>
    /// 海龟策略工具类
    /// </summary>
    class HGStaUtil
    {
        #region 常量定义
        //股票统计信息
        public static Dictionary<string, GpTotal> gpTotalDic = new Dictionary<string, GpTotal>();
        public static Dictionary<string, PositionDb> checkGpDic = new Dictionary<string, PositionDb>();
        public static Dictionary<string, Hy> hyDic = new Dictionary<string, Hy>();
        public static Dictionary<string, Hot> hotDic = new Dictionary<string, Hot>();


        public static Dictionary<string, Hy5> hy5Dic = new Dictionary<string, Hy5>();
        public static Dictionary<string, Hot5> hot5Dic = new Dictionary<string, Hot5>();

        public static List<String> hyTop6 = new List<String>();
        public static List<String> hotTop6 = new List<String>();

        public const string GP_TYPE_BUY = "b";
        public const string GP_TYPE_SELL = "s";

        //大盘编号
        //public const string DP_CODES = "sh000001,sz399001,sz399006,sh000016";
        public const string DP_CODES = "sh000001";
        public const string DP_TICK_CODES = "000001";
        public const string SZ_JJ_CODE = "SHSE.000001";

        public static bool isTraning = false;

       
       

        #endregion

        /// <summary>
        /// 初始化交易股票清单
        /// </summary>
        /// <param name="codes"></param>
        public static void initTotalBean(Strategy str, string codes, string btime, string etime)
        {

            string codesAll = codes;          
            string jjCode = "";
            string sec_id = "";

            //DataRow strRow = GPUtil.helper.ExecuteDataRow("SELECT GROUP_CONCAT(DISTINCT CODE) gpcodes FROM gpsel WHERE zbflag = 0", GPUtil.parms);           ;
            //if (strRow != null)
            //{
            //    codesAll += "," + strRow["gpcodes"].ToString();
            //}           

            foreach (string code in codesAll.Split(",".ToCharArray()))
            {
                if (String.IsNullOrEmpty(code))
                {
                    continue;
                }
                jjCode = MdComm.getJJCode(code);

                sec_id = loadGpTotalList(str,jjCode, btime, etime);
                                    
            }

            Console.WriteLine("gpTotalDic.count {0}", gpTotalDic.Count);

        }
  
        /// <summary>
        /// 是否上证大盘
        /// </summary>
        /// <param name="tick"></param>
        /// <returns></returns>
        public static bool isSHTick(Tick tick)
        {
            if (tick == null)
            {
                return false;
            }

            if (tick.sec_id.Equals("000001"))
            {
                return true;
            }

            return false;
        }

        /// <summary>        
        /// 涨幅
        /// </summary>
        /// <param name="gp"></param>
        /// <returns></returns>
        public static double getTickZF(Tick gp)
        {
            if (gp.pre_close > 0)
            {
                return Math.Round(((gp.last_price - gp.pre_close) / gp.pre_close) * 100, 2); //涨幅
            }

            return 0;
        }

        public static double getBarZF(DailyBar gp)
        {
            if (gp != null && gp.pre_close > 0)
            {
                return Math.Round(((gp.close - gp.pre_close) / gp.pre_close) * 100, 2); //涨幅
            }

            return 0;
        }

        public static double getBarZF(Bar gp)
        {
            if (gp != null && gp.pre_close > 0)
            {
                return Math.Round(((gp.close - gp.pre_close) / gp.pre_close) * 100, 2); //涨幅
            }

            return 0;
        }

        /// <summary>        
        /// 上次买入后的涨幅
        /// </summary>
        /// <param name="gp"></param>
        /// <returns></returns>
        public static double getTickZFFrmLastBuy(Tick gp, double lastBuy)
        {
            if (lastBuy > 0)
            {
                return Math.Round(((gp.last_price - lastBuy) / lastBuy) * 100, 2); //涨幅
            }

            return 0;
        }

        /// <summary>
        /// 加载一个月的日历史数据
        /// </summary>
        /// <param name="symbol_list"></param>
        public static string loadGpTotalList(Strategy str, string symbol_list
             )
        {
            return loadGpTotalList(str, symbol_list, GPUtil.nowTranDate.AddMonths(-2).ToShortDateString(), GPUtil.nowTranDate.ToShortDateString());

        }

        public static string getSubscribeCodes()
        {
             DataRow strRow = GPUtil.helper.ExecuteDataRow("SELECT strcode,strname,gpcodes FROM stratey where flag=1", GPUtil.parms);
             String codes = "";
             string subscribe_symbols = "";   
             if (strRow != null)
             {
                 codes = strRow["gpcodes"].ToString();
                 codes = HGStaUtil.DP_CODES + "," + codes;
                          
                 List<string> codeList = codes.Split(",".ToCharArray()).ToList();
                 foreach (string c in codeList)
                 {                     
                     subscribe_symbols += MdComm.getJJCfgCode(c, "tick", "bar.60") + ",";                     
                 }
             }

             return subscribe_symbols;
        }

        public static List<String> getHotGn()
        {
            DataTable tables = GPUtil.helper.ExecuteDataTable("SELECT gn FROM 热点最大", GPUtil.parms);
            List<String> gns = new List<string>();           
            if (tables != null)
            {

                foreach (DataRow r in tables.Rows)
                {
                    gns.Add(r["gn"].ToString());
                }
            }

            return gns;
        }

        public static string loadGpTotalList(string symbol_list, string btime, string etime
            )
        {
            return loadGpTotalList(null, symbol_list, Convert.ToDateTime(btime).AddMonths(-2).ToString("yyyy-MM-dd HH:MM:ss"), etime);           
        }

        public static string formatTime(string time)
        {
            if (string.IsNullOrEmpty(time))
            {
                return "";
            }
            else
            {
                return Convert.ToDateTime(time).ToString("yyyy-MM-dd HH:MM:ss");
            }
        }

        public static double getTr(DailyBar bar)
        {
            double tr = Math.Max(bar.high - bar.low, Math.Abs(bar.pre_close - bar.high));
            tr = Math.Max(tr, Math.Abs(bar.pre_close - bar.low));
            return tr;
        }

        private static double getTr(Tick tick)
        {
            double tr = Math.Max(tick.high - tick.low, Math.Abs(tick.pre_close - tick.high));
            tr = Math.Max(tr, Math.Abs(tick.pre_close - tick.low));
            return tr;
        }

        public static string loadGpTotalList(Strategy str, string symbol_list,
               TranBean tick)
        {
            List<DailyBar> barList = null;

            if (MdComm.md == null)
            {
                MdComm.initMd();
            }

            //大盘指数           
            if (HGStaUtil.DP_TICK_CODES.IndexOf(symbol_list.Replace("SHSE.","").Replace("SHSE.","")) != -1)
            {
                tick.isDp = true;
            }

            string begin_time = Convert.ToDateTime(tick.strtime).AddMonths(-5).ToString("yyyy-MM-dd HH:MM:ss");
            string end_time = Convert.ToDateTime(tick.strtime).AddDays(-1).ToString("yyyy-MM-dd HH:MM:ss");
            barList = MdComm.md.GetDailyBars(symbol_list, begin_time, end_time);
            if (barList.Count < 150)
            {
                begin_time = Convert.ToDateTime(begin_time).AddMonths(-7).ToString("yyyy-MM-dd HH:MM:ss");
                barList = MdComm.md.GetDailyBars(symbol_list, begin_time, end_time);
            }

            int cnt = 0;
            int pre_cnt = 0;
            int qt_cnt = 0;
            double zhengf = 0;
            double sum_zhengf = 0;

            double sumPrice = 0;
            double pre_sumPrice = 0;
            double qt_sumPrice = 0;                                 

            double tr = 0;
            double atr = 0;
            double zf = 0;
            double pre_zf = 0;

            string kstr = "";
            DailyBar bar = null;
            GpTotal total = new GpTotal();
            GpTotal pre_total = new GpTotal();
            GpTotal qt_total = new GpTotal();         

            double top_5_price = 0;          
            double low_5_price = 0;

            double low_cjl = 0;          
            double sum_zf = 0;
            double sum_abs_zf = 0;

            double sum_rsi_zf = tick.zf > 0 ? tick.zf : 0;
            double sum_rsi_df = tick.zf < 0 ? Math.Abs(tick.zf) : 0;

            //double ema10 = 0;         
            //double ema10_zr = 0;        
            //double ema10_qr = 0;
            //double pre_ema10 = 0;

            DateTime top_5_price_date = Convert.ToDateTime(begin_time);
            DateTime low_5_price_date = Convert.ToDateTime(begin_time);

            List<DailyBar> emaList = new List<DailyBar>();
            for (int i = barList.Count - 1; i >= 0; i--)
            {
                cnt++;

                if (cnt >= 180)
                {
                    break;
                }
                
                bar = barList[i];
                total.code = bar.sec_id;
                tr = getTr(bar);
                zf = getBarZF(bar);
                if (bar.low!= 0)
                {
                    zhengf = Math.Round(((bar.high - bar.low) / bar.low) * 100, 4);
                    sum_zhengf += zhengf;
                }              

                sumPrice += bar.close;

                if (cnt > 1)
                {
                    pre_cnt++;
                    pre_sumPrice += bar.close;

                    if (cnt > 2)
                    {
                        qt_cnt++;
                        qt_sumPrice += bar.close;
                    }    
                }                    
               
                sum_zf += zf;
                sum_abs_zf += Math.Abs(zf);

                sum_rsi_zf += (zf > 0 ? zf : 0);
                sum_rsi_df += (zf < 0 ? Math.Abs(zf) : 0);

                atr += tr;
                kstr += getZfStr(bar.sec_id,zf);

                top_5_price = top_5_price > bar.close ? top_5_price : bar.close;
                top_5_price_date = top_5_price > bar.close ? top_5_price_date : Convert.ToDateTime(bar.strtime);

                //是否大盘           
                //非大盘时候
                if (tick.isDp)
                {
                    low_cjl = (low_cjl > 0 && low_cjl < Math.Round(bar.amount / 100000000, 2)) ? low_cjl : Math.Round(bar.amount / 100000000, 2);
                }
                else
                {
                    low_cjl = (low_cjl > 0 && low_cjl < Math.Round(bar.amount, 2)) ? low_cjl : Math.Round(bar.amount, 2);
                }
                
                low_5_price = (low_5_price > 0 && low_5_price < bar.close) ? low_5_price : bar.close;
                low_5_price_date = (low_5_price > 0 && low_5_price < bar.close) ? low_5_price_date : Convert.ToDateTime(bar.strtime);


                //记录涨停到现在天数
                if (total.zt_bar_num <= 0 && zf > 8)
                {
                    total.zt_bar_num = cnt;
                }

                //突破到现在天数
                if (total.tp_bar_num <= 0 && zf > 3.2)
                {
                    total.tp_bar_num = cnt;
                    total.last_tp_open = bar.open;
                }

                //记录跌停到现在天数
                if (total.dt_bar_num == 0 && zf < (bar.sec_id.Equals("RB") ? -1.5 : -2))
                {
                    total.dt_bar_num = cnt;
                }

                //记录跌停到现在天数
                if (total.dt_max_bar_num == 0 && zf < -5)
                {
                    total.dt_max_bar_num = cnt;
                }

                //上长影线到现在天数
                if (total.syx_bar_num == 0 && Math.Round((bar.high - bar.low) / bar.low, 2) > 0.02 
                    && (bar.high - (bar.close + bar.open) / 2) > ((bar.close + bar.open) / 2 - bar.low) * 2)
                {
                    total.syx_bar_num = cnt;
                }

                //下长影线到现在天数
                if ("000001,399001,399006".IndexOf(bar.sec_id) == -1
                    && total.xyx_bar_num == 0
                    && (bar.high - (bar.close + bar.open) / 2) < ((bar.close + bar.open) / 2 - bar.low) * 0.5)
                {
                    total.xyx_bar_num = cnt;
                }

                #region EMA10日计算
                ////当日
                //if (cnt == 1)
                //{
                //    emaList = MdComm.md.GetDailyBars(symbol_list, Convert.ToDateTime(bar.strtime).AddMonths(-5).ToString("yyyy-MM-dd HH:MM:ss")
                //            , Convert.ToDateTime(bar.strtime).ToString("yyyy-MM-dd HH:MM:ss"));
                //    if (barList.Count < 10)
                //    {
                //        emaList = MdComm.md.GetDailyBars(symbol_list, Convert.ToDateTime(bar.strtime).AddMonths(-7).ToString("yyyy-MM-dd HH:MM:ss")
                //            , Convert.ToDateTime(bar.strtime).ToString("yyyy-MM-dd HH:MM:ss"));
                //    }

                //    if (emaList.Count >= 10)
                //    {
                //        int i1 = 0;
                //        for (int i0 = emaList.Count - 10; i0 < emaList.Count; i0++)
                //        {
                //            i1++;
                //            if (i1 == 1)
                //            {
                //                ema10 = emaList[i0].close;
                //            }
                //            else
                //            {
                //                ema10 = (emaList[i0].close * 2 + pre_ema10 * (i1 - 1)) / (i1 + 1);
                //            }

                //            pre_ema10 = ema10;
                //        }

                //        //指数平均
                //        total.ema10 = Math.Round(ema10, 2);
                //    }

                //}

                ////昨日
                //if (pre_cnt == 1)
                //{
                //    emaList = MdComm.md.GetDailyBars(symbol_list, Convert.ToDateTime(bar.strtime).AddMonths(-5).ToString("yyyy-MM-dd HH:MM:ss")
                //             , Convert.ToDateTime(bar.strtime).ToString("yyyy-MM-dd HH:MM:ss"));
                //    if (barList.Count < 10)
                //    {
                //        emaList = MdComm.md.GetDailyBars(symbol_list, Convert.ToDateTime(bar.strtime).AddMonths(-7).ToString("yyyy-MM-dd HH:MM:ss")
                //            , Convert.ToDateTime(bar.strtime).ToString("yyyy-MM-dd HH:MM:ss"));
                //    }

                //    if (emaList.Count >= 10)
                //    {
                //        int i1 = 0;
                //        for (int i0 = emaList.Count - 10; i0 < emaList.Count; i0++)
                //        {
                //            i1++;
                //            if (i1 == 1)
                //            {
                //                ema10_zr = emaList[i0].close;
                //            }
                //            else
                //            {
                //                ema10_zr = (emaList[i0].close * 2 + pre_ema10 * (i1 - 1)) / (i1 + 1);
                //            }

                //            pre_ema10 = ema10_zr;
                //        }

                //        //指数平均
                //        pre_total.ema10 = Math.Round(ema10_zr, 2);
                //    }

                //}

                ////前日
                //if (qt_cnt == 1)
                //{
                //    emaList = MdComm.md.GetDailyBars(symbol_list, Convert.ToDateTime(bar.strtime).AddMonths(-5).ToString("yyyy-MM-dd HH:MM:ss")
                //              , Convert.ToDateTime(bar.strtime).ToString("yyyy-MM-dd HH:MM:ss"));

                //    if (barList.Count < 10)
                //    {
                //        emaList = MdComm.md.GetDailyBars(symbol_list, Convert.ToDateTime(bar.strtime).AddMonths(-7).ToString("yyyy-MM-dd HH:MM:ss")
                //            , Convert.ToDateTime(bar.strtime).ToString("yyyy-MM-dd HH:MM:ss"));
                //    }

                //    if (emaList.Count >= 10)
                //    {
                //        int i1 = 0;
                //        for (int i0 = emaList.Count - 10; i0 < emaList.Count; i0++)
                //        {
                //            i1++;
                //            if (i1 == 1)
                //            {
                //                ema10_qr = emaList[i0].close;
                //            }
                //            else
                //            {
                //                ema10_qr = (emaList[i0].close * 2 + pre_ema10 * (i1 - 1)) / (i1 + 1);
                //            }

                //            pre_ema10 = ema10_qr;
                //        }
                //        //指数平均
                //        qt_total.ema10 = Math.Round(ema10_qr, 2);
                //    }

                //}
                #endregion
                              
                if (cnt == 2)
                {
                    total.top_2_day = Math.Round(top_5_price, 2);
                    total.sum2Zf = Math.Round(sum_zf, 2);
                    total.sum2ABSZf = Math.Round(sum_abs_zf, 2);

                    total.low_2_day = Math.Round(low_5_price, 2);
                }
                else if (cnt == 3)
                {
                    total.sum3Zf = Math.Round(sum_zf, 2);
                    total.low_3_day = Math.Round(low_5_price, 2);
                    total.top_3_day = Math.Round(top_5_price, 2);  

                }
                else if (cnt == 4)
                {
                    total.sum4Zf = Math.Round(sum_zf, 2);
                }
                else if (cnt == 5)
                {                   
                    total.jj5 = Math.Round(sumPrice / cnt, 2);               
                    total.top_5_day = Math.Round(top_5_price, 2);
                    total.low_5_day = Math.Round(low_5_price, 2);
                    total.top_5_day_date = top_5_price_date;
                    total.low_5_day_date = low_5_price_date;
                    total.sum5Zf = Math.Round(sum_zf, 2);

                    total.low_cjl_5_day = low_cjl;
                }
                else if (cnt == 6)
                {
                    total.rsi6 = Math.Round(sum_rsi_zf / (sum_rsi_zf + Math.Abs(sum_rsi_df)), 2) * 100;
                }
                else if (cnt == 10)
                {                   
                    total.jj10 = Math.Round(sumPrice / cnt, 2);
                    total.k10_str = kstr;
                    total.low_10_day = Math.Round(low_5_price, 2);
                    total.top_10_day = Math.Round(top_5_price, 2);

                    total.sum10Zf = Math.Round(sum_zf, 2);
                    total.low_cjl_10_day = low_cjl;
                                       
                }
                else if (cnt == 12)
                {
                    total.rsi12 = Math.Round(sum_rsi_zf / (sum_rsi_zf + Math.Abs(sum_rsi_df)), 2) * 100;
                }
                else if (cnt == 15)
                {
                    total.sum15Zf = Math.Round(sum_zf, 2);
                    if (sum_zhengf != 0)
                    {
                        total.pj_15_zhengfu = Math.Round(sum_zhengf / cnt, 2);
                    }                  
                }                
                else if (cnt == 20)
                {                   
                    total.jj20 = Math.Round(sumPrice / cnt, 2);
                    total.low_20_day = Math.Round(low_5_price, 2);
                    total.atr = Math.Round(atr / cnt, 2);

                    total.top_20_day_date = top_5_price_date;                               
                    total.low_cjl_20_day = low_cjl;
                    total.sum20Zf = Math.Round(sum_zf, 2);
                }
                else if (cnt == 24)
                {
                    total.rsi24 = Math.Round(sum_rsi_zf / (sum_rsi_zf + Math.Abs(sum_rsi_df)), 2) * 100;
                }
                else if (cnt == 30)
                {      
                    total.jj30 = Math.Round(sumPrice / cnt, 2);
                    total.sum30Zf = Math.Round(sum_zf, 2);

                    total.top_30_day = Math.Round(top_5_price, 2);
                    total.low_cjl_30_day = low_cjl;
                    total.low_30_day = Math.Round(low_5_price, 2);

                    if (sum_zhengf != 0)
                    {
                        total.pj_30_zhengfu = Math.Round(sum_zhengf / cnt, 2);
                    }     
                }
                else if (cnt == 50)
                {
                    total.jj50 = Math.Round(sumPrice / cnt, 2);
                    //dma指标
                    total.ddd = Math.Round(total.jj10 - total.jj50, 2);
                }
                else if (cnt == 60)
                {                   
                    total.jj60 = Math.Round(sumPrice / cnt, 2);
                    total.sum60Zf = Math.Round(sum_zf, 2);

                    total.top_60_day = Math.Round(top_5_price, 2);
                    total.low_cjl_60_day = low_cjl;
                    total.low_60_day = Math.Round(low_5_price, 2);

                    if (sum_zhengf != 0)
                    {
                        total.pj_60_zhengfu = Math.Round(sum_zhengf / cnt, 2);
                    }     
                }
                else if (cnt == 90)
                {
                    total.sum90Zf = Math.Round(sum_zf, 2);
                }

                //前一日
                if (pre_cnt == 5)
                {                  
                    pre_total.jj5 = Math.Round(pre_sumPrice / pre_cnt, 2);
                }
                else if (pre_cnt == 10)
                {                  
                    pre_total.jj10 = Math.Round(pre_sumPrice / pre_cnt, 2);                   
                }
                else if (pre_cnt == 20)
                {                 
                    pre_total.jj20 = Math.Round(pre_sumPrice / pre_cnt, 2);
                }
                else if (pre_cnt == 30)
                {                  
                    pre_total.jj30 = Math.Round(pre_sumPrice / pre_cnt, 2);
                }
                else if (pre_cnt == 50)
                {
                    pre_total.jj50 = Math.Round(pre_sumPrice / pre_cnt, 2);
                    //dma指标
                    pre_total.ddd = Math.Round(pre_total.jj10 - pre_total.jj50, 2);
                }

                //前前一日
                if (qt_cnt == 5)
                {                   
                    qt_total.jj5 = Math.Round(qt_sumPrice / qt_cnt, 2);
                }
                else if (qt_cnt == 10)
                {                   
                    qt_total.jj10 = Math.Round(qt_sumPrice / qt_cnt, 2);                   
                }
                else if (qt_cnt == 50)
                {
                    qt_total.jj50 = Math.Round(qt_sumPrice / qt_cnt, 2);
                    //dma指标
                    qt_total.ddd = Math.Round(qt_total.jj10 - qt_total.jj50, 2);
                }

                pre_zf = zf;
              
            }

            if (total.code != null)
            {
                gpTotalDic.Remove(total.code);              
                total.preGpTotal = pre_total;
                total.qtGpTotal = qt_total;              
                gpTotalDic.Add(total.code, total);
            }

            return total.code;
        }

        /// <summary>
        /// 加载股票统计信息
        /// </summary>
        /// <param name="symbol_list"></param>
        /// <param name="begin_time"></param>
        /// <param name="end_time"></param>
        public static string loadGpTotalList(Strategy str, string symbol_list,
                string begin_time,
                string end_time)
        {
           TranBean bean = new TranBean();
           bean.strtime = begin_time;
           return loadGpTotalList(str, symbol_list, bean);
        }

        /// <summary>
        /// K线涨幅
        /// </summary>
        /// <param name="in_zf"></param>
        /// <returns></returns>
        public static string getZfStr(String code,double in_zf)
        {

            string v_zf_str = "";
            if (code.Equals("000001") || code.Equals("399006")  || code.Equals("399001"))
            {
                if (in_zf <= -0.5)
                {
                    v_zf_str = "3";
                }
                else if (in_zf >= 0.4)
                {
                    v_zf_str = "2";
                }                
                else
                {
                    v_zf_str = "1";
                };
            } else if (code.IndexOf("399006") > 0)
            {
                if (in_zf <= -0.7)
                {
                    v_zf_str = "3";
                }
                else if (in_zf >= 0.6)
                {
                    v_zf_str = "2";
                }
                else
                {
                    v_zf_str = "1";
                };
            } else if (code.IndexOf("399001") > 0)
            {
                if (in_zf <= -0.6)
                {
                    v_zf_str = "3";
                }
                else if (in_zf >= 0.5)
                {
                    v_zf_str = "2";
                }
                else
                {
                    v_zf_str = "1";
                };
            }
            else
            {
                if (in_zf >= -200 && in_zf <= -8)
                {
                    v_zf_str = "0";
                }
                else if (in_zf >= -8 && in_zf <= -6)
                {
                    v_zf_str = "1";
                }
                else if (in_zf > -6 && in_zf <= -4)
                {
                    v_zf_str = "2";
                }
                else if (in_zf > -4 && in_zf <= -2)
                {
                    v_zf_str = "3";
                }
                else if (in_zf > -2 && in_zf < 0)
                {
                    v_zf_str = "4";
                }
                else if (in_zf >= 0 && in_zf <= 2)
                {
                    v_zf_str = "5";
                }
                else if (in_zf > 2 && in_zf <= 4)
                {
                    v_zf_str = "6";
                }
                else if (in_zf > 4 && in_zf <= 6)
                {
                    v_zf_str = "7";
                }
                else if (in_zf > 6 && in_zf <= 8)
                {
                    v_zf_str = "8";
                }
                else if (in_zf > 8 && in_zf <= 200)
                {
                    v_zf_str = "9";
                }
                else
                {
                    v_zf_str = "a";
                };
            }
            

            return v_zf_str;
        }

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

                    String sql = "insert into gpzhibiao (code,type,zf5,zf10,zf30,rsi_6,rsi_12,rsi_24,sy_zf,ykl,"
                                + "tp_bar_num,syx_bar_num,top_5_price,top_2_price,zr_open,qt_close,dp_rsi_6,dp_zf3,dp_zf,date) values ('"
                                + t.sec_id + "'," + type + ","
                                + bean.gpTotal.sum5Zf + ","
                                + bean.gpTotal.sum10Zf + ","
                                + bean.gpTotal.sum30Zf + ","
                                + bean.gpTotal.rsi6 + ","
                                + bean.gpTotal.rsi12 + ","
                                + bean.gpTotal.rsi24 + ","
                                + (bean.tick.last_price - bean.tick.low) / bean.tick.last_price * 100 + ","
                                + bean.ykl+","
                                + bean.gpTotal.tp_bar_num + ","
                                + bean.gpTotal.syx_bar_num + ","
                                + bean.gpTotal.top_5_day + ","
                                + bean.gpTotal.top_2_day + ","
                                + bean.lastDailyBar.open + ","
                                + bean.lastDailyBar.pre_close + ","
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

                String sql = "";
                if (bean.code.Length == 6)
                {
                    sql = "insert into gpzhibiao (code,type,zf5,zf10,zf30,rsi_6,rsi_12,rsi_24,sy_zf,ykl,"
                              + "tp_bar_num,syx_bar_num,top_5_price,top_2_price,zr_open,qt_close,dp_rsi_6,dp_zf3,dp_zf,date) values ('"
                              + bean.code + "'," + type + ","
                              + bean.gpTotal.sum5Zf + ","
                              + bean.gpTotal.sum10Zf + ","
                              + bean.gpTotal.sum30Zf + ","
                              + bean.gpTotal.rsi6 + ","
                              + bean.gpTotal.rsi12 + ","
                              + bean.gpTotal.rsi24 + ","
                              + (bean.tick.last_price - bean.tick.low) / bean.tick.last_price * 100 + ","
                              + bean.ykl + ","
                              + bean.gpTotal.tp_bar_num + ","
                              + bean.gpTotal.syx_bar_num + ","
                              + bean.gpTotal.top_5_day + ","
                              + bean.gpTotal.top_2_day + ","
                              + bean.lastDailyBar.open + ","
                              + bean.lastDailyBar.pre_close + ","
                              + dp.gpTotal.rsi6 + ","
                              + dp.gpTotal.sum3Zf + ","
                              + dp.zf + ",'"
                              + Convert.ToDateTime(bean.tick.strtime).ToString("yyyy-MM-dd") + "')";
                }
                else
                {

                    if (type == 0)
                    {
                        bean.ykl = 0;
                    }

                    sql = "insert into gpzhibiao (code,type,zf5,zf10,zf30,rsi_6,rsi_12,rsi_24,sy_zf,ykl,"
                              + "tp_bar_num,syx_bar_num,top_5_price,top_2_price,zr_open,qt_close,dp_rsi_6,dp_zf3,dp_zf,date) values ('"
                              + bean.code + "'," + type + ","
                              + bean.gpTotal.sum5Zf + ","
                              + bean.gpTotal.sum10Zf + ","
                              + bean.gpTotal.sum30Zf + ","
                              + bean.gpTotal.rsi6 + ","
                              + bean.gpTotal.rsi12 + ","
                              + bean.gpTotal.rsi24 + ","
                              + (bean.tick.last_price - bean.tick.low) / bean.tick.last_price * 100 + ","
                              + bean.ykl + ","
                              + bean.gpTotal.tp_bar_num + ","
                              + bean.gpTotal.syx_bar_num + ","
                              + bean.gpTotal.top_5_day + ","
                              + bean.gpTotal.top_2_day + ","
                              + bean.lastDailyBar.open + ","
                              + bean.lastDailyBar.pre_close + ",0,0,0,'"                            
                              + Convert.ToDateTime(bean.tick.strtime).ToString("yyyy-MM-dd") + "')";
                }

               
                GPUtil.helper.ExecuteNonQuery(sql);
            }

        }


        /// <summary>
        /// 获取当前股票仓位
        /// </summary>
        /// <param name="sec_id"></param>
        /// <returns></returns>
        public static Position getPos(string sec_id, List<Position> poList)
        {
            Position rtnPos = null;
            foreach (Position p in poList)
            {
                if (!p.sec_id.Equals(sec_id))
                {
                    continue;
                }

                rtnPos = p;
            }

            return rtnPos;
        }


        /// <summary>
        /// 当前TRANBEAN
        /// </summary>
        /// <param name="tranStas"></param>
        /// <param name="tick"></param>
        /// <returns></returns>
        public static TranBean getTranBean(Strategy strategy,Dictionary<string, TranBean> tranStas, Tick tick, StrateSta sta)
        {
                                
            TranBean bean = null;
            if (tranStas.ContainsKey(tick.sec_id))
            {
                bean = tranStas[tick.sec_id];
                bean.zf = HGStaUtil.getTickZF(tick);
                bean.tick = tick;
                bean.code = tick.sec_id;

                //同一天
                if (bean.strtime.Substring(0, 10).Equals(tick.strtime.Substring(0, 10)))
                {
                    bean.seq++;                   
                }
                else
                {
                    GPUtil.buyList.Clear();
                    GPUtil.GN_MAP.Clear();
                    bean.tp_cnt = 0;
                    bean.buyNum = 100;
                    bean.tp_last_price = 0;
                    bean.pre_tp_last_price = 0;
                    bean.zf1sec = 0;
                    bean.pre_tick_price = 0;
                    bean.pre_pre_tick_price = 0;
                    bean.isTodayXyx = false;
                    sta.cf_zb = "";
                    sta.is_dc = 0;
                    bean.b_buy_time = 0;    

                    bean.low = 0;
                    bean.high = 0;
                    bean.buyCodes.Clear();
                    
                    bean.low1 = 0;
                    bean.low2 = 0;
                    bean.low3 = 0;
                    bean.isClearXHFlag = false;

                    bean.seq = 0;
                    bean.buy_cnt = 0;               
                    sta.buy_cnt = 0;
                    sta.cf_zb = "";
                    
                    bean.sell_cnt = 0;
                    bean.xh_cnt = 0;                 
                    bean.sell_xh_cnt = 0;
                    bean.tick = tick;
                    bean.strtime = tick.strtime;
                    JJUtil.isLoadCurPosFlag = "0";     

                    bean.highest_time = bean.tick.strtime;
                    bean.lowest_time = bean.tick.strtime;

                    bean.more_timejj_cnt = 0;
                    bean.less_timejj_cnt = 0;

                    //清除
                    GPUtil.TL_FLAG.Clear();

                    //重新加载统计信息
                    loadGpTotalList(strategy, tick.exchange+"."+tick.sec_id, bean);
                    if (HGStaUtil.gpTotalDic.ContainsKey(tick.sec_id))
                    {                       
                        bean.gpTotal = HGStaUtil.gpTotalDic[tick.sec_id];                      
                    }
                    if (bean.gpTotal != null)
                    {
                        bean.gpTotal.stime = tick.strtime;
                    }
                   
                    DateTime t_tran_time = Convert.ToDateTime(tick.strtime);                 
                    //昨日bar
                    List<DailyBar> bars = null;
                    if (bean.tick.sec_id.Length == 6)
                    {
                        //昨日bar
                        bars = strategy.GetLastNDailyBars(tick.exchange + "." + tick.sec_id,
                                    20, t_tran_time.ToString("yyyy-MM-dd HH:MM:ss"));
                        if (bars != null && bars.Count >= 4)
                        {
                            bean.lastDailyBar = bars[1];
                            bean.qtDailyBar = bars[2];
                            bean.pre_qtDailyBar = bars[3];
                        }
                    }
                    else
                    {
                        //昨日bar
                        bars = MdComm.md.GetDailyBars(tick.exchange + "." + tick.sec_id,
                              t_tran_time.AddDays(-20).ToString("yyyy-MM-dd HH:MM:ss"), t_tran_time.ToString("yyyy-MM-dd HH:MM:ss"));
                        if (bars != null && bars.Count >= 3)
                        {
                            bean.lastDailyBar = bars[bars.Count - 2];
                            bean.qtDailyBar = bars[bars.Count - 3];
                            bean.pre_qtDailyBar = bars[bars.Count - 4];
                        }
                    }                    
                   
                    //总共头寸次数
                    StoreDb store = GPUtil.getStoreDb();
                    sta.initial_cash = store.total;
                    sta.dw_amt = store.pamt;
                    sta.cf_zb = "";

                    //初始化本地仓位
                    GPUtil.initPosition(tick.strtime);                                                       

                    //本地库
                    bean.positionDb = GPUtil.getPositionDb(tick.sec_id);
                    if (bean.positionDb != null)
                    {
                        bean.positionDb.available_today = 0;
                        //更新盈亏率
                        if (MdComm.str_mode != GPConstants.STRATEGY_MODE_NORMAR_PRD && bean.tick.pre_close > 0)
                        {
                            if (bean.positionDb.inxh != 2)
                            {
                                GPUtil.helper.ExecuteNonQuery("UPDATE POSITION SET sumzf=("
                                   + bean.tick.pre_close
                                   + "-position.vwap)/position.vwap*100 WHERE code='" + tick.sec_id + "' and available > 0 and vwap > 0");
                            }
                            else if (bean.positionDb.inxh == 2)
                            {
                                GPUtil.helper.ExecuteNonQuery("UPDATE POSITION SET sumzf=("                                 
                                  + "position.vwap -"+ bean.tick.pre_close
                                  + ")/position.vwap*100 WHERE code='" + tick.sec_id + "' and available > 0 and vwap > 0");
                            }
                           
                        }
                    }

                    //股票基本信息
                    bean.gpInfo = JJUtil.getGpInfo(tick.sec_id);

                    if (bean.isDp)
                    {
                        JJUtil.loadDbGns();
                    }
                                      
                }

                bean.strtime = tick.strtime;                              

                //仓位
                //bean.position = getPos(tick.sec_id, strategy.GetPositions());                               
            }
            else
            {
                bean = new TranBean();
                bean.tick = tick;
                bean.strtime = tick.strtime;
                bean.b_buy_time = 0;
                bean.tickDate = Convert.ToDateTime(bean.strtime);
                bean.code = tick.sec_id;
                bean.zf = HGStaUtil.getTickZF(tick);               
                bean.seq = 0;              
                bean.buy_cnt = 0;               
                bean.sell_cnt = 0;
                bean.buyNum = 100;
                sta.is_dc = 0;

                GPUtil.buyList.Clear();
                GPUtil.GN_MAP.Clear();

                //股票基本信息
                bean.gpInfo = JJUtil.getGpInfo(tick.sec_id);

                bean.buyCodes.Clear();
                bean.low = 0;
                bean.high = 0;

                bean.low1 = 0;
                bean.low2 = 0;
                bean.low3 = 0;

                //重新加载统计信息
                loadGpTotalList(strategy, tick.exchange + "." + tick.sec_id, bean);                               

                //加载统计信息
                if (HGStaUtil.gpTotalDic.ContainsKey(tick.sec_id))
                {
                    bean.gpTotal = HGStaUtil.gpTotalDic[tick.sec_id];

                    if (bean.gpTotal != null)
                    {                     
                        bean.gpTotal.stime = tick.strtime;
                    }
                   
                }

                //昨日bar
                List<DailyBar> bars = null;
                if (bean.tick.sec_id.Length == 6)
                {
                    bars = strategy.GetLastNDailyBars(tick.exchange + "." + tick.sec_id,
                           20, Convert.ToDateTime(bean.strtime).AddDays(-1).ToString("yyyy-MM-dd HH:MM:ss"));

                    if (bars != null && bars.Count >= 3)
                    {
                        bean.lastDailyBar = bars[0];
                        bean.qtDailyBar = bars[1];
                        bean.pre_qtDailyBar = bars[2];
                    }
                }
                else
                {
                    //昨日bar
                    bars = MdComm.md.GetDailyBars(tick.exchange + "." + tick.sec_id,
                          Convert.ToDateTime(bean.strtime).AddDays(-20).ToString("yyyy-MM-dd HH:MM:ss"), Convert.ToDateTime(bean.strtime).ToString("yyyy-MM-dd HH:MM:ss"));

                    if (bars != null && bars.Count >= 3)
                    {
                        bean.lastDailyBar = bars[bars.Count - 2];
                        bean.qtDailyBar = bars[bars.Count - 3];
                        bean.pre_qtDailyBar = bars[bars.Count - 4];                                            
                    }
                }
                             
                //仓位
                //bean.position = getPos(tick.sec_id, strategy.GetPositions());
                                                    
                //总共头寸次数
                StoreDb store = GPUtil.getStoreDb();
                sta.total_dws = store.per_cnt;
                sta.dw_amt = store.pamt;
                sta.initial_cash = store.total;
                sta.cf_zb = "";                        
                tranStas.Add(tick.sec_id, bean);

                //初始化本地仓位
                GPUtil.initPosition(bean.strtime);

                //本地库
                bean.positionDb = GPUtil.getPositionDb(tick.sec_id);    
            }
                      
            bean.tick = tick;
            bean.strtime = tick.strtime;
            bean.tickDate = Convert.ToDateTime(bean.strtime);
            bean.btime = Convert.ToDouble(bean.strtime.Substring(11, 5).Replace(":", "."));
            if (bean.code.Length == 6)
            {
                bean.openZf = (tick.open - tick.pre_close) / tick.pre_close * 100;
            }
            else
            {
                bean.openZf = (tick.open - bean.lastDailyBar.close) / bean.lastDailyBar.close * 100;
            }
            
            //分时均价
            if (tick.cum_volume > 0 && bean.code.Length == 6)
            {
                bean.timejj = Math.Round(tick.cum_amount / tick.cum_volume, 2);
            }                                            
            
            //当日5,10均线
            if (bean.gpTotal != null && bean.code.Length == 6)
            {
                bean.todayJJ5 = Math.Round((bean.gpTotal.jj5 + bean.timejj) / 2, 2);
                bean.todayJJ10 = Math.Round((bean.gpTotal.jj10 + bean.timejj) / 2, 2);
                bean.todayJJ20 = Math.Round((bean.gpTotal.jj20 + bean.timejj) / 2, 2);
                bean.todayJJ30 = Math.Round((bean.gpTotal.jj30 + bean.timejj) / 2, 2);
            }
              
            if (bean.position != null && bean.position.vwap > 0)
            {
                //盈亏率
                bean.ykl = Math.Round((bean.position.price - bean.position.vwap) / bean.position.vwap * 100, 2);
            }

            if (bean.gpTotal != null)
            {
                bean.gpTotal.stime = tick.strtime;
            }

            //是否大盘           
            if (HGStaUtil.DP_TICK_CODES.IndexOf(tick.sec_id) != -1)
            {
                bean.isDp = true;
                sta.dp = bean;
            }
            else
            {
                bean.isDp = false;
            }           
            
            //测试用
            if (bean.isDp)
            {
                if (bean.seq % 120 == 0)
                {
                     Console.WriteLine("趋势: {0} 方向: {1}: 时间={2} 代码={3} 指数={4} 最低={5}", MdComm.TRAN_MODE,
                         MdComm.IN_TYPE,
                         Convert.ToDateTime(tick.strtime).ToString("yyyy-MM-dd HH:mm:ss"),
                         tick.sec_id,
                         tick.last_price,
                         tick.low);
                 }                          

               //插入数据库日志
               if ((MdComm.str_mode == 6 || MdComm.str_mode == 2) && bean.seq % 60 == 0)
               {
                   JJUtil.dblog(0, "模式[" + MdComm.TRAN_MODE + "] 获取tick信息[" + tick.sec_id
                       + "],方向[" + MdComm.IN_TYPE + "]", Convert.ToDateTime(tick.strtime));
               }
            }     

            return bean;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="barDic"></param>
        /// <param name="bar"></param>
        /// <param name="sta"></param>
        /// <returns></returns>
        public static BarTotal getBarTotal(Strategy strat,Dictionary<string, BarTotal> barDic, Bar bar, StrateSta sta)
        {
            BarTotal bean = null;
            DateTime t_tran_time;
            if (barDic.ContainsKey(bar.sec_id))
            {
                bean = barDic[bar.sec_id];
                bean.bar = bar;               
                bean.close = bar.close;
                bean.high = Math.Round(bar.high, 2);
                bean.low = Math.Round(bar.low, 2);                               
                bean.pre_close = bar.pre_close;

                //同一天
                if (bean.strtime.Substring(0,10).Equals(bar.strtime.Substring(0,10))) {
                     bean.seq++;
                } else {
                     bean.seq = 0;
                     bean.buy_cnt = 0;
                     bean.sell_cnt = 0;
                     bean.high = Math.Round(bar.high, 2);
                     bean.low = Math.Round(bar.low, 2);
                     bean.strtime = bar.strtime;

                     //昨日bar
                     List<DailyBar> bars = null;
                     t_tran_time = Convert.ToDateTime(bar.strtime); 

                     if (bar.sec_id.Length == 6)
                     {
                         bars = strat.GetLastNDailyBars(bar.exchange + "." + bar.sec_id,
                             2, Convert.ToDateTime(bean.strtime).AddDays(-1).ToString("yyyy-MM-dd HH:MM:ss"));
                         if (bars != null && bars.Count >= 2)
                         {
                             bean.qtDailyBar = bars[1];
                             bean.lastDailyBar = bars[0];
                         }
                     }
                     else
                     {                
                         //昨日bar
                         bars = MdComm.md.GetDailyBars(bar.exchange + "." + bar.sec_id,
                               t_tran_time.AddDays(-20).ToString("yyyy-MM-dd HH:MM:ss"), t_tran_time.ToString("yyyy-MM-dd HH:MM:ss"));
                         if (bars != null && bars.Count >= 3)
                         {
                             bean.lastDailyBar = bars[bars.Count - 2];
                             bean.qtDailyBar = bars[bars.Count - 3];
                         }
                     } 

                     //重新加载统计信息
                     loadGpTotalList(strat, bar.exchange + "." + bar.sec_id, bar.strtime, bar.strtime);
                     if (HGStaUtil.gpTotalDic.ContainsKey(bar.sec_id))
                     {
                         bean.gpTotal = HGStaUtil.gpTotalDic[bar.sec_id];
                     }
                    
                     //本地库                    
                     bean.positionDb = GPUtil.getPositionDb(bean.code);
                     if (bean.positionDb != null)
                     {
                         bean.positionDb.available_today = 0;
                     }

                     //初始化本地仓位
                     GPUtil.initPosition(bar.strtime);                    
                }

                bean.zf = Math.Round((bean.close - bean.lastDailyBar.close) / bean.lastDailyBar.close * 100, 2);                   
                bean.strtime = bar.strtime;
                bean.btime =  Convert.ToDouble(bean.strtime.Substring(11, 5).Replace(":", "."));               
            }
            else
            {               
                bean = new BarTotal();
                bean.code = bar.sec_id;
                bean.bar = bar;
                bean.close = bar.close;
                bean.high = Math.Round(bar.high,2);
                bean.low = Math.Round(bar.low, 2);
                bean.highest_time = bar.strtime;
                bean.lowest_time = bar.strtime;
                bean.buy_cnt = 0;
                bean.sell_cnt = 0;

                bean.strtime = bar.strtime;
                bean.pre_close = bar.pre_close;
                bean.volume = bar.volume;
                bean.seq = 0;
                bean.btime = Convert.ToDouble(bean.strtime.Substring(11, 5).Replace(":", "."));

                //重新加载统计信息
                loadGpTotalList(strat, bar.exchange + "." + bar.sec_id, bar.strtime, bar.strtime);                
                if (HGStaUtil.gpTotalDic.ContainsKey(bar.sec_id))
                {
                    bean.gpTotal = HGStaUtil.gpTotalDic[bar.sec_id];                   
                }

                //本地库
                bean.positionDb = GPUtil.getPositionDb(bean.code);

                //前一天日bar
                //昨日bar
                List<DailyBar> bars = null;
                t_tran_time = Convert.ToDateTime(bar.strtime);
                if (bar.sec_id.Length == 6)
                {
                    bars = strat.GetLastNDailyBars(bar.exchange + "." + bar.sec_id,
                        2, Convert.ToDateTime(bean.strtime).AddDays(-1).ToString("yyyy-MM-dd HH:MM:ss"));
                    if (bars != null && bars.Count >= 2)
                    {
                        bean.qtDailyBar = bars[1];
                        bean.lastDailyBar = bars[0];
                    }
                }
                else
                {
                    //昨日bar
                    bars = MdComm.md.GetDailyBars(bar.exchange + "." + bar.sec_id,
                          t_tran_time.AddDays(-20).ToString("yyyy-MM-dd HH:MM:ss"), t_tran_time.ToString("yyyy-MM-dd HH:MM:ss"));
                    if (bars != null && bars.Count >= 3)
                    {
                        bean.lastDailyBar = bars[bars.Count - 2];
                        bean.qtDailyBar = bars[bars.Count - 3];
                    }
                } 

                if (bean.lastDailyBar != null)
                {
                    bean.zf = Math.Round((bean.close - bean.lastDailyBar.close) / bean.lastDailyBar.close * 100, 2);
                }
                               
                barDic.Add(bean.code, bean);
            }

            //是否大盘           
            if (HGStaUtil.DP_TICK_CODES.IndexOf(bar.sec_id) != -1)
            {
                bean.isDp = true;
            }
            else
            {
                bean.isDp = false;
            } 

            //测试用
            if (bean.isDp)
            {
                if (bean.seq % 5 == 0)
                {
                    Console.WriteLine("趋势: {0} 方向: {1}: 时间={2} 代码={3} 指数={4} 最低={5}", MdComm.TRAN_MODE,
                        MdComm.IN_TYPE,
                        Convert.ToDateTime(bar.strtime).ToString("yyyy-MM-dd HH:mm:ss"),
                        bar.sec_id,
                        bar.close,
                        bar.low);
                }

                //插入数据库日志
                if ((MdComm.str_mode == 2 || MdComm.str_mode == 3 || MdComm.str_mode == 6 || MdComm.str_mode == 7) && bean.seq % 5 == 0)
                {
                    JJUtil.dblog(0, "模式[" + MdComm.TRAN_MODE + "] 获取tick信息[" + bar.sec_id
                        + "],方向[" + MdComm.IN_TYPE + "]", Convert.ToDateTime(bar.strtime));
                }
            }               
            
            return bean;
        }           

    }
}
