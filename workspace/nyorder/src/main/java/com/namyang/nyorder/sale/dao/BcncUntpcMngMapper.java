package com.namyang.nyorder.sale.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.namyang.nyorder.sale.vo.BcncUntpcVO;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 거래처별 단가 관리 Mapper
 * 파일명  : BcncUntpcMngMapper.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 1. 18.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 18.    이웅일     최조 프로그램 작성
 *
 ****************************************************/
public interface BcncUntpcMngMapper {
	/**
	 * @Method Name : selectUntpcMngList
	 * @작성일 : 2022. 1. 26.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처별 단가 조회
	 * @param param
	 * @return List<BcncUntpcVO>
	 */
	public List<BcncUntpcVO> selectUntpcMngList(BcncUntpcVO param);

	/**
	 * @Method Name : insAgenVendUntpc
	 * @작성일 : 2022. 1. 27.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처별 단가 저장
	 * @param param
	 * @return Intrger
	 */
	public int megAgenVendUntpc(BcncUntpcVO param);

	/**
	 * @Method Name : insVendUntpcChg
	 * @작성일 : 2022. 2. 22.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처별 단가 변경  저장
	 * @param param
	 * @return Intrger
	 */
	public int megVendUntpcChg(BcncUntpcVO param);

	/**
	 * @Method Name : updateUntpcEnd
	 * @작성일 : 2022. 1. 27.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처별 단가 상태 업데이트
	 * @param param
	 * @return Intrger
	 */
	public int updateUntpcEnd(BcncUntpcVO param);

	/**
	 * @Method Name : selectAllBcncUntpc
	 * @작성일 : 2022. 2. 16.
	 * @작성자 : 이웅일
	 * @Method 설명 : 제품 거래처별 단가 조회
	 * @param param
	 * @return List<BcncUntpcVO>
	 */
	public List<BcncUntpcVO> selectAllBcncUntpc(BcncUntpcVO param);

	/**
	 * @Method Name : selectBcncPrdChgHis
	 * @작성일 : 2022. 2. 25.
	 * @작성자 : 이웅일
	 * @Method 설명 : 제품변경 및 단가 이력 조회
	 * @param param
	 * @return List<BcncUntpcVO>
	 */
	public List<BcncUntpcVO> selectBcncPrdChgHis(BcncUntpcVO param);

	/**
	 * @Method Name : selectStdrPrdList
	 * @작성일 : 2022. 3. 10.
	 * @작성자 : 이웅일
	 * @Method 설명 : 단가복사 단가리스트 조회
	 * @param param
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> selectStdrPrdList(Map<String, Object> param);
}
