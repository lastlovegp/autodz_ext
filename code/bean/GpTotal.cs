using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MdTZ
{
    public class GpTotal
    {
        public string code { get; set; } //股票代码
        public string stime { get; set; } //交易时间
        public string type { get; set; } //交易类型 s:卖出 b:买入     
        public double costPrice { get; set; } //成本价
        public double buyzf { get; set; } //买入涨幅          
        public int minUnit { get; set; } //交易最小单位
        public int lxsz_bar_num { get; set; } //联系3天以上上涨距现在K柱数
        public int zt_bar_num { get; set; } //涨停离现在K柱数
        public int tp_bar_num { get; set; } //突破离现在K柱数
        public double last_tp_open { get; set; } //突破时开盘价

        public int dt_max_bar_num { get; set; } //跌停离现在K柱数
        public int dt_bar_num { get; set; } //跌停离现在K柱数
        public int syx_bar_num { get; set; } //上长影线离现在K柱数
        public int xyx_bar_num { get; set; } //下长影线离现在K柱数

        public double atr { get; set; } //atr 指标
        public double tr { get; set; } //tr 指标
        public double pj_15_zhengfu { get; set; } //平均振幅
        public double pj_30_zhengfu { get; set; } //平均振幅
        public double pj_60_zhengfu { get; set; } //平均振幅

        public double rsi6 { get; set; }
        public double rsi12 { get; set; }
        public double rsi24 { get; set; }

        public double ema10 { get; set; } //10日指数平均     
        public double ddd { get; set; } //dma里面指标

        public double jj5 { get; set; } //均价
        public double jj10 { get; set; } //均价       
        public double jj20 { get; set; } //均价
        public double jj30 { get; set; } //均价     
        public double jj50 { get; set; } //均价  
        public double jj60 { get; set; } //均价       
        public string k10_str { get; set; } //10日K线
      
        public double top_2_day { get; set; }      
        public double top_5_day { get; set; } //5日最高价
        public double top_10_day { get; set; } //5日最高价
        public double top_20_day { get; set; } //5日最高价    
        public double top_30_day { get; set; } //5日最高价
        public double top_60_day { get; set; } //5日最高价

        public double low_2_day { get; set; } //5日最低价   
        public double low_3_day { get; set; } //5日最低价   
        public double low_5_day { get; set; } //5日最低价   
        public double low_10_day { get; set; }
        public double low_20_day { get; set; }
        public double low_30_day { get; set; }
        public double low_60_day { get; set; }

        public double low_cjl_5_day { get; set; } //5日最低价   
        public double low_cjl_10_day { get; set; }
        public double low_cjl_20_day { get; set; }
        public double low_cjl_30_day { get; set; }
        public double low_cjl_60_day { get; set; }
      
        public double sum3Zf { get; set; }
        public double sum2Zf { get; set; }
        public double sum2ABSZf { get; set; }
        public double sum4Zf { get; set; }
        public double sum5Zf { get; set; }
        public double sum10Zf { get; set; }
        public double sum15Zf { get; set; }
        public double sum20Zf { get; set; }
        public double sum30Zf { get; set; }
        public double sum60Zf { get; set; }
        public double sum90Zf { get; set; }

        public DateTime top_5_day_date { get; set; } //5日最高价时间
        public DateTime top_20_day_date { get; set; } //5日最高价时间
        public DateTime low_5_day_date { get; set; } //5日最高价时间
        public GpTotal preGpTotal { get; set; } //昨日
        public GpTotal qtGpTotal { get; set; } //前日
       
    }
}
