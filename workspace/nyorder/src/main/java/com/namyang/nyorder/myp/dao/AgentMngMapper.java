package com.namyang.nyorder.myp.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.namyang.nyorder.myp.vo.AgentMngVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 
 * 파일명  : AgentMngMapper.java
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

public interface AgentMngMapper {
	
	List<List<AgentMngVO>> selectAgentMngList(AgentMngVO param);
	
	int insertAgentMng(AgentMngVO param);
	
	

}
