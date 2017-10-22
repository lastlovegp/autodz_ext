using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MdTZ
{
    class StrateSta
    {

        public List<PositionDb> positionDbList { get; set; }

        public double initial_cash { get; set; }
      
        public int dp_time_qs { get; set; }

        public int dp_qs { get; set; }

        public int total_dws { get; set; }

        public int bar_seq_cnt { get; set; }

        public double dw_amt { get; set; }

        public int buy_cnt { get; set; }

        public bool is_dp_lowLevel { get; set; }

        public TranBean dp { get; set; }

        public TranBean sz50 { get; set; }

        public TranBean zxb { get; set; }

        public TranBean cyb { get; set; }

        public BarTotal bar_dp { get; set; }

        public String cf_zb { get; set; } //触发指标

    }
}
