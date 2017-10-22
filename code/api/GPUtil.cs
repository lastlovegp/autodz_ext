using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using MySql.Data.MySqlClient;
using System.IO;
using System.Windows.Forms;
using GMSDK;
using System.Reflection;

namespace MdTZ
{
    class GPUtil
    {
        /// <summary>
        /// 
        /// 所有股票代码
        /// </summary>
        /// 
        public static bool isTest = true;
        public static string codes = "";
        public static string sinaHeyCodes = "";  
        public static MySqlHelper helper = new MySqlHelper();
        public static MySqlParameter[] parms = new MySqlParameter[] { };

        public static string top1hy = "";
        public static int STORE_GP_NUMS = 0; //持仓股票数

        public static string HY_HOT_STRS = ""; //行业排名
        public static string GN_HOT_STRS = ""; //概念排名
        public static int JJ_BUY_CNT = 0; //掘金买人数
        public static int TOTAL_BUY_CNT = 0; //总计买人数量

        public static List<int> buyList = new List<int>();

        //套利集合
        public static Dictionary<string, string> TL_MAP = new Dictionary<string, string>();
        public static Dictionary<string, string> TL_FLAG = new Dictionary<string, string>();

        /**
         * 当前交易日
         * */
        public static DateTime nowTranDate { get; set; }

        public static bool isTranTime()
        {
            if (isTest)
            {
                return true;
            }
            //后面不是
            if (Convert.ToInt16(DateTimeHelper.GetWeekNumberOfDay(DateTime.Now)) >= 6)
            {
                return false;
            }    

            //9 下午3点以后不做了
            if (DateTime.Now.Hour <= 9 || DateTime.Now.Hour >= 16)
            {
                return false;
            }

            return true;
        }


        /// <summary>
        /// 加载套利清单
        /// </summary>
        public static void loadTaoLiList()
        {
            DataTable dataTable = GPUtil.helper.ExecuteDataTable("SELECT gn TYPE,GROUP_CONCAT(CODE) tlcode FROM gpsel WHERE zbflag =0 GROUP BY gn", GPUtil.parms);
            TL_MAP.Clear();
            if (dataTable != null)
            {           
                foreach (DataRow row in dataTable.Rows)
                {
                    TL_MAP.Add(row["TYPE"].ToString(), row["tlcode"].ToString());                   
                }
            }
        }

        public static void setTodayTranDay() {

             //最近交易日                      
            if (Convert.ToInt16(DateTimeHelper.GetWeekNumberOfDay(DateTime.Now)) >= 6)
            {
               GPUtil.nowTranDate = Convert.ToDateTime(SinaAPI.getGPList("sh600006")[0].date).Date;
            }
            else
            {
                GPUtil.nowTranDate = DateTime.Now.Date;
            }
           
            GPUtil.updateTranDate();
        }

        public static void updateTranDate()
        {
            GPUtil.helper.ExecuteNonQuery("update gpparam set jydate='" + GPUtil.nowTranDate + "'");
        }

        /// <summary>
        /// 买入时候的信号类型记录
        /// </summary>
        /// <param name="code"></param>
        /// <param name="xhType"></param>
        public static void updatePosition(int side, string code,int xhType,int volume,double price,DateTime tranTime,string type)
        {

            GPUtil.helper.ExecuteProcNoOut("CALL upd_position(" + side + ",'" + code + "'," + xhType + "," 
                + volume + "," + Math.Round(price,2) + ",'"+tranTime.ToString()+"','"+type+"')");
           
        }

        public static void clearPosition(string code)
        {
            GPUtil.helper.ExecuteNonQuery("delete from position where code='" + code + "'");            
        }

        /// <summary>
        /// 初始化仓位
        /// </summary>
        /// <param name="code"></param>
        public static void initPosition(string stime)
        {           
            if (string.IsNullOrEmpty(stime))
            {
                stime = GPUtil.nowTranDate.ToString();
            }
            else
            {
                stime = Convert.ToDateTime(stime).ToString();
            }
            GPUtil.helper.ExecuteNonQuery("UPDATE POSITION SET available_today = 0 WHERE indate < '"+stime+"'");           
        }      

