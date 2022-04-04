package com.namyang.nyorder.eqp.vo;

import com.namyang.nyorder.comm.vo.CommVO;

import lombok.Getter;
import lombok.Setter;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 대리점 장비 관리 VO
 * 파일명  : AgenEqpVO.java
 * 작성자  : YESOL
 * 작성일  : 2022. 3. 7.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2022. 3. 7.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Getter
@Setter
public class AgenEqpVO extends CommVO{
	private String agenEqpSeq;		// 장비 시퀀스
	private String chagEmplNm;		// 담당자명
	private String chagEmplSeq;		// 담당자
	private String eqpNm;			// 장비명
	private String eqpCd;			// 장비번호
	private String eqpStusSec;		// 장비상태
	private String eqpStusSecNm;	// 장비상태명
	private String pymDt;			// 지급일
	private String colDt;			// 반납일
}
