using GMSDK;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace MdTZ
{
    /// <summary>
    ///  行情获取对象
    ///  
    /// </summary>
    class MdComm
    {
        #region 常量定义
        public const string DEFAULT_STRATAGY_CONFIG = "strategy.ini";
        public const string DEFAULT_STRATAGY_ID = "startegy_1";
        public const double DEFAULT_INITIAL_CASH = 1000000;

        public const string JJ_ACCOUNT = "18221685724";
        public const string JJ_PASSWORD = "198322";
        public const string JJ_BACK_URL = "localhost:8001";

        //掘金服务连接状态
        public static int ERROR_CODE = 0;

        //交易模式
        public static int TRAN_MODE = GPConstants.TRAN_MODE_RISK;
        public static int TRAN_FALG = 1; //实盘开关
        public static int IN_TYPE = 0; //入场模式 0:右侧;1:左侧
        public static int IS_10_LOWEST_ANOUMT = 0; //是否10日最低

        public static int SYN_FLAG = 0; //同步标志       
        public static int JJ_SP_FLAG = 0; //掘金实盘开关
        public static int SL_SP_FLAG = 0; //新浪开关实盘
        public static double US_GP_ZF = 0; //美股当天涨幅


        /// <summary>
        /// 日频行情
        /// 日频行情仅在策略回测时订阅使用，其他策略运行模式下订阅将接收不到DailyBar。
        /// </summary>
        public const string HQ_TYPE_DAILY = "daily";

        public static MdApi md = null;
        private static bool isInit = false;

        public static int str_mode = 3;
        public static int post_cnt = 0; //仓位股票只数
        public static int SP_TRAN_FLAG = 0; //实盘标志，加锁控制
        public static String TEST_BEG_DATE = null;     

        #endregion

        private static string getSinaCodes(string codes)
        {
            string sqlCodes = "";
            if (codes.IndexOf(",") == -1)
            {
                sqlCodes = SinaAPI.getUrlCode(codes);
            }
            else
            {
                foreach (string subCode in codes.Split(','))
                {
                    sqlCodes += SinaAPI.getUrlCode(subCode);
                }

                sqlCodes = sqlCodes.Substring(0, sqlCodes.LastIndexOf(","));
            }

            return sqlCodes;
        }

        /// <summary>
        /// 初始化 MD 对象
        /// </summary>
        public static void initMd()
        {
            if (isInit)
            {
                return;
            }

            //本例子演示如何用行情API提取数据
            md = MdApi.Instance;

            int ret = md.Init(JJ_ACCOUNT, JJ_PASSWORD);

            if (ret != 0)
            {
                isInit = false;
                //登录失败
                return;
            }
            else
            {
                isInit = true;
            }
        }

        /// <summary>
        /// 设置配置文件
        /// </summary>
        /// <param name="strategy"></param>
        /// <param name="cfgFile"></param>
        /// <returns></returns>
        public static int setStrategyConfig(Strategy strategy, string cfgFile)
        {
            if (string.IsNullOrEmpty(cfgFile))
            {
                return -1;
            }

            int ret = strategy.InitWithConfig(cfgFile);          
            if (ret != 0)
            {
                System.Console.WriteLine("Init error: {0}", ret);
            }

            return ret;

        }            

        /// <summary>
        /// 初始化策略
        /// </summary>
        /// <param name="strategy"></param>
        /// <param name="mdMode"></param>
        /// <param name="codes"></param>
        /// <param name="strategyId"></param>
        /// <param name="bar_cfg"></param>
        /// <param name="init_cash"></param>
        /// <param name="btime"></param>
        /// <param name="etime"></param>
        /// <returns></returns>
        public static int setStrategyInit(Strategy strategy,
            int mdMode, string codes,
            string strategyId, string bar_cfg,
            double init_cash, string btime, string etime)
        {

            Console.WriteLine("股票标的:{0}", codes);
            string getHisCode = codes;

            //初始化止损，止盈参数
            RiskMng.setRiskParam();           

            codes = HGStaUtil.DP_CODES + "," + codes;

            //初始化100万本金
            if (init_cash == 0)
            {
                init_cash = DEFAULT_INITIAL_CASH;
            }          

            if (String.IsNullOrEmpty(codes))
            {
                return -1;
            }

            if (string.IsNullOrEmpty(strategyId))
            {
                strategyId = DEFAULT_STRATAGY_ID;
            }

            string subscribe_symbols = "";
            string symbols = "";
            List<string> codeList = codes.Split(",".ToCharArray()).ToList();
            foreach (string c in codeList)
            {
                if (bar_cfg == null && HGStaUtil.DP_CODES.IndexOf(c) != -1)
                {
                    bar_cfg = "bar.60";
                }
                subscribe_symbols += MdComm.getJJCfgCode(c, "tick", bar_cfg) + ",";
                if (HGStaUtil.DP_CODES.IndexOf(c) == -1)
                {
                    symbols += MdComm.getJJCode(c) + ",";
                }
               
            }

            //初始化
            HGStaUtil.initTotalBean(null, codes, btime, etime);

            int ret = -1;
            switch (mdMode)
            {
                case 1:
                    ret = strategy.Init(JJ_ACCOUNT,
                         JJ_PASSWORD,
                         strategyId,
                         subscribe_symbols,
                         MDMode.MD_MODE_NULL,
                         JJ_BACK_URL);
                    break;
                case 2:
                case 6:
                case 7:
                    ret = strategy.Init(JJ_ACCOUNT,
                         JJ_PASSWORD,
                         strategyId,
                         subscribe_symbols,
                         MDMode.MD_MODE_LIVE,
                         JJ_BACK_URL);
                    break;
                case 3:
                    ret = strategy.Init(JJ_ACCOUNT,
                        JJ_PASSWORD,
                        strategyId,
                        subscribe_symbols,
                        MDMode.MD_MODE_SIMULATED,
                        JJ_BACK_URL);
                    break;
                case 4:                   
                case 5:                                
                    ret = strategy.Init(JJ_ACCOUNT,
                         JJ_PASSWORD,
                         strategyId,
                         subscribe_symbols,
                         MDMode.MD_MODE_PLAYBACK,
                         JJ_BACK_URL);
                    break;                
                default:
                    ret = strategy.Init(JJ_ACCOUNT,
                         JJ_PASSWORD,
                         strategyId,
                         subscribe_symbols,
                         MDMode.MD_MODE_SIMULATED,
                         JJ_BACK_URL);
                    break;
            }

            if (ret != 0)
            {
                System.Console.WriteLine("Init error: {0}", ret);
            }
            else
            {
                if (mdMode == 4 || mdMode == 6)
                {
                    DateTime testBtime = Convert.ToDateTime(btime).AddMonths(-3);                    
                    if (String.IsNullOrEmpty(MdComm.TEST_BEG_DATE))
                    {
                        MdComm.TEST_BEG_DATE = testBtime.ToString("yyyy-MM-dd") + " 09:25:00";                      
                    }

                    Console.WriteLine("回测开始时间 {0} 结束时间 {1} 总金额 {2}",
                            MdComm.TEST_BEG_DATE, etime, init_cash);
                    setStrategyBackTestInit(strategy, MdComm.TEST_BEG_DATE, etime, init_cash);

                    //六个月前日线
                    if (mdMode == 4)
                    {
                        Console.WriteLine("导入历史信息成功 begin...");

                        DataRow strRow = GPUtil.helper.ExecuteDataRow("SELECT GROUP_CONCAT(DISTINCT CODE) gpcodes FROM gpsel WHERE zbflag = 0", GPUtil.parms);
                        String addCodes = "";
                        if (strRow != null)
                        {
                            addCodes += "," + strRow["gpcodes"].ToString();
                        }

                        foreach (string code in addCodes.Split(",".ToCharArray()))
                        {
                            if (String.IsNullOrEmpty(code) || symbols.IndexOf(code) != -1)
                            {
                                continue;
                            }
                            symbols += ","+ MdComm.getJJCode(code);                           
                        }

                        JJUtil.loadGpDayHisList(symbols, testBtime.ToString("yyyy-MM-dd") + " 09:25:00", etime);

                       
                        Console.WriteLine("导入历史信息成功 end....");
                    }
                   
                   
                } else if (mdMode == 5) {
                    Console.WriteLine("回测开始时间 {0} 结束时间 {1} 总金额 {2}",
                            MdComm.TEST_BEG_DATE, etime, init_cash);
                    setStrategyBackTestInit(strategy, MdComm.TEST_BEG_DATE, etime, init_cash);                   
                }


            }

            return ret;

        }
     


        /// <summary>
        /// 参数名	类型	说明        
        /**
            start_time	string	回放行情开始时间，格式：yyyy-MM-dd HH:MM:ss
            end_time	string	回放行情结束时间，格式：yyyy-MM-dd HH:MM:ss
            initial_cash	double	回测初始资金，默认1000000
            transaction_ratio	double	委托量成交比率,默认1，按委托量全部成交
            commission_ratio	double	手续费率,默认0，无手续费
            slippage_ratio	double	滑点比率,默认0，无滑点
            price_type	int	复权方式，0-不复权，1-前复权 **/
        /// </summary>
        /// <param name="strategy"></param>
        /// <param name="start_time"></param>
        /// <param name="end_time"></param>
        /// <param name="initial_cash"></param>
        public static void setStrategyBackTestInit(Strategy strategy, string start_time,
               string end_time,
               double initial_cash
         )
        {
            if (initial_cash == 0)
            {
                initial_cash = DEFAULT_INITIAL_CASH;
            }

            strategy.BacktestConfig(start_time, end_time, initial_cash, 1, 0, 0, 1,null);
        }

        /// <summary>
        ///  转化URL code
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public static string getJJCfgCode(string code, string tick_cfg, string bar_cfg)
        {
            string rtnCode = "";
            if (string.IsNullOrEmpty(code))
            {
                return rtnCode;
            }

            if (code.ToUpper().IndexOf("SHSE") != -1 
                || code.ToUpper().IndexOf("SZSE") != -1
                || code.ToUpper().IndexOf("CFFEX") != -1
                || code.ToUpper().IndexOf("CZCE") != -1
                || code.ToUpper().IndexOf("DCE") != -1
                || code.ToUpper().IndexOf("SHFE") != -1)
            {
                rtnCode = code;
            }

            if (code.IndexOf(".") != -1)
            {
                rtnCode = code;
            }

            if (code.IndexOf("sh") != -1 || code.IndexOf("sz") != -1)
            {
                code = code.Replace("sh", "").Replace("sz", "");
            }

            if (code.IndexOf("000001") == 0)
            {
                rtnCode = "SHSE." + code;
            }
            else if (code.IndexOf("6") == 0)
            {
                rtnCode = "SHSE." + code;
            }
            else if (code.IndexOf("0") == 0 || code.IndexOf("3") == 0)
            {
                rtnCode = "SZSE." + code;
            }

            string cfgRtnCode = rtnCode;
            if (!string.IsNullOrEmpty(tick_cfg))
            {
                cfgRtnCode = rtnCode + "." + tick_cfg;
            }

            if (!string.IsNullOrEmpty(bar_cfg))
            {
                cfgRtnCode = cfgRtnCode + "," + rtnCode + "." + bar_cfg;
            }

            return cfgRtnCode;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public static string getJJCode(string code)
        {
            return getJJCfgCode(code, "", "");
        }


      



    }

}
