using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GMSDK;

namespace MdTZ
{
    class BarTotal
    {
        public int seq { get; set; }
        public string code { get; set; }
        public string strtime { get; set; }

        /// <summary>
        /// 当日最高
        /// </summary>
        public double high { get; set; }
        public string highest_time { get; set; }

        public double low { get; set; }
        public string lowest_time { get; set; }

        public bool isDp { get; set; }
        public bool isSZ { get; set; }
        public bool isCYB { get; set; }      
        public int xh_cnt { get; set; }    
        public int sell_cnt { get; set; }
        public int sell_xh_cnt { get; set; }
        public int xh_flag { get; set; }
        public int xh_type { get; set; }
        public double ykl { get; set; } //盈亏率

        public PositionDb positionDb { get; set; } // 本地仓位

        /// <summary>
        /// 当日最大
        /// </summary>
        public double volume { get; set; }

        public double close { get; set; }
      
        public double pre_close { get; set; }

        public double btime { get; set; }

        public GpTotal gpTotal { get; set; }

        /// <summary>
        /// 昨天
        /// </summary>
        public DailyBar lastDailyBar { get; set; }

        /// <summary>
        /// 前天
        /// </summary>
        public DailyBar qtDailyBar { get; set; }

        public double zf { get; set; }

        public Bar bar { get; set; }

        public int buy_cnt { get; set; }    

        public bool strong_sell_flag { get; set; } //强制清空

        public bool strong_buy_flag { get; set; } //强制清空

        public int gp_time_qs { get; set; } //分时趋势      

    }
}
