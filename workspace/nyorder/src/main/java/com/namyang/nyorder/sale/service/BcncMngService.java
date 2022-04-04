package com.namyang.nyorder.sale.service;

import java.util.HashMap;
import java.util.List;

import com.namyang.nyorder.myp.vo.AgentMngVO;
import com.namyang.nyorder.sale.vo.AgenVendVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 거래처 관리 Service
 * 파일명  : BcncMngService.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 7.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 7.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
public interface BcncMngService {

	public List<AgenVendVO> selectAgentEmplList(AgenVendVO param);

	public List<AgenVendVO> selectBcncMngList(AgenVendVO param);

	public String saveBcnc(AgenVendVO param) throws Exception;

	public AgenVendVO selectBcncMngDtl(AgenVendVO param);

	public String saveBcncSprt(AgenVendVO param) throws Exception;

	public List<AgenVendVO> selectBcncSprtList(AgenVendVO param);

	public String useSprtSec(AgenVendVO param);

	public AgenVendVO bncSprtDtl(AgenVendVO param);

}
