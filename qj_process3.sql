DELIMITER $$

USE `guopiao`$$

DROP PROCEDURE IF EXISTS `qj_process`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `qj_process`()
BEGIN
      /*上证50涨幅*/
      DECLARE sz_50_zf DOUBLE; 
      DECLARE cyb_zf DOUBLE; 
      DECLARE cyb_jj DOUBLE; 
      DECLARE cyb_dqj DOUBLE; 
      DECLARE cyb_zgj DOUBLE; 
      DECLARE cyb_zr_close DOUBLE; 
      
      DECLARE dp_zf DOUBLE;     
      DECLARE dp_jj DOUBLE;  
      DECLARE dp_jx_5 DOUBLE;  
      DECLARE dp_jx_10 DOUBLE;   
      DECLARE dp_jx_20 DOUBLE;         
      
      DECLARE dp_dqj DOUBLE;  
      DECLARE dp_zgj DOUBLE; 
      DECLARE dp_zr_close DOUBLE; 
      
      DECLARE risk_mode INT;  
      DECLARE buy_cnt INT;                
      
      SELECT g.tranmode INTO risk_mode FROM gpparam g WHERE g.code= '001';
      SELECT COUNT(1) INTO buy_cnt FROM POSITION p ,gp g WHERE p.`code`=g.`code` AND g.`ltsz` > 1000 AND p.`available` > 0;      
      SELECT MAX(g.zf) INTO sz_50_zf FROM gptoday g WHERE g.`code` = 'sh000016';      
         
      SELECT MAX(g.zf),MAX(g.jj),MAX(g.dqj),MAX(g.zrspj),MAX(g.jrzgj) INTO dp_zf,dp_jj,dp_dqj,dp_zr_close,dp_zgj
            FROM gptoday g WHERE g.`code` = 'sh000001';        
       
      SELECT MAX(g.zf),MAX(g.jj),MAX(g.dqj),MAX(g.zrspj),MAX(g.jrzgj) INTO cyb_zf,cyb_jj,cyb_dqj,cyb_zr_close,cyb_zgj
            FROM gptoday g WHERE g.`code` = 'sz399006';        
	
      SELECT MAX(g.jx_5),MAX(g.jx_10),MAX(g.jx_20) INTO dp_jx_5,dp_jx_10,dp_jx_20
            FROM gpzfrec g WHERE g.`code` = '000001';        
           
	
       /**行业涨幅  */   
      TRUNCATE hyzfrec;     
      INSERT INTO hyzfrec SELECT 0,hy,zf, 0,'',NOW() FROM 今日行业涨幅;	 
         	      
      /**概念涨幅**/	     
      TRUNCATE gnzfrec;
      INSERT INTO gnzfrec SELECT 0,gn,gnzf, 0,'',NOW() FROM 热点排序;	 
      
      /** 美股最后删 **/
      DELETE FROM gptoday WHERE id = (SELECT * FROM MaxId);      
         
      
       /**浮动盈亏**/  
      UPDATE `position` SET sumzf=((SELECT dqj FROM gptoday WHERE position.`code`= gptoday.`code`)-position.`vwap`)/position.`vwap`*100
		WHERE available > 0; 	      
      
       
       /** 风险模式 **/
       TRUNCATE qjsel;
       
       /** 突破 **/
       INSERT INTO qjsel SELECT 0,g.`code`,10,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`) 
                FROM gp g,gptoday g1,gpzfrec g2 WHERE g.`code`=g1.`code` AND g.`code`=g2.`code`                
		AND g2.`top_2` > 0	
		AND g1.dqj > 0			
		AND g1.`dqj` > g2.`top_2`						
		AND g2.zf2 > -2
		AND g2.zf2 < 2								
		AND g1.kpj > 0 
		AND g1.cj_amt > 0
		AND g1.`trantime` IS NOT NULL	
		AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC("09:31:00")
		AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC("14:30:00")
		AND IF((sz_50_zf < 0 AND cyb_zf < 0 AND dp_zf< 0 ),(TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC("14:30:00")),TRUE)
		AND IF(g.ltsz < 1000,g1.`zrspj` <= g2.`low_5`,TRUE)
		AND IF(g.ltsz < 1000,g.syl<=70,TRUE)		
		AND IF(g.ltsz < 1000,g.hy IN (SELECT hy FROM `行业排名5`) ,TRUE)
		AND IF(g.ltsz > 1000,(g2.zf7 < 7 AND g.hy <> '食品加工制造'),TRUE)
		AND IF(g.ltsz > 1000,(buy_cnt < 5),TRUE)
		AND g.hy NOT IN (SELECT DISTINCT g.hy FROM POSITION p,gp g WHERE p.`code`=g.`code` GROUP BY g.`hy` HAVING COUNT(g.hy) > 1)			
		AND g1.zf > 1
		AND g1.zf < 2				
		AND g1.dqj < 60	
		AND g1.dqj < g1.jrzgj
		AND g.ltsz > IF((sz_50_zf >= dp_zf AND sz_50_zf > cyb_zf),1000,0)
		AND g.ltsz < IF(dp_zf > sz_50_zf,1000,5000)
		AND g.syl < IF(sz_50_zf > dp_zf,35,999)		
		AND IF((sz_50_zf < dp_zf AND cyb_zf < dp_zf),(dp_jj > dp_zr_close AND dp_dqj < dp_zgj),TRUE)
		AND IF(cyb_zf > dp_zf,(cyb_jj > cyb_zr_close AND cyb_dqj < cyb_zgj),TRUE)
		AND g.`syl` <> 999;
	  
	 /*SZ50抄底*/
	INSERT INTO qjsel SELECT 0,g.`code`,11,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`) 
                FROM gp g,gptoday g1,gpzfrec g2 WHERE g.`code`=g1.`code` AND g.`code`=g2.`code`
                AND risk_mode = 1
		AND g.ltsz > 1000
		AND g.ltsz < 5000
		AND g.syl < 30
		AND g1.kpj > 0 
		AND g1.cj_amt > 0
		AND g1.dqj < 50	
		AND dp_dqj < dp_jx_20
		AND g1.dqj < g2.`jx_5`
		AND g.hy NOT IN (SELECT DISTINCT g.hy FROM POSITION p,gp g WHERE p.`code`=g.`code` GROUP BY g.`hy` HAVING COUNT(g.hy) > 1)	
		AND g1.dqj < (IFNULL(g1.jj,0)+g1.jrzdj)/2
		AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC(IF(g1.zf >0,"09:35:00","14:31:00"));  
		
         /*强势股抄底*/
	INSERT INTO qjsel SELECT 0,g.`code`,12,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`) 
                FROM gpsel gs,gp g,gptoday g1,gpzfrec g2 WHERE gs.`code`=g.`code` AND g.`code`=g1.`code` AND g.`code`=g2.`code`               
		AND g1.kpj > 0 
		AND g1.cj_amt > 0
		AND g1.dqj < 60			
		AND ((g2.`zr_close` < g2.`jx_30` AND g2.`zf` < -5 )
		       OR (g2.`zr_close` < g2.`jx_5` AND g2.`zr_close` < g2.`jx_60`))
		AND g.`syl` <> 999
		AND gs.`zbflag` IN (5,6)			
		AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC(IF(g1.zf >= 1,"09:35:00","14:31:00"));    
       
       /*行业排名2*/
       INSERT INTO qjsel 
		SELECT 0,g.`code`,9,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`) 
		 FROM gp g,gptoday g1,gpzfrec g2 WHERE g.`code`=g1.`code` 
		 AND g1.`code`=g2.`code`
		 AND g.`hy` IN (SELECT hy FROM `行业排名1`) 		 
		 AND g1.`zf` > 1 
		 AND g1.`zf` < 2
		 AND g2.zf7 < 10
		 AND g2.zf3 < 10	
		 AND g.syl < 50	
		 AND g1.dqj < 60	
		 AND dp_zf > sz_50_zf
		 AND g.hy NOT IN (SELECT DISTINCT g.hy FROM POSITION p,gp g WHERE p.`code`=g.`code` GROUP BY g.`hy` HAVING COUNT(g.hy) > 1)
		 AND g1.dqj < g1.jrzgj	 
		 AND g.ltsz < 5000
		 AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC("9:40:00")
		 AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC("14:40:00")
		 ORDER BY g2.zf7;  
        
        /*概念排名2*/
       INSERT INTO qjsel 
		SELECT 0,g.`code`,4,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`) 
		 FROM gp g,gptoday g1,gpzfrec g2,gn2gp g3 WHERE g.`code`=g1.`code` 
		 AND g1.`code`=g2.`code` AND g2.code=g3.gpcode
		 AND g.`code` IN (SELECT g.`gpcode` FROM gn2gp g WHERE g.`gn` IN (SELECT gn FROM `概念排名1`))			 
		 AND g1.`zf` > 1 
		 AND g1.`zf` < 2
		 AND g2.zf7 < 10
		 AND g2.zf3 < 10	
		 AND g.syl < 50	
		 AND g.ltsz < 100
		 AND g1.dqj < 60		 
		 AND IF((cyb_zf > 0 AND cyb_zf > dp_zf AND dp_zf > sz_50_zf),TRUE,FALSE)
		 AND g3.gn NOT IN (SELECT DISTINCT g.gn FROM POSITION p ,gn2gp g WHERE p.`code`=g.gpcode GROUP BY g.`gn` HAVING COUNT(g.gn) > 1)
		 AND g1.dqj < g1.jrzgj	 		
		 AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC("9:40:00")
		 AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC("14:40:00")
		 ORDER BY g2.zf7;   
	 	       					 
       COMMIT;    
       
      
       /**买人 */
       SELECT DISTINCT CODE,price,jcdate,1 trantype,xhtype FROM (SELECT q.xhtype,q.code,q.price,IFNULL(q.jcdate,NOW()) jcdate 
         FROM qjsel q,gpzfrec g1 WHERE q.code=g1.code AND q.price < 50 
          AND q.code NOT IN (SELECT p.code FROM `position` p WHERE p.`available_today` > 0)
		   AND q.zf < 9 ORDER BY q.xhtype DESC,g1.pj_15_zhengfu DESC ) tmp LIMIT 0,1
       UNION ALL
       
       /** 止损卖出**/
       SELECT p.code,p.`price`,CONCAT(DATE_FORMAT(g.`date`,'%Y-%m-%d'),' ',g.`trantime`) jcdate,-1 trantype,p.`inxh` xhtype FROM POSITION p,gptoday g 
		WHERE p.`code`=g.`code`
		 AND p.`available` > 0
		 AND (p.available - p.`available_today`) > 0		
		 AND (g.`zf` < 0 AND g.`dqj` < g.`jj`)
		 AND (p.`sumzf` >= 1 OR p.`sumzf` < -2)
		 AND DATE(p.`indate`) < DATE(NOW())
		 AND TIME_TO_SEC(g.`trantime`) > TIME_TO_SEC(IF(p.`sumzf` > 0, "9:32:00", "9:45:00"))
		 
	UNION ALL
        
        /** 止赢**/
        SELECT p.code,p.`price`,CONCAT(DATE_FORMAT(g.`date`,'%Y-%m-%d'),' ',g.`trantime`) jcdate,-1 trantype,p.`inxh` xhtype FROM POSITION p,gptoday g 
		WHERE p.`code`=g.`code`
		 AND p.`available` > 0
		 AND (p.available - p.`available_today`) > 0		 
		 AND  p.`sumzf` > 1
		 AND DATE(p.`indate`) < DATE(NOW())
		 AND  TIME_TO_SEC(g.`trantime`) > TIME_TO_SEC(IF(g.`zf` > 0 AND g.`dqj` > g.`jj`,"14:40:00","9:40:00"));
    END$$

DELIMITER ;