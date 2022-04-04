package com.namyang.nyorder.sale.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.myp.vo.AgentMngVO;
import com.namyang.nyorder.sale.dao.BcncMngMapper;
import com.namyang.nyorder.sale.vo.AgenVendVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 거래처 관리 Service Implement
 * 파일명  : BcncMngServiceImpl.java
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
@Service
public class BcncMngServiceImpl implements BcncMngService {

	@Autowired
	BcncMngMapper bcncMngMapper;

	/**
	 *	거래처 조회
	 */
	public List<AgenVendVO> selectAgentEmplList(AgenVendVO param) {
		return bcncMngMapper.selectAgentEmplList(param);
	}
	/**
	 *	거래처 조회
	 */
	public List<AgenVendVO> selectBcncMngList(AgenVendVO param) {
		return bcncMngMapper.selectBcncMngList(param);
	}

	/**
	 * 거래처 저장
	 */
	@Transactional
	public String saveBcnc(AgenVendVO param) throws Exception {
		bcncMngMapper.megBncn(param);
		bcncMngMapper.megVendEmpl(param);

		return "저장되었습니다.";
	}

	/**
	 *	거래처 상세 조회
	 */
	public AgenVendVO selectBcncMngDtl(AgenVendVO param) {
		return bcncMngMapper.selectBcncMngDtl(param);
	}

	/**
	 * 거래처 지원내역 저장
	 */
	@Transactional
	public String saveBcncSprt(AgenVendVO param) throws Exception {
		bcncMngMapper.megBcncSprt(param);

		return "저장되었습니다.";
	}

	/**
	 *	거래처 지원내역 조회
	 */
	public List<AgenVendVO> selectBcncSprtList(AgenVendVO param) {
		return bcncMngMapper.selectBcncSprtList(param);
	}

	/**
	 *	사용 지원내역 구분
	 */
	public String useSprtSec(AgenVendVO param) {
		return bcncMngMapper.selectUseSprtSec(param);

	}

	/**
	 *	거래처 지원내역 상세
	 */
	public AgenVendVO bncSprtDtl(AgenVendVO param) {
		return bcncMngMapper.selectBncSprtDtl(param);
	}



}
