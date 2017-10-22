package com.erp.job;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

@Service("gpStaticJob")
public class GpStaticJob {

//	@Resource(name = "gpStaticService")
//	private GpStaticService gpStaticService;

	protected Log log = LogFactory.getLog(GpStaticJob.class);

	// 每5秒执行一次
	// @Scheduled(cron = " 0/15 25 9 ? * MON-FRI")
	// @Scheduled(cron = "0/10 * *  * * ?")
	public void countGpInfo() {
		log.info("countGpInfo start ...");

		// 记录次数
//		long t1 = new Date().getTime();
//
//		if (GPUtil.isGpTranTime()) {
//			try {
//				log.info("synDpMap.cnt:" + gpStaticService.synDpMap(null));
//				log.info("synGpMap.cnt:" + gpStaticService.synGpMap(null));
//				log.info("synGpselMap.cnt:"
//						+ this.gpStaticService.synGpselMap("1"));
//				log.info("getGpList.size:"
//						+ this.gpStaticService.getGpList(new BaseDto()).size());
//
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		} else {
//			log.info("no tran time ...");
//		}

//		long t2 = new Date().getTime();
//		log.info("countGpInfo end ...cost time:" + (t2 - t1) / 1000);
	}

	// @Scheduled(cron = "0 10 16 * * ?")
	public void updateToDb() {
		log.info("updateToDb start ...");
//		gpStaticService.setJdbcBaseDao(new BaseDAOImpl());
//		gpStaticService.getJdbcBaseDao().getEm().getTransaction().begin();
//		try {
//			gpStaticService.saveGpStatic();
//			gpStaticService.saveGpSel();
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} finally {
//			gpStaticService.getJdbcBaseDao().getEm().getTransaction().commit();
//		}

		log.info("updateToDb end ...");
	}

}