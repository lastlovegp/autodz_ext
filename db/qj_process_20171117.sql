DELIMITER $$

USE `guopiao`$$

DROP PROCEDURE IF EXISTS `qj_process`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `qj_process`()
BEGIN		      
        DECLARE td_mode INT;  
        
        DECLARE zxp_zf DOUBLE;  /*上证50涨幅*/  
        DECLARE cyb_zf DOUBLE; 
        DECLARE dp_zf DOUBLE;  
                                     
        SELECT MAX(g.zf) INTO zxp_zf FROM gptoday g WHERE g.`code` = 'sz399001';    
        SELECT MAX(g.zf) INTO dp_zf FROM gptoday g WHERE g.`code` = 'sh000001';   
        SELECT MAX(g.zf) INTO cyb_zf FROM gptoday g WHERE g.`code` = 'sz399006';   
                                                       	
	 /**初始化*/   
        CALL comm_proc();
        
        /**股票池抄底*/
        CALL cl_cdqsg(1,cyb_zf,zxp_zf,dp_zf);            		
	
	 /**补仓**/
        CALL cl_bc(2);    
	        
        /**测试模式*/              
        SELECT g.tranmode INTO td_mode FROM gpparam g WHERE g.code= '001';   
        IF (td_mode = 0) THEN      
           DELETE FROM POSITION;           
           INSERT POSITION (CODE,indate,inxh,available) 
		SELECT CODE,jcdate,xhtype,300 FROM qjsel WHERE qjsel.`code` NOT IN (SELECT CODE FROM POSITION); 
           COMMIT;
        END IF;        
        
        TRUNCATE prezf;   
	INSERT INTO prezf SELECT CODE,zf FROM gptoday;                          
        
        COMMIT;
             
        /**买人 卖出 */
        CALL buy_sell();
       			 
    END$$

DELIMITER ;