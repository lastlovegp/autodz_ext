using GMSDK;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MdTZ
{
    /// <summary>
    /// 模拟盘
    /// </summary>
    class Strategy_DEMO : Strategy
    {
        //标的状态
        public Dictionary<string, TranBean> tranBeanDic = new Dictionary<string, TranBean>();

        //标的状态
        public Dictionary<string, BarTotal> barDic = new Dictionary<string, BarTotal>();

        //策略状态
        public StrateSta strateSta = new StrateSta();

        private int tick_cnt = 0;

        private bool isStartMainStr = false;
       
    
        /// <summary>
        /// 收到tick事件，在这里添加策略逻辑。我们简单的每10个tick开仓/平仓，以最新价下单。
        /// </summary>
        /// <param name="tick"></param>
        public override void OnTick(Tick tick)
        {
            Console.WriteLine(tick.sec_id);
            //刷新
            if ("000001".Equals(tick.sec_id))
            {
                tick_cnt++;
                if (!HGStaUtil.isTraning && MdComm.str_mode != 4 && tick_cnt % 10 == 0)
                {
                    HGStaUtil.isTraning = true;
                    ZXApi.refreshWin();
                    HGStaUtil.isTraning = false;
                }               
            }
                                     
        }

        /// <summary>
        /// 10点半以后
        /// 1,第 4,5条 bar 最高超过之前最高-> 买入
        /// 2,大于昨天
        /// </summary>
        /// <param name="bar"></param>
        public override void OnBar(Bar bar)
        {
            //大盘    
            if (bar.sec_id.Equals("000001"))
            {
                BarTotal bean = HGStaUtil.getBarTotal(this, barDic, bar, strateSta);
            }                           
        }            

     
    }
}
