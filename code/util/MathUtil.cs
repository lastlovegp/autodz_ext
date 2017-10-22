using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MdTZ
{
    class MathUtil
    {
        /// <summary> 
        /// Calculates Exponential Moving Average (EMA) indicator 
        /// </summary> 
        /// <param name="input">Input signal</param> 
        /// <param name="period">Number of periods</param> 
        /// <returns>Object containing operation results</returns> 
        public static EMAResult EMA(IEnumerable<double> input, int period)
        {
            var returnValues = new List<double>();

            double multiplier = (2.0 / (period + 1));
            double initialSMA = input.Take(period).Average();

            returnValues.Add(initialSMA);

            var copyInputValues = input.ToList();

            for (int i = period; i < copyInputValues.Count; i++)
            {
                var resultValue = (copyInputValues[i] - returnValues.Last()) * multiplier + returnValues.Last();

                returnValues.Add(resultValue);
            }

            var result = new EMAResult()
            {
                Values = returnValues,
                StartIndexOffset = period - 1
            };

            return result;
        }


        public static double MA(int[] data, int start, int duration)
        {
            //前后分别补充两个-1,
            var para = Enumerable.Repeat(-1, duration - 1)
                .Concat(data)
                .Concat(Enumerable.Repeat(-1, duration - 1))
                .ToArray();

            //跳过前start个,取duration个,排除补的-1,得出平均值
            /*
            para = para.Skip(start).ToArray();
            para = para.Take(duration).ToArray();
            para = para.Where(x => x > 0).ToArray();
            var re = para.Average();
            return re;
             */
            return para
                .Skip(start)
                .Take(duration)
                .Where(x => x > 0)
                .Average();
        }


    }
}
