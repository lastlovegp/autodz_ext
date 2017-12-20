using GMSDK;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MdTZ
{
    class Jx2Vars
    {
        public List<Bar> fastMA { get; set; } //快速均线
        public List<Bar> slowMA { get; set; } //慢速均线
        public bool conCrossOver { get; set; } //是否金叉（快速均线上穿慢速均线)
        public bool conCrossUnder { get; set; } //是否死叉（快速均线下穿慢速均线)

        public double hh { get; set; } //最近N跟BAR 的高点
        public double ll { get; set; } //最近N跟BAR 的地点

        public double lEntryPrice { get; set; } //开多的突波价
        public double sEntryPrice { get; set; } //开空的突波价

        public int lCount { get; set; } //均线金叉后记录BAR序号

        public int sCount { get; set; } //均线死叉后记录BAR序号

        public double trailStopPrice { get; set; } //跟踪止损的止损价

        public double reEntryPrice { get; set; } //再进场突波开仓的价格

        public double reEntryCount { get; set; } //跟踪止损后记录BAR 序号

    }
}
