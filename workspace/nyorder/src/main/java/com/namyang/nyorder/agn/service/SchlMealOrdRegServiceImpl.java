package com.namyang.nyorder.agn.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.namyang.nyorder.agn.dao.SchlMealOrdRegMapper;
import com.namyang.nyorder.agn.vo.SchlMealOrdRegVO;
import com.namyang.nyorder.comm.vo.UserInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 학교급식 주문 등록 Service Implement
 * 파일명  : SchlMealOrdRegServiceImpl.java
 * 작성자  : 윤이준
 * 작성일  : 2022. 2. 9.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 2. 9.    윤이준     최조 프로그램 작성
 *
 ****************************************************/
@Slf4j
@Service
public class SchlMealOrdRegServiceImpl implements SchlMealOrdRegService {
	@Autowired
	SchlMealOrdRegMapper schlMealOrdRegMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	@Override
	public Map<String, Object> selectSchlList(SchlMealOrdRegVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", schlMealOrdRegMapper.selectSchlList(param) );
		return result;
	}

	@Override
	public Map<String, Object> selectSchlMealPrdList(SchlMealOrdRegVO param) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", schlMealOrdRegMapper.selectSchlMealPrdList(param) );
		return result;
	}
	
}
