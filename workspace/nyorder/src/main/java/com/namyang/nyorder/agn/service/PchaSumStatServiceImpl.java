package com.namyang.nyorder.agn.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.agn.dao.PchaSumStatMapper;
import com.namyang.nyorder.agn.vo.PchaSumStatVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 매입 집계 현황 Service Implement
 * 파일명  : PchaSumStatServiceImpl.java
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
public class PchaSumStatServiceImpl implements PchaSumStatService {

	@Autowired
	PchaSumStatMapper pchaSumStatMapper;

	@Override
	public Map<String, Object> selectSumStatPchaList(PchaSumStatVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list",pchaSumStatMapper.selectSumStatPchaList(param));
		return result;
	}

	@Override
	public Map<String, Object> selectPchaSumStatDayList(PchaSumStatVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list",pchaSumStatMapper.selectPchaSumStatDayList(param));
		return result;
	}

	@Override
	public Map<String, Object> selectPchaSumStatMonList(PchaSumStatVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list",pchaSumStatMapper.selectPchaSumStatMonList(param));
		return result;
	}

	@Override
	public Map<String, Object> selectMjrPchaSumStatDayList(PchaSumStatVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list",pchaSumStatMapper.selectMjrPchaSumStatDayList(param));
		return result;
	}

	@Override
	public Map<String, Object> selectMjrPchaSumStatMonList(PchaSumStatVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list",pchaSumStatMapper.selectMjrPchaSumStatMonList(param));
		return result;
	}
}
