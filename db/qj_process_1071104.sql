DELIMITER $$

USE `guopiao`$$

DROP PROCEDURE IF EXISTS `qj_process`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `qj_process`()
BEGIN		      
        DECLARE td_mode INT;  
        DECLARE sz_50_zf DOUBLE;  /*上证50涨幅*/  
        DECLARE cyb_zf DOUBLE; 
        DECLARE dp_zf DOUBLE;  
        
        DECLARE dc_flag INT;
        
        SELECT COUNT(DISTINCT p.`code`) INTO dc_flag FROM POSITION p WHERE p.`inxh` IN (2,22) AND p.`available` > 0;
        
        SELECT MAX(g.zf) INTO sz_50_zf FROM gptoday g WHERE g.`code` = 'sh000016';    
        SELECT MAX(g.zf) INTO dp_zf FROM gptoday g WHERE g.`code` = 'sh000001';   
        SELECT MAX(g.zf) INTO cyb_zf FROM gptoday g WHERE g.`code` = 'sz399006';   
        
        /*对冲标志*/
        IF (dc_flag > 0 AND cyb_zf < -0.18) THEN
          SET dc_flag = 1;
        ELSE 
          SET dc_flag = 0;
        END IF;
        
        SELECT g.tranmode INTO td_mode FROM gpparam g WHERE g.code= '001';  
        	
	 /**初始化*/   
        CALL comm_proc();
        
        /**中小创**/
        CALL cl_zxp(sz_50_zf,cyb_zf,dp_zf,dc_flag);
        
        /**对冲**/
        CALL cl_dc(sz_50_zf,cyb_zf,dp_zf);
        
        /**补仓**/
        CALL cl_bc(sz_50_zf,cyb_zf,dp_zf,dc_flag);
        
        /**测试模式*/
        IF (td_mode = 0) THEN      
           DELETE FROM POSITION;           
           INSERT POSITION (CODE,indate,inxh,available) 
		SELECT CODE,jcdate,xhtype,300 FROM qjsel WHERE qjsel.`code` NOT IN (SELECT CODE FROM POSITION); 
           COMMIT;
        END IF;                                  
        
        COMMIT;
             
        /**买人 卖出 */
        CALL buy_sell(dc_flag);
       			 
    END$$

DELIMITER ;