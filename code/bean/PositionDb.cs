using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MdTZ
{

    /// <summary>
    /// 仓存类
    /// </summary>
    class PositionDb
    {
         public string code { get; set; }
         public DateTime indate { get; set; }
         public DateTime outdate { get; set; }
         public int inxh { get; set; }
         public int available { get; set; }
         public int available_today { get; set; }

        public double vwap { get; set; }

        public double price { get; set; }

        public double cost { get; set; }

        public double sumZf { get; set; }

        public double fpnl { get; set; }

        public string hy { get; set; }

        public string gn { get; set; }

        public int can_tran_dw { get; set; }

        public double selltime { get; set; }
        public double zy { get; set; }
        public double zs { get; set; } 

        public int flag { get; set; }
    }
}
