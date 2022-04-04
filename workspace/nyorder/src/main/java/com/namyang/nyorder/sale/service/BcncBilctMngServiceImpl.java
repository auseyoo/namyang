package com.namyang.nyorder.sale.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.sale.dao.BcncBilctMngMapper;
import com.namyang.nyorder.sale.vo.BcncBilctMngVO;
import com.namyang.nyorder.sale.vo.SaleRegVO;
/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 거래처 수금관리 Service Implement
 * 파일명  : BcncBilctMngServiceImpl.java
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
@Service
public class BcncBilctMngServiceImpl implements BcncBilctMngService {
	@Autowired
	BcncBilctMngMapper bcncBilctMngMapper;

	/**
	 *	거래처 판매 수금정보 조회
	 */
	public SaleRegVO selectBaBillTot(SaleRegVO param) {
		return bcncBilctMngMapper.selectBaBillTot(param);
	}
	/**
	 *	거래처 수금 리스트 조회
	 */
	public List<SaleRegVO> selectBaBillTotList(SaleRegVO param) {
		return bcncBilctMngMapper.selectBaBillTotList(param);
	}
	/**
	 *	거래처 판매 수금정보 등록
	 */
	public String saveBaBillTot(SaleRegVO param) {
		bcncBilctMngMapper.updateAtmptCt(param);
		bcncBilctMngMapper.megBaBillTot(param);
		return "저장되었습니다.";
	}
}
