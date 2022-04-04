package com.namyang.nyorder.sale.service;

import java.util.HashMap;
import java.util.List;

import com.namyang.nyorder.sale.vo.BcncBilctMngVO;
import com.namyang.nyorder.sale.vo.SaleRegVO;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 거래처수금관리 Service
 * 파일명  : BcncBilctMngService.java
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
public interface BcncBilctMngService {
	public SaleRegVO selectBaBillTot(SaleRegVO param);
	public List<SaleRegVO> selectBaBillTotList(SaleRegVO param);
	public String saveBaBillTot(SaleRegVO param) throws Exception;
}
