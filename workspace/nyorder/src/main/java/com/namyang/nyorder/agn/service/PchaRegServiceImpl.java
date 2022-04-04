package com.namyang.nyorder.agn.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.agn.dao.InvryMstMapper;
import com.namyang.nyorder.agn.dao.PchaRegMapper;
import com.namyang.nyorder.agn.vo.PchaRegVO;
import com.namyang.nyorder.comm.vo.UserInfo;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 매입 등록 Service Implement
 * 파일명  : PchaRegServiceImpl.java
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
public class PchaRegServiceImpl implements PchaRegService {

	@Autowired
	PchaRegMapper pchaRegMapper;
	
	@Autowired
	private InvryMstMapper invryMstMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	@Override
	public Map<String, Object> selectPchaList(PchaRegVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", pchaRegMapper.selectPchaList(param));
		return result;
	}

	@Override
	public Map<String, Object> selectPchaRegList(PchaRegVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", pchaRegMapper.selectPchaRegList(param));
		return result;
	}

	@Override
	@Transactional
	public String savePchaRegList(List<PchaRegVO> list) throws Exception {
		for(PchaRegVO param : list) {
			param.setAgenSeq( userInfo.getAgenSeq() );
			param.setEmplSeq(userInfo.getEmplSeq());
			
			if("C".equals( param.getCrudMode() )) {
				//타사제품 사용여부 수정(사용)
				param.setOthComPrdYn("Y");
				pchaRegMapper.updateOthComPrdYn(param);
				//매입 등록
				this.savePchaReg(param);
			}else if("U".equals( param.getCrudMode() )) {
				//매입 등록
				this.savePchaReg(param);
			}else if( "D".equals( param.getCrudMode() ) ) {
				//타사제품 사용여부 수정(삭제)
				param.setOthComPrdYn("N");
				pchaRegMapper.updateOthComPrdYn(param);
			}
		}
		return "정상적으로 저장되었습니다.";
	}

	@Override
	public Map<String, Object> selectOthComPrdList(PchaRegVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", pchaRegMapper.selectOthComPrdList(param));
		return result;
	}
	
	//매입등록
	public void savePchaReg( PchaRegVO param ) {
		PchaRegVO pchaRegVO = new PchaRegVO();
		//기존에 있던 매입정보 조회
		pchaRegVO = pchaRegMapper.selectPchaInfoList(param);
		
		if( pchaRegVO != null ) {
			param.setBoxQty( param.getBoxQty() + pchaRegVO.getBoxQty() );
			param.setIddyQty( param.getIddyQty() + pchaRegVO.getIddyQty() );
		}
		
		//매입정보 마지막여부 수정(N)
		pchaRegMapper.updateOthComPrdLastYn(param);
		
		//매입정보 등록
		pchaRegMapper.insertOtgOrdPrd(param);
		
		PchaRegVO invryParam = new PchaRegVO();
		invryParam.setAgenSeq(param.getAgenSeq());
		invryParam.setPuchSeq(param.getPuchSeq());
		invryParam.setPrdDtlSeq(param.getPrdDtlSeq());
		invryParam.setStdrDt(param.getOrdStusDt());
		invryParam.setWrhsBoxQty( param.getBoxQty() );
		invryParam.setWrhsIddyQty( param.getIddyQty() );
		invryParam.setEmplSeq( param.getEmplSeq() );
		invryParam.setFaltQty(param.getFaltQty());
		
		//재고 정보가 있는지 조회
		int cnt = pchaRegMapper.selectInvryMst(invryParam);
		if( cnt > 0 ) {
			int invrySeq = pchaRegMapper.selectInvryMstKey(invryParam);
			invryParam.setInvrySeq(invrySeq);
			//재고 수정
			pchaRegMapper.updateInvryMst(invryParam);
		}else {
			PchaRegVO invryVO = new PchaRegVO();
			invryVO = pchaRegMapper.selectYestdInvry(invryParam);
			if( invryVO != null ) {
				invryParam.setYestdBoxQty( invryVO.getYestdBoxQty() );
				invryParam.setInvryBoxQty( invryParam.getYestdBoxQty() + invryParam.getWrhsBoxQty() );
				invryParam.setYestdIddyQty( invryParam.getYestdIddyQty() );
				invryParam.setInvryIddyQty( invryParam.getYestdIddyQty() + invryParam.getWrhsIddyQty() );
			}else {
				invryParam.setYestdBoxQty( 0 );
				invryParam.setInvryBoxQty( invryParam.getWrhsBoxQty() );
				invryParam.setYestdIddyQty( 0 );
				invryParam.setInvryIddyQty( invryParam.getWrhsIddyQty() );
			}
			//재고 등록
			pchaRegMapper.insertInvryMst(invryParam);
		}
		
		//재고 로그 등록
		pchaRegMapper.insertInvryMstLog(invryParam);
		
		//InvryMstVO invryMstVO = new InvryMstVO();
		//invryMstVO.setAgenSeq( userInfo.getAgenSeq() );
		//invryMstVO.setPrdDtlSeq( invryParam.getPrdDtlSeq() );
		//invryMstVO.setPuchSeq( invryParam.getPuchSeq() );
		//invryMstVO.setStdrDt( invryParam.getStdrDt() );
		//invryMstVO.setEmplSeq( userInfo.getEmplSeq() );
		// 입고수량 적용일 포함, 이후일자 재고 갱신 프로시저 호출
		//invryMstMapper.updStdPrdInvryAfterUpd(invryMstVO);
	}
	
}
