package com.namyang.nyorder.sale.dao;

import java.util.HashMap;
import java.util.List;

import com.namyang.nyorder.sale.vo.AgenVendVO;
import com.namyang.nyorder.sale.vo.SaleRegVO;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판매등록 Mapper
 * 파일명  : SaleRegMapper.java
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
public interface SaleRegMapper {
	/**
	 * @Method Name : selectSaleRegList
	 * @작성일 : 2022. 2. 3.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 판매 조회
	 * @param param
	 * @return List<SaleRegVo>
	 */
	public List<SaleRegVO> selectSaleRegList(SaleRegVO param);
	/**
	 * @Method Name : selectStdPrdPopList
	 * @작성일 : 2022. 2. 3.
	 * @작성자 : 이웅일
	 * @Method 설명 : 표준제품조회 (팝업)
	 * @param param
	 * @return List<SaleRegVo>
	 */
	public List<SaleRegVO> selectStdPrdPopList(SaleRegVO param);

	/**
	 * @Method Name : saveSaleMstReg
	 * @작성일 : 2022. 2. 4.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 판매 마스터 등록
	 * @param param
	 * @return List<SaleRegVo>
	 */
	public int megSaleMstReg(SaleRegVO param);
	/**
	 * @Method Name : saveSaleDtlReg
	 * @작성일 : 2022. 2. 4.
	 * @작성자 : 이웅일
	 * @Method 설명 : 거래처 판매 상세 등록
	 * @param param
	 */
	public int megSaleDtlReg(SaleRegVO param);


}
