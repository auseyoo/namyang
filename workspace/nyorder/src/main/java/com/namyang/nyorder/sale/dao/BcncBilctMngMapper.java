package com.namyang.nyorder.sale.dao;

import java.util.HashMap;
import java.util.List;

import com.namyang.nyorder.sale.vo.AgenVendVO;
import com.namyang.nyorder.sale.vo.BcncBilctMngVO;
import com.namyang.nyorder.sale.vo.SaleRegVO;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 거래처수금관리 Mapper
 * 파일명  : BcncBilctMngMapper.java
 * 작성자  : 이웅일
 * 작성일  : 2022. 2. 8.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 8.    이웅일     최조 프로그램 작성
 *
 ****************************************************/
public interface BcncBilctMngMapper {
	/**
	 * @Method Name : selectBaBillTotList
	 * @작성일 : 2022. 2. 11.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 수금 리스트 조회
	 * @param param
	 * @return List<SaleRegVo>
	 */
	public List<SaleRegVO> selectBaBillTotList(SaleRegVO param);
	/**
	 * @Method Name : selectBaBillTot
	 * @작성일 : 2022. 2. 10.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 판매 수금 조회
	 * @param param
	 * @return SaleRegVo
	 */
	public SaleRegVO selectBaBillTot(SaleRegVO param);
	/**
	 * @Method Name : megBaBillTot
	 * @작성일 : 2022. 2. 10.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 판매 수금정보 등록
	 * @param param
	 */
	public int megBaBillTot(SaleRegVO param);
	/**
	 * @Method Name : updateAtmptCt
	 * @작성일 : 2022. 2. 10.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 판매 미수금 일괄 업데이트
	 * @param param
	 */
	public int updateAtmptCt(SaleRegVO param);
}
