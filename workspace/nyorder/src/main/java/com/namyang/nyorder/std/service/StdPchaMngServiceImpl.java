package com.namyang.nyorder.std.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.std.dao.StdPchaMngMapper;
import com.namyang.nyorder.std.vo.StdPchaMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  :  기준정보관리 - 매입처 관리 Service Implement
 * 파일명  : StdPchaMngServiceImpl.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 11.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 11.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class StdPchaMngServiceImpl implements StdPchaMngService {

	@Autowired
	StdPchaMngMapper stdPchaMngMapper;
	
	/**
	 *	매입처 리스트 조회
	 */
	@Override
	public Map<String, Object> selectPchaList(StdPchaMngVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", stdPchaMngMapper.selectPchaList(param));
		return result;
	}

	/**
	 *	매입처 상세 조회
	 */
	@Override
	public Map<String, Object> selectPchaDetail(StdPchaMngVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("detail", stdPchaMngMapper.selectPchaDetail(param));
		return result;
	}

	/**
	 *	매입처 수정 / 저장
	 */
	@Override
	@Transactional
	public Map<String, Object> savePchaDetail(StdPchaMngVO param) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int result = 0;
		
		if("C".equals(param.getCrudMode())) {
			result = stdPchaMngMapper.insertPchaDetail(param);
		}else if("U".equals(param.getCrudMode())) {
			result = stdPchaMngMapper.updatePchaDetail(param);
		}
		
		if( result > 0 ) {
			resultMap.put("msg", "저장되었습니다." );
		}else {
			resultMap.put("msg", "저장에 실패했습니다." );
		}
		return resultMap;
	}

	/**
	 *	매입처 삭제
	 */
	@Override
	@Transactional
	public Map<String, Object> removePcha(StdPchaMngVO param) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int result = 0;
		
		if( "D".equals(param.getCrudMode()) ) result = stdPchaMngMapper.removePcha(param);
		
		if( result > 0 ) {
			resultMap.put("msg", "저장되었습니다.");
		}else {
			resultMap.put("msg", "저장에 실패했습니다.");
		}
		return resultMap;
	}
}
