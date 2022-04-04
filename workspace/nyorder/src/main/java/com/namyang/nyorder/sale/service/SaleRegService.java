package com.namyang.nyorder.sale.service;

import java.util.HashMap;
import java.util.List;

import com.namyang.nyorder.sale.vo.AgenVendVO;
import com.namyang.nyorder.sale.vo.BcncUntpcVO;
import com.namyang.nyorder.sale.vo.SaleRegVO;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판매등록 Service
 * 파일명  : SaleRegService.java
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
public interface SaleRegService {
	public List<SaleRegVO> selectSaleRegList(SaleRegVO param);
	public List<SaleRegVO> selectStdPrdPopList(SaleRegVO param);
	public String saveSaleReg(SaleRegVO param) throws Exception;
}
