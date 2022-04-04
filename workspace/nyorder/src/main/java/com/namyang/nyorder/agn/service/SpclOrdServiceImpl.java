package com.namyang.nyorder.agn.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.agn.dao.SpclOrdMapper;
import com.namyang.nyorder.agn.vo.SpclOrdVO;
import com.namyang.nyorder.comm.vo.UserInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 특수처 주문 조회 Service Implement
 * 파일명  : SpclOrdServiceImpl.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 3. 22.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 22.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Service
public class SpclOrdServiceImpl implements SpclOrdService {
	@Autowired
	SpclOrdMapper spclOrdMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;

	@Override
	public Map<String, Object> selectSpclOrdList(SpclOrdVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put( "list" , spclOrdMapper.selectSpclOrdList(param) );
		return result;
	}
}
