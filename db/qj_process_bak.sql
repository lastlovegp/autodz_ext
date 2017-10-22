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
      DECLARE dp_zr_zf DOUBLE;    
      DECLARE dp_jj DOUBLE;  
      DECLARE dp_zf_3 DOUBLE;  
      DECLARE dp_jx_5 DOUBLE;  
      DECLARE dp_jx_10 DOUBLE;   
      DECLARE dp_jx_20 DOUBLE;   
      DECLARE dp_jx_60 DOUBLE;   
      DECLARE dp_rsi_6 DOUBLE;      
            
      DECLARE dp_dqj DOUBLE;  
      DECLARE dp_zgj DOUBLE; 
      DECLARE dp_zr_close DOUBLE; 
      
      DECLARE zxp_zf DOUBLE;   
      DECLARE zxp_dqj DOUBLE;  
      DECLARE zxp_zgj DOUBLE; 
      DECLARE zxp_zr_close DOUBLE; 
      
      /*declare risk_mode int;  */
      DECLARE sz50_cd_buy_cnt INT;   
      DECLARE cd_buy_cnt INT;   
      DECLARE drd_gn_cnt INT;  
      DECLARE gn_gn_cnt INT;  
      DECLARE total_cnt INT;  
      DECLARE sz_gp_cnt INT;       
      DECLARE tp_buy_cnt INT;  
      DECLARE can_buy_cnt INT DEFAULT 10;  
      DECLARE in_time VARCHAR(200) DEFAULT "9:40:00";      
      
      DECLARE gn_cnt INT;   
      
      SELECT COUNT(p.code) INTO sz50_cd_buy_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 11; 
      SELECT COUNT(p.code) INTO cd_buy_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 12; 
      SELECT COUNT(p.code) INTO  drd_gn_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 9;  
      SELECT COUNT(p.code) INTO  gn_gn_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 4;
      SELECT COUNT(p.code) INTO  tp_buy_cnt FROM POSITION p WHERE DATE(p.`indate`) = DATE(NOW()) AND  p.`inxh` = 10;    
      SELECT COUNT(p.code) INTO  total_cnt FROM POSITION p WHERE p.inxh < 20 AND p.`available`> 0 ;
      
      SELECT COUNT(DISTINCT g.`gn`) INTO gn_cnt FROM gn2gp g,POSITION p WHERE g.`gpcode`=p.`code` AND p.`available` > 0
              AND g.`gn` IN (SELECT gn FROM `概念排名5`);
      
      
      /*SELECT g.tranmode INTO risk_mode FROM gpparam g WHERE g.code= '001';*/
          
      SELECT MAX(g.zf) INTO sz_50_zf FROM gptoday g WHERE g.`code` = 'sh000016';      
         
      SELECT MAX(g.zf),MAX(g.jj),MAX(g.dqj),MAX(g.zrspj),MAX(g.jrzgj) INTO dp_zf,dp_jj,dp_dqj,dp_zr_close,dp_zgj
            FROM gptoday g WHERE g.`code` = 'sh000001';        
       
      SELECT MAX(g.zf),MAX(g.jj),MAX(g.dqj),MAX(g.zrspj),MAX(g.jrzgj) INTO cyb_zf,cyb_jj,cyb_dqj,cyb_zr_close,cyb_zgj
            FROM gptoday g WHERE g.`code` = 'sz399006';    
       
      SELECT MAX(g.zf),MAX(g.dqj),MAX(g.zrspj),MAX(g.jrzgj) INTO zxp_zf,zxp_dqj,zxp_zr_close,zxp_zgj
            FROM gptoday g WHERE g.`code` = 'sz399001';     
	
      SELECT MAX(g.jx_5),MAX(g.jx_10),MAX(g.jx_20),MAX(g.zf3),MAX(g.`rsi_6`),MAX(g.jx_60),MAX(g.`zf`)
           INTO dp_jx_5,dp_jx_10,dp_jx_20,dp_zf_3,dp_rsi_6,dp_jx_60,dp_zr_zf
            FROM gpzfrec g WHERE g.`code` = '000001';                
                  	
       /**行业涨幅  */   
      TRUNCATE hyzfrec;     
      INSERT INTO hyzfrec SELECT 0,hy,zf, 0,'',NOW() FROM 今日行业涨幅;	 
         	      
      /**概念涨幅**/	     
      TRUNCATE gnzfrec;
      INSERT INTO gnzfrec SELECT 0,gn,gnzf, 0,'',NOW() FROM 热点排序;	 
                          
       /**浮动盈亏**/  
      UPDATE `position` SET sumzf=((SELECT dqj FROM gptoday WHERE position.`code`= gptoday.`code`)-position.`vwap`)/position.`vwap`*100
		WHERE available > 0; 	      
      
       
       /** 风险模式 **/
       TRUNCATE qjsel;
       
       /*大热点*/
       INSERT INTO qjsel SELECT 0,g.`code`,9,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`) 
	FROM
	  hyref r,
	  gp g,
	  gptoday g1,
	  gpzfrec g2 
	WHERE 
	  drd_gn_cnt < 3
	  AND r.`dl` IN (SELECT dl FROM `大热点`) 
	  AND r.`xl` = g.`hy` 
	  AND g.`code` = g1.`code` 
	  AND g.`code` = g2.`code` 
	  AND g1.`cj_amt` > 0 
	  AND g1.`dqj` < 60 
	  AND g.`ltsz` < 1000 
	  AND g.`syl` < IF(r.`dl` = 'gqgg', 1000, 999) 
	  AND g1.`zf` > 1
	  AND g1.zf  < 5	 	  
	  AND g.hy NOT IN (SELECT DISTINCT g.hy FROM POSITION p,gp g WHERE p.`code`=g.`code` GROUP BY g.`hy` HAVING COUNT(g.hy) > 0)	
	  AND g1.`dqj` > g1.`jj` 
	  AND g1.`dqj` > g2.`jx_5` 
	  AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC(in_time)
	  AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC("14:20:00")
	  ORDER BY g1.`zf` DESC LIMIT 0,3;
       
       /** 行业转化 **/
       INSERT INTO qjsel SELECT 0,g.`code`,10,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`) 
                FROM gp g,gptoday g1,gpzfrec g2 WHERE g.`code`=g1.`code` AND g.`code`=g2.`code`    
                AND g1.`trantime` IS NOT NULL            
		AND g2.`top_2` > 0	
		AND g1.dqj > 0																				
		AND g1.kpj > 0 
		AND g1.cj_amt > 0
		AND g2.`rsi_6` < 60
		AND g2.`rsi_12` < 60
		AND g2.`rsi_24` < 60					
		AND g1.`dqj` > g2.`top_2`							
		AND IF(dp_zf > 0.5,tp_buy_cnt < 3, tp_buy_cnt < 2)			
		AND (g.hy IN (SELECT hy FROM `行业排名1`))
		AND g.hy NOT IN (SELECT DISTINCT g.hy FROM POSITION p,gp g WHERE p.`code`=g.`code` GROUP BY g.`hy` HAVING COUNT(g.hy) > 0)	      								        																								
		AND g1.dqj < g1.jrzgj				
		AND g.syl < 100
		AND g1.dqj < 60
		AND g.ltsz < 5000		
		AND g1.zf < 5	
		AND g1.dqj > g1.jj			
		AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC(in_time)
		AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC("14:20:00")
		ORDER BY g1.zf DESC,g2.zf7;	
		
         /** 概念突破 **/
        INSERT INTO qjsel 
		SELECT DISTINCT 0,g.`code`,4,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`) 
		 FROM gp g,gptoday g1,gpzfrec g2,gn2gp g3 WHERE g.`code`=g1.`code` 
		 AND g1.`code`=g2.`code` AND g2.code=g3.gpcode
		 AND g.`code` IN (SELECT DISTINCT g.`gpcode` FROM gn2gp g WHERE g.`gn` IN (SELECT gn FROM `概念排名5`))	
		 AND g2.`zf3` < 3		
		 AND g2.`rsi_6` < 60
		 AND g2.`rsi_12` < 60
		 AND g2.`rsi_24` < 60	
		 AND g1.cj_amt > 0	
		 AND g1.`dqj` > g2.`top_2`
		 AND g.syl < 70
		 AND IF(dp_zf > 0.5,gn_gn_cnt < 2, gn_gn_cnt < 1)		
		 AND g.ltsz < 100
		 AND g1.dqj < 60
		 AND gn_cnt = 0	
		 AND g1.zf < 5						
		 AND g1.dqj < g1.jrzgj	
		 AND g1.dqj > g1.jj		 	
		 AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC(in_time)	
		 AND TIME_TO_SEC(g1.`trantime`) < TIME_TO_SEC("14:41:00")	 
		 ORDER BY g1.zf DESC,g2.zf7; 
			                       
         /*大盘股抄底*/
	INSERT INTO qjsel SELECT 0,g.`code`,11,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`) 
                FROM gp g,gptoday g1,gpzfrec g2,gpsel g3 WHERE g.`code`=g1.`code` AND g.`code`=g2.`code` AND g.code=g3.code
                AND g3.zbflag = 0    
                AND g1.dqj > 0   
                AND dp_dqj > 0         		
		AND g1.dqj < g2.`jx_5`			
		AND dp_dqj < dp_jx_5
		AND sz50_cd_buy_cnt < 1
		AND g2.`zf3` < 4
		AND g1.zf > -1 
		AND g1.zf < 1	
		AND TIME_TO_SEC(g1.`trantime`) > IF(g1.zf > 0 AND g1.zf < 1,TIME_TO_SEC('9:35:00'),TIME_TO_SEC('14:43:00')); 
	  
		
         /*强势股抄底*/
	INSERT INTO qjsel SELECT 0,g.`code`,12,g1.dqj,g1.zf,CONCAT(DATE_FORMAT(g1.`date`,'%Y-%m-%d'),' ',g1.`trantime`) 
                FROM gpsel gs,gp g,gptoday g1,gpzfrec g2 WHERE gs.`code`=g.`code` AND g.`code`=g1.`code` AND g.`code`=g2.`code`               
		AND g1.kpj > 0 
		AND g1.cj_amt > 0
		AND g1.dqj > 0		
		AND g1.`zrspj` <= g2.`low_3`	
		AND g1.zf > 1
		AND g1.zf < 2
		AND cd_buy_cnt < 1
		AND gs.`zbflag` IN (5,6)
		AND (g.`code` IN (SELECT DISTINCT g.`gpcode` FROM gn2gp g WHERE g.`gn` IN (SELECT gn FROM `概念排名5`))	
		       OR g.hy IN (SELECT hy FROM `行业排名6`))		       				
		AND TIME_TO_SEC(g1.`trantime`) > TIME_TO_SEC('9:45:00')		
		ORDER BY gs.gpflag DESC;    
              	 	       					
       COMMIT;    
             
       /**买人 */
       SELECT DISTINCT CODE,price,jcdate,trantype,xhtype FROM (
       SELECT CODE,price,jcdate,1 trantype,xhtype FROM (SELECT q.xhtype,q.code,q.price,IFNULL(q.jcdate,NOW()) jcdate 
         FROM qjsel q,gpzfrec g1 WHERE q.code=g1.code AND q.price < 50
          AND g1.zr_close > 0
          AND (g1.`jx_5`-g1.`zr_close`)/g1.`zr_close`*100 < 30
          AND q.code NOT IN (SELECT p.code FROM `position` p WHERE p.`available_today` > 0)
		   AND q.zf < 9 ORDER BY q.xhtype DESC,g1.pj_15_zhengfu DESC ) tmp 
          WHERE total_cnt < can_buy_cnt
	  LIMIT 0,1
	  
       UNION ALL
       
       /** 止损卖出**/
       SELECT p.code,p.`price`,CONCAT(DATE_FORMAT(g.`date`,'%Y-%m-%d'),' ',g.`trantime`) jcdate,-1 trantype,p.`inxh` xhtype FROM POSITION p,gptoday g 
		WHERE p.`code`=g.`code`
		 AND p.`available` > 0
		 AND (p.available - p.`available_today`) > 0				
		 AND IF(g.zf > 0,FALSE,TRUE)
		 AND p.`sumzf` < IF(p.inxh <= 10,-2,-5)			 	 
		 AND DATE(p.`indate`) < DATE(NOW())
		 AND TIME_TO_SEC(g.`trantime`) > TIME_TO_SEC(IF(g.`jj` > 0 AND g.`dqj` >= g.`jj`,"14:45:00","9:40:00"))
		 
	UNION ALL
        
        /** 止赢**/
        SELECT p.code,p.`price`,CONCAT(DATE_FORMAT(g.`date`,'%Y-%m-%d'),' ',g.`trantime`) jcdate,-1 trantype,p.`inxh` xhtype FROM POSITION p,gptoday g 
		WHERE p.`code`=g.`code`
		 AND p.`available` > 0
		 AND (p.available - p.`available_today`) > 0		 
		 AND  p.`sumzf` > 1
		 AND  p.sumzf < 9
		 AND DATE(p.`indate`) < DATE(NOW())
		 AND TIME_TO_SEC(g.`trantime`) > TIME_TO_SEC(IF(g.`jj` > 0 AND g.`dqj` >= g.`jj`,"14:40:00","9:40:00"))) 
		 tmp ORDER BY trantype;
    END$$

DELIMITER ;