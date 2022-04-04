package com.namyang.nyorder.comm.dao;

import org.apache.ibatis.annotations.Mapper;

import com.namyang.nyorder.comm.vo.AccountVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 
 * 파일명  : AccountMapper.java
 * 작성자  : YESOL
 * 작성일  : 2022. 1. 4.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 4.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Mapper
public interface AccountMapper {
	
	AccountVO selectAccount(AccountVO param) throws Exception;

}
