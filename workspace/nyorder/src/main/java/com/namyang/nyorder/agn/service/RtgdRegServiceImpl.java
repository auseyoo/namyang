package com.namyang.nyorder.agn.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.agn.dao.RtgdRegMapper;
import com.namyang.nyorder.agn.vo.RtgdVO;
import com.namyang.nyorder.comm.vo.UserInfo;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 반품등록 Service Implement
 * 파일명  : RtgdRegServiceImpl.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 1. 04.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 04.    LEEJUN     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class RtgdRegServiceImpl implements RtgdRegService{
	@Autowired
	private RtgdRegMapper rtgdRegMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 *	반품등록 리스트 조회
	 */
	@Override
	public Map<String, Object> selectRtgdRegList(RtgdVO param) {
		param.setReqYm(param.getReqYm().replace("-", ""));
		
		List<RtgdVO> data = rtgdRegMapper.selectRtgdRegList(param);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", data);
		result.put("cnt", data.size());
		return result;
	}
	
	/**
	 *	반품등록 - 표준제품 불러오기
	 */
	@Override
	public Map<String, Object> selectStdPrdList(RtgdVO param) {
		List<RtgdVO> data = rtgdRegMapper.selectStdPrdList(param);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", data);
		result.put("cnt", data.size());
		return result;
	}
	
	/**
	 *	반품등록 - 전월반품 불러오기
	 */
	@Override
	public Map<String, Object> selectPrevRtgdList(RtgdVO param) {
		List<RtgdVO> data = rtgdRegMapper.selectPrevRtgdList(param);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", data);
		result.put("cnt", data.size());
		return result;
	}
	
	/**
	 *	반품등록 저장
	 */	
	@Transactional
	public String saveRtgdRegList(List<RtgdVO> list) {
		for(RtgdVO param : list) {
			param.setAgenSeq(userInfo.getAgenSeq());
			param.setEmplSeq(userInfo.getEmplSeq());
			
			if(param.getCrudMode().equals("M")) {
				rtgdRegMapper.megOrdRtgd(param);	
			} else if(param.getCrudMode().equals("D"))  {
				rtgdRegMapper.delOrdRtgd(param);
			}
		}		
		return "정상적으로 저장되었습니다.";
	}
	
	/**
	 *	반품등록 전송
	 */	
	@Override
	public String sendRtgdReg(List<RtgdVO> list) {
		
		/*
		 반품 전송은 SAP읋 데이터 전송처리임. 
		 전송데이터 스펙 정의 되어야함
		 */
		
		for(RtgdVO param : list) {
			param.setAgenSeq(userInfo.getAgenSeq());
			param.setEmplSeq(userInfo.getEmplSeq());
			// 아래에서는 전송여부 컬럼 'Y'로 update처리함
			rtgdRegMapper.sendOrdRtgd(param);
		}	
		return "정상적으로 전송되었습니다.";
	}
	
	/**
	 *	반품등록 전송여부 조회
	 */	
	@Override
	public String selectTrnstYn(RtgdVO param) {
		param.setReqYm(param.getReqYm().replace("-", ""));
		param.setAgenSeq(userInfo.getAgenSeq());			
		return rtgdRegMapper.selectTrnstYn(param);
	}
	
	/**
	 *	반품등록 저장여부 조회
	 */	
	@Override
	public String selectSavedYn(RtgdVO param) {
		param.setReqYm(param.getReqYm().replace("-", ""));
		param.setAgenSeq(userInfo.getAgenSeq());			
		return rtgdRegMapper.selectSavedYn(param);
	}
	
	/**
	 *	제품등록 팝업창 - 제품리스트
	 */
	@Override
	public Map<String, Object> selectPrdList(RtgdVO param) {
		List<RtgdVO> data = rtgdRegMapper.selectPrdList(param); 
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", data);
		result.put("cnt", data.size());
		return result;
	}
}