        /// <summary>
        /// 
        /// 持仓股票数
        /// </summary>
        /// <returns></returns>
        public static int getStoreGpNum()
        {            
            DataRow row = GPUtil.helper.ExecuteDataRow("select count(*) gpnum from position p where p.available > 0");
            if (row != null)
            {
                return Convert.ToInt16(row["gpnum"]);
            }

            return 0;
        }

        public static int getJJStoreGpNum()
        {
            DataRow row = GPUtil.helper.ExecuteDataRow("select count(*) gpnum from position p where p.available > 0 and p.inxh >=20");
            if (row != null)
            {
                return Convert.ToInt16(row["gpnum"]);
            }

            return 0;
        }

        /// <summary>
        /// 信号类型
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public static PositionDb getPositionDb(string code)
        {
            PositionDb positionDb = null;
            string sql = "select position.code,hy,'',indate,ifnull(outdate,null) outdate,inxh,ifnull(available,0) available,ifnull(available_today,0) available_today," +
                        "ifnull(sumzf,0) sumzf,ifnull(vwap,0) vwap,ifnull(price,0) price,ifnull(selltime,0) selltime,zy,zs from position,gp where position.code=gp.code " +
                        " and position.code='" + code + "'";
            DataRow row = GPUtil.helper.ExecuteDataRow(sql);
            if (row != null)
            {
                positionDb = new PositionDb();
                positionDb.inxh = Convert.ToInt16(row["inxh"]);
                positionDb.code = row["code"].ToString();
                positionDb.hy = row["hy"].ToString();
                positionDb.gn = "";
                positionDb.indate = Convert.ToDateTime(row["indate"]);
                bool isDBNull = Convert.IsDBNull(row["outdate"]);
                if (!isDBNull)
                {
                    positionDb.outdate = Convert.ToDateTime(row["outdate"]);
                   
                }
                isDBNull = Convert.IsDBNull(row["selltime"]);
                if (!isDBNull)
                {                  
                    positionDb.selltime = Convert.ToDouble(row["selltime"]);
                }    
                positionDb.available = Convert.ToInt32(row["available"]);
                positionDb.available_today = Convert.ToInt32(row["available_today"]);
                positionDb.price = Convert.ToDouble(row["price"]);
                positionDb.vwap = Convert.ToDouble(row["vwap"]);
                positionDb.sumZf = Convert.ToDouble(row["sumzf"]);
                positionDb.can_tran_dw = (positionDb.available - positionDb.available_today) / 100;
             
                positionDb.zs = Convert.ToDouble(row["zs"]);
                positionDb.zy = Convert.ToDouble(row["zy"]);
            }

            return positionDb;
        }


        public static List<PositionDb> getAllPositionDb()
        {
            List<PositionDb> rtnList = new List<PositionDb>();
            PositionDb positionDb = null;
            string sql = "select position.code,hy,'',indate,ifnull(outdate,null) outdate,inxh,ifnull(available,0) available,ifnull(available_today,0) available_today,"
                        + "ifnull(sumzf,0) sumzf,ifnull(vwap,0) vwap,ifnull(price,0) price,ifnull(selltime,0) selltime,zy,zs "
                        + " from position,gp where position.code=gp.code";
            DataRow row = GPUtil.helper.ExecuteDataRow(sql);
            if (row != null)
            {
                positionDb = new PositionDb();
                positionDb.inxh = Convert.ToInt16(row["inxh"]);
                positionDb.code = row["code"].ToString();
                positionDb.hy = row["hy"].ToString();
                positionDb.gn = "";
                positionDb.indate = Convert.ToDateTime(row["indate"]);
                bool isDBNull = Convert.IsDBNull(row["outdate"]);
                if (!isDBNull)
                {
                    positionDb.outdate = Convert.ToDateTime(row["outdate"]);
                }
                positionDb.available = Convert.ToInt32(row["available"]);
                positionDb.available_today = Convert.ToInt32(row["available_today"]);
                positionDb.price = Convert.ToDouble(row["price"]);
                positionDb.vwap = Convert.ToDouble(row["vwap"]);
                positionDb.sumZf = Convert.ToDouble(row["sumzf"]);
                positionDb.can_tran_dw = (positionDb.available - positionDb.available_today) / 100;

                isDBNull = Convert.IsDBNull(row["selltime"]);
                if (!isDBNull)
                {
                    positionDb.selltime = Convert.ToDouble(row["selltime"]);
                }
              
                positionDb.zs = Convert.ToDouble(row["zs"]);
                positionDb.zy = Convert.ToDouble(row["zy"]);
                rtnList.Add(positionDb);
            }

            return rtnList;
        }

