using GMSDK;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace MdTZ
{
    /// <summary>
    /// 全局选股策略
    /// </summary>
    class Strategy_Sel_Ext 
    {
        public static void gp_sel_process()
        {
            if (MdComm.md == null)
            {
                MdComm.initMd();
            }         

            string allCodes = GPUtil.codes;
            String allHyCode = HisDataAPI.getHeyCodesFromDb();
            allCodes = allCodes + "," + allHyCode;            

            string allJJCodes = getAllJJCodes(allCodes)+",SHSE.000001,SZSE.399001,SZSE.399006";
            //string allJJCodes = "SHSE.000001,SZSE.399001,SZSE.399006";

            List<DailyBar> barList = MdComm.md.GetLastDailyBars(allJJCodes);          
            List<DailyBar> last70Bars = null;         
            int idx = 0;
            int process_cnt = 0;

            int selCnt = 0;

            double zhengf = 0;
            double sum_zhengf = 0;
            double zr_open = 0;          
            double qt_close = 0;
            double qt_pre_close = 0;
            double zr_low = 0;
            int dt_bar_num = 0;
            int tp_bar_num = 0;
            int zt_bar_num = 0;
            int syk_bar_num = 0;
            int is_cxg = 0;
            double last_tp_open = 0;
            double zt_bar_open = 0; 

            double lowest_price = 0;
            double lowest_amt = 0;

            double highest_price = 0;
            double highest_amt = 0;
            double tran_am = 0;

            double low_3_price = 0;
            double low_5_price = 0;
            double low_10_price = 0;
            double low_30_price = 0;
            double low_60_price = 0;

            double top_2_price = 0;
            double top_5_price = 0;
            double top_60_price = 0;

            double sum_price = 0;
            double pre_sum_price = 0;
            double sum_zf = 0;          
            double zf = 0;           

            double pre_jj_5 = 0;
            double pre_jj_10 = 0;
            double jj_5 = 0;
            double jj_10 = 0;
            double jj_20 = 0;
            double jj_30 = 0;
            double jj_60 = 0;

            double zf_sum_2 = 0;                   
            double zf_sum_10 = 0;
            double zf_sum_30 = 0;
            double zf_sum_3 = 0;

            double low_3_amt = 0;
            double low_5_amt = 0;
            double low_10_amt = 0;
            double low_30_amt = 0;
            double low_60_amt = 0;

            double sum_amt = 0;
            double sum_5_amt = 0;
            double sum_10_amt = 0;
            double sum_30_amt = 0;
            double sum_60_amt = 0;

            double high_5_amt = 0;
            double last_price = 0;
            double qt_price = 0;
            double dqt_price = 0;
            double last_amt = 0;           

            double sum_rsi_zf = 0;
            double sum_rsi_df = 0;
            double rsi6 = 0;
            double rsi12 = 0;
            double rsi24 = 0;
            double rsi60 = 0;
            string zfRec = "";

            double tr = 0;
            double atr = 0;
            double sum_atr = 0;

            //优势行业，优势概念
            GPUtil.HY_HOT_STRS = JJUtil.getHotHyStrs();
            GPUtil.GN_HOT_STRS = JJUtil.getHotGnStrs();

            GpInfo gp = null;

            DailyBar curBar = null;
            DailyBar qtDayBar = null;
            DailyBar preBar = null;

            StringBuilder updSql = new StringBuilder();
            List<string> updSqlList = new List<string>();
            //bool isSel = false;
            foreach (DailyBar bar in barList)
            {
             
                #region  变量初始化
                process_cnt++;
                gp = JJUtil.getGpInfo(bar.sec_id);

                sum_rsi_zf = 0;
                sum_rsi_df = 0;               

                rsi6 = 0;
                rsi12 = 0;
                rsi24 = 0;
                rsi60 = 0;

                zhengf = 0;
                sum_zhengf =0;
                is_cxg = 0;
                zr_open = 0;             
                qt_close = 0;
                zr_low = 0;
                dt_bar_num = 0;
            
                tp_bar_num = 0;
                zt_bar_num = 0;
                syk_bar_num = 0;              
                last_tp_open = 0;
                zt_bar_open = 0;

                idx = 0;
                lowest_price = 0;
                highest_price = 0;
                lowest_amt = 0;
                highest_amt = 0;
                tran_am = 0;
                zf = 0;             

                low_3_price = 0;
                low_5_price = 0;
                low_10_price = 0;
                low_30_price = 0;
                low_60_price = 0;

                top_2_price = 0;
                top_5_price = 0;
                top_60_price = 0;

                pre_sum_price = 0;
                sum_price = 0;
                sum_zf = 0;               

                pre_jj_5 = 0;
                pre_jj_10 = 0;

                jj_5 = 0;
                jj_10 = 0;
                jj_20 = 0;
                jj_30 = 0;
                jj_60 = 0;

                high_5_amt = 0;

                sum_amt = 0;
                sum_5_amt = 0;
                sum_10_amt = 0;
                sum_30_amt = 0;
                sum_60_amt = 0;

                low_3_amt = 0;
                low_5_amt = 0;
                low_10_amt = 0;
                low_30_amt = 0;
                low_60_amt = 0;

                last_price = 0;
                qt_price = 0;
                dqt_price = 0;
                last_amt = 0;               
                curBar = null;
                qtDayBar = null;

                zf_sum_2 = 0;               
                qt_pre_close = 0;
                zf_sum_10 = 0;
                zf_sum_30 = 0;
                zf_sum_3 = 0;

                zfRec = "";

                last70Bars = MdComm.md.GetLastNDailyBars(MdComm.getJJCode(bar.exchange+"."+bar.sec_id), 360, GPUtil.nowTranDate.ToString("yyyy-MM-dd HH:MM:ss"));
                if (last70Bars.Count < 60)
                {
                    is_cxg = 1;
                }
               
                //last5WeekBars = MdComm.md.GetLastNBars(MdComm.getJJCode(bar.sec_id), 60 * 60 * 24 * 7, 5, GPUtil.nowTranDate.ToString("yyyy-MM-dd HH:MM:ss"));
                preBar = null;
                updSql.Clear();
                #endregion                                        

                #region 中间数据计算
                foreach (DailyBar c_bar in last70Bars)
                {
                    idx++;
                    tran_am = Math.Round(c_bar.amount / 100000000, 2);
                    sum_price += c_bar.close;
                    zf = HGStaUtil.getBarZF(c_bar);
                    sum_zf += zf;                  
                    sum_amt += tran_am;

                    //上长影线到现在天数
                    if (syk_bar_num == 0 && Math.Round((c_bar.high - c_bar.low) / c_bar.low, 2) > 0.02
                        && (c_bar.high - (c_bar.close + c_bar.open) / 2) > ((c_bar.close + c_bar.open) / 2 - c_bar.low) * 2)
                    {
                        syk_bar_num = idx;
                    }             

                    tr = HGStaUtil.getTr(bar);
                    sum_atr += tr;

                    sum_rsi_zf += HGStaUtil.getBarZF(c_bar) > 0 ? HGStaUtil.getBarZF(c_bar) : 0;
                    sum_rsi_df += HGStaUtil.getBarZF(c_bar) < 0 ? Math.Abs(HGStaUtil.getBarZF(c_bar)) : 0;

                    if (c_bar.low != 0)
                    {
                        zhengf = Math.Round(((c_bar.high - c_bar.low) / c_bar.low) * 100, 2);
                        sum_zhengf += zhengf;
                    }                   

                    if (lowest_price != 0 && lowest_amt != 0)
                    {
                        lowest_price = lowest_price < c_bar.close ? lowest_price : c_bar.close;
                        lowest_amt = lowest_amt < tran_am ? lowest_amt : tran_am;
                    }
                    else
                    {
                        lowest_price = c_bar.close;
                        lowest_amt = tran_am;
                    }

                    if (highest_price != 0 && highest_amt != 0)
                    {
                        highest_price = highest_price > c_bar.close ? highest_price : c_bar.close;
                        highest_amt = highest_amt > tran_am ? highest_amt : tran_am;
                    }
                    else
                    {
                        highest_price = c_bar.close;
                        highest_amt = tran_am;
                    }

                    //涨幅历史记录
                    if (idx <= 10)
                    {
                        zfRec += getZfHisStr(c_bar.sec_id,zf);
                    }

                    //记录上次突破K线数
                    if (tp_bar_num == 0 && zf > 4)
                    {
                        tp_bar_num = idx;
                        last_tp_open = Math.Round(c_bar.open, 2);
                    }

                    if (dt_bar_num == 0 && zf < -5)
                    {
                        dt_bar_num = idx;                        
                    }

                    if (zt_bar_num == 0 && zf > 9)
                    {
                        zt_bar_num = idx;
                        zt_bar_open = Math.Round(c_bar.open, 2);
                    }
 
                    if (idx > 1)
                    {
                        pre_sum_price += c_bar.close;
                    }


                    if (idx == 1)
                    {
                        last_price = c_bar.close;                        
                        curBar = c_bar;
                        last_amt = tran_am;
                        zr_low = c_bar.low;

                        zr_open = c_bar.open;
                    }
                    else if (idx == 2)
                    {
                        qt_price = c_bar.close;                       
                        qtDayBar = c_bar;

                        zf_sum_2 = sum_zf;                       
                        top_2_price = Math.Round(highest_price, 2);
                        qt_close = c_bar.close;
                        qt_pre_close = c_bar.pre_close;
                    }
                    else if (idx == 3)
                    {
                        dqt_price = c_bar.close; 

                        low_3_amt = lowest_amt;
                        low_3_price = lowest_price;

                        zf_sum_3 = sum_zf;
                       
                    }
                    else if (idx == 5)
                    {
                        low_5_price = lowest_price;
                        low_5_amt = lowest_amt;

                        high_5_amt = highest_amt;                        
                        sum_5_amt = sum_amt;

                        jj_5 = Math.Round(sum_price / idx, 2);
                        top_5_price = Math.Round(highest_price, 2);

                       
                    }
                    else if (idx == 6)
                    {
                        rsi6 = Math.Round(sum_rsi_zf / (sum_rsi_zf + Math.Abs(sum_rsi_df)), 2) * 100;
                        pre_jj_5 = Math.Round(pre_sum_price / (idx-1), 2);                       
                    }                   
                    else if (idx == 10)
                    {
                        low_10_price = lowest_price;
                        low_10_amt = lowest_amt;

                        zf_sum_10 = sum_zf;
                        sum_10_amt = sum_amt;

                        jj_10 = Math.Round(sum_price / idx, 2);
                    }
                    else if (idx == 11)
                    {
                        pre_jj_10 = Math.Round(pre_sum_price / (idx - 1), 2);                        
                    }
                    else if (idx == 12)
                    {
                        rsi12 = Math.Round(sum_rsi_zf / (sum_rsi_zf + Math.Abs(sum_rsi_df)), 2) * 100;                        
                    }                   
                    else if (idx == 20)
                    {
                        jj_20 = Math.Round(sum_price / idx, 2);                      
                    }
                    else if (idx == 24)
                    {
                        rsi24 = Math.Round(sum_rsi_zf / (sum_rsi_zf + Math.Abs(sum_rsi_df)), 2) * 100;
                       
                    }
                  
                    else if (idx == 30)
                    {
                        jj_30 = Math.Round(sum_price / idx, 2);
                        low_30_price = lowest_price;
                        low_30_amt = lowest_amt;

                        zf_sum_30 = sum_zf;                       
                        sum_30_amt = sum_amt;
                                               
                    }
                    else if (idx == 60)
                    {
                        jj_60 = Math.Round(sum_price / idx, 2);
                        low_60_price = lowest_price;
                        low_60_amt = lowest_amt;                      

                        rsi60 = Math.Round(sum_rsi_zf / (sum_rsi_zf + Math.Abs(sum_rsi_df)), 2) * 100;

                        atr = Math.Round(sum_atr / idx, 2);                       

                        top_60_price = Math.Round(highest_price, 2);

                        sum_60_amt = sum_amt;
                      
                    }                   

                    preBar = c_bar;
                }

                last_price = Math.Round(last_price, 2);
                qt_price = Math.Round(qt_price, 2);
                dqt_price = Math.Round(dqt_price, 2);
                low_10_price = Math.Round(low_10_price, 2);
                last_amt = Math.Round(last_amt, 2);
                low_10_amt = Math.Round(low_10_amt, 2);

                if (curBar == null)
                {
                    continue;
                }

                #endregion
                                        
                #region 基础数据更新
                updSql.Clear();
                if (curBar != null && !String.IsNullOrEmpty(curBar.sec_id))
                {                   
                    updSql.Append("UPDATE gpzfrec SET zr_close=")
                        .Append(last_price)                                                
                        .Append(",jx_5=")
                        .Append(jj_5)
                        .Append(",jx_10=")
                        .Append(jj_10)
                        .Append(",jx_20=")
                        .Append(jj_20)
                        .Append(",jx_30=")                       
                        .Append(jj_30)
                        .Append(",jx_60=")
                        .Append(jj_60)                       
                        .Append(",zr_cjl=")
                        .Append(last_amt)
                        .Append(",low_5=")
                        .Append(low_5_price)
                        .Append(",top_2=")
                        .Append(top_2_price)
                        .Append(",top_5=")
                        .Append(top_5_price)
                        .Append(",top_60=")
                        .Append(top_60_price)
                        .Append(",zf_rec=REVERSE('")
                        .Append(zfRec)
                        .Append("'),rsi_6=")
                        .Append(rsi6)
                        .Append(",rsi_12=")
                        .Append(rsi12)
                        .Append(",rsi_24=")
                        .Append(rsi24)
                        .Append(",zf=")
                        .Append(HGStaUtil.getBarZF(curBar))
                        .Append(",zf2=")
                        .Append(zf_sum_2)
                        .Append(",low_3=")
                        .Append(low_3_price)
                        .Append(",qt_pre_close=")
                        .Append(qt_pre_close)
                        .Append(",zf10=")
                        .Append(zf_sum_10)
                        .Append(",zf30=")
                        .Append(zf_sum_30)
                        .Append(",zf3=")
                        .Append(zf_sum_3)
                        .Append(",zr_open=")
                        .Append(zr_open)         
                        .Append(",qt_close=")
                        .Append(qt_close)
                        .Append(",zr_low=")
                        .Append(zr_low)
                        .Append(",dt_bar_num=")
                        .Append(dt_bar_num)
                        .Append(",tp_bar_num=")
                        .Append(tp_bar_num)
                        .Append(",last_tp_open=")
                        .Append(last_tp_open)
                        .Append(",zt_bar_num=")
                        .Append(zt_bar_num)
                        .Append(",zt_bar_open=")
                        .Append(zt_bar_open)
                        .Append(",syx_bar_num=")
                        .Append(syk_bar_num)
                        .Append(",is_cxg=")
                        .Append(is_cxg)                                     
                        .Append(",date='").Append(DateTime.Today.ToString()).Append("'")
                        .Append(" WHERE CODE='").Append(curBar.sec_id).Append("' or code='").Append(curBar.exchange+"."+curBar.sec_id).Append("'");                   

                    updSqlList.Add(updSql.ToString());

                    if (updSqlList.Count % 50 == 0)
                    {
                        Console.WriteLine("已经出来了【{0}】只股票", process_cnt);
                        MysqlHelper1.ExecuteNoQueryTran(updSqlList);
                        updSqlList.Clear();
                    }
                   
                }
                             
                #endregion                        
                                        
            }

            //批量插入
            if (updSqlList.Count > 0)
            {
                MysqlHelper1.ExecuteNoQueryTran(updSqlList);
                Console.WriteLine("已经出来了【{0}】只股票", process_cnt);
            }

            if (selCnt > 0)
            {
                //GPUtil.helper.ExecuteProcNoOut("call copy_to_gpsel();");
                Console.WriteLine("选股结束选出【{0}】只股票", selCnt);
            }

            Console.WriteLine("结束处理##################");
        }

        public static string getAllJJCodes(string gpcodes)
        {
            StringBuilder rtnCodes = new StringBuilder();
            string tran_code = "";
            foreach (string code in gpcodes.Split(new char[] { ',' }))
            {
                if (code.Length > 6)
                {
                    tran_code = code;
                }
                else if (code.IndexOf("6") == 0)
                {
                    tran_code = "SHSE." + code;
                }
                else if (code.IndexOf("0") == 0 || code.IndexOf("3") == 0)
                {
                    tran_code = "SZSE." + code;
                }
                else
                {
                    tran_code = code;
                }

                rtnCodes.Append(tran_code).Append(",");
            }

            if (!String.IsNullOrEmpty(rtnCodes.ToString()))
            {
                return rtnCodes.ToString().Substring(0, rtnCodes.ToString().LastIndexOf(","));
            }

            return "";
        }

        public static string getZfHisStr(string code,double in_zf)
        {

            string v_zf_str = "";
            if (code.Equals("000001"))
            {
                if (in_zf <= -0.5)
                {
                    v_zf_str = "3";
                }             
                else if (in_zf >= 0.4)
                {
                    v_zf_str = "5";
                }               
                else
                {
                    v_zf_str = "1";
                }
            }
            else if (code.Equals("399001"))
            {               
                if (in_zf <= -0.6)
                {
                    v_zf_str = "3";
                }
                else if (in_zf >= 0.5)
                {
                    v_zf_str = "5";
                }
                else
                {
                    v_zf_str = "1";
                }
            }
            else if (code.Equals("399006"))
            {
                if (in_zf <= -0.7)
                {
                    v_zf_str = "3";
                }
                else if (in_zf >= 0.6)
                {
                    v_zf_str = "5";
                }
                else
                {
                    v_zf_str = "1";
                }
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
                }
            }
            

            return v_zf_str;
		
        }

    }
}
