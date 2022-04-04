package com.namyang.nyorder.agn.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.agn.dao.OrdrRegMapper;
import com.namyang.nyorder.agn.vo.OrdRegVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.std.dao.StdPrdMngMapper;
import com.namyang.nyorder.std.vo.StdPrdMngDetailVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 주문 등록 Service Implement
 * 파일명  : OrdrRegServiceImpl.java
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
@Slf4j
@Service
public class OrdrRegServiceImpl implements OrdrRegService {

	@Autowired
	OrdrRegMapper ordrRegMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	@Autowired
	private StdPrdMngMapper stdPrdMngMapper;
	
	@Override
	public Map<String, Object> selectSdtPrdList(OrdRegVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", ordrRegMapper.selectSdtPrdList(param) );
		return result;
	}
	
	@Override
	@Transactional
	public String saveOrdRegList(List<OrdRegVO> list) throws Exception{
		OrdRegVO ordRegVO = new OrdRegVO();
		ordRegVO.setOrdDt(list.get(0).getOrdDt());
		ordRegVO.setAgenSeq( userInfo.getAgenSeq() );
		ordRegVO.setEmplSeq( userInfo.getEmplSeq() );
		ordRegVO.setOrdStus("PCHA");
		ordRegVO.setOrdType( list.get(0).getOrdType() );
		ordRegVO.setVendSeq(list.get(0).getVendSeq());
		
		int ordSeq;
		int cnt = ordrRegMapper.selectOrdRegConfirm(ordRegVO);
		if( cnt == 0 ) {
			ordrRegMapper.insertOrdMst(ordRegVO);
			ordSeq = ordRegVO.getOrdSeq();
		}else {
			ordRegVO = ordrRegMapper.selectOrdSeqKey(ordRegVO);
			ordSeq = ordRegVO.getOrdSeq();
		}
		
		for(OrdRegVO param : list) {
			param.setAgenSeq( userInfo.getAgenSeq() );
			param.setEmplSeq( userInfo.getEmplSeq() );
			//삭제는 제외
			if( !"D".equals( param.getCrudMode() ) ) {
				if( "C".equals( param.getCrudMode() ) ) {
					StdPrdMngDetailVO spmdVO = new StdPrdMngDetailVO();
					spmdVO.setPrdSeq(String.valueOf(param.getPrdSeq()));
					spmdVO.setAgenSeq(param.getAgenSeq());
					spmdVO.setStdPrdNm(param.getStdPrdNm());
					spmdVO.setEmplSeq(userInfo.getEmplSeq());
					
					stdPrdMngMapper.insertStdPrdDetail(spmdVO);
					param.setPrdDtlSeq(spmdVO.getPrdDtlSeq());
				}
				
				param.setOrdSeq( ordSeq );
				
				ordrRegMapper.insertOrdPrd(param);
			}
		}
		
		return "정상적으로 저장되었습니다.";
	}

	@Override
	public List<OrdRegVO> selectPrdMstSapList(OrdRegVO param) {
		return ordrRegMapper.selectPrdMstSapList(param);
	}

	@Override
	public Map<String, Object> selectMkslPrdList(OrdRegVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", ordrRegMapper.selectMkslPrdList(param) );
		return result;
	}

	@Override
	public Map<String, Object> selectTmprtPrdList(OrdRegVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", ordrRegMapper.selectTmprtPrdList(param) );
		return result;
	}
}