        /// <summary>
        /// 总仓位获取
        /// </summary>
        /// <returns></returns>
        public static StoreDb getStoreDb()
        {
            StoreDb storeDb = null;
            DataRow row = GPUtil.helper.ExecuteDataRow("select code,total,gpsz,zjye,ykje,ykl,pamt,syl,per_cnt from store where code='001'");
            if (row != null)
            {
                storeDb = new StoreDb();
                storeDb.code = row["code"].ToString();
                storeDb.total = Convert.ToDouble(row["total"]);
                storeDb.gpsz = Convert.ToDouble(row["gpsz"]);
                storeDb.zjye = Convert.ToDouble(row["zjye"]);
                storeDb.ykje = Convert.ToDouble(row["ykje"]);
                storeDb.ykl = Convert.ToDouble(row["ykl"]);
                storeDb.pamt = Convert.ToDouble(row["pamt"]);
                storeDb.syl = Convert.ToDouble(row["syl"]);
                storeDb.per_cnt = Convert.ToInt16(row["per_cnt"]);
            }

            return storeDb;
        }

        public static string getMGZFStr()
        {
            string zf = "";
            DataRow row = GPUtil.helper.ExecuteDataRow("SELECT zf_rec FROM gpzfrec WHERE CODE = 'int_dji'");
            if (row != null)
            {
                zf = row["zf_rec"].ToString();
            }            
            return zf;
        }

        /// <summary>
        /// 交易模式获取
        /// </summary>
        /// <returns></returns>
        public static int updGpParam()
        {
            int tranmode =0;
            int tranflag = 1;
            int intype = 0;
            int synFlag = 0;

            int jj_sp_flag = -2;
            int sl_sp_flag = -6;            
            DataRow row = GPUtil.helper.ExecuteDataRow("SELECT tranflag,tranmode,intype,testbdate,jjspflag,slspflag,syn_flag FROM gpparam WHERE CODE = '001'");
            if (row != null)
            {
                tranmode = Convert.ToInt16(row["tranmode"]);
                tranflag = Convert.ToInt16(row["tranflag"]);
                intype = Convert.ToInt16(row["intype"]);
                jj_sp_flag = Convert.ToInt16(row["jjspflag"]);
                sl_sp_flag = Convert.ToInt16(row["slspflag"]);               
                synFlag = Convert.ToInt16(row["syn_flag"]);

                MdComm.SYN_FLAG = synFlag;
                MdComm.TRAN_MODE = tranmode;
                MdComm.TRAN_FALG = tranflag;
                MdComm.IN_TYPE = intype;
                MdComm.JJ_SP_FLAG = jj_sp_flag;
                MdComm.SL_SP_FLAG = sl_sp_flag;               
                if (!Convert.IsDBNull(row["testbdate"]) && !String.IsNullOrEmpty(row["testbdate"].ToString()))
                {
                    MdComm.TEST_BEG_DATE = Convert.ToDateTime(row["testbdate"]).ToString("yyyy-MM-dd") +" 09:25:00";                   
                }                
            }
            return tranmode;
        }

