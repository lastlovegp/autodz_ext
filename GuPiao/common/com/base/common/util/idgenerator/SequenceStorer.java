package com.base.common.util.idgenerator;

/**
 * SequenceStorer
 * 此代码源于开源项目E3,原作者：黄云辉
 *
 * @author XiongChun
 * @since 2010-03-17
 */
public interface SequenceStorer {

	/**
	 * 保存序号
	 *
	 * @param pSequence
	 *            序号
	 * @param pSequenceID
	 *            序号ID
	 * @throws Exception
	 */
	public void updateMaxValueByFieldName(long pSequence, final String pSequenceID)
			throws Exception;

	/**
	 *
	 * @param pSequenceID
	 *            序号ID
	 * @return
	 * @throws Exception
	 */
	public long load(final String pSequenceID) throws Exception;
}
