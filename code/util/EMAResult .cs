using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MdTZ
{
    class EMAResult
    {

        public List<double> Values { get; set; }

        /// <summary> 
        /// Represents the index of input signal at which the indicator starts 
        /// </summary> 
        public int StartIndexOffset { get; set; } 
    }
}
