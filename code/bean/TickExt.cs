using GMSDK;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MdTZ
{

    /**
        TICK 扩展
    **/
    public class TickExt : Tick
    {
        /**
         * 附加属性
         **/
        public double zhengf { get; set; } //振幅
        public double jj { get; set; } //均价
        public double zf { get; set; }//涨幅
        
    }
}