        public static void write(string msg)
        {

            Console.WriteLine(msg);
            //当前程序目录
            string logPath = Path.GetDirectoryName(Application.ExecutablePath);
            //新建文件
            System.IO.StreamWriter sw = System.IO.File.AppendText(logPath + "/日志.txt");
            sw.WriteLine(DateTime.Now+" :" + msg);

            sw.Close();
            sw.Dispose();

        }

        /**
         * 获取涨停价格
         * */
        public static double getUpPrice(String code)
        {
            string sql = "SELECT  h.`zrspj`,h.`zrspj`*(1-0.1) dtj,h.`zrspj`*(1+0.1) ztj FROM gpsinahis h WHERE h.`code` = '"
                +code+"' and Date(h.date)='"+GPUtil.nowTranDate+"'";
            DataRow row = helper.ExecuteDataRow(sql, parms);

            if (row != null)
            {
                return Math.Round(Convert.ToDouble(row["ztj"]), 2)-0.05;
            }

            return 0;
        }

        /**
        * 大盘历史涨幅
        * */
        public static string getDPHis()
        {
            string his = "";
            string sql = "SELECT h.his FROM 大盘历史 h WHERE h.`code` = 'sh000001'";
            DataRow row = helper.ExecuteDataRow(sql, parms);

            if (row != null)
            {
                his = row["his"].ToString();
            }

            return his;
        }

        /**
        * 获取跌停价格
        * */
        public static double getLowPrice(String code)
        {
            string sql = "SELECT h.`zrspj`,h.`zrspj`*(1-0.1) dtj,h.`zrspj`*(1+0.1) ztj FROM gpsinahis h WHERE h.`code` = '" 
                + code + "' and Date(h.date)='" + GPUtil.nowTranDate + "'";
            DataRow row = helper.ExecuteDataRow(sql, parms);

            if (row != null)
            {
                return Math.Round(Convert.ToDouble(row["dtj"]), 2) + 0.05;
            }

            return 0;
        }

        /**
         * 
         * 大盘瞬时涨跌幅
         * */
        public static double getRealDpZf(DaoPan dp)
        {
            if (GPTotalAPI.dpMap.ContainsKey(dp.code))
            {
                DaoPan old_dp = GPTotalAPI.dpMap[dp.code];
                if (old_dp.zs > 0)
                {
                    return Math.Round(((dp.zs - old_dp.zs) / old_dp.zs) * 100, 2);
                }
            }
            return 0;
        }

        /**
        * 
        * 股票成本价涨幅
        * */
        public static void setGpCostPriceZf(GuoPiao gp)
        {
            if (GPTotalAPI.gpMap.ContainsKey(gp.code))
            {
                GpTotal total = GPTotalAPI.gpMap[gp.code];
                if (total != null)
                {                  
                    total.buyzf =  Math.Round(((gp.dqj - total.costPrice) / total.costPrice) * 100, 3);
                    gp.total = total;
                }
            }           
           
        }

        public static void listGpTimeSort(string field, string rule)
        {
            if (!string.IsNullOrEmpty(rule) && (!rule.ToLower().Equals("desc") || !rule.ToLower().Equals("asc")))
            {
                try
                {
                    List<GpTime> infoList = JJUtil.gpTimes;
                    infoList.Sort(
                        delegate(GpTime info1, GpTime info2)
                        {
                            Type t1 = info1.GetType();
                            Type t2 = info2.GetType();
                            PropertyInfo pro1 = t1.GetProperty(field);
                            PropertyInfo pro2 = t2.GetProperty(field);
                            return rule.ToLower().Equals("asc") ?
                                pro1.GetValue(info1, null).ToString().CompareTo(pro2.GetValue(info2, null).ToString()) :
                                pro2.GetValue(info2, null).ToString().CompareTo(pro1.GetValue(info1, null).ToString());
                        });
                    Console.WriteLine("*****ListSort**********");

                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.StackTrace);
                }
            } Console.WriteLine("ruls is wrong");

        }


    }
}
