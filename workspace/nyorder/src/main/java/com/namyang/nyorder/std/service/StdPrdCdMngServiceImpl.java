package com.namyang.nyorder.std.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.std.dao.StdPrdCdMngMapper;
import com.namyang.nyorder.std.vo.StdPrdCdMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  :  기준정보관리 - 타사제품코드 관리 Service Implement
 * 파일명  : StdPrdCdMngServiceImpl.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 1. 17.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 17.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class StdPrdCdMngServiceImpl implements StdPrdCdMngService {

	@Autowired
	StdPrdCdMngMapper stdPrdCdMngMapper;

	@Override
	public Map<String, Object> selectPrdCdMstList(StdPrdCdMngVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put( "list", stdPrdCdMngMapper.selectPrdCdMstList(param) );
		return result;
	}

	@Override
	public Map<String, Object> saveStdPrdCdDetail(StdPrdCdMngVO param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int result = 0;
		
		if("C".equals(param.getCrudMode())) {
			result = stdPrdCdMngMapper.insertStdPrdCdDetail(param);
			if( result > 0 ) {
				stdPrdCdMngMapper.insertStdrPrdSpprc(param);
			}
		}else if("U".equals(param.getCrudMode())) {
			result = stdPrdCdMngMapper.updateStdPrdCdDetail(param);
			if( result > 0 ) {
				//매입단가 정보 수정됐는지 체크
				StdPrdCdMngVO spcmVO = stdPrdCdMngMapper.selectStdrPrdSpprc(param);
				if( param.getUntpc() != spcmVO.getUntpc() ) {
					stdPrdCdMngMapper.updateStdrPrdSpprcLastYn(param);
					stdPrdCdMngMapper.insertStdrPrdSpprc(param);
				}
			}
		}
		
		if( result > 0 ) {
			resultMap.put("msg", "저장되었습니다." );
		}else {
			resultMap.put("msg", "저장에 실패했습니다." );
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> removeStdPrdCd(StdPrdCdMngVO param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int result = 0;
		
		if( "D".equals(param.getCrudMode()) ) result = stdPrdCdMngMapper.removeStdPrdCd(param);
		
		if( result > 0 ) {
			resultMap.put("msg", "저장되었습니다.");
		}else {
			resultMap.put("msg", "저장에 실패했습니다.");
		}
		return resultMap;
	}

	@Override
	public StdPrdCdMngVO selectStdPrdMngDetail(StdPrdCdMngVO param) {
		return stdPrdCdMngMapper.selectStdPrdMngDetail(param);
	}
}
