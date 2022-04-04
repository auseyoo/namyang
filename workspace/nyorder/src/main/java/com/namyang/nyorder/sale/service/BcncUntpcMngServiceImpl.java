package com.namyang.nyorder.sale.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.sale.dao.BcncMngMapper;
import com.namyang.nyorder.sale.dao.BcncUntpcMngMapper;
import com.namyang.nyorder.sale.vo.AgenVendVO;
import com.namyang.nyorder.sale.vo.BcncUntpcVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 거래처별 단가 관리 Service Implement
 * 파일명  : BcncUntpcMngServiceImpl.java
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
public class BcncUntpcMngServiceImpl implements BcncUntpcMngService {
	@Autowired
	BcncUntpcMngMapper bcncUntpcMngMapper;

	/**
	 *	거래처 조회
	 */
	public List<BcncUntpcVO> selectUntpcMngList(BcncUntpcVO param) {
		return bcncUntpcMngMapper.selectUntpcMngList(param);
	}

	/**
	 * 거래처별 단가  저장
	 */
	@Transactional
	public String saveAgenVendUntpc(BcncUntpcVO param) throws Exception {
		if(param.getApplYn().equals("Y") || param.getRemoveYn().equals("Y")) {
			bcncUntpcMngMapper.updateUntpcEnd(param);
		}
		if(param.getApplYn().equals("Y") &&!param.getAftPrdDtlSeq().equals(param.getBefPrdDtlSeq())) {
			BcncUntpcVO tParam = new BcncUntpcVO();
			tParam.setAgenSeq(param.getAgenSeq());
			tParam.setEmplSeq(param.getEmplSeq());
			tParam.setVendSeq(param.getVendSeq());
			tParam.setAftPrdDtlSeq(param.getBefPrdDtlSeq());
			tParam.setRemoveYn("Y");
			bcncUntpcMngMapper.updateUntpcEnd(tParam);
		}
		if(!param.getRemoveYn().equals("Y") && param.getChgSaleUntpc() !=null && !param.getChgSaleUntpc().equals("")){
			bcncUntpcMngMapper.megAgenVendUntpc(param);
			bcncUntpcMngMapper.megVendUntpcChg(param);
		}

		return "저장되었습니다.";
	}


	/**
	 *	제품 거래처별 조회
	 */
	public List<BcncUntpcVO> selectAllBcncUntpc(BcncUntpcVO param) {
		return bcncUntpcMngMapper.selectAllBcncUntpc(param);
	}

	/**
	 *	제품변경 및 단가 이력 조회
	 */
	public List<BcncUntpcVO> selectBcncPrdChgHis(BcncUntpcVO param) {
		return bcncUntpcMngMapper.selectBcncPrdChgHis(param);
	}

	/**
	 *	단가복사 단가리스트 조회
	 */
	public List<Map<String, Object>> selectStdrPrdList(Map<String, Object> param) {
		return bcncUntpcMngMapper.selectStdrPrdList(param);
	}

}
