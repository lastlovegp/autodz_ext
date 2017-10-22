using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MdTZ
{
    /// <summary>
    /// 总仓位
    /// </summary>
    class StoreDb
    {
        public string code { get; set; }
        public double total { get; set; }
        public double gpsz { get; set; }
        public double zjye { get; set; }
        public double ykje { get; set; }
        public double ykl { get; set; }
        public double pamt { get; set; }
        public double syl { get; set; }

        public int per_cnt { get; set; }
    }
}
