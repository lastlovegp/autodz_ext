using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MdTZ
{
    class FsZbComparer :IComparer<GpTime>
    {

        //实现姓名升序
        public int Compare(GpTime x, GpTime y)
        {
            return (x.fszb.CompareTo(y.fszb));
        }
    }
}
