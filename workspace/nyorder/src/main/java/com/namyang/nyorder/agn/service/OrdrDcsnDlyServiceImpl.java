package com.namyang.nyorder.agn.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.agn.dao.OrdrDcsnDlyMapper;
import com.namyang.nyorder.agn.vo.OrdrDcsnDlyVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 주문확정/배송조회  Service Implement
 * 파일명  : OrdrDcsnDlyServiceImpl.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 2. 15.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 15.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class OrdrDcsnDlyServiceImpl implements OrdrDcsnDlyService {

	@Autowired
	OrdrDcsnDlyMapper ordrDcsnDlyMapper;

	@Override
	public Map<String, Object> selectOrdrDcsnDlyList(OrdrDcsnDlyVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put( "list" , ordrDcsnDlyMapper.selectOrdrDcsnDlyList(param) );
		return result;
	}
}
