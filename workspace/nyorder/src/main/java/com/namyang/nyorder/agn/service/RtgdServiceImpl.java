package com.namyang.nyorder.agn.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.namyang.nyorder.agn.dao.RtgdMapper;
import com.namyang.nyorder.agn.vo.RtgdVO;
import com.namyang.nyorder.comm.vo.UserInfo;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 반품/반송 조회 Service Implement
 * 파일명  : RtgdServiceImpl.java
 * 작성자  : LEEJUN
 * 작성일  : 2022. 1. 04.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 04.    LEEJUN     최조 프로그램 작성
 * 2022. 1. 26.    JUNGAE     반품/반송조회 그리드 데이터 조회
 *
 ****************************************************/
@Service
public class RtgdServiceImpl implements RtgdService{
	@Autowired
	private RtgdMapper rtgdMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 *	반품/반송 리스트 조회
	 */
	@Override
	public Map<String, Object> selectRtngudList(RtgdVO param) {
		param.setReqYm(param.getReqYm().replace("-", ""));
		List<RtgdVO> data = rtgdMapper.selectRtngudList(param);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", data);
		result.put("cnt", data.size());
		return result;
	}
	
	/**
	 *	반품확인서 리스트 조회
	 */
	@Override
	public List<RtgdVO> selectRtgdConfmList(RtgdVO param) {
		List<RtgdVO> result = rtgdMapper.selectRtgdConfmList(param);
		return result;
	}
}
