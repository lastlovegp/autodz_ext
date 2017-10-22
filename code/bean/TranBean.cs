using GMSDK;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MdTZ
{
    class TranBean
    {

        public List<Tick> buyCodes = new List<Tick>();  
        public List<TranBean> zbBeans { get; set; } //指标BEAN
        public bool isClearXHFlag { get; set; } //是否大盘
        public  bool isDp { get; set; } //是否大盘
        public bool isZxp { get; set; } //是否大盘
        public bool isSZ50{ get; set; } //是否深市
        public bool isCYB { get; set; } //是否创业板
        public long seq { get; set; } //TICK 序号
        public bool isTodayXyx { get; set; } //当日下影线
        public bool isTodaySyx { get; set; } //当日上影线      
        public string code { get; set; } //代码
        public int cqFlag { get; set; } //除权标志

        public int top_5_bar_nums { get; set; } //5日最高离现在距离
        public int top_20_bar_nums { get; set; } //20日最高离现在距离

        public GpInfo gpInfo { get; set; } //股票基本信息      
        public double zf { get; set; } //涨幅
        public double fszb { get; set; } //分时占比
        public double fszb_ext { get; set; } //分时占比
        public double zhengFu { get; set; }      
        public double pre_tick_price { get; set; } //上次记录TICK价格
        public double pre_pre_tick_price { get; set; } //上次记录TICK价格
        public double zf1sec { get; set; } //1分钟涨幅
        public int tp_cnt { get; set; } //向上突破次数（分时线)
        public bool is_low_timejj { get; set; } //向上突破次数（分时线)
        public int buyNum { get; set; } //突破均线次数
        public int tp_timejj_num { get; set; } //突破均线次数
        public long tp_tick_seq_cg_sum { get; set; }
        public long last_tp_tick_seq { get; set; }
        public double tp_last_price { get; set; } // 突破价格
        public double pre_tp_last_price { get; set; } // 突破价格
        public long tp_seq { get; set; } //突破时候TICK 序号
        public string strtime { get; set; }
        public double btime { get; set; } //交易时间
        public double b_buy_time { get; set; }
        public Tick tick { get; set; }
        public GpTotal gpTotal { get; set; } //指标统计对象
        public Position position { get; set; } //仓位
        public PositionDb positionDb{ get; set; } // 本地仓位
        public DailyBar lastDailyBar { get; set; }
        public DailyBar qtDailyBar { get; set; }
        public DailyBar pre_qtDailyBar { get; set; } 
        public int xh_flag { get; set; }
        public int xh_type { get; set; }
        public double ykl { get; set; } //盈亏率
        public double todayJJ5 { get; set; }
        public double todayJJ10 { get; set; }
        public double todayJJ20 { get; set; }
        public double todayJJ30 { get; set; }
        public double timejj { get; set; } //分时均价
        public int less_timejj_cnt { get; set; } //小于均价次数
        public int less_timejj_cnt_ext { get; set; } //小于均价次数
        public int more_timejj_cnt { get; set; }
        public int more_timejj_cnt_ext { get; set; }
        public int buy_cnt { get; set; }
        public int xh_cnt { get; set; }      
        public int sell_xh_cnt { get; set; }
        public int sell_cnt { get; set; }
        public bool strong_sell_flag { get; set; } //强制清空
        public int gp_time_qs { get; set; } //分时趋势
        /// <summary>
        /// 当日最高
        /// </summary>
        public double high { get; set; }
        public string highest_time { get; set; }
        public double low { get; set; }
        public double low1 { get; set; }
        public double low2 { get; set; }
        public double low3 { get; set; }
        public double high1 { get; set; }
        public double high2 { get; set; }
        public double high3 { get; set; }
        public string lowest_time { get; set; }
        public int load_time_flag { get; set; }

        public DateTime tickDate { get; set; }

    }
}
