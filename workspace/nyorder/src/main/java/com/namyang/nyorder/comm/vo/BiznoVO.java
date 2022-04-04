package com.namyang.nyorder.comm.vo;

import lombok.Getter;
import lombok.Setter;


/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 
 * 파일명  : BiznoVO.java
 * 작성자  : GAIN
 * 작성일  : 2022. 1. 24.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 1. 24.    GAIN     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class BiznoVO{
	private String agenSeq;//대리점 시퀀스
	private String agenCd;//대리점 코드
	private String agenNm;
	private String emplSeq;
	private String emplCd;
	private String saleCd;//시방판분류코드
	private String bizNo;//대리점 사업자번호
}
