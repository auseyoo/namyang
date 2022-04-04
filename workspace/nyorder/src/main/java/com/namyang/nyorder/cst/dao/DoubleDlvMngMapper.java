package com.namyang.nyorder.cst.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import com.namyang.nyorder.cst.vo.DoubleDlvMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 더블작업 Mapper
 * 파일명  : DoubleDlvMngMapper.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 3. 14.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 14.    이웅일     최조 프로그램 작성
 *
 ****************************************************/
@Repository
public interface DoubleDlvMngMapper {
	/**
	 * @Method Name : selectLegacyDlvData
	 * @작성일 : 2022. 3. 18.
	 * @작성자 : 이웅일
	 * @Method 설명 : 기존 출고데이터 SELECT
	 * @param param
	 * @return List<DoubleDlvMngVo>
	 */
	public List<DoubleDlvMngVO> selectLegacyDlvData(DoubleDlvMngVO param);
	/**
	 * @Method Name : megCstPrdDlvy
	 * @작성일 : 2022. 3. 18.
	 * @작성자 : 이웅일
	 * @Method 설명 : 출고데이터 MERGE
	 * @param param
	 * @return int
	 */
	public int megCstPrdDlvy(DoubleDlvMngVO param);

	/**
	 * @Method Name : megStatDoubleDlv
	 * @작성일 : 2022. 3. 18.
	 * @작성자 : 이웅일
	 * @Method 설명 : 출고데이터 더블작업 MERGE
	 * @param param
	 * @return int
	 */
	public int megStatDoubleDlv(DoubleDlvMngVO param);

	/**
	 * @Method Name : insDoubleMst
	 * @작성일 : 2022. 3. 18.
	 * @작성자 : 이웅일
	 * @Method 설명 : 더블작업 마스터 INSERT
	 * @param param
	 * @return int
	 */
	public int insDoubleMst(DoubleDlvMngVO param);

	/**
	 * @Method Name : insDoubleDtl
	 * @작성일 : 2022. 3. 18.
	 * @작성자 : 이웅일
	 * @Method 설명 : 더블작업 상세 INSERT
	 * @param param
	 * @return int
	 */
	public int insDoubleDtl(DoubleDlvMngVO param);


	/**
	 * @Method Name : updateLegacyQtyZero
	 * @작성일 : 2022. 3. 21.
	 * @작성자 : 이웅일
	 * @Method 설명 : 이전데이터 물량 0으로 UPDATE
	 * @param param
	 * @return int
	 */
	public int updateLegacyQtyZero(DoubleDlvMngVO param);

	/**
	 * @Method Name : selectDoubleList
	 * @작성일 : 2022. 3. 21.
	 * @작성자 : 이웅일
	 * @Method 설명 : 더블 마스터 조회
	 * @param param
	 * @return List<DoubleDlvMngVo>
	 */
	public List<DoubleDlvMngVO> selectDoubleList(DoubleDlvMngVO param);

	/**
	 * @Method Name : updateDlvyQty
	 * @작성일 : 2022. 3. 21.
	 * @작성자 : 이웅일
	 * @Method 설명 : 더블 분리작업
	 * @param param
	 * @return int
	 */
	public int updateDlvyQty(DoubleDlvMngVO param);

	/**
	 * @Method Name : updateReturnYn
	 * @작성일 : 2022. 3. 22.
	 * @작성자 : 이웅일
	 * @Method 설명 : 더블 분리 작업 완료 업데이트
	 * @param param
	 * @return int
	 */
	public int updateReturnYn(DoubleDlvMngVO param);
}
