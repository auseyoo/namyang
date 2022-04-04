package com.namyang.nyorder.myp.service;

import java.util.HashMap;
import java.util.List;

import com.namyang.nyorder.myp.vo.AgentMenuRoleVO;
import com.namyang.nyorder.myp.vo.AgentMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 
 * 파일명  : AgentMngService.java
 * 작성자  : JungsuKim
 * 작성일  : 2022. 1. 3.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 3.    JungsuKim     최조 프로그램 작성
 *
 ****************************************************/
public interface AgentMngService {
	
	HashMap<String, Object> selectAgentMngList(AgentMngVO param) throws Exception;
	
	int insertAgentMng(AgentMngVO param);
	
	HashMap<String, Object> selectAxis(AgentMngVO param);

}
