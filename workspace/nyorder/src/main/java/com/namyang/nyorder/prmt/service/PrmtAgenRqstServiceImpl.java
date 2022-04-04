package com.namyang.nyorder.prmt.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.agn.vo.RtgdVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.prmt.dao.PrmtAgenRqstMapper;
import com.namyang.nyorder.prmt.vo.PrmtAgenRqstVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 판촉물 소요량 요청 관리 Service Implement
 * 파일명  : PrmtAgenRqstServiceImpl.java
 * 작성자  : JUNGAE
 * 작성일  : 2022. 2. 23.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 23.    JUNGAE     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class PrmtAgenRqstServiceImpl implements PrmtAgenRqstService {
	
	@Autowired
	private PrmtAgenRqstMapper prtmAgenRqstMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;

	/**
	 *	판촉물 소요량 요청월 조회
	 */
	@Override
	public PrmtAgenRqstVO selectDvyfgRqstMonth(PrmtAgenRqstVO param) {
		return prtmAgenRqstMapper.selectDvyfgRqstMonth(param);
	}
	
	/**
	 *	판촉물 소요량 요청 리스트 조회
	 */
	@Override
	public Map<String, Object> selectPrmtAgenRqstList(PrmtAgenRqstVO param) {
		param.setReqYm(param.getReqYm().replace("-", ""));
		List<PrmtAgenRqstVO> data = prtmAgenRqstMapper.selectPrmtAgenRqstList(param); 
		PrmtAgenRqstVO lastSend = prtmAgenRqstMapper.selectAgenRqstLastSend(param);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", data);
		result.put("cnt", data.size());
		result.put("lastSend", lastSend);
		return result;
	}
	
	/**
	 *	판촉물 소요량 요청 최종전송시각
	 */
	@Override
	public PrmtAgenRqstVO selectAgenRqstLastSend(PrmtAgenRqstVO param) {
		return prtmAgenRqstMapper.selectAgenRqstLastSend(param);
	}
	
	@Override
	@Transactional
	public String savePrmtAgenRqst(List<PrmtAgenRqstVO> list) {
		for(PrmtAgenRqstVO param : list) {
			param.setAgenSeq(userInfo.getAgenSeq());
			param.setEmplSeq(userInfo.getEmplSeq());
			
			if(param.getCrudMode().equals("M"))
				prtmAgenRqstMapper.updPrmtAgenRqst(param);
			else if(param.getCrudMode().equals("C")) {
				prtmAgenRqstMapper.insPrmtAgenRqst(param);
				prtmAgenRqstMapper.merStdPrdDetail(param);
			}	
		}
		return "정상적으로 저장되었습니다.";
	}	
	
	/**
	 *	판촉물 소요량 요청 저장여부 조회
	 */	
	@Override
	public String selectSavedYn(PrmtAgenRqstVO param) {
		param.setReqYm(param.getReqYm().replace("-", ""));
		param.setAgenSeq(userInfo.getAgenSeq());			
		return prtmAgenRqstMapper.selectSavedYn(param);
	}
	
	@Override
	@Transactional
	public String sendPrmtAgenRqst(PrmtAgenRqstVO param) {
		param.setAgenSeq(userInfo.getAgenSeq());
		param.setEmplSeq(userInfo.getEmplSeq());
		prtmAgenRqstMapper.updPrmtAgenRqstSend(param);
		return "정상적으로 전송되었습니다.";
	}		
}
