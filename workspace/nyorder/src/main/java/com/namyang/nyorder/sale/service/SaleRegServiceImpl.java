package com.namyang.nyorder.sale.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.sale.dao.BcncUntpcMngMapper;
import com.namyang.nyorder.sale.dao.SaleRegMapper;
import com.namyang.nyorder.sale.vo.AgenVendVO;
import com.namyang.nyorder.sale.vo.SaleRegVO;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판매등록 Service Implement
 * 파일명  : SaleRegServiceImpl.java
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
@Service
public class SaleRegServiceImpl implements SaleRegService {

	@Autowired
	SaleRegMapper saleRegMapper;
	/**
	 *	거래처 판매 조회
	 */
	public List<SaleRegVO> selectSaleRegList(SaleRegVO param) {
		return saleRegMapper.selectSaleRegList(param);
	}
	/**
	 *	표준제품 조회 (팝업)
	 */
	public List<SaleRegVO> selectStdPrdPopList(SaleRegVO param) {
		return saleRegMapper.selectStdPrdPopList(param);
	}
	/**
	/**
	 *	거래처 판매 등록
	 */
	public String saveSaleReg(SaleRegVO param) {

		saleRegMapper.megSaleMstReg(param);
		if(!param.getRemoveYn().equals("Y")){
			saleRegMapper.megSaleDtlReg(param);
		}

		return "저장되었습니다.";
	}

}
