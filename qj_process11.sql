DELIMITER $$

USE `guopiao`$$

DROP PROCEDURE IF EXISTS `qj_process`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `qj_process`()
BEGIN
      /*上证50涨幅*/
      DECLARE p_syl DOUBLE DEFAULT 30; 
      DECLARE p_ltsz DOUBLE DEFAULT 1500; 
      DECLARE sz_50_zf DOUBLE; 
      DECLARE cyb_zf DOUBLE; 
      DECLARE cyb_jj DOUBLE; 
      DECLARE cyb_dqj DOUBLE; 
      DECLARE cyb_zgj DOUBLE; 
      DECLARE cyb_zr_close DOUBLE; 
      
      DECLARE dp_zf DOUBLE;   
      DECLARE dp_zr_zf DOUBLE;    
      DECLARE dp_jj DOUBLE;  
      DECLARE dp_zf_3 DOUBLE;  
      DECLARE dp_zf_7 DOUBLE;  
      DECLARE dp_jx_5 DOUBLE;  
      DECLARE dp_jx_10 DOUBLE;   
      DECLARE dp_jx_20 DOUBLE;   
      DECLARE dp_jx_60 DOUBLE;   
      DECLARE dp_rsi_6 DOUBLE;      
            
      DECLARE dp_dqj DOUBLE;  
      DECLARE dp_zgj DOUBLE; 
      DECLARE dp_zr_close DOUBLE; 
      
      DECLARE xz_dp_zf DOUBLE DEFAULT 0;   
      DECLARE zxp_zf DOUBLE;   
      DECLARE zxp_dqj DOUBLE;  
      DECLARE zxp_zgj DOUBLE; 
      DECLARE zxp_zr_close DOUBLE; 
      DECLARE avg_rsi_6 DOUBLE DEFAULT 60; 
      DECLARE avg_rsi_12 DOUBLE DEFAULT 65; 
      DECLARE avg_rsi_24 DOUBLE DEFAULT 70; 
      
      DECLARE risk_mode INT;  
      DECLARE sz50_cd_buy_cnt INT;   
      DECLARE cyb_buy_cnt INT;   
      DECLARE cd_buy_cnt_1 INT; 
      DECLARE drd_gn_cnt INT; 
      DECLARE syl_cnt INT;   
      DECLARE gn_gn_cnt INT;  
      DECLARE hy_tl_cnt INT; 
      DECLARE ltg_buy_cnt INT;     
      DECLARE sz_gp_cnt INT;   
      DECLARE zt_gp_cnt INT;   
      DECLARE plan_gp_cnt INT;  
      DECLARE hey_zj_gp_cnt INT;   
      DECLARE tp_buy_cnt INT;  
      DECLARE gnzt_buy_cnt INT; 
      DECLARE dp_cd_buy_cnt INT; 
      DECLARE ld_gn_cnt INT;
      DECLARE jr_gn_cnt INT;
      
      DECLARE total_cnt INT;  
      DECLARE can_buy_cnt INT DEFAULT 12;  
      DECLARE in_time VARCHAR(200) DEFAULT "9:40:00";  
      DECLARE end_time VARCHAR(200) DEFAULT "14:53:00";    
      
      DECLARE is_cyb_qs INT DEFAULT 0; 
      DECLARE is_dp_qs INT DEFAULT 0;    
      
      SELECT IF(COUNT(*) =1,1,0) INTO is_cyb_qs FROM `指数比较` t WHERE t.`dp_zf_30`> t.`cyb_zf_30` AND t.`cyb_zf_7` > t.`dp_zf_7`;
      SELECT IF(COUNT(*) =1,1,0) INTO is_dp_qs FROM `指数比较` t WHERE t.`dp_zf_30`< t.`cyb_zf_30` AND t.`cyb_zf_7` < t.`dp_zf_7`;    
                        
      SELECT COUNT(p.code) INTO hy_tl_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 1; 
      SELECT COUNT(p.code) INTO plan_gp_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 2; 
      SELECT COUNT(p.code) INTO gnzt_buy_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 3; 
      SELECT COUNT(p.code) INTO gn_gn_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 4;
      SELECT COUNT(p.code) INTO hey_zj_gp_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 5; 
      SELECT COUNT(p.code) INTO zt_gp_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 6;
      SELECT COUNT(p.code) INTO ltg_buy_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 7; 
      SELECT COUNT(p.code) INTO syl_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 8;  
      SELECT COUNT(p.code) INTO drd_gn_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 9;  
      SELECT COUNT(p.code) INTO tp_buy_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 10;  
      SELECT COUNT(p.code) INTO sz50_cd_buy_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 11; 
      SELECT COUNT(p.code) INTO cyb_buy_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 12; 
      SELECT COUNT(p.code) INTO cd_buy_cnt_1 FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 13;   
      SELECT COUNT(p.code) INTO dp_cd_buy_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 14;  
      SELECT COUNT(p.code) INTO ld_gn_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 15;  
      SELECT COUNT(p.code) INTO jr_gn_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 16;      
                
      SELECT COUNT(p.code) INTO total_cnt FROM POSITION p WHERE p.`available`> 0;           
      
      SELECT g.tranmode INTO risk_mode FROM gpparam g WHERE g.code= '001';      
          
      SELECT MAX(g.zf) INTO sz_50_zf FROM gptoday g WHERE g.`code` = 'sh000016';      
         
      SELECT MAX(g.zf),MAX(g.jj),MAX(g.dqj),MAX(g.zrspj),MAX(g.jrzgj) INTO dp_zf,dp_jj,dp_dqj,dp_zr_close,dp_zgj
            FROM gptoday g WHERE g.`code` = 'sh000001';        
       
      SELECT MAX(g.zf),MAX(g.jj),MAX(g.dqj),MAX(g.zrspj),MAX(g.jrzgj) INTO cyb_zf,cyb_jj,cyb_dqj,cyb_zr_close,cyb_zgj
            FROM gptoday g WHERE g.`code` = 'sz399006';    
       
      SELECT MAX(g.zf),MAX(g.dqj),MAX(g.zrspj),MAX(g.jrzgj) INTO zxp_zf,zxp_dqj,zxp_zr_close,zxp_zgj
            FROM gptoday g WHERE g.`code` = 'sz399001';     
	
      SELECT MAX(g.jx_5),MAX(g.jx_10),MAX(g.jx_20),MAX(g.zf3),MAX(g.zf7),MAX(g.`rsi_6`),MAX(g.jx_60),MAX(g.`zf`)
           INTO dp_jx_5,dp_jx_10,dp_jx_20,dp_zf_3,dp_zf_7,dp_rsi_6,dp_jx_60,dp_zr_zf
            FROM gpzfrec g WHERE g.`code` = '000001';      
       
      SET p_syl = p_syl+((IF(dp_zf<0,dp_zf*1.5,dp_zf)+zxp_zf+cyb_zf/3)/3)*100;           
      IF (p_syl < 0) THEN
         SET p_syl = 15;
      END IF;     
      
      IF (is_cyb_qs = 1) THEN
        SET p_ltsz := 200;
      END IF;      
      
      IF (dp_rsi_6 > 80 OR (dp_zf + dp_zf_3 < dp_zf_7)) THEN
       SET xz_dp_zf := 0.2;          
      END IF;
      
      IF (dp_zr_zf >= 1.5 OR dp_zf_3 >= 2 OR dp_zf_7 > 2) THEN       
       SET end_time := '11:25:00';     
      END IF;           
                  	
       /**行业涨幅  */   
      TRUNCATE hyzfrec;     
      INSERT INTO hyzfrec SELECT 0,hy,zf, 0,'',NOW() FROM 今日行业涨幅;	 
         	      
      /**概念涨幅**/	     
      TRUNCATE gnzfrec;
      INSERT INTO gnzfrec SELECT 0,gn,gnzf, 0,'',NOW() FROM 热点排序;	 
                          
       /**浮动盈亏**/  
      UPDATE `position` SET sumzf=((SELECT dqj FROM gptoday WHERE position.`code`= gptoday.`code`)-position.`vwap`)/position.`vwap`*100
		WHERE available > 0; 
		
      CALL sel_zt_gps();	 
             
       /** 风险模式 **/
       TRUNCATE qjsel;  
       
       /**合约套利*/
       INSERT INTO qjsel SELECT 0,g.`code`,1,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),'0'
	 FROM `合约排名股票1` g,gpzfrec g2,gptoday g1,gp g3 WHERE g.`code`=g2.`code` AND g2.`code`=g1.`code` AND g1.`code`=g3.`code`
	  AND hy_tl_cnt < 1	 
	  AND g1.`cj_amt` > 0 	  
	  AND g1.`dqj` < 70	
	  AND g1.`dqj` > g1.`jj`  
	  AND g1.dqj < g1.`jrzgj`
	  AND g2.`rsi_6` < avg_rsi_6 
	  AND g2.`rsi_12` < avg_rsi_12 
	  AND g2.`rsi_24` < avg_rsi_24
	  AND g2.zf < 3
	  AND g1.`zf` >= 1
	  AND g1.`zf` < 3	
	  AND dp_zf > xz_dp_zf	 
	  AND g3.hy NOT IN (SELECT hy FROM 买入行业)	 	
	  AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC('9:40:00')	  	 
	  ORDER BY g2.zf30 DESC LIMIT 0,1;	  	
        
       /**投资计划*/
       INSERT INTO qjsel SELECT 0,g.`code`,2,g2.dqj,g2.zf,CONCAT(DATE_FORMAT(g2.`date`,'%Y-%m-%d'),' ',g2.`trantime`),'0'
	 FROM gp g,gpzfrec g1,gptoday g2,投资计划 j WHERE g.`code`=g1.`code` AND g.`code`=g2.`code` AND g.code=j.code
	 AND plan_gp_cnt < 1		 
	 AND g2.`cj_amt` > 0 	  
	 AND g2.`dqj` < 60 	
	 AND g2.zf >= 2 
	 AND g2.zf < 3
	 AND g1.zf < 3	  
	 AND dp_zf > xz_dp_zf	
	 AND g.syl < IF(g.hy = '国防军工', 1000, p_syl)	 	
	 AND g2.`dqj`> g2.`jj`  
	 AND g2.dqj < g2.`jrzgj`	
	 AND TIME_TO_SEC(g2.`trantime`) > TIME_TO_SEC('10:30:00')	  	 
	 ORDER BY g1.zf30 LIMIT 0,1;   
	 
	 /**概念涨停跟进*/
       INSERT INTO qjsel SELECT 0,g.`code`,3,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),g3.`gn`
	 FROM gptoday g1,gp g,gpzfrec g2,`gn2gp` g3 WHERE g1.`code`=g.`code` AND g.`code`=g2.`code`  AND g.`code`=g3.`gpcode` 	 
	 AND g.syl < IF(g.hy = '国防军工', 1000, p_syl)   
	 AND gnzt_buy_cnt < 1	
	 AND g1.`cj_amt` > 0 	  
	 AND g1.`dqj` < 60 
	 AND g.ltsz < 300
	 AND dp_zf > xz_dp_zf	
	 AND g3.`gn` IN (SELECT gn FROM `概念涨停`)
	 AND g1.zf >= 1 
	 AND g1.zf < 3
	 AND g2.`rsi_6` < avg_rsi_6  AND g2.`rsi_12` < avg_rsi_12 AND g2.`rsi_24` < avg_rsi_24	
	 AND g3.`gn` NOT IN (SELECT DISTINCT p.type FROM POSITION p WHERE p.`available` > 0 AND p.`inxh` = 3)	 
	 AND g.hy NOT IN (SELECT hy FROM 买入行业)	 	
	 AND g1.`dqj` > g1.`jj`  
	 AND g1.dqj < g1.`jrzgj`
	 AND g2.zf < 3
	 AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC('9:55:00')
	 AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC('13:40:00')	  	 
	 ORDER BY g1.zf DESC LIMIT 0,1;
	 
	 /** 概念突破 **/
        INSERT INTO qjsel 
		SELECT DISTINCT 0,g.`code`,4,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),g3.gn 
		 FROM gp g,gptoday g1,gpzfrec g2,gn2gp g3 WHERE g.`code`=g1.`code` 
		 AND g1.`code`=g2.`code` AND g2.code=g3.gpcode
		 AND gn_gn_cnt < 1
		 AND g.syl < p_syl
		 AND g.`code` IN (SELECT DISTINCT g.`gpcode` FROM gn2gp g WHERE g.`gn` IN (SELECT gn FROM `概念排名5`))	
		 AND g2.`zf3` < 3	
		 AND dp_zf > xz_dp_zf	
		 AND g2.`rsi_6` < avg_rsi_6
		 AND g2.`rsi_12` < avg_rsi_12
		 AND g2.`rsi_24` < avg_rsi_24	
		 AND g1.cj_amt > 0	
		 AND g1.`dqj` > g2.`top_2`		
		 AND g3.`gn` NOT IN (SELECT DISTINCT p.type FROM POSITION p WHERE p.`available` > 0 AND p.`inxh` = 4)
		 AND g.hy NOT IN (SELECT hy FROM 买入行业)
	         AND g.hy NOT IN (SELECT DISTINCT xl FROM hyref WHERE dl IN (SELECT DISTINCT h.`dl` 
			FROM POSITION p,gp g,hyref h WHERE p.`available` > 0 AND 
	              p.`code`=g.`code` AND g.`hy` = h.`xl`) AND TYPE = 0 AND dl NOT IN ('zqg'))							
		 AND g.ltsz < 100
		 AND g1.dqj < 60		
		 AND g2.zf3 > -3
		 AND g2.zf3 < 3
		 AND g1.zf < 3	
		 AND g1.zf > 1
		 AND risk_mode <> 0						
		 AND g1.dqj < g1.jrzgj	
		 AND g1.dqj > g1.jj		 	
		 AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC(in_time)	
		 AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC(end_time)		 	 
		 ORDER BY g1.zf DESC,g2.zf7 LIMIT 0,1; 
	 
       /**周期股跟进1*/
       INSERT INTO qjsel SELECT 0,g.`code`,5,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),'0'
	    FROM gp g,gptoday g1,gpzfrec g2 WHERE g.code=g2.`code` AND g2.`code`=g1.`code` 
	    AND hey_zj_gp_cnt < 1
	    AND g.`hy` IN ('有色冶炼加工','煤炭开采','钢铁') AND get_gp_hey_zfc('',g.`hy`) = 1 	    
	    AND g2.`rsi_6` < 60 AND g2.`rsi_12` < 60 AND g2.`rsi_24` < 60
	    AND g1.`jrzgj` > g1.kpj 
	    AND g1.`zf` > 0   
	    AND g2.zf < 3
	    AND (g2.`zt_bar_num` = 0 OR g2.zt_bar_num > 7)
	    AND g1.`dqj` > g1.`jj` 
	    AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC(end_time)	
	    ORDER BY g1.zf DESC LIMIT 0,1;
	
	/**周期股跟进2*/
        INSERT INTO qjsel SELECT 0,g2.`code`,5,g4.dqj,g4.zf,CONCAT(DATE_FORMAT(g4.`date`,'%Y-%m-%d'),' ',g4.`trantime`),'0'
		FROM gpzfrec g,hey h,gptoday g1,heyref h1,gp g2,gpzfrec g3,gptoday g4 WHERE 
		hey_zj_gp_cnt < 1
		AND LOCATE('.',g.`code`) > 0 AND h.`code`=h1.`hey` 
		AND h.`slcode`=g1.`code` AND g.`code`=h.`code` 
		AND g.`code` NOT IN ('SHSE.000016')
		AND g1.zf >= 1.5 AND CONCAT(h1.`gps`,h1.`lt`) IS NOT NULL
		AND LOCATE(g2.`name`,CONCAT(h1.`gps`,h1.`lt`)) > 0 
		AND g2.`code`=g3.`code`
		AND g3.`code`=g4.`code`
		AND g4.`cj_amt` > 0				
		AND g4.zf > 2 AND g4.zf < 5 AND g4.`dqj` > g4.`jj`
		AND g3.`zf` < 3
		AND g3.`zf2` < 10
		AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC(end_time)	
		ORDER BY g3.zf30;
                       
        /**行业涨停跟进*/
       INSERT INTO qjsel SELECT 0,g.`code`,6,g2.dqj,g2.zf,CONCAT(DATE_FORMAT(g2.`date`,'%Y-%m-%d'),' ',g2.`trantime`),'0'
	 FROM gp g,gpzfrec g1,gptoday g2 WHERE g.`code`=g1.`code` AND g.`code`=g2.`code`
	 AND g.syl < IF(g.hy = '国防军工', 1000, p_syl)   
	 AND zt_gp_cnt < 1	
	 AND g2.`cj_amt` > 0 	  
	 AND g2.`dqj` < 60 
	 AND g.hy IN (SELECT hy FROM `行业涨停`)	
	 AND g2.zf >= 1 
	 AND g2.zf < 3
	 AND g.ltsz < 500	
	 AND dp_zf > xz_dp_zf
	 AND g1.`rsi_6` < avg_rsi_6  AND g1.`rsi_12` < avg_rsi_12 AND g1.`rsi_24` < avg_rsi_24		 
	 AND g.hy NOT IN (SELECT hy FROM 买入行业)	 	
	 AND g2.`dqj` > g2.`jj`  
	 AND g2.dqj < g2.`jrzgj`
	 AND g1.zf < 3
	 AND TIME_TO_SEC(g2.`trantime`) > TIME_TO_SEC('9:45:00')
	 AND TIME_TO_SEC(g2.`trantime`) < TIME_TO_SEC(end_time)		  	 
	 ORDER BY g2.zf DESC LIMIT 0,1;
	 
	 /*龙头股*/ 
	INSERT INTO qjsel SELECT 0,g.`code`,7,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0
                FROM gpsel gs,gp g,gptoday g1,gpzfrec g2 WHERE gs.`code`=g.`code` AND g.`code`=g1.`code` AND g.`code`=g2.`code`   
                AND gs.zbflag = 2                   
                AND dp_zf > xz_dp_zf       
		AND g1.kpj > 0 
		AND ltg_buy_cnt < 1
		AND g1.cj_amt > 0
		AND g1.dqj > 0	
		AND g.code NOT IN (SELECT p.code FROM `position` p WHERE p.`available_today` > 0)								
		AND g2.`rsi_6` < avg_rsi_6
		AND g2.`rsi_12` < avg_rsi_12
		AND g2.`rsi_24` < avg_rsi_24
		AND g2.zf < 2
		AND g1.zf > 1
		AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC(in_time) 
		AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC(end_time)	
		LIMIT 0,1;  
	 
                            
       /**近期低涨幅行业*/
       INSERT INTO qjsel SELECT 0,g.`code`,8,g2.dqj,g2.zf,CONCAT(DATE_FORMAT(g2.`date`,'%Y-%m-%d'),' ',g2.`trantime`),'0'
	 FROM gp g,gpzfrec g1,gptoday g2 WHERE g.`code`=g1.`code` AND g.`code`=g2.`code` 
	 AND syl_cnt < 1
	 AND g.syl < IF(g.hy = '国防军工', 1000, p_syl) 
	 AND g2.`cj_amt` > 0 	  
	 AND g2.`dqj` < 60 
	 AND g.ltsz < 500
	 AND dp_zf > xz_dp_zf
	 AND g.hy IN (SELECT hy FROM 行业倒序 WHERE hy_zf3 < 1 AND hyzf > 0.6)
	 AND g2.zf >= 1.5 
	 AND g2.zf < 3
	 AND g1.zf < 3
	 AND g1.`rsi_6` < avg_rsi_6  AND g1.`rsi_12` < avg_rsi_12 AND g1.`rsi_24` < avg_rsi_24		 	 
	 AND g.hy NOT IN (SELECT hy FROM 买入行业)			
	 AND g2.`dqj` > g2.`jj`  
	 AND g2.dqj < g2.`jrzgj`
	 AND TIME_TO_SEC(g2.`trantime`) > TIME_TO_SEC('11:35:00')
	 AND TIME_TO_SEC(g2.`trantime`) < TIME_TO_SEC(end_time)			
	 ORDER BY g2.zf DESC LIMIT 0,1;
       
       /*近期热点*/
       INSERT INTO qjsel SELECT 0,g.`code`,9,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),r.dl 
	FROM
	  hyref r,
	  gp g,
	  gptoday g1,
	  gpzfrec g2 
	WHERE 
	  drd_gn_cnt < 1
	  AND g.syl < IF(g.hy = '国防军工', 1000, p_syl) 
	  AND r.`dl` IN (SELECT dl FROM `大热点`) 
	  AND r.`xl` = g.`hy` 
	  AND g.`code` = g1.`code` 
	  AND g.`code` = g2.`code` 
	  AND g1.`cj_amt` > 0 	  
	  AND dp_zf > xz_dp_zf
	  AND g1.`dqj` < 60     	 
	  AND g.`ltsz` < 800 	  
	  AND g2.`rsi_6` < avg_rsi_6
	  AND g2.`rsi_12` < avg_rsi_12
	  AND g2.`rsi_24` < avg_rsi_24		
	  AND g2.zf3 > -3
	  AND g2.zf3 < 3
	  AND g2.zf < 3.5	 
	  AND g1.`zf` > 1
	  AND g1.zf  < 3	
	  AND risk_mode <> 0 	  
	  AND g.hy NOT IN (SELECT hy FROM 买入行业)
	  AND r.dl NOT IN (SELECT DISTINCT p.type FROM POSITION p WHERE p.`available` > 0 AND p.`inxh` = 9)		  	 
	  AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC(in_time)
	  AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC(end_time)		  
	  ORDER BY g1.zf DESC LIMIT 0,1;
       
       /**行业突破 **/
       INSERT INTO qjsel SELECT 0,g.`code`,10,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),g.hy 
                FROM gp g,gptoday g1,gpzfrec g2 WHERE g.`code`=g1.`code` AND g.`code`=g2.`code`  
                AND tp_buy_cnt < 1
                AND dp_zf > xz_dp_zf	
                AND g.syl < IF(g.hy = '国防军工', 1000, p_syl) 
                AND g.hy IN (SELECT h.hy FROM `行业排名6` h,hy1 WHERE h.hy=hy1.`hy` AND hy1.`rsi6` < 60 AND hy1.`rsi12` < 60 AND hy1.`rsi24` < 60)  
                AND g1.`trantime` IS NOT NULL            
		AND g2.`top_2` > 0	
		AND g1.dqj > 0																				
		AND g1.kpj > 0 
		AND g1.cj_amt > 0
		AND g.ltsz < 5000
		AND g2.`rsi_6` < avg_rsi_6
		AND g2.`rsi_12` < avg_rsi_12
		AND g2.`rsi_24` < avg_rsi_24					
		AND g1.`dqj` > g2.`top_2`													
		AND g.hy NOT IN (SELECT hy FROM 买入行业)	 
	        AND g.hy NOT IN (SELECT DISTINCT xl FROM hyref WHERE dl IN (SELECT DISTINCT h.`dl` 
			FROM POSITION p,gp g,hyref h WHERE p.`available` > 0 AND 
	              p.`code`=g.`code` AND g.`hy` = h.`xl`) AND TYPE = 0 AND dl NOT IN ('zqg'))	             								        																							
		AND g1.dqj < g1.jrzgj						
		AND g1.dqj < 60	
		AND g1.dqj > 5      
		AND g2.zf3 > -3
		AND g2.zf3 < 3				
		AND g1.zf < 3
		AND g1.zf > 1	
		AND g1.dqj > g1.jj			
		AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC(in_time)
		AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC(end_time)			
		ORDER BY g1.zf DESC,g2.zf7 LIMIT 0,1;			        
			                       
         /*大盘股早盘跟进*/
	INSERT INTO qjsel SELECT 0,g.`code`,11,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0 
                FROM gp g,gptoday g1,gpzfrec g2,gpsel g3 WHERE g.`code`=g1.`code` AND g.`code`=g2.`code` AND g.code=g3.code
                AND sz50_cd_buy_cnt < 1
                AND g3.zbflag = 0    
                AND g3.gn='jr'
                AND g1.dqj > 0                     				
		AND sz_50_zf > dp_zf AND sz_50_zf > zxp_zf AND sz_50_zf > cyb_zf 
		AND g2.`rsi_6` < avg_rsi_6
		AND g2.`rsi_12` < avg_rsi_12
		AND g2.`rsi_24` < avg_rsi_24
		AND g2.zf < 1
		AND g2.`zf3` < 0
		AND is_cyb_qs <> 1
		AND g1.dqj > g1.`jj`	
		AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC('9:35:00')
		ORDER BY g1.zf DESC LIMIT 0,1; 
					
	/*创业板切换*/ 
	INSERT INTO qjsel SELECT 0,g.`code`,12,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0 
		FROM gp g,gptoday g1,gpzfrec g2 WHERE g.`code`=g1.`code` AND g1.`code`=g2.`code`
		 AND SUBSTR(g.`code`,1,1) = '3' AND g1.`cj_amt` > 0
		 AND cyb_buy_cnt < 1
		 AND g.`syl` < 50 
		 AND g.`ltsz` < 200
		 AND (g.hy IN (SELECT hy FROM `行业排名6`))  
		 AND g.syl < IF(g.hy = '国防军工', 1000, p_syl) 
		 AND is_cyb_qs = 1
		 AND dp_zf < 0 AND cyb_zf > 0.5
		 AND g2.zf < 2
		 AND g1.zf > 0 AND g1.zf < 2
		 AND g1.dqj > g1.jj		 
		 AND g2.`rsi_6` < 60 AND g2.`rsi_12` < 60 AND g2.`rsi_24` < 60 
		 AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC(in_time)
		 ORDER BY g2.`zf10` LIMIT 0,1; 
		
         /*强势股抄底2*/
	INSERT INTO qjsel SELECT 0,g.`code`,13,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0 
                FROM gpsel gs,gp g,gptoday g1,gpzfrec g2 WHERE gs.`code`=g.`code` AND g.`code`=g1.`code` AND g.`code`=g2.`code` 
                AND cd_buy_cnt_1 < 1                           
		AND g1.kpj > 0 
		AND g1.cj_amt > 0		
		AND g1.dqj > 0				
		AND g1.zf > -2
		AND g1.zf < 2
		AND gs.zbflag <> 1		
		AND risk_mode <> 0		
		AND (g1.dqj < g1.jj || g1.zf < 0)
		AND g2.`rsi_6` < 65	
		AND g.hy NOT IN (SELECT hy FROM 买入行业)	 
		AND g.code NOT IN (SELECT CODE FROM `position` WHERE `available` > 0 AND `inxh`<> 13 )		
		AND g1.dqj < IF(gs.`gpflag`= 5,g2.`jx_5`,g2.`jx_5`)   
		AND g1.dqj < IF(gs.`gpflag`= 5,g2.`jx_5`,g2.`jx_10`)  
		AND g1.dqj <= IF(gs.`gpflag`= 5,g2.`jx_5`,g2.`jx_30`)   
		AND g.ltsz < IF(is_cyb_qs=1,200,1000)										
		AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC("14:35:00")
		ORDER BY g2.zf30 LIMIT 0,1;  
	
	 /*大盘急跌抢反弹*/
	INSERT INTO qjsel SELECT 0,g.`code`,14,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0 
                FROM gpsel g2,gp g,gptoday g1,gpzfrec g3 WHERE g.`code`=g1.`code` AND g.`code`=g2.`code` AND g2.`code`=g1.`code`
                AND g1.code=g3.code
	   AND g3.`rsi_6` < 60 AND g3.`rsi_12` < 60 AND g3.`rsi_24` < 60
	   AND dp_cd_buy_cnt < 1
	   AND g3.`zf` < 1
	   AND g1.zf < 1
	   AND dp_zf < -1
	   AND g.ltsz > IF(is_dp_qs=1,1000,0)
	   AND g.ltsz < IF(is_cyb_qs=1,200,2000)
	   AND g3.zf10 < 3
	   AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC("14:40:00")
	   ORDER BY g3.`zf30` DESC LIMIT 0,1;   
	   
	  /**次新股**/
	 INSERT INTO qjsel SELECT 0,g1.`code`,15,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0 
	        FROM gpzfrec g,gptoday g1,gp g2 WHERE g.`code`=g1.code AND g1.`code`=g2.`code` 
	        AND ld_gn_cnt < 2
	        AND g.`zf3` >=30
		AND g.`zf30` = 0 AND g1.`cj_amt`>= 3 AND g1.`cj_amt` < 4 AND g1.`dqj` > g1.`jj` AND g1.`dqj` > g1.`kpj` AND g1.`zf` < 3
		AND g.zf > 9 AND g.`zr_cjl` < 2 
		AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC(end_time)	
		LIMIT 0,1;
	  
	  /**次新股**/ 
	 INSERT INTO qjsel SELECT 0,g2.`code`,15,g2.dqj,g2.zf,CONCAT(DATE_FORMAT(g2.`date`,'%Y-%m-%d'),' ',g2.`trantime`),0 
	    FROM gn1,gn2gp g,gnzfrec g1,gptoday g2,gpzfrec g3 WHERE
	          gn1.`code`=718 
	          AND ld_gn_cnt < 2
	          AND dp_zf > xz_dp_zf
		  AND gn1.`code`=g.`gn` AND g.`gpcode`=g2.`code` AND g2.`code`=g3.`code` AND g.`gn`=g1.`gn` 
		  AND gn1.`rsi6` < 70 AND gn1.`rsi12` < 60 AND gn1.`rsi24` < 60
		  AND g1.`zf` > 1 AND g2.`dqj` > g2.`kpj` AND g2.`dqj` > g2.`jj` AND g2.`zf` > 1 AND g2.`zf` < 3
		  AND g3.`rsi_6` < 60 AND g3.`rsi_12` < 60 AND g3.`rsi_24` < 60
		  AND TIME_TO_SEC(g2.`trantime`) > TIME_TO_SEC(in_time)
		  AND TIME_TO_SEC(g2.`trantime`) < TIME_TO_SEC(end_time)	
		  ORDER BY g2.`zf` DESC LIMIT 0,1;
	 
	 /**底部概念**/
	 INSERT INTO qjsel SELECT 0,g3.`code`,15,g4.dqj,g4.zf,CONCAT(DATE_FORMAT(g4.`date`,'%Y-%m-%d'),' ',g4.`trantime`),0 
		 FROM gn1,gn2gp g1,gpzfrec g2,gp g3,gptoday g4,gnzfrec g5
		 WHERE gn1.`code`=g1.`gn` AND g1.`gpcode`=g2.`code` AND g2.`code` = g3.`code` AND g3.`code`=g4.`code`
		 AND gn1.`code`=g5.gn		
		 AND ld_gn_cnt < 2
		 AND dp_zf > xz_dp_zf		  
		 AND gn1.`rsi6` < 60 AND gn1.`rsi12` < 60 AND gn1.`rsi24` < 60
		 AND g2.`rsi_6` < 60 AND g2.`rsi_12` < 60 AND g2.`rsi_24` < 60			
		 AND g5.zf > 1
		 AND g4.`cj_amt` > 0 		
		 AND g4.`dqj` < 50	
		 AND g4.dqj > g4.jj
		 AND g4.dqj > g4.kpj
		 AND g4.zf > 1 AND g4.zf < 3	 
		 AND g3.syl < IF(g3.hy = '国防军工', 1000, p_syl) 
		 AND g3.ltsz < 300												
		 AND TIME_TO_SEC(g4.`trantime`) > TIME_TO_SEC(in_time)
		 AND TIME_TO_SEC(g4.`trantime`) < TIME_TO_SEC(end_time)	
		 ORDER BY g4.zf DESC LIMIT 0,1;		 
         
         /*今日概念*/
         INSERT INTO qjsel SELECT 0,g.`code`,16,g3.dqj,g3.zf,CONCAT(DATE_FORMAT(g3.`date`,'%Y-%m-%d'),' ',g3.`trantime`),0 
		 FROM 当日题材 g1,gp g,gpzfrec g2,gptoday g3 WHERE g1.`code`=g.`code` AND g.`code`=g2.`code` AND g2.`code`=g3.`code`
		 AND jr_gn_cnt < 1
		 AND g2.`rsi_6` < 60 AND g2.`rsi_12` < 60 AND g2.`rsi_24` < 60
		 AND g2.`zf` < 3 
		 AND g.syl < IF(g.hy = '国防军工', 1000, p_syl) 
		 AND g3.zf >= 2 
		 AND g3.zf < 4
		 AND g3.dqj > g3.jj
		 AND g3.`dqj` > g3.`kpj`
		 AND g.ltsz < 400
		 AND TIME_TO_SEC(g3.`trantime`) > TIME_TO_SEC("10:20:00")
		 AND TIME_TO_SEC(g3.`trantime`) < TIME_TO_SEC(end_time)				 
		 AND g.hy NOT IN (SELECT hy FROM 买入行业)	 
		 ORDER BY g2.`zf30`;
		 
	  /*今日涨停-概念*/	 
          INSERT INTO qjsel SELECT 0,g1.`code`,16,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0 
		 FROM gn2gp g,rtn_value r,gptoday g1 WHERE g.`gn`=r.`rtn_value`
		 AND jr_gn_cnt < 1
		 AND g.`gpcode` = g1.`code` AND g1.`dqj` > g1.`jj` AND g1.`zf` > 1 AND g1.zf < 3
		 AND g1.cj_amt > 0
		 AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC("10:10:00")
		 AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC(end_time)	
		 ORDER BY g1.zf DESC LIMIT 0,1;
	
	   /*今日涨停-行业*/	 
	  INSERT INTO qjsel SELECT 0,g1.`code`,16,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`),0 
		FROM gp g,gptoday g1,rtn_value r,gpzfrec g2 WHERE g.`hy`= r.`rtn_value` AND g.`code`=g1.`code` AND g1.`code`=g2.`code`
		 AND jr_gn_cnt < 1
		 AND g1.`cj_amt` > 0 AND g1.`dqj` > g1.`jj` 
		 AND g1.`zf` > 1 AND g1.`zf` < 3 
		 AND g2.`zf` < 3
		 AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC("10:10:00")
		 AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC(end_time) 
		 ORDER BY g1.zf DESC LIMIT 0,1;
	              	 	       					
       COMMIT;    
             
       /**买人 */
       SELECT DISTINCT CODE,price,jcdate,trantype,xhtype,TYPE FROM (
       SELECT CODE,price,jcdate,1 trantype,xhtype,TYPE FROM (SELECT q.xhtype,q.code,q.price,IFNULL(q.jcdate,NOW()) jcdate,q.type 
         FROM qjsel q,gpzfrec g1,gp g2 WHERE q.code=g1.code AND g1.code=g2.code AND q.price < 50
          AND g1.zr_close > 0
          AND (g1.`jx_5`-g1.`zr_close`)/g1.`zr_close`*100 < 30
          AND q.code NOT IN (SELECT p.code FROM `position` p WHERE p.`available_today` > 0 AND p.`inxh`<>13)
	  AND q.zf < 9 ORDER BY q.xhtype ASC,g2.syl) tmp 
          WHERE total_cnt < can_buy_cnt
	  LIMIT 0,1
	  
       UNION ALL
       
       /** 止损卖出**/
       SELECT p.code,p.`price`,CONCAT(DATE_FORMAT(g.`date`,'%Y-%m-%d'),' ',g.`trantime`) jcdate,-1 trantype,p.`inxh` xhtype,0 FROM POSITION p,gptoday g,gp g1 
		WHERE p.`code`=g.`code` AND g.code=g1.code
		 AND p.`available` > 0
		 AND (p.available - p.`available_today`) > 0				
		 AND IF(g.zf > 0,FALSE,TRUE)
		 AND p.`sumzf` < IF((dp_rsi_6 < 50 OR g1.syl <= 10 OR p_syl >= 80),-5,-2.5)					 	 
		 AND DATE(p.`indate`) < DATE(NOW())
		 AND TIME_TO_SEC(g.`trantime`) > TIME_TO_SEC(IF(g.`jj` > 0 AND g.`dqj` >= g.`jj`,"14:45:00","9:40:00"))
		 
	UNION ALL
        
        /** 止赢**/
        SELECT p.code,p.`price`,CONCAT(DATE_FORMAT(g.`date`,'%Y-%m-%d'),' ',g.`trantime`) jcdate,-1 trantype,p.`inxh` xhtype,0 FROM POSITION p,gptoday g 
		WHERE p.`code`=g.`code`
		 AND p.`available` > 0
		 AND (p.available - p.`available_today`) > 0		 
		 AND p.`sumzf` > IF((p_syl >= 80 OR dp_rsi_6 < 50),3,1)	
		 AND g.zf < 9		
		 AND DATE(p.`indate`) < DATE(NOW())
		 AND TIME_TO_SEC(g.`trantime`) > TIME_TO_SEC(IF(g.`jj` > 0 AND g.`dqj` >= g.`jj`,"14:40:00","9:40:00"))) 
		 tmp ORDER BY trantype,xhtype;
    END$$

DELIMITER ;